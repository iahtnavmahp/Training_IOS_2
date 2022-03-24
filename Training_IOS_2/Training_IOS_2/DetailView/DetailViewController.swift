//
//  ViewController.swift
//  Training_IOS_2
//
//  Created by Pham Van Thai on 24/03/2022.
//

import UIKit

class DetailViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func scrToolBar(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "ToolBarViewController")
        self.present(vc, animated: true, completion: nil)
    }
    
}

