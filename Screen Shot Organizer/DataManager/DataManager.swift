//
//  DataManager.swift
//  Screenshot Organizer
//
//  Created by Emad Beyrami on 1/24/1400 AP.
//

import Foundation
class DataManager: NSObject {
    
    // MARK: - Singleton
    static var standard = DataManager()
    
    // MARK: - Saved Data
    @Storage(key: "items", defaultValue: [CategoryModel(id: 0, name: "All", photos: [PhotoModel]())])
    var items: [CategoryModel]
    
    
    //MARK: - setters
    func addNewCategory(_ category: CategoryModel) {
        self.items.append(category)
    }
    
    func setPhotos(_ item: [CategoryModel]) {
        items = item
    }
    
    func addPhotosToCategory(catId: Int, photo: PhotoModel, prevCatid: Int? = nil)  {
        if prevCatid == nil && isAlreadyAdded(photo) { return }
        if let index = items.firstIndex(where: {$0.id == catId}) {
            items[index].photos.append(photo)
//            print(items)
        } else {
            print("404! Error category ID not found")
        }
        
        /// Remove from other categories To avoid duplications
        guard let removeId = prevCatid else { return }
        if let index = items.firstIndex(where: {$0.id == removeId}) {
            if let removablePhoto = items[index].photos.firstIndex(where: {$0.photo == photo.photo}) {
                items[index].photos.remove(at: removablePhoto)
            }
        }
    }
    
    //MARK: - logic
    fileprivate func isAlreadyAdded(_ photo: PhotoModel) -> Bool {
        if let _ = items.firstIndex(where: { (cat) -> Bool in
            return cat.photos.first(where: {$0.photo == photo.photo}) == photo
        }) {
            return true
        } else {
            return false
        }
    }
    
}
