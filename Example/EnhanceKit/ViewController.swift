//
//  ViewController.swift
//  EnhanceKit
//
//  Created by lixinxing on 01/10/2022.
//  Copyright (c) 2022 lixinxing. All rights reserved.
//

import UIKit
import EnhanceKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let str:NSString = "abcdefg"
        let data = str.data(using:  String.Encoding.utf8.rawValue)!
        
        let secKey: NSString = "cCaCAbACtQDUsbc6AgMnAAcCBEquaek5"
        let data2 = (data as NSData).aesEncrypt(withKey: secKey.data(using: String.Encoding.utf8.rawValue)!, iv: nil)!
        let str2 = (data2 as NSData).aesDecryptWithkey(secKey.data(using: String.Encoding.utf8.rawValue)!, iv: nil)
        print(NSString.init(data: str2!, encoding: String.Encoding.utf8.rawValue)!)
        
        view.backgroundColor = UIColor.eh.hexColor("#FFD8D8D822")
        
        
        print("\(Date.init().eh.format("HH:mm"))")
        print("\(Date.init().eh.weekday())")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

