//
//  MainViewController.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 20.11.2016.
//  Copyright © 2016 dominika.czarnecka. All rights reserved.
//

import UIKit
import FirebaseDatabase
import ANDLineChartView

import ObjectMapper

class MainViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, ANDLineChartViewDataSource{
    
    let ref = FIRDatabase.database().reference(withPath: "bills")
    
    let tableView = UITableView()
    let chartView = ANDLineChartView.init()
    
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
        
        //Table View
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        //Chart View
        self.view.addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.chartBackgroundColor = Colors.darkBlue
        chartView.dataSource = self
        chartView.layer.cornerRadius = 10
        
        setupConstraints()
        
        //Add button
        let addButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "add"), style: .done, target: self, action: #selector(addButtonAction))
        
        self.navigationItem.rightBarButtonItem = addButtonItem
        
    }

    func setupConstraints(){
        
        self.view.addConstraints([
            NSLayoutConstraint.init(item: chartView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: chartView, attribute: .top, relatedBy: .equal,toItem: view, attribute: .top, multiplier: 1.0, constant: 25),
            NSLayoutConstraint.init(item: chartView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: -10),
            NSLayoutConstraint.init(item: chartView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 200)])
        
        self.view.addConstraints([
            NSLayoutConstraint.init(item: tableView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: tableView, attribute: .top, relatedBy: .equal,toItem: chartView, attribute: .bottom, multiplier: 1.0, constant: 20),
            NSLayoutConstraint.init(item: tableView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: tableView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1.0, constant: -215)])
        
    }
    
    //MARK: TableView Selegate and Data Source
    
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
        
        //TODO: change for ownerImage, not bill image
        cell.ownerImage.image = bills[indexPath.row].photo?.convertBase64ToImage()
        
        return cell
    }

    
    //MARK: Chart Data Source and Delegate methods
    
    func numberOfElements(in chartView: ANDLineChartView!) -> UInt {
        return UInt(bills.count)
    }
    
    func chartView(_ chartView: ANDLineChartView!, valueForElementAtRow row: UInt) -> CGFloat {
        return bills[Int(row)].price ?? 0
    }
    
    func numberOfGridIntervals(in chartView: ANDLineChartView!) -> UInt {
        return 5
    }
    
    public func chartView(_ chartView: ANDLineChartView!, descriptionForGridIntervalValue interval: CGFloat) -> String! {
        return interval.description
    }
    
    func maxValueForGridInterval(in chartView: ANDLineChartView!) -> CGFloat {
        return 100
    }
    
    func minValueForGridInterval(in chartView: ANDLineChartView!) -> CGFloat {
        return 0
    }
    
    //MARK: Others methods
    
    func addButtonAction(){
        self.navigationController?.pushViewController(AddBillViewController(), animated: true)
    }
    
    func setupDatabaseObserver(){
        //TODO: bill with homeID
        
        ref.queryOrdered(byChild: "title").observe(.childAdded, with: { (snapshot) in
            
            if let bill = Mapper<Bill>().map(JSON: snapshot.value as? [String : Any] ?? [:]) {
                self.bills.append(bill)
                self.tableView.reloadData()
                self.chartView.reloadData()
            }

        })
    }
    
}
