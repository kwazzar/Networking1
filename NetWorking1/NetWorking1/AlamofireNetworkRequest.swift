//
//  AlamofireNetworkRequest.swift
//  NetWorking1
//
//  Created by Quasar on 24.05.2023.
//

import Foundation
import Alamofire

class AlamofireNetworkRequest {
    
    static func sendRequest(url: String) {
        
        guard let url = URL(string: url) else { return }
        
        AF.request(url, method: .get).responseData { response in
            print(response)
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    print(json)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error)
            }
        }
        }
}
            // 11:23мин видео
        
    

    

