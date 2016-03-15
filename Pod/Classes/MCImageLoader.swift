//
//  MCImageLoader.swift
//  Pods
//
//  Created by Miguel Chaves on 15/03/16.
//
//

import UIKit

@available(iOS 8.0, *)
public class MCImageLoader: NSObject {
    
    /**
    *   Configurations
    */
    
    // The duration of the transiction afer getting the image
    public var animationDuration: Double = 0.5
    
    // After retrieve an image, it will be stored in memory for fast acess.
    public var usesFastCache: Bool = true
    
    // The max number of images that can be stored in the fast cache (after retrieve the image)
    public var fastCacheCapacity: Int = 15
    
    // Filepath for cache directory
    lazy var filePath: String = {
        let documentsDirectory: AnyObject = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)[0]
        let dataPath = documentsDirectory.stringByAppendingPathComponent("MCImageLoaderCache")
        
        do {
            // Append the cache directory to the documents folder
            try NSFileManager.defaultManager().createDirectoryAtPath(dataPath, withIntermediateDirectories: false, attributes: nil)
        } catch { }
        
        return dataPath
    }()
    
    // Queue for the requests. Concurrent to handle multiples requests at the same time
    lazy var privateQueue: dispatch_queue_t = dispatch_queue_create("com.mcimageloader.queue", DISPATCH_QUEUE_CONCURRENT)
    
    // Cache dictionary for fast access to the images
    lazy var cacheDictionary: NSMutableDictionary = {
        return NSMutableDictionary(capacity: self.fastCacheCapacity)
    }()
    
    // MARK:
    // MARK: - Singleton
    
    public class var sharedInstance: MCImageLoader {
        struct Singleton {
            static let instance = MCImageLoader()
        }
        
        return Singleton.instance
    }
    
    // MARK:
    // MARK: - Load Image
    
    /**
    *   Load an image to an image view. While the image is retrieved, a placeholder is shown.
    *
    *   @param: the url of the image
    *   @param: the image view where the image will be loaded
    *   @param: the placeholder to show
    */
    public func loadImage(urlString: String, imageView: UIImageView, placeHolder: UIImage?) {
        
        if (true == self.usesFastCache) {
            let imageName = urlString.componentsSeparatedByString("/").last!
            
            // Check first in the cache dictionary
            if ((self.cacheDictionary.objectForKey(imageName)) != nil) {
                imageView.image = (self.cacheDictionary.objectForKey(imageName) as! UIImage)
                return
            }
        }
        
        if (placeHolder != nil) {
            imageView.image = placeHolder!
        }
        
        // Add the spinner
        let spinner: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        spinner.frame = imageView.bounds
        spinner.startAnimating()
        
        imageView.addSubview(spinner)
        
        // Retrieve the image
        self.concurrentOperation { () -> () in
            
            var image: UIImage?
            var imageData = self.getDataFromImageUrl(urlString)
            
            if (imageData != nil) {
                image = UIImage(data: imageData!)
                imageData = nil
            }
            
            self.mainOperation({ () -> () in
                
                // Animate the image transition
                for element in imageView.subviews {
                    element.removeFromSuperview()
                }
                
                if (image != nil) {
                    
                    let tempView = UIImageView(frame: imageView.bounds)
                    tempView.contentMode = imageView.contentMode
                    tempView.image = imageView.image
                    
                    imageView.addSubview(tempView)
                    imageView.image = image
                    
                    // Image transition
                    UIView.animateWithDuration(self.animationDuration,
                        animations: { () -> Void in
                            tempView.alpha = 0.0
                        },
                        completion: { (_) -> Void in
                            tempView.removeFromSuperview()
                    })
                } else {
                    // Failed to get the image, so if there is placeholder, it will be the added image
                    if (placeHolder != nil) {
                        imageView.image = placeHolder!
                    }
                }
            })
        }
    }
    
    // MARK:
    // MARK: - Clear cache
    
    /**
    *   Clears all the stored images in the cache file directory and removes objects from dictionary
    */
    public func clearCache() {
        do {
            self.cacheDictionary.removeAllObjects()
            
            let fileManager = NSFileManager.defaultManager()
            let fileArray = try fileManager.contentsOfDirectoryAtPath(self.filePath)
            
            for file in fileArray {
                try fileManager.removeItemAtPath(getFilePathToImageUrl(file))
            }
        } catch {
            print("MCImageLoader: Error cleaning the cache system!")
        }
    }
    
    // MARK:
    // MARK: - Queue Operations
    
    func concurrentOperation(block: () -> ()) {
        dispatch_async(privateQueue, block)
    }
    
    func mainOperation(block: () -> ()) {
        dispatch_async(dispatch_get_main_queue(), block)
    }
    
    // MARK:
    // MARK: - Get data from image url
    
    /**
    *   Get the data of the image.
    *   If not exists in the cache file system will try to retrieve it from the Internet
    *   and them store it in the cache directory and add it to the cache dictionary
    */
    func getDataFromImageUrl(imageUrl: String) -> NSData? {
        
        var data: NSData?
        
        let array = imageUrl.componentsSeparatedByString("/")
        let pathFile = getFilePathToImageUrl(array.last!)
        
        if (NSFileManager.defaultManager().fileExistsAtPath(pathFile)) {
            data = NSData(contentsOfFile: pathFile)
            
            if ((data != nil) && (data?.length == 0)) {
                data = nil
            }
        }
        
        if (nil == data) {
            let url = NSURL(string: imageUrl)
            data = NSMutableData(contentsOfURL: url!)
            
            if ((data != nil) && (data?.length != 0)) {
                data?.writeToFile(pathFile, atomically: true)
            }
        }
        
        if (data != nil) {
            self.cacheDictionary.addEntriesFromDictionary([array.last!: UIImage(data: data!)!])
        }
        
        return data
    }
    
    func getFilePathToImageUrl(imageUrl: String) -> String {
        return self.filePath + "/" + imageUrl
    }
}
