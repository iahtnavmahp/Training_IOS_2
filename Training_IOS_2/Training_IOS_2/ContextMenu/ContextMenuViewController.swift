//
//  ContextMenuViewController.swift
//  Training_IOS_2
//
//  Created by Pham Van Thai on 25/03/2022.
//

import UIKit

class ContextMenuViewController: UIViewController, UIContextMenuInteractionDelegate,UITextViewDelegate {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let interaction = UIContextMenuInteraction(delegate: self)
        img.addInteraction(interaction)
        img.isUserInteractionEnabled = true
        addCustomMenu()
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
           //Xcode doesn't like printToConsole being a var and a function call
           let printToConsole = UIMenuItem(title: "test custom menu", action: #selector(printToConsole2))

            UIMenuController.shared.menuItems = [printToConsole]
        }

        @objc func printToConsole2() {
           if let range = textView.selectedTextRange, let selectedText = textView.text(in: range) {
              print(selectedText)
           }
        }
}
