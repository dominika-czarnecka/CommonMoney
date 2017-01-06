//
//  MainViewController.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 20.11.2016.
//  Copyright © 2016 dominika.czarnecka. All rights reserved.
//

import UIKit
import FirebaseDatabase

import ObjectMapper

class MainViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    let ref = FIRDatabase.database().reference(withPath: "bills")
    let tableView = UITableView()
    var bills: [Bill] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: false)
    
        setupDatabaseObserver()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
        tableView.register(CMBillTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorColor = UIColor.clear
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addConstraints([
            NSLayoutConstraint.init(item: tableView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: tableView, attribute: .top, relatedBy: .equal,toItem: view, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: tableView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: tableView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1.0, constant: 0)])
        
        let addButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "add"), style: .done, target: self, action: #selector(addButtonAction))
        
        self.navigationItem.rightBarButtonItem = addButtonItem
        
    }

    //MARK: TableView delegate and dataSource
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return UIView()
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bills.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CMBillTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CMBillTableViewCell
        
        cell = CMBillTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.titleLabel.text = bills[indexPath.row].title
        
        cell.ownerAndDateLabel.text = Date.init(timeIntervalSince1970: Double(bills[indexPath.row].date ?? 0)).dateToString(format: "dd-MM-yyyy")
        cell.priceLabel.text = bills[indexPath.row].price?.description
        cell.separatorView.backgroundColor = UIColor.blue
        
        return cell
    }

    func addButtonAction(){
        self.navigationController?.pushViewController(AddBillViewController(), animated: true)
    }
    
    func setupDatabaseObserver(){
        //TODO: bill with homeID
        
        ref.queryOrdered(byChild: "title").observe(.childAdded, with: { (snapshot) in
            
            print(snapshot.debugDescription)
            
            if let bill = Mapper<Bill>().map(JSON: snapshot.value as? [String : Any] ?? [:]) {
                self.bills.append(bill)
            }
            self.tableView.reloadData()
        })
    }
    
}
