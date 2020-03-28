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
        
        // Do any additional setup after loading the view.
    }

    @IBAction func changeTable(_ sender: UIButton) {
        guard let titleButton = sender.accessibilityIdentifier else { return}
        switch titleButton {
        case "left":
            middleStackView.isHidden = true
            leftStackView.isHidden = false
             rightStackView.isHidden = true
        case "midle":
            leftStackView.isHidden = true
            middleStackView.isHidden = false
             rightStackView.isHidden = true
        case "right":
            leftStackView.isHidden = true
            middleStackView.isHidden = true
            rightStackView.isHidden = false
        default:
            break
        }
    }
    
    @IBAction func choiceImage(_ sender: UIButton){
//        sender.isHidden = true
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

