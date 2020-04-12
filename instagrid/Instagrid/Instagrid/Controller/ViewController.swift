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
    var buttonSelected: UIButton?
    var number = 0
   
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
           // Do any additional setup after loading the view.
       }

//        override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//            super.viewWillTransition(to: size, with: coordinator)
//            if UIDevice.current.orientation.isLandscape {
//                let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
//                upSwipe.direction = .left
//                view.addGestureRecognizer(upSwipe)
//                print("Landscape")
//            } else {
//                print("Portrait")
//            }
//        }
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
        let buttonNumber = sender.tag
        changeButton(number : buttonNumber)
        displayPicture(number : buttonNumber)
    }
    func transformQuestionViewWith(gesture: UISwipeGestureRecognizer) {
        
    }
    /**
       handleSwipe() with a swipe up, allows to display a UIActivityViewController for share or save your photo
        
       - Parameters:
           - sender : allows to know when the gesture is execute
       */
    @objc func handleSwipe(sender: UISwipeGestureRecognizer){
        print(UIDevice.current.orientation.isPortrait)
        if UIDevice.current.orientation.isPortrait {
            
        }
       if sender.state == .ended{
            if sender.direction == .up{
                transformQuestionViewWith(gesture: sender)
                 print("sender.orientation = UP")
                 let newImage = viewToShare.asImage()
                 let activityController = UIActivityViewController(activityItems: [newImage], applicationActivities: nil)
                 present(activityController, animated: true, completion: nil)
            } else if sender.direction == .left{
                transformQuestionViewWith(gesture: sender)
                 print("sender.orientation = LEFT")
                 let newImage = viewToShare.asImage()
                 let activityController = UIActivityViewController(activityItems: [newImage], applicationActivities: nil)
                 present(activityController, animated: true, completion: nil)
            }
        
        }
        

//        if sender.state == .ended{
//            if sender.direction == .up{
//                print("hello")
//                let newImage = viewToShare.asImage()
//                let activityController = UIActivityViewController(activityItems: [newImage], applicationActivities: nil)
//                present(activityController, animated: true, completion: nil)
//            }
//        }
        
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
        case 2:
            print("displayPicture \(number)")
            for image in imageStackView{
                if image.tag == 4{
                    image.isHidden = true
                } else {
                    image.isHidden = false
                }
           }
        default:
             for image in imageStackView{
                image.isHidden = false
            }
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

