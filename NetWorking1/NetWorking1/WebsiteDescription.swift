//
//  WebsiteDescription.swift
//  NetWorking1
//
//  Created by Quasar on 26.04.2023.
//

import Foundation

struct WebsiteDescription: Decodable {
    
    let websiteDescription: String?
    let websiteName: String?
    let courses: [Course?]
}
