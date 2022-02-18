//
//  CoinManager.swift
//  ExchangeMyCoin
//
//  Created by Raunaq Vyas on 2022-02-18.
//


import Foundation

protocol CoinMangerDelegate{
    func diUpdateExchange(_ coinManger: CoinManager,coinData:ExchangeModel )
    func didFailWithError(error: Error)
}


struct CoinManager {
    
    var delegate: CoinMangerDelegate?
    var baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = yourKey
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    
    
    mutating func fetchCrypto(for crypto: String) {
        baseURL = "https://rest.coinapi.io/v1/exchangerate/\(crypto)"
    }
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        print(urlString)
        perfromRequest(with:urlString)
    }
func perfromRequest(with urlString: String){
        //1. create Url
        if let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? " ") {
            //2. Create URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                }
                if let safeData = data {
                    if let coinData = self.parseJSON(safeData){
                        print(coinData.assetName)
                        print(coinData.rate)
                        delegate?.diUpdateExchange(self, coinData: coinData)
                    }
                        
                    //let safeDataAsAstring = String(data: safeData, encoding: String.Encoding.utf8)
                    
                }
            }
            //4. Start the task
            task.resume()
        }
    
}
    func parseJSON(_ currencyData: Data) -> ExchangeModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CurrencyData.self, from: currencyData)
            let rate = decodedData.rate
            print(rate)
            let assetName = decodedData.asset_id_quote
            let coinData = ExchangeModel(rate: rate, assetName: assetName)
            return coinData
            
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}
