//
//  CMChartTableViewCell.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 18.04.2017.
//  Copyright © 2017 dominika.czarnecka. All rights reserved.
//

import UIKit
import Charts

class CMChartTableViewCell: UITableViewCell {

    let chartView = LineChartView.init(frame: CGRect.zero)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        
        //Chart View
        self.addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.layer.cornerRadius = 10
        chartView.layer.masksToBounds = true
        chartView.backgroundColor = UIColor.white
        
        chartView.gridBackgroundColor = UIColor.blue
        chartView.chartDescription?.text = ""
        
        //chartView.leftAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawAxisLineEnabled = true
        chartView.leftAxis.labelFont = UIFont.appFont(bold: false, fontSize: 8)
        chartView.leftAxis.labelTextColor = Constants.Colors.purple
        
        chartView.rightAxis.drawGridLinesEnabled = false
        chartView.rightAxis.drawAxisLineEnabled = false
        chartView.rightAxis.drawLabelsEnabled = false
        
        //chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = UIFont.appFont(bold: false, fontSize: 6)
        chartView.xAxis.drawLabelsEnabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        
        self.addConstraints([
            NSLayoutConstraint.init(item: chartView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: chartView, attribute: .top, relatedBy: .equal,toItem: self, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: chartView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: -10),
            NSLayoutConstraint.init(item: chartView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0, constant: -10)])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
