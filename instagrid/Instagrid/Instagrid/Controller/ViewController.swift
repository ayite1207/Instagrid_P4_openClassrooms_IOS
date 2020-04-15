//
//  ViewController.swift
//  Instagrid
//
//  Created by ayite  on 09/03/2020.
//  Copyright © 2020 ayite . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /**
     the first three variables represent the three composition of images
     the variable viewToShare is the view that i will share or save
     the variable collectionButton represents the three botom buttons
     the variable buttonStackView represents all the buttons that allow me to select a photo
     the variable imageStackView represents all the images that allow me to select a photo
    */
    @IBOutlet weak var rightStackView: UIStackView!
    @IBOutlet weak var viewToShare: UIView!
    @IBOutlet var collectionButton: [UIButton]!
    @IBOutlet var imageStackView: [UIImageView]!
    var imagePicker = UIImagePickerController()
    var buttonNumber = 2
    var number = 0
    var firstgrid: [Int : UIImage] = [:]
    var secondgrid: [Int : UIImage] = [:]
    var thirdgrid: [Int : UIImage] = [:]
    /**
       viewDidLoad() when the first view is loaded everything in this function is applicated
       */
       
       override func viewDidLoad() {
           super.viewDidLoad()
           displayPicture(number : 2)
           imagePicker.delegate = self
           // the variable firsButton alows to display the midle button
           let firsButton = collectionButton[1]
           firsButton.setBackgroundImage(UIImage(named: "Layout 2 selected"), for: .normal)
          
           // addGesture() makes stackview photos clickable
           addGesture()
           
           // this variable alows to detect when i make a swipe on my view
           
           let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
            upSwipe.direction = .up
           view.addGestureRecognizer(upSwipe)
            let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
            leftSwipe.direction = .left
            view.addGestureRecognizer(leftSwipe)
           // Do any additional setup after loading the view.
       }

        override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            super.viewWillTransition(to: size, with: coordinator)
            if UIDevice.current.orientation.isLandscape {
            let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
            leftSwipe.direction = .left
            view.addGestureRecognizer(leftSwipe)
                print("Landscape")
            }
        }
     /**
       addGesture() makes stackview photos clickable
       */
    fileprivate func addGesture() {
        for imageView in imageStackView{
            imageView.isUserInteractionEnabled = true
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            tapRecognizer.accessibilityLabel = String(imageView.tag)
            imageView.addGestureRecognizer(tapRecognizer)
        }
    }
    
    /**
    changeTable() allows to change the photo frame
     
    - Parameters:
        - sender : represents the button on which the user pressed
    */
    @IBAction func changeTable(_ sender: UIButton) {
        buttonNumber = sender.tag
        print("Le button number est : \(buttonNumber)")
        changeButton(number : buttonNumber)
        displayPicture(number : buttonNumber)
    }
    /**
       handleSwipe() with a swipe up, allows to display a UIActivityViewController for share or save your photo
        
       - Parameters:
           - sender : allows to know when the gesture is execute
       */
    @objc func handleSwipe(sender: UISwipeGestureRecognizer){
       if sender.state == .ended{
            if sender.direction == .up && UIDevice.current.orientation.isPortrait{
                 print("sender.orientation = UP")
                 let newImage = viewToShare.asImage()
                 let activityController = UIActivityViewController(activityItems: [newImage], applicationActivities: nil)
                 present(activityController, animated: true, completion: nil)
            } else if sender.direction == .left && UIDevice.current.orientation.isLandscape {
                 print("sender.orientation = LEFT")
                 let newImage = viewToShare.asImage()
                 let activityController = UIActivityViewController(activityItems: [newImage], applicationActivities: nil)
                 present(activityController, animated: true, completion: nil)
            }
        }
    }
    /**
    imageTapped() when you hit on a photo, imageTapped allows to acces in the photo library of the phone
     
    - Parameters:
        - recognizer : allows to know when the gesture is execute
    */
    @objc func imageTapped(recognizer: UITapGestureRecognizer) {
        guard let numberString = recognizer.accessibilityLabel else {return}
        guard let number1 = Int(numberString) else {return}
        number = number1
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    /**
    changeButton() when the user presse on a button a valid logo appears
     
    - Parameters:
        - number : represents the button on which the user pressed
    */
    func changeButton(number : Int){
        for button in collectionButton{
            if button.tag == number {
                let str = "Layout \(button.tag) selected"
                button.setBackgroundImage(UIImage(named: str), for: .normal)
            } else {
                let str = "Layout \(button.tag)"
                button.setBackgroundImage(UIImage(named: str), for: .normal)
            }
        }
    }
    /**
    displayPicture() allows to display the stackView selected
     
    - Parameters:
        - firstStack : represents the stackView that will be displayed
        - secondStack : represents the stackView that will be hidden
        - secondStack : represents the stackView that will be hidden
    */
    func displayPicture(number : Int){
        switch number {
        case 1:
            print("displayPicture \(number)")
            for image in imageStackView{
                if image.tag == 2{
                    image.isHidden = true
                } else {
                    image.isHidden = false
                }
            }
            displayTheGoodImage(tab: firstgrid)
        case 2:
            print("displayPicture \(number)")
            for image in imageStackView{
                if image.tag == 4{
                    image.isHidden = true
                } else {
                    image.isHidden = false
                }
           }
            displayTheGoodImage(tab: secondgrid)
        default:
             for image in imageStackView{
                image.isHidden = false
            }
            displayTheGoodImage(tab: thirdgrid)
        }
    }
    
    func displayTheGoodImage(tab : [Int : UIImage]){
        print("nombre de photos tableau : \(tab.count)")
        if tab.count == 0{
            print("tableau vide")
            for image in imageStackView{
                image.image = UIImage(named: "Plus")
                image.contentMode = .center
            }
        } else {
            switch buttonNumber {
            case 1:
                print("Je dois afficher trois images dans la grille de gauche !")
                for image in imageStackView {
                    for key in tab {
                        if key.key == image.tag{
                            print("\(key.key) est egale à \(image.tag)")
                            image.image = key.value
                            image.contentMode = .scaleAspectFill
                            break
                        } else {
                            print("\(key.key) n'est pas egale à \(image.tag) j'affiche le plus")
                            image.image = UIImage(named: "Plus")
                            image.contentMode = .center
                        }
                    }
                }
            case 2:
                print("Je dois afficher trois images dans la grille du centre!")
                for image in imageStackView {
                    for key in tab {
                        if key.key == image.tag{
                            print("\(key.key) est egale à \(image.tag)")
                            image.image = key.value
                            image.contentMode = .scaleAspectFill
                            break
                        } else {
                            print("\(key.key) n'est pas egale à \(image.tag) j'affiche le plus")
                            image.image = UIImage(named: "Plus")
                            image.contentMode = .center
                        }
                    }
                }
            default:
                print("Je dois afficher trois images dans la grille de droite!")
                for image in imageStackView {
                    for key in tab {
                        if key.key == image.tag{
                            print("\(key.key) est egale à \(image.tag)")
                            image.image = key.value
                            image.contentMode = .scaleAspectFill
                            break
                        } else {
                            print("\(key.key) n'est pas egale à \(image.tag) j'affiche le plus")
                            image.image = UIImage(named: "Plus")
                            image.contentMode = .center
                        }
                    }
                }
            }
        }
    }
    
    func savePhoto(numberImage: Int,photo : UIImage, buttonNumber : Int){
        print("numberImage \(numberImage)")
        print("buttonNumber \(buttonNumber)")
        switch buttonNumber {
        case 1:
            firstgrid[numberImage] = photo
            print("La photo est enregistrée dans le tableau firstGrid")
        case 2:
            secondgrid[numberImage] = photo
            print("La photo est enregistrée dans le tableau secondGrid")
        default:
            thirdgrid[numberImage] = photo
            print("La photo est enregistrée dans le tableau thirdtGrid")
        }
    }
    
    
}



extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    /**
    imagePickerController()  allows to display the photo selected
     
    - Parameters:
        - sender : represents the button on which the user pressed
    */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let photo = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            for image in imageStackView{
                if image.tag == number{
                    image.image = photo
                    image.contentMode = .scaleAspectFill
                    image.isHidden = false
                    savePhoto(numberImage: image.tag,photo : photo, buttonNumber : buttonNumber)
                }
            }
            dismiss(animated: true, completion: nil)
        }
    }
}

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

