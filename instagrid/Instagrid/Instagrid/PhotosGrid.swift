//
//  PhotosGrid.swift
//  Instagrid
//
//  Created by ayite  on 09/04/2020.
//  Copyright © 2020 ayite . All rights reserved.
//

import Foundation
import UIKit

class GestionPhoto {
    
    var firstgrid: [Int : UIImage] = [:]
    var secondgrid: [Int : UIImage] = [:]
    var thirdgrid: [Int : UIImage] = [:]
    var imageStackView: [UIImageView]!
    var buttonNumber = 2
    
    init(imageStackView: [UIImageView]) {
        self.imageStackView = imageStackView
    }
    /**
    displayGrid() allows to display the selected grid. Displays origal photos or the photos already selected by the user
     
    - Parameters:
        - number :represents the button who si clicked
    */
    func displayGrid(number : Int){
        switch number {
        case 1:
            for image in imageStackView{
                if image.tag == 2{
                    image.isHidden = true
                } else {
                    image.isHidden = false
                }
            }
            displayTheGoodImage(tab: firstgrid)
        case 2:
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
    /**
    savePhoto() when the user selcet an image, this image is saved in a dictionary  who represent the grid displayed
     
    - Parameters:
        - numberImage :represents the UIImage tag saved
        - photo :represents the photo who will be displayed in the grid
        - buttonNumber :the button the user clicked to display the grid
        
    */
    func savePhoto(numberImage: Int,photo : UIImage, buttonNumber : Int){
        switch buttonNumber {
        case 1:
            firstgrid[numberImage] = photo
        case 2:
            secondgrid[numberImage] = photo
        default:
            thirdgrid[numberImage] = photo
        }
    }
    /**
    displayTheGoodImage() when the user selcet a grid, this function check if there are photos in the dictionary who represents the grid
     
    - Parameters:
        - tab :the dictionary who represents the grid
    */
    func displayTheGoodImage(tab : [Int : UIImage]){
        if tab.count == 0{
            for image in imageStackView{
                image.image = UIImage(named: "Plus")
                image.contentMode = .center
            }
        } else {
            switch buttonNumber {
            case 1:
                checkTheImagesOfTheGrid(tab)
            case 2:
                checkTheImagesOfTheGrid(tab)
            default:
                checkTheImagesOfTheGrid(tab)
            }
        }
    }
    /**
    checkTheImagesOfTheGrid() when the user select a grid, if there are images in the dictionary this function allows display the good image in the good UIImage
     
    - Parameters:
        - tab :the dictionary who represents the grid
    */
    func checkTheImagesOfTheGrid(_ tab: [Int : UIImage]) {
        for image in imageStackView {
            for key in tab {
                if key.key == image.tag{
                    image.image = key.value
                    image.contentMode = .scaleAspectFill
                    break
                } else {
                    image.image = UIImage(named: "Plus")
                    image.contentMode = .center
                }
            }
        }
    }
}
