//
//  Extantions.swift
//  FitnessSchedule
//
//  Created by Nazar Prysiazhnyi on 12/12/18.
//  Copyright © 2018 Nazar Prysiazhnyi. All rights reserved.
//

import Foundation

import UIKit

extension UIColor {
    public convenience init?(hexString: String) {
        let redColor, greenColor, blueColor: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString.substring(from: start)
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt32 = 0
                
                if scanner.scanHexInt32(&hexNumber) {
                    redColor = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    greenColor = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    blueColor = CGFloat(hexNumber & 0x0000ff) / 255
                    
                    self.init(red: redColor, green: greenColor, blue: blueColor, alpha: 1.0)
                    
                    return
                }
            }
        }
        
        return nil
    }
    
    open class var silver: UIColor { // rgb 237 238 238
        get {
            return UIColor(red: 237.0/255.0, green: 238.0/255.0, blue: 238.0/255.0, alpha: 1.0)
        }
    }

    open class var marigold: UIColor { // rgb 253 192 0
        get {
            return UIColor(hexString: "#FDC000")!
        }
    }
}
