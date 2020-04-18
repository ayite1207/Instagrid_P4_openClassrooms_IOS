//
//  ViewController+UIImagePickerController.swift
//  Instagrid
//
//  Created by ayite  on 17/04/2020.
//  Copyright © 2020 ayite . All rights reserved.
//

import Foundation
import UIKit

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
