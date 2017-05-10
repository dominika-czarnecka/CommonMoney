//
//  HistoryViewController.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 07.05.2017.
//  Copyright © 2017 dominika.czarnecka. All rights reserved.
//

import UIKit
import FirebaseDatabase
import ObjectMapper

class HistoryViewController: BaseViewController, UIPickerViewDelegate{
    
    let colaborantTextField = CMTextField(type: "Who?", picker: true)
    let startDateTextField = CMTextField(type: "Start date?", dataPicker: true)
    let endDateTextField = CMTextField(type: "End date?", dataPicker: true)
    
    var owner: Cotenant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "History"
        let doneItem = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(doneItemAction))
        self.navigationItem.setRightBarButton(doneItem, animated: true)
        
        self.view.addSubview(colaborantTextField)
        colaborantTextField.translatesAutoresizingMaskIntoConstraints = false
        colaborantTextField.pickerView.tag = 0
        colaborantTextField.pickerView.delegate = self
        
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
        return Constants.cotenents.count + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0{
            return "All"
        }
        return (Constants.cotenents[row - 1].firstName ?? "") + " " + (Constants.cotenents[row - 1].lastName ?? "")
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if row == 0{
            self.owner = nil
            self.colaborantTextField.titleLabel.text = "All"
        }else{
            self.owner = Constants.cotenents[row - 1]
            self.colaborantTextField.titleLabel.text = (Constants.cotenents[row - 1].firstName ?? "") + " " + (Constants.cotenents[row - 1].lastName ?? "")
        }
        
    }
    
    func doneItemAction(){
        
        guard self.colaborantTextField.isValid(withPattern: "^.+$") else{
            return
        }
        
        self.navigationController?.pushViewController(HistoryDetailsViewController.init(owner: self.owner, startDate: self.startDateTextField.dataPickerView.date, endDate: self.endDateTextField.dataPickerView.date), animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
