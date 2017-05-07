//
//  HistoryViewController.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 07.05.2017.
//  Copyright © 2017 dominika.czarnecka. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let colaborantTextField = CMTextField(type: "Who?", picker: true)
    let startDateTextField = CMTextField(type: "Start date?", dataPicker: true)
    let endDateTextField = CMTextField(type: "End date?", dataPicker: true)
    
    var pickerOptions: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(colaborantTextField)
        colaborantTextField.translatesAutoresizingMaskIntoConstraints = false
        colaborantTextField.pickerView.delegate = self
        colaborantTextField.pickerView.tag = 0
        
        let formater = DateFormatter()
        formater.dateFormat = "dd-MM-yyyy"
        
        self.view.addSubview(startDateTextField)
        startDateTextField.translatesAutoresizingMaskIntoConstraints = false
        startDateTextField.titleLabel.text = formater.string(from: NSDate() as Date)
        startDateTextField.pickerView.tag = 1
        
        self.view.addSubview(endDateTextField)
        endDateTextField.translatesAutoresizingMaskIntoConstraints = false
        endDateTextField.titleLabel.text = formater.string(from: NSDate() as Date)
        endDateTextField.pickerView.tag = 2
        
        setupConstraints()
        
    }
    
    func setupConstraints(){
        
        self.view.addConstraints(
            [NSLayoutConstraint.init(item: colaborantTextField, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: Constants.Space.CMTtextFieldSpace),
             NSLayoutConstraint.init(item: colaborantTextField, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
             NSLayoutConstraint.init(item: colaborantTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40),
             NSLayoutConstraint.init(item: colaborantTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: Constants.Size.CMTextFieldSize.width)
            ])
        
        self.view.addConstraints(
            [NSLayoutConstraint.init(item: startDateTextField, attribute: .top, relatedBy: .equal, toItem: colaborantTextField, attribute: .bottom, multiplier: 1.0, constant: Constants.Space.CMTtextFieldSpace),
             NSLayoutConstraint.init(item: startDateTextField, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
             NSLayoutConstraint.init(item: startDateTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40),
             NSLayoutConstraint.init(item: startDateTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: Constants.Size.CMTextFieldSize.width)
            ])
        
        self.view.addConstraints(
            [NSLayoutConstraint.init(item: endDateTextField, attribute: .top, relatedBy: .equal, toItem: startDateTextField, attribute: .bottom, multiplier: 1.0, constant: Constants.Space.CMTtextFieldSpace),
             NSLayoutConstraint.init(item: endDateTextField, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
             NSLayoutConstraint.init(item: endDateTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40),
             NSLayoutConstraint.init(item: endDateTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: Constants.Size.CMTextFieldSize.width)
            ])
        
    }
    
    //MARK: PickerViewDelegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        colaborantTextField.titleLabel.text = pickerOptions[row]
    }
    
    func doneItemAction(){
        
//        let dateFormatter = DateFormatter.init()
//        dateFormatter.dateFormat = "dd-MM-yyyy"
//        
//        let title = colaborantTextField.titleLabel.text!
//        let type = colaborantTextField.titleLabel.text!
//        let price = colaborantTextField.titleLabel.text!
//        let date = colaborantTextField.titleLabel.text!
//        
//        //3
//        let newBillRef = self.ref
//            .childByAutoId()
//        
//        let newBillId = newBillRef.key
//        
//        let photo = imageView.imageButton.image(for: .normal) != #imageLiteral(resourceName: "add") ? imageView.imageButton.image(for: .normal)?.toBase64(quality: 0.4) : nil
//        
//        let bill = Bill.init(id: newBillId, homeID: self.homeID, title: title, ownerId: self.cotenantID, date: dateFormatter.date(from: date)!.timeIntervalSince1970, fullPrice: type == "Income" ? Float(NSString(string: price).floatValue) : -Float(NSString(string: price).floatValue), type: type, photo: photo)
//        
//        // 4
//        newBillRef .setValue(bill.toJSON())
//        
//        KVNProgress.showSuccess(withStatus: "Bill added")
//        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
