//
//  ViewController.swift
//  JLCustomImagesViewerView
//
//  Created by José Lucas on 05/02/2016.
//  Copyright (c) 2016 José Lucas. All rights reserved.
//

import UIKit
import JLCustomImagesViewerView

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getImages()->[UIImage]{
        
        var images = [UIImage]()
        
        for i in 1..<8{
            images.append(UIImage(named: "image\(i)")!)
        }
        return images
    }

    @IBAction func seeDetailAction(sender: AnyObject) {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        
        let viewer = JLCustomImagesViewerView(effect: blurEffect)
        
        viewer.addPageControl(ComponentAligment.BottomRight, tintColor: UIColor.blackColor(), currentPageColor: UIColor.whiteColor())
        
        
        viewer.showViewerForImages(getImages(), OnView: self.view, showViewCompletion: nil, hideViewCompletion: nil)
        
    }
    
    
    //MARK: - Collection View methods
    
    func configCollectionView(){
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ImageCollectionViewCell
        
         cell.imageView.image = getImages()[indexPath.row]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        
        let viewer = JLCustomImagesViewerView(effect: blurEffect)
        
        viewer.addPageControl(ComponentAligment.BottomRight, tintColor: UIColor.blackColor(), currentPageColor: UIColor.whiteColor())
        
        
        viewer.showViewerForImages([getImages()[indexPath.row]], OnView: self.view, showViewCompletion: nil, hideViewCompletion: nil)

    }
    
    
}

