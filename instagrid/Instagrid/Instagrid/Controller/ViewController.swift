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
    var imagePicker = UIImagePickerController()
    var buttonSelected = UIButton?.self
    var imageSelected = UIImage?.self
    var number = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func changeTable(_ sender: UIButton) {
        let titleButton = sender.currentTitle
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
        number = sender.tag
        print(number)
    }
}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let photo = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            for button in buttonStackView{
                if button.tag == number{
                    print("bouton.tag = \(button.tag)")
                    button.isHidden = true
                }
            }
            for image in imageStackView{
                if image.tag == number{
                    print(image.tag)
                    image.image = photo
                    image.isHidden = false
                }
            }
//            buttonStackView[number].isHidden = true
            dismiss(animated: true, completion: nil)
        }
    }
}


