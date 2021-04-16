//
//  PhotosModel.swift
//  Screenshot Organizer
//
//  Created by Emad Beyrami on 1/25/1400 AP.
//

import UIKit

//MARK: - photo model
/// get photos as Base64 String
struct PhotoModel: Codable {
    
    let photo: String
    
    init(photo: String = "") {
        self.photo = photo
    }
    
    enum CodingKeys: String, CodingKey {
        case photo
    }
    
}

//MARK: - equatable function
extension PhotoModel: Equatable {
    
    static func ==(lhs: PhotoModel, rhs: PhotoModel) -> Bool {
        return lhs.photo == rhs.photo
    }
    
}
