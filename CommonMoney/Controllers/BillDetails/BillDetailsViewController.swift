//
//  AddBillViewController.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 03.12.2016.
//  Copyright © 2016 dominika.czarnecka. All rights reserved.
//

import UIKit
import FirebaseDatabase
import KVNProgress

class BillDetailsViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var bill: Bill? = nil
    var owner: Cotenant? = nil
    
    let ref = FIRDatabase.database().reference(withPath: "bills")
    
    let scrollView = UIScrollView()
    
    let whoTextField = CMTextField(type: "Who?")
    let titleTextField = CMTextField(type: "Title?")
    let typeTextField = CMTextField(type: "What?")
    let priceTextField = CMTextField(type: "How much?")
    let dateTextField = CMTextField(type: "Date?", dataPicker: true)
    let imageView = AddBillImageView()
    
    var imageHeightContraint: NSLayoutConstraint? = nil
    
    var activityIndicatorView: UIActivityIndicatorView
    
    init(bill: Bill, owner: Cotenant){
        
        let user = Constants.thisCotentant
        
        self.activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        self.bill = bill
        self.owner = owner
        
        super.init()
        
        if owner.id == user?.id{
            
            let deleteItem = UIBarButtonItem.init(title: "Delete", style: .done, target: self, action: #selector(deleteItemAction))
            self.navigationItem.setRightBarButton(deleteItem, animated: true)
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationItem.title = "Bill"
        
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = false
        
        self.scrollView.addSubview(whoTextField)
        whoTextField.translatesAutoresizingMaskIntoConstraints = false
        whoTextField.titleLabel.text = (owner?.firstName ?? "") + " " + (owner?.lastName ?? "")
        whoTextField.titleLabel.userActivity = .none
        
        self.scrollView.addSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.titleLabel.text = bill?.title ?? ""
        titleTextField.titleLabel.userActivity = .none
        
        self.scrollView.addSubview(typeTextField)
        typeTextField.translatesAutoresizingMaskIntoConstraints = false
        typeTextField.titleLabel.text = bill?.type ?? ""
        typeTextField.titleLabel.userActivity = .none
        
        self.scrollView.addSubview(priceTextField)
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        priceTextField.titleLabel.keyboardType = .decimalPad
        priceTextField.titleLabel.text = bill?.price?.description ?? ""
        priceTextField.titleLabel.userActivity = .none
        
        self.scrollView.addSubview(dateTextField)
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        dateTextField.titleLabel.userActivity = .none
        
        let formater = DateFormatter()
        formater.dateFormat = "dd-MM-yyyy"
        
        dateTextField.titleLabel.text = formater.string(from: Date.init(timeIntervalSince1970: bill?.date ?? 0) as Date)
        
        self.scrollView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.imageButton.setImage(bill?.photo?.convertBase64ToImage(), for: .normal)
        imageView.userActivity = .none
        setupConstraints()
        
    }
    
    func deleteItemAction(){
        
        let confirmAlert = UIAlertController.init(title: "Delete bill?", message: "Are u sure u want to delete this bill? ", preferredStyle: .alert)
        confirmAlert.addAction(UIAlertAction.init(title: "Yes", style: .default, handler: { (UIAlertAction) in
            
            guard self.bill?.id != nil else{
                return
            }
            
            self.ref.child((self.bill?.id)!).removeValue { (error, ref) in
                if error != nil {
                    print("error \(error)")
                }else{
                    _ = self.navigationController?.popViewController(animated: true)
                }
            }

        }))
        confirmAlert.addAction(UIAlertAction.init(title: "No", style: .cancel, handler: nil))
        self.present(confirmAlert, animated: true, completion: nil)
        
    }
    
    func setupConstraints(){
        
        self.view.addConstraints(
            [NSLayoutConstraint.init(item: scrollView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0),
             NSLayoutConstraint.init(item: scrollView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
             NSLayoutConstraint.init(item: scrollView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1.0, constant: 0),
             NSLayoutConstraint.init(item: scrollView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0)
            ])
        
        self.scrollView.addConstraints(
            [NSLayoutConstraint.init(item: whoTextField, attribute: .top, relatedBy: .equal, toItem: self.scrollView, attribute: .top, multiplier: 1.0, constant: Constants.Space.CMTtextFieldSpace),
             NSLayoutConstraint.init(item: whoTextField, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.0, constant: 0),
             NSLayoutConstraint.init(item: whoTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40),
             NSLayoutConstraint.init(item: whoTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: Constants.Size.CMTextFieldSize.width)
            ])
        
        self.scrollView.addConstraints(
            [NSLayoutConstraint.init(item: titleTextField, attribute: .top, relatedBy: .equal, toItem: whoTextField, attribute: .bottom, multiplier: 1.0, constant: Constants.Space.CMTtextFieldSpace),
             NSLayoutConstraint.init(item: titleTextField, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.0, constant: 0),
             NSLayoutConstraint.init(item: titleTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40),
             NSLayoutConstraint.init(item: titleTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: Constants.Size.CMTextFieldSize.width)
            ])
        
        self.scrollView.addConstraints(
            [NSLayoutConstraint.init(item: typeTextField, attribute: .top, relatedBy: .equal, toItem: titleTextField, attribute: .bottom, multiplier: 1.0, constant: Constants.Space.CMTtextFieldSpace),
             NSLayoutConstraint.init(item: typeTextField, attribute: .centerX, relatedBy: .equal, toItem: priceTextField, attribute: .centerX, multiplier: 1.0, constant: 0),
             NSLayoutConstraint.init(item: typeTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40),
             NSLayoutConstraint.init(item: typeTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: Constants.Size.CMTextFieldSize.width)
            ])
        
        self.scrollView.addConstraints(
            [NSLayoutConstraint.init(item: priceTextField, attribute: .top, relatedBy: .equal, toItem: typeTextField, attribute: .bottom, multiplier: 1.0, constant: Constants.Space.CMTtextFieldSpace),
             NSLayoutConstraint.init(item: priceTextField, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.0, constant: 0),
             NSLayoutConstraint.init(item: priceTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40),
             NSLayoutConstraint.init(item: priceTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: Constants.Size.CMTextFieldSize.width)
            ])
        
        
        self.scrollView.addConstraints(
            [NSLayoutConstraint.init(item: dateTextField, attribute: .top, relatedBy: .equal, toItem: priceTextField , attribute: .bottom, multiplier: 1.0, constant: Constants.Space.CMTtextFieldSpace),
             NSLayoutConstraint.init(item: dateTextField, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.0, constant: 0),
             NSLayoutConstraint.init(item: dateTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40),
             NSLayoutConstraint.init(item: dateTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: Constants.Size.CMTextFieldSize.width)
            ])
        
        imageHeightContraint = NSLayoutConstraint.init(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 80)
        
        self.scrollView.addConstraints(
            [NSLayoutConstraint.init(item: imageView, attribute: .top, relatedBy: .equal, toItem: dateTextField, attribute: .bottom, multiplier: 1.0, constant: Constants.Space.CMTtextFieldSpace),
             NSLayoutConstraint.init(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.0, constant: 0),
             imageHeightContraint!,
             NSLayoutConstraint.init(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: Constants.Size.CMTextFieldSize.width),
             NSLayoutConstraint.init(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: self.scrollView, attribute: .bottom, multiplier: 1.0, constant: -40)
            ])
    }
    
}
