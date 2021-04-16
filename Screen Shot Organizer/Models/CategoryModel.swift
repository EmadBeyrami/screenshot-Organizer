//
//  CategoryModel.swift
//  Screen Shot Organizer
//
//  Created by Emad Beyrami on 1/26/1400 AP.
//

import Foundation
//MARK: - category Model
/// contains: category id, category name and array of photos which is for a specific category
struct CategoryModel: Codable {
    var id: Int!
    var name: String!
    var photos: [PhotoModel]! = [PhotoModel]()
    
    enum CodingKeys: String, CodingKey {
        case id, name, photos
    }
    
}
