//
//  JLViewerImageView.swift
//  JLCustomImagesViewer
//
//  Created by José Lucas Souza das Chagas on 22/04/16.
//  Copyright © 2016 José Lucas Souza das Chagas. All rights reserved.
//

import UIKit
/**
 A class that inherit from 'UIImageView' used on 'JLCustomImagesViewerView' 
 */
class JLViewerImageView: UIImageView {

  
    var widthC:NSLayoutConstraint!
    var heightC:NSLayoutConstraint!
    var topC:NSLayoutConstraint!
    var leftC:NSLayoutConstraint!
    var rightC:NSLayoutConstraint?

    
    private(set) var defaultWidthC:CGFloat!
    private(set) var defaultHeightC:CGFloat!
    private(set) var defaultTopC:CGFloat!
    private(set) var defaultLeftC:CGFloat!
    private(set) var defaultRightC:CGFloat!

    
    override init(image: UIImage?) {
        super.init(image: image)
        initialConfigs()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialConfigs()
    }
    
    private func initialConfigs(){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = UIViewContentMode.ScaleAspectFill
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        
    }
    
    func applyDefaultValues(){
        defaultWidthC = widthC.constant
        defaultHeightC = heightC.constant
        defaultTopC = topC.constant
        defaultLeftC = leftC.constant
        
        if let rightC = rightC{
            defaultRightC = rightC.constant
        }
    }
    
    func correctPosition(maxZoom:CGFloat,actualZoom:CGFloat){
        
        
        if self.defaultWidthC <= self.frame.size.width && self.frame.size.width <= self.defaultWidthC*maxZoom{//avoiding the bounce
            
            if self.superview!.frame.height <= self.superview!.frame.width{
                let newLeftCConst = (self.superview!.frame.width - self.frame.width)/2
                if newLeftCConst >= 0 && newLeftCConst <= defaultLeftC{
                    leftC.constant = newLeftCConst
                }
                else if newLeftCConst < 0{
                    leftC.constant = 0
                }
                else{
                    leftC.constant = defaultLeftC
                }
                
            }
            else{/*if self.superview!.frame.height > self.superview!.frame.width{*/
                let newTopCConst = (self.superview!.frame.height - self.frame.height)/2
                if newTopCConst >= 0 && newTopCConst <= defaultTopC{
                    topC.constant = newTopCConst
                }
                else if newTopCConst < 0{
                    topC.constant = 0
                }
                else{
                    topC.constant = defaultTopC
                }
                
            }
        }
 
    }

      
    func hideImage(){
        self.alpha = 0
        self.layer.zPosition = -10
        self.widthC.constant = 1
        self.leftC.constant = 0
        if let _ = rightC{
            self.rightC!.constant = 0
        }
        self.superview!.layoutIfNeeded()
    }
    
    func showImage(){
        self.alpha = 1
        self.layer.zPosition = 0
        self.widthC.constant = defaultWidthC
        self.leftC.constant = self.defaultLeftC
        if let _ = rightC{
            self.rightC!.constant = defaultRightC
        }
        self.superview!.layoutIfNeeded()

    }
}
