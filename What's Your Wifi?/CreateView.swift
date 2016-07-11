//
//  ViewController.swift
//  What's Your Wifi?
//
//  Created by Jake Alsemgeest on 2016-07-09.
//  Copyright © 2016 Jalsemgeest. All rights reserved.
//

import UIKit

class CreateView: UIViewController {

    @IBOutlet weak var ssidTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var qrCode: QRCode?
    
    @IBAction func attemptCreate() {
        if let ssid = ssidTextField.text {
            if let password = passwordTextField.text {
                qrCode = QRCode(name: ssid, password: password)
                goToQRPreview()
            }
        }
    }
    
    // Navigation
    
    @IBAction func goBack(segue: UIStoryboardSegue) {
    }
    
    func goToQRPreview() {
        self.performSegueWithIdentifier(Constants.Segues.SHOW_CREATED_WIFI_QR, sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch (identifier) {
            case Constants.Segues.SHOW_CREATED_WIFI_QR:
                if let cQRVc = segue.destinationView as? CreatedQRImageView {
                    cQRVc.qrCode = self.qrCode
                }
                break;
            default:
                break;
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension UIStoryboardSegue {
    var destinationView : UIViewController {
        get {
            if let vc = self.destinationViewController as? UINavigationController {
                return vc.topViewController!
            } else {
                return self.destinationViewController
            }
        }
    }
}

