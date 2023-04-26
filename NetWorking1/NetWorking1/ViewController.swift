//
//  ViewController.swift
//  NetWorking1
//
//  Created by Quasar on 19.04.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func getRequest(_ sender: Any) {
    
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
                
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            
            guard let response = response,
            let data = data
            else { return }
            
            print(response)
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print(json)
            } catch {
                print(error)
            }
            
        }.resume()
        }
    
    @IBAction func postRequest(_ sender: Any) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let userData = ["Course": "Networking", "Leeson" : "GET and POST requests "]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData) else { return }
        
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            
            guard let response = response, let data = data else { return }
            
            print(response)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
}


