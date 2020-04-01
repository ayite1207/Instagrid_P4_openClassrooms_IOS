//
//  ViewController.swift
//  Instagrid
//
//  Created by ayite  on 09/03/2020.
//  Copyright © 2020 ayite . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leftStackView: UIStackView!
    @IBOutlet var collectionButton: [UIButton]!
    @IBOutlet weak var middleStackView: UIStackView!
    @IBOutlet weak var rightStackView: UIStackView!
    @IBOutlet var buttonStackView: [UIButton]!
    @IBOutlet var imageStackView: [UIImageView]!
    @IBOutlet weak var viewToShare: UIView!
    var imagePicker = UIImagePickerController()
    var buttonSelected: UIButton?
    var number = 0
    
    @IBOutlet weak var swippeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        let firsButton = collectionButton[1]
        firsButton.setBackgroundImage(UIImage(named: "Layout 2 selected"), for: .normal)

        for imageView in imageStackView{
            imageView.isUserInteractionEnabled = true
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            tapRecognizer.accessibilityLabel = String(imageView.tag)
        imageView.addGestureRecognizer(tapRecognizer)
        }
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer){
        if sender.state == .ended{
            if sender.direction == .up{
                print("hello")
                let newImage = viewToShare.asImage()
//                let imageSaver = ImageSaver()
//                imageSaver.writeToPhotoAlbum(image: newImage)
                let activityController = UIActivityViewController(activityItems: [newImage], applicationActivities: nil)
                present(activityController, animated: true, completion: nil)
            }
        }
        
    }
    
    @objc func imageTapped(recognizer: UITapGestureRecognizer) {
        guard let numberString = recognizer.accessibilityLabel else {return}
        guard let number1 = Int(numberString) else {return}
        number = number1
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func changeTable(_ sender: UIButton) {
        let buttonNumber = sender.tag
        changeButton(number : buttonNumber)
        switch buttonNumber {
        case 1:
            displayPicture(firstStack: leftStackView, secondStack: middleStackView, firdStack: rightStackView)
        case 2:
            displayPicture(firstStack: middleStackView, secondStack: leftStackView, firdStack: rightStackView)
        case 3:
            displayPicture(firstStack: rightStackView, secondStack: leftStackView, firdStack: middleStackView)
        default:
            break
        }
    }
    
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
    
    func displayPicture(firstStack: UIStackView, secondStack: UIStackView,firdStack: UIStackView){
        firstStack.isHidden = false
        secondStack.isHidden = true
        firdStack.isHidden = true
    }
    
    @IBAction func choiceImage(_ sender: UIButton){
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        buttonSelected = sender
        number = sender.tag
        print(number)
    }
    
}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let photo = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            buttonSelected?.isHidden = true
            for image in imageStackView{
                if image.tag == number{
                    image.image = photo
                    image.isHidden = false
                }
            }
            dismiss(animated: true, completion: nil)
        }
    }
}

extension UIView {

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

