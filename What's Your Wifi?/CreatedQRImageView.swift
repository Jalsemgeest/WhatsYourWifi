//
//  CreatedQRImageView.swift
//  What's Your Wifi?
//
//  Created by Jake Alsemgeest on 2016-07-09.
//  Copyright © 2016 Jalsemgeest. All rights reserved.
//

import UIKit

class CreatedQRImageView: UIViewController {

    var ciImage : CIImage!
    var wifiName : String!
    
    @IBOutlet weak var wifiNameLabel: UILabel!
    @IBOutlet weak var qrImageView: UIImageView!
    
    @IBAction func saveWifiInfo() {
        
        let scaleX = qrImageView.frame.size.width / ciImage.extent.size.width
        let scaleY = qrImageView.frame.size.height / ciImage.extent.size.height
        
        let transform = CGAffineTransformMakeScale(scaleX, scaleY)
        
        let imageToSave = ciImage.imageByApplyingTransform(transform)
        
        let softwareContext = CIContext(options: [kCIContextUseSoftwareRenderer:true])
        
        let cgimg = softwareContext.createCGImage(imageToSave, fromRect: imageToSave.extent)
        
        let uiimage = textToImage(wifiName, inImage: UIImage(CGImage: cgimg), atPoint: CGPoint(x: 0, y: 0))
        
        UIImageWriteToSavedPhotosAlbum(uiimage, self, #selector(CreatedQRImageView.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    func textToImage(drawText: NSString, inImage: UIImage, atPoint:CGPoint)->UIImage{
        
        // Setup the font specific variables
        var textColor: UIColor = UIColor.blackColor()
        var textFont: UIFont = UIFont(name: "Helvetica Bold", size: 12)!
        
        //Setup the image context using the passed image.
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(inImage.size, false, scale)
        
        //Setups up the font attributes that will be later used to dictate how the text should be drawn
        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
            ]
        
        //Put the image into a rectangle as large as the original image.
        inImage.drawInRect(CGRectMake(0, 0, inImage.size.width, inImage.size.height))
        
        // Creating a point within the space that is as bit as the image.
        var rect: CGRect = CGRectMake(atPoint.x, atPoint.y, inImage.size.width, inImage.size.height + 50)
        
        //Now Draw the text into an image.
        drawText.drawInRect(rect, withAttributes: textFontAttributes)
        
        // Create a new image out of the images we have created
        var newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the context now that we have the image we need
        UIGraphicsEndImageContext()
        
        //And pass it back up to the caller.
        return newImage
        
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>) {
        if error == nil {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Save error", message: error?.localizedDescription, preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    func setup() {
        setQRImage()
        qrImageView.image = UIImage(CIImage: ciImage!)
        wifiNameLabel.text = wifiName
    }
    
    func setQRImage() {
        
        let scaleX = qrImageView.frame.size.width / ciImage.extent.size.width
        let scaleY = qrImageView.frame.size.height / ciImage.extent.size.height
        
        let transform = CGAffineTransformMakeScale(scaleX, scaleY)
        
        let imageToSave = ciImage.imageByApplyingTransform(transform)
        
        let softwareContext = CIContext(options: [kCIContextUseSoftwareRenderer:true])
        
        let cgimg = softwareContext.createCGImage(imageToSave, fromRect: imageToSave.extent)
        
        let image = UIImage(CGImage: cgimg)
        
        qrImageView.image = image
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
}
