//
//  ViewController.swift
//  Animation
//
//  Created by William Peroche on 6/11/15.
//  Copyright © 2015 William Peroche. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageview2: UIImageView!
    @IBOutlet weak var image1Width: NSLayoutConstraint!
    @IBOutlet weak var imageview1: UIImageView!
    @IBOutlet weak var image2Left: NSLayoutConstraint!
    var imageArray = ["1", "2", "3", "4", "5"]
    @IBOutlet weak var image1Left: NSLayoutConstraint!
    var index = 0
    var initialgroupAnimation : CAAnimationGroup?
    var groupAnimation : CAAnimationGroup?
    var scrolling : CAKeyframeAnimation?
    
    @IBOutlet weak var image2Width: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        image1Width.constant = 2000
        image2Width.constant = 2000
        self.view.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        animationGroup1()
        animationGroup2()
        scrollingAnimation()
        imageview1.image = UIImage(named: imageArray[index])
        imageview1.layer.addAnimation(self.initialgroupAnimation!, forKey: "fadinganimation")
    }


    func animationGroup1() {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "position")
        let rect1 = CGPointMake(imageview1.frame.width/2, imageview1.frame.height/2)
        let rect2 = CGPointMake(-(imageview1.frame.width/4), imageview1.frame.height/2)
        let frameValues1 = [NSValue(CGPoint: rect1), NSValue(CGPoint: rect2)]

        var frameTimes = [0.0, 1.0]
        keyFrameAnimation.values = frameValues1
        keyFrameAnimation.keyTimes = frameTimes
        
        let fadingAnimation = CAKeyframeAnimation(keyPath: "opacity")
        let frameValues2 = [1.0, 1.0, 1.0]
        frameTimes = [0.0, 0.9, 1.0]
        fadingAnimation.values = frameValues2
        fadingAnimation.keyTimes = frameTimes
        
        let scrollGroupAnimation = CAAnimationGroup()
        scrollGroupAnimation.fillMode = kCAFillModeForwards;
        scrollGroupAnimation.removedOnCompletion = false;
        scrollGroupAnimation.repeatCount = 0;
        scrollGroupAnimation.duration = 10;
        scrollGroupAnimation.delegate = self;
        scrollGroupAnimation.animations = [keyFrameAnimation, fadingAnimation]

        scrollGroupAnimation.delegate = self
        initialgroupAnimation = scrollGroupAnimation
        
    }
    
    func animationGroup2() {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "position")
        let rect1 = CGPointMake(imageview1.frame.width/2 + self.view.frame.width, imageview1.frame.height/2)
        let rect2 = CGPointMake(-(imageview1.frame.width/4), imageview1.frame.height/2)
        let frameValues1 = [NSValue(CGPoint: rect1), NSValue(CGPoint: rect2)]
        
        var frameTimes = [0.0, 1.0]
        keyFrameAnimation.values = frameValues1
        keyFrameAnimation.keyTimes = frameTimes
        
        let fadingAnimation = CAKeyframeAnimation(keyPath: "opacity")
        let frameValues2 = [1.0, 1.0, 1.0]
        frameTimes = [0.0, 0.9, 1.0]
        fadingAnimation.values = frameValues2
        fadingAnimation.keyTimes = frameTimes
        
        let scrollGroupAnimation = CAAnimationGroup()
        scrollGroupAnimation.fillMode = kCAFillModeForwards;
        scrollGroupAnimation.removedOnCompletion = false;
        scrollGroupAnimation.repeatCount = 0;
        scrollGroupAnimation.duration = 10;
        scrollGroupAnimation.delegate = self;
        scrollGroupAnimation.animations = [keyFrameAnimation, fadingAnimation]
        
        scrollGroupAnimation.delegate = self
        groupAnimation = scrollGroupAnimation
        
    }
    
    
    func scrollingAnimation () {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "position")
        let rect1 = CGPointMake(-(imageview1.frame.width/4), imageview1.frame.height/2)
        let rect2 = CGPointMake(-(imageview1.frame.width/2), imageview1.frame.height/2)
        let frameValues = [NSValue(CGPoint: rect1), NSValue(CGPoint: rect2)]

        let frameTimes = [0, 1]
        keyFrameAnimation.values = frameValues
        keyFrameAnimation.keyTimes = frameTimes
        keyFrameAnimation.fillMode = kCAFillModeForwards;
        keyFrameAnimation.removedOnCompletion = false;
        keyFrameAnimation.repeatCount = 0;
        keyFrameAnimation.duration = 3;
        keyFrameAnimation.delegate = self;
        scrolling = keyFrameAnimation
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if (flag) {
            if (anim.isKindOfClass(CAAnimationGroup)) {
                imageview1.layer.removeAllAnimations()
                index++
                if (index >= imageArray.count) {
                    index = 0
                }
                
                let tempImageview = imageview2
                imageview2 = imageview1
                imageview1 = tempImageview
                self.view.bringSubviewToFront(imageview1)
                imageview1.image = UIImage(named: imageArray[index])
                imageview1.layer.addAnimation(self.groupAnimation!, forKey: "fadinganimation")
                imageview2.layer.addAnimation(self.scrolling!, forKey: "scroll")
            }
            else if (anim.isKindOfClass(CAKeyframeAnimation)) {
                self.view.sendSubviewToBack(imageview2)
                imageview2.image = nil
            }
        }
    }
    
    
}

