//
//  ViewController.swift
//  MCImageLoader
//
//  Created by Miguel Chaves on 03/15/2016.
//  Copyright (c) 2016 Miguel Chaves. All rights reserved.
//

import UIKit
import MCImageLoader

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var sourceArray: [String] = [String]()
    var placeholder: UIImage = UIImage(named: "placeholder")!

    // MARK:
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MCImageLoader.sharedInstance.usesFastCache = true
        MCImageLoader.sharedInstance.fastCacheCapacity = 10
        MCImageLoader.sharedInstance.animationDuration = 0.8
    }
    
    // MARK:
    // MARK: - TableView DataSource / Delegate
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourceArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("imageCell", forIndexPath: indexPath) as! ImageCell
        
        let imageUrl = self.sourceArray[indexPath.row]
        
        MCImageLoader.sharedInstance.loadImage(imageUrl,
            imageView: cell.contentImage,
            placeHolder: placeholder)
        
        cell.imageUrlLabel.text = imageUrl
        
        return cell
    }
    
    // MARK:
    // MARK: - Actions
    
    @IBAction func refresh() {
        if (0 == self.sourceArray.count) {
            self.sourceArray.append("http://images.nationalgeographic.com/wpf/media-live/photos/000/065/cache/glowing-sun-prominence_6594_600x450.jpg")
            self.sourceArray.append("http://dreamatico.com/data_images/sun/sun-3.jpg")
            self.sourceArray.append("http://www.nasa.gov/sites/default/files/thumbnails/image/christmas2015fullmoon.jpg")
            self.sourceArray.append("http://cp91279.biography.com/1000509261001/1000509261001_1707071048001_BIO-Biography-20-Composers-Wolfgang-Amadeus-Mozart-SF.jpg")
            self.sourceArray.append("https://static-secure.guim.co.uk/sys-images/Guardian/Pix/pictures/2014/7/28/1406554322025/d4aa8b75-eaf2-4b0b-8906-d335d43265b3-2060x1236.jpeg")
            self.sourceArray.append("https://support.apple.com/library/content/dam/edam/applecare/images/en_US/osx/mac-apple-logo-screen-icon.png")
            self.sourceArray.append("http://www.nauzero.com/wp-content/uploads/2015/03/eclipse-3.jpg")
        }
        
        self.tableView.reloadData()
    }
    
    @IBAction func clear() {
        self.sourceArray.removeAll()
        self.tableView.reloadData()
    }
    
    @IBAction func clearCache() {
        MCImageLoader.sharedInstance.clearCache()
        
        self.sourceArray.removeAll()
        self.tableView.reloadData()
    }
}

