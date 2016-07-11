//
//  QRCode.swift
//  What's Your Wifi?
//
//  Created by Jake Alsemgeest on 2016-07-10.
//  Copyright © 2016 Jalsemgeest. All rights reserved.
//

import UIKit

class QRCode {
    
    var wifiName : String!
    var password : String!
    var qrImage : CGImage?
    
    init(name: String!, password: String!) {
        self.wifiName = name
        self.password = password
    }
    
    init(qrCode: String!) {
        parseQRCode(qrCode)
    }
    
    func parseQRCode(value: String!) {
        if let wifiName = value.sliceFrom(Constants.WIFI_NAME, to: Constants.PASSWORD) {
            if let pIndex = value.rangeOfString(Constants.PASSWORD, options: .BackwardsSearch) {
                let index = pIndex.endIndex
                if value.substringFromIndex(index).characters.count > 0 {
                    self.wifiName = wifiName
                    self.password = value.substringFromIndex(index)
                }
            }
        }
    }
    
    func getQRCode(value: String) -> (wifiName: String?, password:String?) {
        parseQRCode(value)
        
        if wifiName.isEmpty || password.isEmpty {
            return (nil, nil)
        } else {
            return (wifiName, password)
        }
    }
    
    func getOutput() -> String {
        return "\(Constants.WIFI_NAME)\(self.wifiName)\(Constants.PASSWORD)\(self.password)"
    }
    
    func getQRCodeImage() -> CIImage {
        let filter = CIFilter(name: "CIQRCodeGenerator")!
        
        var data = "\(Constants.WIFI_NAME)\(self.wifiName)\(Constants.PASSWORD)\(self.password)".dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
        
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("Q", forKey: "inputCorrectionLevel")
        
        return filter.outputImage!
    }
    
    func getQRCodeScaled(width: CGFloat, height: CGFloat) -> UIImage {
        let scaleX = width / getQRCodeImage().extent.size.width
        let scaleY = height / getQRCodeImage().extent.size.height
        
        let transform = CGAffineTransformMakeScale(scaleX, scaleY)
        
        let imageToSave = getQRCodeImage().imageByApplyingTransform(transform)
        
        let softwareContext = CIContext(options: [kCIContextUseSoftwareRenderer:true])
        
        let cgimg = softwareContext.createCGImage(imageToSave, fromRect: imageToSave.extent)
        
        return UIImage(CGImage: cgimg)
    }
    
}

extension String {
    func sliceFrom(start: String, to: String) -> String? {
        return (rangeOfString(start)?.endIndex).flatMap { sInd in
            (rangeOfString(to, range: sInd..<endIndex)?.startIndex).map { eInd in
                substringWithRange(sInd..<eInd)
            }
        }
    }
}