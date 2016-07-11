//
//  QRCodeService.swift
//  What's Your Wifi?
//
//  Created by Jake Alsemgeest on 2016-07-10.
//  Copyright © 2016 Jalsemgeest. All rights reserved.
//

import UIKit

class Service {

    static func isValidWYWIFI(value: String!) -> Bool {
        if !value.isEmpty {
            if value.containsString(Constants.WIFI_NAME) {
                if value.containsString(Constants.PASSWORD) {
                    return true
                }
            }
        }
        return false
    }
    
    static func saveQRImage(qrCode: QRCode!, from: UIViewController) {
        
        let transform = CGAffineTransformMakeScale(9.8, 9.8)
        
        let imageToSave = qrCode.getQRCodeImage().imageByApplyingTransform(transform)
        
        let softwareContext = CIContext(options: [kCIContextUseSoftwareRenderer:true])
        
        let cgimg = softwareContext.createCGImage(imageToSave, fromRect: imageToSave.extent)
        
        let uiimage = self.textToImage(qrCode.wifiName, inImage: UIImage(CGImage: cgimg), atPoint: CGPoint(x: 5, y: 0))
        
        UIImageWriteToSavedPhotosAlbum(uiimage, from, #selector(from.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    static func textToImage(drawText: NSString, inImage: UIImage, atPoint:CGPoint)->UIImage{
        
        var textColor = UIColor.blackColor()
        
        var textFont = UIFont(name: "Helvetica Bold", size: 20)!
        
        let scale = UIScreen.mainScreen().scale
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: inImage.size.width, height: inImage.size.height + 100), false, scale)
        
        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor
        ]
        
        inImage.drawAtPoint(CGPoint(x: 0, y: 100))
        
        var rect = CGRectMake(0, 0, inImage.size.width, inImage.size.height)
        
        drawText.drawInRect(rect, withAttributes: textFontAttributes)
        
        var newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}
