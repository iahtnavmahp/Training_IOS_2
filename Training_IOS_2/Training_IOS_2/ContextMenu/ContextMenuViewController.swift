//
//  ContextMenuViewController.swift
//  Training_IOS_2
//
//  Created by Pham Van Thai on 25/03/2022.
//

import UIKit

class ContextMenuViewController: UIViewController, UIContextMenuInteractionDelegate,UITextViewDelegate{
    
 
    @IBOutlet weak var activityIndicators: UIActivityIndicatorView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var txtDatePicker: UITextField!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lblInt: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    private var skUIdatePicker:SKUIDatePicker?
    var switchChage = false
    var idx:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let interaction = UIContextMenuInteraction(delegate: self)
        img.addInteraction(interaction)
        img.isUserInteractionEnabled = true
        addCustomMenu()
        configSKUIDatePiker()
        configActivityIndicators()
    }
    func configActivityIndicators(){
        activityIndicators.style = .large
        activityIndicators.color = .red
    }
    func configSKUIDatePiker(){
        skUIdatePicker = SKUIDatePicker()
        skUIdatePicker!.delegate = self
        skUIdatePicker!.showDatePicker(txtDatePicker:txtDatePicker)
    }
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return  UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ -> UIMenu? in
            return self.createContextMenu()
        }
    }
    func createContextMenu() -> UIMenu {
        let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
            print("Share")
        }
        
        let copy = UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc")) { _ in
            print("Copy")
        }
        
        let saveToPhotos = UIAction(title: "Add To Photos", image: UIImage(systemName: "photo")) { _ in
            print("Save to Photos")
        }
        
        return UIMenu(title: "Click", children: [shareAction, copy, saveToPhotos])
    }
    func addCustomMenu() {
        
        let printToConsole = UIMenuItem(title: "test custom menu", action: #selector(printToConsole2))
        
        UIMenuController.shared.menuItems = [printToConsole]
    }
    
    @objc func printToConsole2() {
        if let range = textView.selectedTextRange, let selectedText = textView.text(in: range) {
            print(selectedText)
        }
    }
    @IBAction func Switch(_ sender: Any) {
        switchChage = !switchChage
        switchChage ? activityIndicators.startAnimating() : activityIndicators.stopAnimating()
    }
    @IBAction func sliderAction(_ sender: UISlider) {
        idx = Int(sender.value)
        stepper.value = Double(idx)
        lblInt?.text = "\(idx)"
    }
    @IBAction func stepperAction(_ sender: UIStepper) {
        idx = Int(sender.value)
        slider.value = Float(idx)
        lblInt?.text = "\(idx)"
    }
}
extension ContextMenuViewController :SKUIDatePickerDelegate {
    func getDate(_ sKUIDatePicker: SKUIDatePicker, date: String) {
        print(date)
        self.view.endEditing(true)
    }
    
    func cancel(_ sKUIDatePicker: SKUIDatePicker) {
        self.view.endEditing(true)
    }
}
