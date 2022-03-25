//
//  ToolBarViewController.swift
//  Training_IOS_2
//
//  Created by Pham Van Thai on 24/03/2022.
//

import UIKit

class ToolBarViewController: UIViewController{
    
    
    @IBOutlet weak var myToolBar: UIToolbar!
    @IBOutlet weak var bottomNS: NSLayoutConstraint!
    @IBOutlet weak var myTableView: UITableView!
    var textfield : UITextField = UITextField()
    var listTest :[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        configToolBar()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        configTableView()
    }
    func configTableView(){
        myTableView.register(UINib(nibName: "SearchBarTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchBarTableViewCell")
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    func configToolBar(){
        
        textfield.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        textfield.placeholder = "  ..."
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        textfield.layer.cornerRadius = 10
        let buttonItemBar = UIBarButtonItem(customView: textfield)
        self.navigationItem.rightBarButtonItem = buttonItemBar
        let button: UIButton = UIButton()
        button.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.addTarget(self, action: #selector(test2), for: .touchUpInside)
        let buttonItemBar2 = UIBarButtonItem(customView: button)
        
        myToolBar.items = [buttonItemBar,buttonItemBar2]
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func test2(){
      
        if let text = self.textfield.text{
            if text.count > 0{
                self.listTest.append(text)
                self.textfield.text = ""
                self.myTableView.reloadData()
            }else{
                print("nhap text")
            }
        }
   
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        bottomNS.constant = keyboardSize.height
        
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        bottomNS.constant = 0
    }
 
    
}
extension ToolBarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBarTableViewCell", for: indexPath) as? SearchBarTableViewCell else { return UITableViewCell() }
        cell.lblTitle?.text = listTest[indexPath.row]
        return cell
    }
}
