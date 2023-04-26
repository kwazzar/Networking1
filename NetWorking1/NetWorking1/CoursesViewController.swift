//
//  CoursesViewController.swift
//  NetWorking1
//
//  Created by Quasar on 26.04.2023.
//

import UIKit

class CoursesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()

    }
   
    func fetchData() {
         
//        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_course"
//        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
//        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_website_description"
        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields"
        
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else { return }
            
            do {
               let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                print("\(websiteDescription.courses)")
            } catch let error {
                print("Error serialization json", error)
            }
            
        }.resume()
    }
    
}


// MARK: Table View Data Source

extension CoursesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        
        return cell
    }
}

// MARK: Table View Delegate

extension CoursesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
