//
//  LocalFileManager.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 23.10.2024.
//

import Foundation
import SwiftUI

class LocalFileManager {
    static let shared = LocalFileManager()
    private init() { }
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        //folder creation
        createFolderIfNeeded(folderName: folderName)
        
        //get path for image
        guard let data = image.pngData(),
              let url = getURLForImage(imageName: imageName, folderName: folderName)
              else {return}
        
        //save image to path
        do {
            try data.write(to: url)
        } catch let error {
            print("error saving image. image name: \(imageName). \(error)")
            
        }

    }
    
    
    func getImage(imageName: String, folderName: String) -> UIImage? { // раскомментировать тут!
        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        
        return UIImage(contentsOfFile: url.path)
        
        
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else {return}
        if !FileManager.default.fileExists(atPath: url.path) {
            
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("error creating directory w folderName \(folderName). \(error)")
            }
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURl = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return folderURl.appendingPathComponent(imageName + ".png")
        
    }
}
