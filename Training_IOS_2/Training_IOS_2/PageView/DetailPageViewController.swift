//
//  DetailPageViewController.swift
//  Training_IOS_2
//
//  Created by Pham Van Thai on 25/03/2022.
//

import UIKit

class DetailPageViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    var str :String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle?.text = str
    }
    

}
