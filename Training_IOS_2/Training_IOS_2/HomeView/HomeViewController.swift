//
//  HomeViewController.swift
//  Training_IOS_2
//
//  Created by Pham Van Thai on 24/03/2022.
//

import UIKit

class HomeViewController: UIViewController ,UIActionSheetDelegate{
    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
                "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
                "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
                "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
                "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    var dataFilter :[String] = []
    @IBOutlet weak var myTableView: UITableView!
    private var pullControl = UIRefreshControl()
    @IBOutlet weak var mySearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configNav()
        mySearchBar.delegate = self
        dataFilter = data
        configPull()
    }
    func configPull(){
        pullControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            myTableView.refreshControl = pullControl
        } else {
            myTableView.addSubview(pullControl)
        }
    }
    func showAlert(){
        let alert = UIAlertController(title: "Title",
                                      message: "Click ?",
                                      preferredStyle: .alert)
        
        
        // Add action buttons to it and attach handler functions if you want to
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in
            print("cancel")
        }))
        alert.addAction(UIAlertAction(title: "WebView", style: .destructive, handler: {_ in
            self.presentModal()
        }))
        alert.addAction(UIAlertAction(title: "Context Menus", style: .default, handler: {_ in
                                        let vc = self.storyboard!.instantiateViewController(withIdentifier: "ContextMenuViewController") as! ContextMenuViewController
                                        
                                        
                                        self.present(vc, animated: true, completion: nil)        }))
        
        // Show the alert by presenting it
        
        self.present(alert, animated: true)
    }
    func presentModal() {
        
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "SheetViewController") as! SheetViewController
        
        
        self.present(vc, animated: true, completion: nil)
        
    }
    func configTableView(){
        myTableView.register(UINib(nibName: "SearchBarTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchBarTableViewCell")
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    func configNav(){
        title = "Home"
        navigationController?.navigationBar.barTintColor = .cyan
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor : UIColor(ciColor: .black),
            .font: UIFont(name: "MarkerFelt-Thin", size: 20)!,
        ]
        let button: UIButton = UIButton()
        button.setImage(UIImage(systemName: "swift"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(run), for: .touchUpInside)
        let buttonItemBar = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = buttonItemBar
        let button2: UIButton = UIButton()
        button2.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        button2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button2.addTarget(self, action: #selector(run2), for: .touchUpInside)
        let buttonItemBar2 = UIBarButtonItem(customView: button2)
        self.navigationItem.rightBarButtonItems = [buttonItemBar,buttonItemBar2]
        navigationItem.backBarButtonItem = UIBarButtonItem(
            
            image: UIImage(systemName: "star.circle.fill"), style: .plain,
            target: self,
            action: #selector(popViewController)
        )
        
        
        
    }
    @objc private func refreshListData(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.pullControl.endRefreshing()
        }
        
    }
    @objc func run(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func run2(){
        showAlert()
    }
    @objc func popViewController(){
        navigationController?.popViewController(animated: true)
    }
    
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBarTableViewCell", for: indexPath) as? SearchBarTableViewCell else { return UITableViewCell() }
        cell.lblTitle?.text = dataFilter[indexPath.row]
        return cell
    }
}
extension HomeViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataFilter = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
            
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        myTableView.reloadData()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.mySearchBar.showsCancelButton = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.mySearchBar.showsCancelButton = false
        self.mySearchBar.text = ""
        self.mySearchBar.resignFirstResponder()
        self.dataFilter = data
        self.myTableView.reloadData()
    }
}
