//
//  StorageService.swift
//  Tiger Hunt
//
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

class StorageService {
    //MARK: - STATIC SELF
    static let storageService = StorageService()
    
    //MARK: - PROPERTIES
    private var _BASE_REF = FIRStorage.storage().reference(forURL: Constants.FIR_STORAGE_URL)
    
    var STORAGE_REF: FIRStorageReference {
        return self._BASE_REF
    }
    
    var IMAGES_REF: FIRStorageReference {
        return self._BASE_REF.child("images")
    }
    
    //MARK: STORAGE FUNCS
    func uploadPhoto(filePath: String, data: NSData) -> String {
        var downloadUrl: String = ""
        
        IMAGES_REF.child(filePath).put(data as Data, metadata: nil){(metaData,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }else{
                downloadUrl = metaData!.downloadURL()!.absoluteString
            }
        }
        
        return downloadUrl
    }
    
    func downLoadPhoto(uid: String, photoID: String, imageView: UIImageView, view: UIView) {
        
        let ref = StorageService.storageService.IMAGES_REF.child(uid).child("\(photoID).jpg")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        ref.data(withMaxSize: 1 * 1024 * 1024) { (data, error) -> Void in
            if (error != nil) {
                print(error?.localizedDescription)
            } else {
                // Data for "images/island.jpg" is returned
                let image: UIImage! = UIImage(data: data!)
                imageView.image = image
            }
        }
    }
}

