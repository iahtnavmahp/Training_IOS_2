//
//  SheetViewController.swift
//  Training_IOS_2
//
//  Created by Pham Van Thai on 25/03/2022.
//

import UIKit
import WebKit
class SheetViewController: UIViewController {

    @IBOutlet weak var myWebView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        myWebView.load(NSURLRequest(url: NSURL(string: "https://developer.apple.com/documentation/webkit/wkwebview")! as URL) as URLRequest)
    }


}
