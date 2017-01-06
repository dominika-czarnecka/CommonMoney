//
//  AddBillViewController.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 03.12.2016.
//  Copyright © 2016 dominika.czarnecka. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddBillViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let ref = FIRDatabase.database().reference(withPath: "bills")
    
    let titleTextField = CMTextField(type: "Title?")
    let typeTextField = CMTextField(type: "What?")
    let priceTextField = CMTextField(type: "How much?")
    let dateTextField = CMTextField(type: "Date?", dataPicker: true)
    let imageView = AddBillImageView()

    
    var activityIndicatorView: UIActivityIndicatorView
    
    override init(){
        
        self.activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationItem.title = "Adding bill"
        let doneItem = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(doneItemAction))
        self.navigationItem.setRightBarButton(doneItem, animated: true)
        
        self.view.addSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.titleLabel.placeholder = "Title"
        
        //TODO: not textField
        self.view.addSubview(typeTextField)
        typeTextField.translatesAutoresizingMaskIntoConstraints = false
        typeTextField.titleLabel.placeholder = "type temperary textField"
        
        self.view.addSubview(priceTextField)
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        priceTextField.titleLabel.keyboardType = .decimalPad
        priceTextField.titleLabel.placeholder = "Price"
        
        self.view.addSubview(dateTextField)
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let formater = DateFormatter()
        formater.dateFormat = "dd-MM-yyyy"
        
        dateTextField.titleLabel.text = formater.string(from: NSDate() as Date)
        
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.imageButton.addTarget(self, action: #selector(imageButtonAction), for: .touchUpInside)
        
        setupConstraints()
        
    }

    func setupConstraints(){
        
        self.view.addConstraints(
            [NSLayoutConstraint.init(item: titleTextField, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: Space.CMTtextFieldSpace),
             NSLayoutConstraint.init(item: titleTextField, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
             NSLayoutConstraint.init(item: titleTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40),
             NSLayoutConstraint.init(item: titleTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: Size.CMTextFieldSize.width)
            ])
        
        self.view.addConstraints(
            [NSLayoutConstraint.init(item: typeTextField, attribute: .top, relatedBy: .equal, toItem: titleTextField, attribute: .bottom, multiplier: 1.0, constant: Space.CMTtextFieldSpace),
             NSLayoutConstraint.init(item: typeTextField, attribute: .centerX, relatedBy: .equal, toItem: priceTextField, attribute: .centerX, multiplier: 1.0, constant: 0),
             NSLayoutConstraint.init(item: typeTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40),
             NSLayoutConstraint.init(item: typeTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: Size.CMTextFieldSize.width)
            ])
        
        self.view.addConstraints(
            [NSLayoutConstraint.init(item: priceTextField, attribute: .top, relatedBy: .equal, toItem: typeTextField, attribute: .bottom, multiplier: 1.0, constant: Space.CMTtextFieldSpace),
            NSLayoutConstraint.init(item: priceTextField, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: priceTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40),
            NSLayoutConstraint.init(item: priceTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: Size.CMTextFieldSize.width)
            ])

        
        self.view.addConstraints(
            [NSLayoutConstraint.init(item: dateTextField, attribute: .top, relatedBy: .equal, toItem: priceTextField , attribute: .bottom, multiplier: 1.0, constant: Space.CMTtextFieldSpace),
             NSLayoutConstraint.init(item: dateTextField, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
             NSLayoutConstraint.init(item: dateTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40),
             NSLayoutConstraint.init(item: dateTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: Size.CMTextFieldSize.width)
            ])
        
        self.view.addConstraints(
            [NSLayoutConstraint.init(item: imageView, attribute: .top, relatedBy: .equal, toItem: dateTextField, attribute: .bottom, multiplier: 1.0, constant: Space.CMTtextFieldSpace),
             NSLayoutConstraint.init(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
             NSLayoutConstraint.init(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 80),
             NSLayoutConstraint.init(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: Size.CMTextFieldSize.width)
            ])
    }
    
    func imageButtonAction(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.camera
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: ImagePickerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        imageView.billImage.image = image
        
        self.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func doneItemAction(){
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        guard let title = titleTextField.titleLabel.text, let type = typeTextField.titleLabel.text, let price = priceTextField.titleLabel.text, let date = dateTextField.titleLabel.text else{
            
            let alert = UIAlertController.init(title: "Adding bill", message: "Cannot add bill", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        //3
        let newBillRef = self.ref
            .childByAutoId()
        
        let newBillId = newBillRef.key
        
        let bill = Bill.init(id: newBillId, title: title, ownerId: "12345", date: dateFormatter.date(from: date)!.timeIntervalSince1970, fullPrice: CGFloat(NSString(string: price).floatValue), type: type, photo: imageView.billImage.image)

        // 4
        //TODO: no date in batabase
        newBillRef .setValue(bill.toJSON())
        
        let alert = UIAlertController.init(title: "Adding bill", message: "Bill has been added", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
