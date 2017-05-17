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
import MMDrawerController
import GoogleMobileAds

class MainViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource{
    
    let tableView = UITableView()
    let adsBanner = GADBannerView()
    
    let homeID = Constants.thisCotentant?.homeId
    
    var bills: [Bill] = []
    var home: Home? = nil
    var homeRef = FIRDatabase.database().reference(withPath: "homes")
    
    var billsData: [String : Any] = [:]
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "CommonyMoney"
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : Constants.Colors.purple]
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
        tableView.register(CMBillTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CMChartTableViewCell.self, forCellReuseIdentifier: "chart")
        tableView.separatorColor = UIColor.clear
        
        //Table View
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        //Set defaults for billDates and billsPrices
        for i in 0...30{
            let dateToAdd = Date.init(timeIntervalSinceNow: Double(-60 * 60 * 24 * (30 - i))).dateToString(format: "dd-MM-yyyy")
        
            billsData[dateToAdd] = 0
        }
        
        //Baner
        self.view.addSubview(self.adsBanner)
        self.adsBanner.translatesAutoresizingMaskIntoConstraints = false
        //Ads
        adsBanner.adUnitID = "ca-app-pub-9803756475242056/99415681266"
        let request = GADRequest.init()
        request.testDevices = ["Simulator"]
        adsBanner.rootViewController = self
        adsBanner.load(request)
        
        setupConstraints()
        
        //Add button
        let addButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "add"), style: .done, target: self, action: #selector(addButtonAction))
        
        self.navigationItem.rightBarButtonItem = addButtonItem
        
        //Menu button
        let menuButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "leftMenu"), style: .done, target: self, action: #selector(leftMenuAction))
            self.navigationItem.leftBarButtonItem = menuButtonItem
        
        setupDatabaseObserver()
    }
    
    func setupConstraints(){
        
        self.view.addConstraints([
            NSLayoutConstraint.init(item: tableView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: tableView, attribute: .top, relatedBy: .equal,toItem: view, attribute: .top, multiplier: 1.0, constant: 10),
            NSLayoutConstraint.init(item: tableView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: tableView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1.0, constant: -50)])
        
        self.view.addConstraints([
            NSLayoutConstraint.init(item: adsBanner, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: adsBanner, attribute: .top, relatedBy: .equal,toItem: tableView, attribute: .bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: adsBanner, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: -10),
            NSLayoutConstraint.init(item: adsBanner, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)])
    }
    
    //MARK: TableView Selegate and Data Source
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return indexPath.row == 0 ? 160 : 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bills.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        for owner in Constants.cotenents{
            if owner.id == bills[indexPath.row].ownerId{
                
                self.navigationController?.pushViewController(BillDetailsViewController.init(bill: bills[indexPath.row], owner: owner), animated: true)
                return
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard indexPath.row != 0 else {
           return tableView.dequeueReusableCell(withIdentifier: "chart") as! CMChartTableViewCell
        }
        
        if indexPath.row == 1{
            self.setChart(dictionary: self.bills)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CMBillTableViewCell
        
//                cell = CMBillTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        cell.titleLabel.text = bills[indexPath.row].title
        
        cell.ownerAndDateLabel.text = Date.init(timeIntervalSince1970: Double(bills[indexPath.row].date ?? 0)).dateToString(format: "dd-MM-yyyy")
        cell.priceLabel.text = bills[indexPath.row].price?.description
        cell.separatorView.backgroundColor = (self.bills[indexPath.row].price ?? 0 >= 0) ? UIColor.green : UIColor.red
        
        //TODO: change for ownerImage, not bill image
        cell.ownerImage.image = bills[indexPath.row].photo?.convertBase64ToImage()
        
        return cell
    }
    
    //MARK: Chart Data Source and Delegate methods
    
    func setChart(dictionary: [Bill]){
        
        var dataEntries: [ChartDataEntry] = []
        
        var dict = dictionary.sorted { (value1, value2) -> Bool in
            return value1.date ?? 0 < value2.date ?? 0
        }
        
        var entries: [Float] = []
        var e = 0
        
        if dict.count > 0 {
            entries.append(dict[0].price ?? 0)
        }else{
            return
        }
        
        for i in 1..<dict.count{
            
            if Date.init(timeIntervalSince1970: (dict[i-1].date ?? 0)).dateToString(format: "dd-MM-yyyy") == Date.init(timeIntervalSince1970: (dict[i].date ?? 0)).dateToString(format: "dd-MM-yyyy"){
                
                entries[e] += dict[i].price ?? 0
            }else{
                entries.append(entries[e] + (dict[i].price ?? 0))
                e += 1
            }
        }
        
        for i in 0..<entries.count{
            let dataEntry = ChartDataEntry.init(x: Double(i), y: Double(entries[i]), data: nil)
            
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet.init(values: dataEntries, label: "Budget")
        
        chartDataSet.axisDependency = .left
        chartDataSet.setCircleColor(Constants.Colors.purple)
        chartDataSet.setColor(Constants.Colors.purple)
        chartDataSet.lineWidth = 2.0
        chartDataSet.circleRadius = 3.0
        chartDataSet.highlightColor = Constants.Colors.purple
        
        var dataSets = [LineChartDataSet]()
        dataSets.append(chartDataSet)
        
        let chartData = LineChartData.init(dataSets: dataSets)
        chartData.setValueTextColor(Constants.Colors.purple)
        chartData.setValueFont(UIFont.appFont(bold: true, fontSize: 10))
        
        guard let chartCell = self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as? CMChartTableViewCell else {
            return
        }
        
       chartCell.chartView.data = chartData
    }
    
    //MARK: Others methods
    
    func addButtonAction(){
        self.navigationController?.pushViewController(AddBillViewController(), animated: true)
    }
    
    func setupDatabaseObserver(){
        //Home bills
        self.bills = []
        //Current home
        self.home = nil
        
        //Search throu homes to find user's home
        homeRef.queryOrdered(byChild: "id").queryEqual(toValue: self.homeID).observe(.childAdded, with: {(Snapshot) in
            
            if let thisHome = Mapper<Home>().map(JSON: Snapshot.value as? [String : Any] ?? [:]) {
                //Set home and reset budget
                self.home = thisHome
                Constants.thisHome = thisHome
                self.home?.budget = 0
            }
            
        })
        
        //Fild home's bills
        let ref = FIRDatabase.database().reference(withPath: "bills").queryOrdered(byChild: "homeID").queryEqual(toValue: self.homeID)
        
        ref.observe(.childAdded, with: { (snapshot) in
            if let bill = Mapper<Bill>().map(JSON: snapshot.value as? [String : Any] ?? [:]){
                //Append bill to array
                self.bills.append(bill)
                //Sort array by date
                self.bills = self.bills.sorted(by: { (Bill1, Bill2) -> Bool in
                    return Bill1.date ?? 0 >= Bill2.date ?? 0
                })
                
                //Reload tableView and chart with new bill
                self.tableView.reloadData()
                self.setChart(dictionary: self.bills)
                
            }
        })
        
        //Find cotenants of user
        let refOwners = FIRDatabase.database().reference(withPath: "users").queryOrdered(byChild: "homeId").queryEqual(toValue: self.homeID)
        
        refOwners.observe(.childAdded, with: { (snapshot) in
            if let owner = Mapper<Cotenant>().map(JSON: snapshot.value as? [String : Any] ?? [:]) {
                Constants.cotenents.append(owner)
            }
        })
    }
    
    func leftMenuAction(){
        (self.navigationController?.parent as? MMDrawerController)?.open(.left, animated: true, completion: nil)
    }
    
}
