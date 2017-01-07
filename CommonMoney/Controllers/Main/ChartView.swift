//
//  ChartView.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 07.01.2017.
//  Copyright © 2017 dominika.czarnecka. All rights reserved.
//

import UIKit
import ANDLineChartView

class ChartView: UIView {

    let chartView = ANDLineChartView.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    self.addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.chartBackgroundColor = Colors.darkBlue
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
