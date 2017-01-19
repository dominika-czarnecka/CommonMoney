//
//  MainViewController.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 20.11.2016.
//  Copyright © 2016 dominika.czarnecka. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Charts
import ObjectMapper

class MainViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource{
    
    let tableView = UITableView()
    let chartView = LineChartView.init(frame: CGRect.zero)
    
    let homeID: String = UserDefaults.standard.object(forKey: "thisHomeID") as! String
    
    var bills: [Bill] = []
    var owners: [Cotenant] = []
    
    var billsDates: [String] = []
    var billsPrices: [Double] = []
    
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
        chartView.layer.cornerRadius = 10
        
        chartView.gridBackgroundColor = UIColor.blue
        
        //chartView.leftAxis.drawGridLinesEnabled = false
        chartView.leftAxis.axisMinimum = 0
        chartView.leftAxis.drawAxisLineEnabled = true
        chartView.leftAxis.labelFont = UIFont.appFont(bold: false, fontSize: 8)
        
        chartView.rightAxis.drawGridLinesEnabled = false
        chartView.rightAxis.drawAxisLineEnabled = false
        chartView.rightAxis.drawLabelsEnabled = false
        
        //chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.labelPosition = .topInside
        chartView.xAxis.drawLabelsEnabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        
        setupConstraints()
        
        //Add button
        let addButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "add"), style: .done, target: self, action: #selector(addButtonAction))
        
        self.navigationItem.rightBarButtonItem = addButtonItem
        
    }

    func setupConstraints(){
        
        self.view.addConstraints([
            NSLayoutConstraint.init(item: chartView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: chartView, attribute: .top, relatedBy: .equal,toItem: view, attribute: .top, multiplier: 1.0, constant: 10),
            NSLayoutConstraint.init(item: chartView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: -10),
            NSLayoutConstraint.init(item: chartView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 150)])
        
        self.view.addConstraints([
            NSLayoutConstraint.init(item: tableView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: tableView, attribute: .top, relatedBy: .equal,toItem: chartView, attribute: .bottom, multiplier: 1.0, constant: 20),
            NSLayoutConstraint.init(item: tableView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)])
        
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
        
        for owner in owners{
            if owner.id == bills[indexPath.row].ownerId{
                
                self.navigationController?.pushViewController(BillDetailsViewController.init(bill: bills[indexPath.row], owner: owner), animated: true)
                
                return
            }
            
        }
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
    
    func setChart(dataPoints: [String], values: [Double]) {
        chartView.noDataText = "No data."
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry.init(x: Double(i), y: values[i], data: dataPoints[i] as AnyObject?)// init(x: Double(i), yValues: [values[i]], label: dataPoints[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet.init(values: dataEntries, label: "Budget")

        chartDataSet.axisDependency = .left
        chartDataSet.setCircleColor(Colors.darkBlue)
        chartDataSet.setColor(Colors.darkBlue)
        chartDataSet.lineWidth = 2.0
        chartDataSet.circleRadius = 3.0 // the radius of the node circle
      //  chartDataSet.fillAlpha = 65 / 255.0
        chartDataSet.highlightColor = UIColor.white
        //chartDataSet.drawCircleHoleEnabled = true
        
        var dataSets = [LineChartDataSet]()
        dataSets.append(chartDataSet)
        
        let chartData = LineChartData.init(dataSets: dataSets)
        chartData.setValueTextColor(UIColor.white)
        chartData.setValueFont(UIFont.appFont(bold: true, fontSize: 12))
        chartView.data = chartData
        
    }
    
    //MARK: Others methods
    
    func addButtonAction(){
        self.navigationController?.pushViewController(AddBillViewController(), animated: true)
    }
    
    func setupDatabaseObserver(){
        
        let ref = FIRDatabase.database().reference(withPath: "bills")//.queryOrdered(byChild: "homeID").queryEqual(toValue: self.homeID)
        
        ref.queryOrdered(byChild: "id").observe(.childAdded, with: { (snapshot) in
            
            if let bill = Mapper<Bill>().map(JSON: snapshot.value as? [String : Any] ?? [:]){
                
                guard bill.homeID == self.homeID else{
                    return
                }
                
                self.bills.append(bill)
                self.billsDates.append(Date.init(timeIntervalSince1970: Double(bill.date ?? 0)).dateToString(format: "dd-MM-yyyy"))
                self.billsPrices.append(Double(bill.price ?? 0))
                
                self.tableView.reloadData()
                self.setChart(dataPoints: self.billsDates, values:self.billsPrices)
            }

        })
        
        let refOwners = FIRDatabase.database().reference(withPath: "users")//.queryOrdered(byChild: "homeID").queryEqual(toValue: self.homeID)
        
        refOwners.queryOrdered(byChild: "id").observe(.childAdded, with: { (snapshot) in
            
            if let owner = Mapper<Cotenant>().map(JSON: snapshot.value as? [String : Any] ?? [:]) {
                
                guard owner.homeId == self.homeID else{
                    return
                }
                
                self.owners.append(owner)
            }
            
        })
        
    }
    
}
