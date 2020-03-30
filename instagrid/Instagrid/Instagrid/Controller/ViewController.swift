//
//  ViewController.swift
//  Instagrid
//
//  Created by ayite  on 09/03/2020.
//  Copyright © 2020 ayite . All rights reserved.
//

import UIKit

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}

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
    var imageSelected: UIImage?
    
    var number = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        let firsButton = collectionButton[1]
        firsButton.setBackgroundImage(UIImage(named: "Layout 2 selected"), for: .normal)
        print("hello")
        for imageView in imageStackView{
            imageView.isUserInteractionEnabled = true
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            imageView.addGestureRecognizer(tapRecognizer)
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func imageTapped(recognizer: UITapGestureRecognizer) {
        print("Image was tapped")
        let thePoint = recognizer.location(in: view)
        let theView = recognizer.view
        print("\(theView?.tag)")
    }
    
    @IBAction func changeTable(_ sender: UIButton) {
        guard let titleButton = sender.accessibilityIdentifier else { return}
        let buttonNumber = sender.tag
        changeButton(number : buttonNumber)
        switch titleButton {
        case "left":
            displayPicture(firstStack: leftStackView, secondStack: middleStackView, firdStack: rightStackView)
        case "midle":
            displayPicture(firstStack: middleStackView, secondStack: leftStackView, firdStack: rightStackView)
        case "right":
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
    
    
    @IBAction func shareImage(_ sender: UIButton) {
        let newImage = viewToShare.asImage()
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: newImage)
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

