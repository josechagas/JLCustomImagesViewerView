//
//  JLCustomImagesViewerView.swift
//  JLCustomImagesViewer
//
//  Created by José Lucas Souza das Chagas on 20/04/16.
//  Copyright © 2016 José Lucas Souza das Chagas. All rights reserved.
//

import UIKit

public enum ComponentAligment:Int{
    case BottomLeft = 0
    case BottomRight = 1
    case BottomCenter = 2
    
}

public class JLCustomImagesViewerView: UIVisualEffectView,UIScrollViewDelegate {
    
    private var scrollView:UIScrollView!
    
    private var addedImagesView:[JLViewerImageView]! = [JLViewerImageView]()
    
    private var currentImageViewPos:Int!
    
    private var hideViewerCompletion:(()->())?
    
    private var pageControl:UIPageControl?
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        addGestures()
        
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    //MARK: - Components
    
    public func addPageControl(aligment:ComponentAligment,tintColor:UIColor,currentPageColor:UIColor){
        
        pageControl = UIPageControl()
        pageControl?.tintColor = tintColor
        pageControl?.currentPageIndicatorTintColor = currentPageColor
        pageControl?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pageControl!)
        pageControl!.layer.zPosition = 2
        
        let heightC = NSLayoutConstraint(item: pageControl!, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant:40)
        pageControl?.addConstraint(heightC)
        
        
        if aligment.rawValue < 3{
            let bottomDistC = NSLayoutConstraint(item: pageControl!, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 5)
            self.addConstraint(bottomDistC)
            
        }
        
        //Constraints
        
        switch aligment{
        case ComponentAligment.BottomLeft:
            let bottomLeftC = NSLayoutConstraint(item: pageControl!, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 5)
            self.addConstraint(bottomLeftC)
            
            
        case ComponentAligment.BottomRight:
            let bottomRightC = NSLayoutConstraint(item: pageControl!, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: -5)
            self.addConstraint(bottomRightC)
            
        case ComponentAligment.BottomCenter:
            let centerXC = NSLayoutConstraint(item: pageControl!, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
            self.addConstraint(centerXC)
            
        }
        
        
    }
    
    
    private func addScroll(){
        
        scrollView = UIScrollView(frame: self.frame)
        scrollView.delegate = self
        scrollView.maximumZoomScale = 5
        scrollView.minimumZoomScale = 1
        scrollView.contentSize = self.frame.size
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.pagingEnabled = true
        self.addSubview(scrollView)
        //Constraints
        
        let distToTopC = NSLayoutConstraint(item: scrollView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        self.addConstraint(distToTopC)
        
        let distToBottomC = NSLayoutConstraint(item: scrollView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        self.addConstraint(distToBottomC)
        
        let distToLeftC = NSLayoutConstraint(item: scrollView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0)
        self.addConstraint(distToLeftC)
        
        let distToRightC = NSLayoutConstraint(item: scrollView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0)
        self.addConstraint(distToRightC)
        
        //
    }
    
    /**
     Present the JLCustomImagesViewerView on the choosed view
     - parameter images: Array of images that you want to see
     - parameter view: The view where you want to show it
     - parameter showViewCompletion: A block that will be executed after present the JLCustomImagesViewerView
     - parameter hideViewCompletion: A block that will be executed after remove the JLCustomImagesViewerView
     */
    public func showViewerForImages(images:[UIImage],OnView view:UIView,showViewCompletion:(()->())?,hideViewCompletion:(()->())?) {
        
        if let pageControl = pageControl{
            pageControl.numberOfPages = images.count
        }
        
        
        self.alpha = 0
        self.frame = view.bounds
        self.translatesAutoresizingMaskIntoConstraints = false
        //view.addSubview(self)
        if let delegate = UIApplication.sharedApplication().delegate , window = delegate.window{
            window?.addSubview(self)
            
            //window?.makeKeyAndVisible()
            
            //Constraints
            let distToTopC = NSLayoutConstraint(item: window!, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
            window!.addConstraint(distToTopC)
            
            let distToBottomC = NSLayoutConstraint(item: window!, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
            window!.addConstraint(distToBottomC)
            
            let distToLeftC = NSLayoutConstraint(item: window!, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0)
            window!.addConstraint(distToLeftC)
            
            let distToRightC = NSLayoutConstraint(item: window!, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0)
            window!.addConstraint(distToRightC)
            //
            
            addScroll()
            
            for i in 0..<images.count{
                
                addImageViewForImage(images[i],actualPosition: i,lastPosition: images.count - 1)
            }
            
            currentImageViewPos = 0
            
            hideViewerCompletion = hideViewCompletion
            
            self.showViewerAnimated(true,completion: showViewCompletion)
            
        }
        
    }
    
    /**
     Add an image on Viewer
     - parameter image: The image you want to add
     - parameter actualPosition: position that the image will be added
     - parameter lastPosition: the last position
     */
    private func addImageViewForImage(image:UIImage!,actualPosition:Int,lastPosition:Int){
        
        let imageAspectRatio = image.size.height/image.size.width
        
        let imageView = JLViewerImageView(image: image)
        
        self.addedImagesView.append(imageView)
        
        self.scrollView.addSubview(imageView)
        
        
        //Constraints
        
        imageView.widthC = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: self.frame.width <= self.frame.height ? self.frame.width : self.frame.height)
        self.scrollView.addConstraint(imageView.widthC)
        
        imageView.heightC = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: imageView, attribute: NSLayoutAttribute.Width, multiplier: imageAspectRatio, constant: 0)
        imageView.addConstraint(imageView.heightC)
        
        let rightLeftConsValue = (self.frame.width - imageView.widthC.constant)
        
        
        if actualPosition > 0{
            
            if let rightC = addedImagesView[actualPosition - 1].rightC{
                addedImagesView[actualPosition - 1].removeConstraint(rightC)
            }
            
            imageView.leftC = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: addedImagesView[actualPosition - 1], attribute: NSLayoutAttribute.Right, multiplier: 1, constant: rightLeftConsValue)
            self.scrollView.addConstraint(imageView.leftC)
            addedImagesView[actualPosition - 1].rightC = imageView.leftC
            addedImagesView[actualPosition - 1].applyDefaultValues()
            
            
        }
        else{
            imageView.leftC = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: scrollView, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: rightLeftConsValue/2)
            self.scrollView.addConstraint(imageView.leftC)
        }
        
        
        if actualPosition == lastPosition{
            imageView.rightC = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: scrollView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: -rightLeftConsValue/2)
            self.scrollView.addConstraint(imageView.rightC!)
        }
        
