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
        let imageRef = StorageService.storageService.IMAGES_REF.child(uid)
        imageRef.child("\(photoID).jpg").downloadURL(completion: { url, error in
            print(url)
            
            if error != nil {
                imageView.image = UIImage(named: "not-submitted.png")
            } else {
                if let imageData = NSData(contentsOf: url!), let image = UIImage(data: imageData as Data) {
                    imageView.image = image
                    imageView.maskCircle(view: view)
                }
            }
        })
    }
}
