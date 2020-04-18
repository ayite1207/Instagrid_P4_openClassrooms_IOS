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
    var firstgrid: [Int : UIImage] = [:]
    var secondgrid: [Int : UIImage] = [:]
    var thirdgrid: [Int : UIImage] = [:]
    var imagePicker = UIImagePickerController()
    var buttonNumber = 2
    var number = 0
    /**
       viewDidLoad() when the first view is loaded everything in this function is applicated
       */
       
       override func viewDidLoad() {
           super.viewDidLoad()
           displayGrid(number : 2)
           imagePicker.delegate = self
           // the variable firsButton alows to display the midle button
           let firsButton = collectionButton[1]
           firsButton.setBackgroundImage(UIImage(named: "Layout 2 selected"), for: .normal)
          
           // addGesture() makes stackview photos clickable
           addGesture()
           
           // this variables alow to detect when i make a swipe on my view
           
           let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
            upSwipe.direction = .up
           view.addGestureRecognizer(upSwipe)
            let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
            leftSwipe.direction = .left
            view.addGestureRecognizer(leftSwipe)
           // Do any additional setup after loading the view.
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
        changeButton(number : buttonNumber)
        displayGrid(number : buttonNumber)
    }
    /**
       handleSwipe() with a swipe up, allows to display a UIActivityViewController for share or save your photo
        
       - Parameters:
           - sender : allows to know when the gesture is execute
       */
    @objc func handleSwipe(sender: UISwipeGestureRecognizer){
        let newImage = viewToShare.asImage()
        let activityController = UIActivityViewController(activityItems: [newImage], applicationActivities: nil)
       if sender.state == .ended{
            if sender.direction == .up && UIDevice.current.orientation.isPortrait{
                animateSwipe(translationX: 0, y: -view.frame.height)
                 present(activityController, animated: true, completion: nil)
                activityController.completionWithItemsHandler = { activity, completed, items, error in
                    if !completed || activity != nil{
                        let frameHeight = self.viewToShare.frame.height
                        self.animateSwipe2(translationX: 0, y: -frameHeight)
                    }
                }
            } else if sender.direction == .left && UIDevice.current.orientation.isLandscape {
                animateSwipe(translationX: -view.frame.width, y: 0)
                 present(activityController, animated: true, completion: nil)
                activityController.completionWithItemsHandler = { activity, completed, items, error in
                    if !completed || activity != nil{
                        let frameWidth = self.viewToShare.frame.width
                        self.animateSwipe2(translationX: -frameWidth, y: 0)
                        return
                    }
                }
            }
        }
    }
    /**
    animateSwipe2() when you hit on a photo, imageTapped allows to acces in the photo library of the phone
     
    - Parameters:
        - x : indicate position relative to the upper left corner
        - y : indicate position relative to the upper left corner
    */
    func animateSwipe2(translationX x: CGFloat, y: CGFloat){
        self.viewToShare.transform = CGAffineTransform(translationX: x, y: y)
        UIView.animate(withDuration: 0.4, animations: {
            self.viewToShare.transform = .identity
        }, completion: nil)
    }
    /**
    animateSwipe() when you hit on a photo, imageTapped allows to acces in the photo library of the phone
     
    - Parameters:
     - x : indicate position relative to the upper left corner
     - y : indicate position relative to the upper left corner
    */
    func animateSwipe(translationX x: CGFloat, y: CGFloat) {
        UIView.animate(withDuration: 0.5, animations: {
            self.viewToShare.transform = CGAffineTransform(translationX: x, y: y)
        })
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
}



