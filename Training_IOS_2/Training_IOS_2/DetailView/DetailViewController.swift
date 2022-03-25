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
        title = "Detail"
    }

    @IBAction func scrToolBar(_ sender: Any) {
        showAlert()

    }
   


   func showAlert() {
        let alert = UIAlertController(title: "Title", message: "chuyen man hinh", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "move", style: .default , handler:{ (UIAlertAction)in
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "ToolBarViewController")
            self.present(vc, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Share", style: .default , handler:{ (UIAlertAction)in
            print("User click Edit button")
            self.share()
        }))

        alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
            print("User click Delete button")
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))

        
        //uncomment for iPad Support
        //alert.popoverPresentationController?.sourceView = self.view

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    func share(){
        let items = ["This app is my favorite"]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
}
