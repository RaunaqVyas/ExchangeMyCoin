//
//  ViewController.swift
//  ExchangeMyCoin
//
//  Created by Raunaq Vyas on 2022-02-18.
//

import UIKit

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate,CoinMangerDelegate{
   
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
   
    
    var coinManager = CoinManager()
    
    

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var searchTextFeild: UITextField!
    @IBOutlet weak var assetNameValue: UILabel!
    
    
override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        searchTextFeild.delegate = self
        coinManager.delegate = self
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let chosenCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: chosenCurrency)
    }
    
    
    
    
    func diUpdateExchange(_ coinManger: CoinManager, coinData: ExchangeModel) {
        DispatchQueue.main.async{
            self.currencyLabel.text = coinData.assetName
            self.bitcoinLabel.text = coinData.rateString
       
        }
      
        
        
    }
    

}


extension ViewController: UITextFieldDelegate {
    @IBAction func searchButtonPressed(_ sender: Any) {
        searchTextFeild.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextFeild.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            textField.placeholder = "Search"
            return true
        } else{
            textField.placeholder = "Type Something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let crypto = searchTextFeild.text?.uppercased(){
            assetNameValue.text = "\(crypto) is worth"
            coinManager.fetchCrypto(for:crypto)
          
        }
        searchTextFeild.text = ""
    }
}
