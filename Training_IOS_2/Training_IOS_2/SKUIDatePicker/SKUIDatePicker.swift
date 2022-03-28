//
//  SKUIDatePicker.swift
//  Training_IOS_2
//
//  Created by Pham Van Thai on 28/03/2022.
//

import UIKit

protocol SKUIDatePickerDelegate:AnyObject {
    func getDate(_ sKUIDatePicker:SKUIDatePicker, date:String)
    func cancel(_ sKUIDatePicker:SKUIDatePicker)
}

class SKUIDatePicker:UIView {
    
    private let datePicker = UIDatePicker()
    private var dateFormate = "dd/mm/yyyy"
    weak var delegate:SKUIDatePickerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // self.frame = UIScreen.main.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showDatePicker(txtDatePicker:UITextField){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action:       #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem:       UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action:       #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        txtDatePicker.inputAccessoryView = toolbar
        txtDatePicker.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormate
        let result = formatter.string(from: datePicker.date)
        self.delegate?.getDate(self, date: result)
        
    }
    
    @objc func cancelDatePicker(){
        self.delegate?.cancel(self)
    }
    
}
