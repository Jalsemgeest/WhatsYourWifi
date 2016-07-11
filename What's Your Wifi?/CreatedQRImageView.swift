//
//  CreatedQRImageView.swift
//  What's Your Wifi?
//
//  Created by Jake Alsemgeest on 2016-07-09.
//  Copyright © 2016 Jalsemgeest. All rights reserved.
//

import UIKit

class CreatedQRImageView: UIViewController {

    var qrCode : QRCode! {
        didSet {
            image = qrCode.getQRCodeImage()
        }
    }
    var image : CIImage?
    
    @IBOutlet weak var wifiNameLabel: UILabel!
    @IBOutlet weak var qrImageView: UIImageView!
    
    @IBAction func saveWifiInfo() {
        Service.saveQRImage(qrCode, from: self)
    }
    
    func setup() {
        setQRImage()
        wifiNameLabel.text = qrCode.wifiName
    }
    
    func setQRImage() {
        qrImageView.image = qrCode.getQRCodeScaled(qrImageView.frame.size.width, height: qrImageView.frame.size.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

extension UIViewController {
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
}
