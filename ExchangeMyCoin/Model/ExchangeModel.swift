//
//  ExchangeModel.swift
//  ExchangeMyCoin
//
//  Created by Raunaq Vyas on 2022-02-18.
//

import Foundation

struct ExchangeModel {
    let rate: Double
    let assetName: String
    
    var rateString:String {
        let newrate = String(format: "%.2f", rate)
        return newrate
    }

}
