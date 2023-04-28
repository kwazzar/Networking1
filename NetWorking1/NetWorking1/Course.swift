//
//  Course.swift
//  NetWorking1
//
//  Created by Quasar on 26.04.2023.
//

import Foundation

struct Course: Decodable {
    
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
   
}