        let dist = self.frame.height - imageAspectRatio*imageView.widthC.constant
        
        imageView.topC = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: scrollView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: dist/2)
        
        self.scrollView.addConstraint(imageView.topC)
        
        imageView.applyDefaultValues()
        
        //self.scrollView.layoutIfNeeded()
    }
    
    
    //MARK: - Gestures methods
    
    private func addGestures(){
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(JLCustomImagesViewerView.tapGesAction(_:)))
        self.addGestureRecognizer(tapGes)
        
        let doubleTapGes = UITapGestureRecognizer(target: self, action: #selector(JLCustomImagesViewerView.doubleTapAction(_:)))
        doubleTapGes.numberOfTapsRequired = 2
        
        self.addGestureRecognizer(doubleTapGes)
        
    }
    
    func tapGesAction(tapGes:UITapGestureRecognizer){
        for imageView in addedImagesView{
            if imageView.frame.contains(tapGes.locationInView(self)){
                return
            }
        }
        hideViewerAnimated(true) {
            self.removeFromSuperview()
        }
        
    }
    
    func doubleTapAction(tapGes:UITapGestureRecognizer){
        if  scrollView.zoomScale > 1{
            self.scrollView.setZoomScale(1, animated: true)
        }
    }
    //MARK: - Hide and Show Animations
    
    private func showViewerAnimated(animated:Bool,completion:(()->())?){
        if animated{
            UIView.animateWithDuration(0.4, animations: {
                self.alpha = 1
                }, completion: { (finished) in
                    if finished{
                        if let block = completion{
                            block()
                        }
                    }
            })
        }
        else{
            self.alpha = 1
            if let block = completion{
                block()
            }
        }
    }
    
    private func hideViewerAnimated(animated:Bool,completion:()->()){
        if animated{
            UIView.animateWithDuration(0.4, animations: {
                self.alpha = 0
                }, completion: { (finished) in
                    if finished{
                        completion()
                        if let block = self.hideViewerCompletion{
                            block()
                        }
                    }
            })
        }
        else{
            self.alpha = 0
            completion()
            if let block = self.hideViewerCompletion{
                block()
            }
        }
    }
    //MARK: - Scroll delegate methods
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        if !scrollView.zooming && scrollView.zoomScale == 1{
            
            var pos = Int(scrollView.contentOffset.x)/Int(self.frame.width)
            
            for i in 0..<currentImageViewPos{
                if addedImagesView[i].alpha == 0{
                    pos+=1
                }
            }
            
            
            currentImageViewPos = pos
            
            
            if let pageControl = pageControl{
                pageControl.currentPage = currentImageViewPos
            }
            
        }
        
    }
    
    public func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView?) {
        scrollView.pagingEnabled = false
        
        if let pageControl = pageControl{
            pageControl.hidden = true
        }
        
        for i in 0..<addedImagesView.count{
            if i != currentImageViewPos{
                addedImagesView[i].hideImage()
            }
        }
    }
    
    public func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        return addedImagesView[currentImageViewPos]
    }
    
    
    public func scrollViewDidZoom(scrollView: UIScrollView) {
        addedImagesView[currentImageViewPos].correctPosition(scrollView.maximumZoomScale,actualZoom: scrollView.zoomScale)
    }
    
    public func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        if scale == 1{
            
            if let pageControl = pageControl{
                pageControl.hidden = false
            }
            
            for i in 0..<addedImagesView.count{
                if i != currentImageViewPos{
                    addedImagesView[i].showImage()
                }
            }
            
            scrollView.pagingEnabled = true
            self.scrollView.contentOffset = CGPoint(x:self.frame.width*CGFloat(currentImageViewPos),y: 0)
            self.scrollView.contentSize = CGSize(width: self.frame.width*CGFloat(addedImagesView.count), height: self.frame.height)
            self.layoutIfNeeded()
        }
    }
}
