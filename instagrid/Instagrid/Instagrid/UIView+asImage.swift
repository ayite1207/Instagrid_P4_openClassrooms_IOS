//
//  ViewController+UIView.swift
//  Instagrid
//
//  Created by ayite  on 17/04/2020.
//  Copyright © 2020 ayite . All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    /**
    asImage() allows to convert my UIView in UIImage
    */
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
