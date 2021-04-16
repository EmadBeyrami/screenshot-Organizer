//
//  String+Data+Base64.swift
//  Screen Shot Organizer
//
//  Created by Emad Beyrami on 1/27/1400 AP.
//

import UIKit

extension String {
    
    ///Decode From Base64 to String
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    ///Convert string to Base64
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    /// Convert Base64 to Image
    func convertBase64StringToImage () -> UIImage {
        let imageData = Data.init(base64Encoded: self, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }

}
