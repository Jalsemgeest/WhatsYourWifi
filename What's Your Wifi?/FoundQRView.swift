//
//  FoundQRView.swift
//  What's Your Wifi?
//
//  Created by Jake Alsemgeest on 2016-07-10.
//  Copyright © 2016 Jalsemgeest. All rights reserved.
//

import UIKit

class FoundQRView: UIViewController {

    var qrCode : QRCode!
    
    @IBOutlet weak var wifiNameLabel: UILabel!
    @IBOutlet weak var wifiPasswordTextField: UITextField!
    
    
    @IBAction func copyPassword() {
        UIPasteboard.generalPasteboard().string = wifiPasswordTextField.text
    }
    
    func setFields() {
        wifiNameLabel.text = qrCode.wifiName
        wifiPasswordTextField.text = qrCode.password
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFields()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
