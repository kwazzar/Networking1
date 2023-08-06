//
//  AlamofireNetworkRequest.swift
//  NetWorking1
//
//  Created by Quasar on 24.05.2023.
//

import Foundation
import Alamofire

class AlamofireNetworkRequest {
    
    static var onProgress: ((Double) -> ())?
    static var completed: ((String) -> ())?
    
    
    static func sendRequest(url: String, completion: @escaping (_ courses:[Course])->()) {
        
        guard let url = URL(string: url) else { return }
        
        AF.request(url, method: .get).validate().responseData { response in
            
            
            switch response.result {
                
            case .success(let data):
                do {
                    let value = try JSONSerialization.jsonObject(with: data)
                    
                    var courses = [Course]()
                    courses = Course.getArray(from: value)!
                    completion(courses)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func downloadImage(url: String, completion: @escaping(_ image: UIImage)->()) {
        guard let url = URL(string: url) else { return }
        
        AF.request(url).responseData { (responseData) in
            
            switch responseData.result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                completion(image)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // JSON переведений в String
    static func responseData(url: String) {
        
        AF.request(url).responseData { (responseData) in
            
            switch responseData.result {
            case .success(let data):
                guard let string = String(data: data, encoding: .utf8) else { return }
                print(string)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func ResponseString(url: String) {
        AF.request(url).responseString { (responseString) in
            
            switch responseString.result {
            case.success(let string):
                print(string)
            case.failure(let error):
                print(error)
            }
        }
    }
    // видает данные в том же виде в котором они получены
    static func response(url: String) {
        AF.request(url).response { (response) in
            
            guard
                let data = response.data,
                let string = String(data: data, encoding: .utf8) else { return }
            
            print(string)
        }
    }
    
    static func downloadImageWithProgress(url: String, completion: @escaping (_ image: UIImage) -> ()) {
        
        guard let url = URL(string: url) else { return }
        
        AF.request(url).validate().downloadProgress { (progress) in
            
            print("totalUnitCount:\(progress.totalUnitCount)\n")
            print("completedUnitCount:\(progress.completedUnitCount)\n")
            print("fractionCompleted:\(progress.fractionCompleted)\n" )
            print("localizedDescription:\(progress.localizedDescription!)\n")
            print("-----------------------------------------------------------------")
            
            self.onProgress?(progress.fractionCompleted)
            self.completed?(progress.localizedDescription)
            
        }.response { (response) in
            
            guard let data = response.data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                completion(image)
            }
            
        }
    }
    
    static func postRequest(url: String, completion: @escaping (_ courses: [Course])->()) {
        
        guard let url = URL(string: url) else { return }
        
        let userData: [ String: Any ] = ["name": "Network Request",
                                         "link": "https://swiftbook.ru/contents/our-first-applications/",
                                         "imageUrl": "https://swiftbook.ru/wp-content/uploads/sites/2/2018/08/notifications-course-with-background.png",
                                         "numberOfLessons": 18,
                                         "numberOfTests" : 10]
        AF.request(url, method: .post, parameters: userData).responseData { (responseJSON) in
            
            guard let statusCode = responseJSON.response?.statusCode else { return }
            print("statusCode", statusCode)
            
            switch responseJSON.result {
                
            case .success(let data):
                do {
                    let value = try JSONSerialization.jsonObject(with: data)
                    print(value)
                    guard let jsonObject = value as? [ String: Any],
                          let course = Course(json: jsonObject)
                    else { return }
                    
                    var courses = [Course]()
                    courses.append(course)
                    
                    completion(courses)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
                
                
            }
        }
    }
    
    static func puttRequest(url: String, completion: @escaping (_ courses: [Course])->()) {
        
        guard let url = URL(string: url) else { return }
        
        let userData: [ String: Any ] = ["name": "Network Request with Alamofire",
                                         "link": "https://swiftbook.ru/contents/our-first-applications/",
                                         "imageUrl": "https://swiftbook.ru/wp-content/uploads/sites/2/2018/08/notifications-course-with-background.png",
                                         "numberOfLessons": "18",
                                         "numberOfTests" : "10"]
        AF.request(url, method: .put, parameters: userData).responseData { (responseJSON) in
            
            guard let statusCode = responseJSON.response?.statusCode else { return }
            print("statusCode", statusCode)
            
            switch responseJSON.result {
                
            case .success(let data):
                do {
                    let value = try JSONSerialization.jsonObject(with: data)
                    print(value)
                    guard let jsonObject = value as? [ String: Any],
                          let course = Course(json: jsonObject)
                    else { return }
                    
                    var courses = [Course]()
                    courses.append(course)
                    
                    completion(courses)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func uploadImage(url: String) {
        
        guard let url = URL(string: url) else { return }
        let image = UIImage(named: "Notification")!
        let data = image.pngData()!
        
        let httpHeaders = ["Authorization": "Client-ID \(yourClientId)"]
        
        AF.upload(multipartFormData: { (MultipartFormData) in
            
            MultipartFormData.append(data, withName: "image")
        }, to: url, headers: HTTPHeaders(httpHeaders)).validate().responseData { (responseJson) in
            
            switch (responseJson).result  {
            case .success(let upload):
                do {
                    let value = try JSONSerialization.jsonObject(with: upload)
                    print(value)
                          } catch {
                        // Handle response
                    }
                print(upload)
            case .failure(let error):
                // Handle error
                print(error)
            }
            
        }
            }
            
        }
            
        
            


