//
//  ImageManager.swift
//  Screen Shot Organizer
//
//  Created by Emad Beyrami on 1/27/1400 AP.
//

import UIKit
import Photos

class ImageManager: NSObject {
    
    //MARK: - Properties
    public let requestOptions = PHImageRequestOptions()
    public let fetchOptions = PHFetchOptions()
    fileprivate let cachingImageManager = PHCachingImageManager()
    //    var assets: [PHAsset] = [] {
    //        willSet {
    //            cachingImageManager.stopCachingImagesForAllAssets()
    //        }
    //
    //        didSet {
    //            cachingImageManager.startCachingImages(for: assets,
    //                                                   targetSize: PHImageManagerMaximumSize,
    //                                                   contentMode: .aspectFit,
    //                                                   options: self.requestOptions
    //            )
    //        }
    //    }
    
    
    //MARK: - Dealocating
    deinit {
        print("🚮 Deinit Class ####\(String(describing: self))")
    }
    
    
    //MARK: - Check Permission and Access
    public func getPermissionIfNecessary(completionHandler: @escaping (Bool) -> Void) {
        
        guard PHPhotoLibrary.authorizationStatus() != .authorized else {
            completionHandler(true)
            return
        }
        PHPhotoLibrary.requestAuthorization { status in
            completionHandler(status == .authorized ? true : false)
        }
    }
    
   
    //MARK: - convert assets to string base64
    fileprivate func getAssetThumbnail(asset: PHAsset) -> String {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var data: String = ""
        option.isSynchronous = true
        option.isNetworkAccessAllowed = true
        manager.requestImageDataAndOrientation(for: asset, options: option) { (Data, _, CGImagePropertyOrientation, _) in
            guard let imagedata = Data else { return }
            data = imagedata.base64EncodedString()
        }
        return data
    }
    
    
    
    //MARK: - Fetch Photos from libarary
    public func fetchPhotos(complition: SimpleAction = nil) {
        requestOptions.resizeMode = PHImageRequestOptionsResizeMode.fast
        requestOptions.version = .current
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.fastFormat
        requestOptions.isSynchronous = true
        requestOptions.isNetworkAccessAllowed = true
        
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false)]
        fetchOptions.fetchLimit = 20
        
        let fetchScreenshots =  PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumScreenshots, options: nil).firstObject!
        
        let fetchResults = PHAsset.fetchAssets(in: fetchScreenshots , options: fetchOptions)
        DispatchQueue.global(qos: .userInitiated).async() { [weak self] in
            fetchResults.enumerateObjects { [weak self] object, index, stop in
                guard let self = self else { return }
                let image = self.getAssetThumbnail(asset: object)
                DataManager.standard.addPhotosToCategory(catId: 0, photo: PhotoModel(photo: image))
            }
            DispatchQueue.main.async {
                complition?()
            }
        }
    }
    
}
