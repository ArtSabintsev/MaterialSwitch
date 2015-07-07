//
//  MaterialSwitch.swift
//  MaterialSwitch
//
//  Created by Arthur Sabintsev on 6/25/15.
//  Copyright (c) 2015 Arthur Ariel Sabintsev. All rights reserved.
//

import UIKit

protocol MaterialSwitchDelegate {
    func switchDidChangeState(#aSwitch: MaterialSwitch, currentState: MaterialSwitchState)
}

internal enum MaterialSwitchState: Int {
    case Off
    case On
}

// Typealiases
typealias MaterialSwitchSize = (x: CGFloat, y: CGFloat, radius: CGFloat)

// Class
public class MaterialSwitch: UIView {

    // Public Variables and Constants
    var state: MaterialSwitchState!
    var thumbOnColor: UIColor = .blueColor()
    var thumbOffColor: UIColor = .darkGrayColor()
    var trackOnColor: UIColor = .cyanColor()
    var trackOffColor: UIColor = .lightGrayColor()
    
    // Private Variables and Constants
    private let size: MaterialSwitchSize!
    private var delegate: MaterialSwitchDelegate?
    private var track: UIView?
    private var thumb: UIView?
    private var flashingThumb: UIView?
    
    // MARK: Initializers
    init(size: MaterialSwitchSize) {
        self.size = size
        super.init(frame: CGRectMake(size.x, size.y, 1.6*size.radius, size.radius))
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    func setup(#delegate: MaterialSwitchDelegate) {
        self.delegate = delegate
        state = .Off
        track = setupTrack()
        thumb = setupThumb()
        setupGesture()
        flashingThumb = setupThumb()
    }
    
    func setupTrack() -> UIView {
        
        let track = UIView(frame: CGRectMake(
            size.x + 0.1*size.radius,
            size.y + 0.1*size.radius,
            1.6*size.radius,
            0.8*size.radius))
        track.backgroundColor = trackOffColor
        track.layer.cornerRadius = CGRectGetHeight(track.frame)/2.0
        self.addSubview(track)
        
        return track
    }
    
    func setupThumb() -> UIView  {
    
        let thumb = UIView(frame: CGRectMake(
            size.x,
            size.y,
            size.radius,
            size.radius))
        thumb.backgroundColor = thumbOffColor
        thumb.layer.cornerRadius = CGRectGetHeight(thumb.frame)/2.0
        self.addSubview(thumb)
        
        return thumb
    }
    
    func setupGesture() {
        if let thumb = thumb {
            self.userInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: "animate")
            tap.numberOfTapsRequired = 1
            self.addGestureRecognizer(tap)
        }
    }
    
    // MARK: Animations!
    func animate() {
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
            
            let xOffsetForAnimation: CGFloat = (self.state == .Off) ? (self.size.x + 0.8*self.size.radius) : self.size.x
            self.thumb!.backgroundColor = (self.state == .Off) ? self.thumbOnColor : self.thumbOffColor
            self.track!.backgroundColor = (self.state == .Off) ? self.trackOnColor : self.trackOffColor
            self.thumb!.frame = CGRectMake(xOffsetForAnimation, self.size.y, self.size.radius, self.size.radius)
            
            if (self.state == .Off) {
                
                if self.flashingThumb?.isDescendantOfView(self) == false {
                    self.flashingThumb = self.setupThumb()
                    self.addSubview(self.flashingThumb!)
                }
                
                let xOffsetForAnimation = self.thumb!.backgroundColor
                self.flashingThumb!.backgroundColor = self.thumb!.backgroundColor
                self.flashingThumb!.frame = self.thumb!.frame
            }
            
            }) { (finished) -> Void in
            
                if (finished) {
                    self.state = (self.state == .Off) ? .On : .Off
                    self.delegate?.switchDidChangeState(aSwitch: self, currentState: self.state)
                }
        }

        UIView.animateWithDuration(0.35, delay: 0.25, options: .CurveEaseOut, animations: { () -> Void in
            
            self.flashingThumb!.alpha = 0.0
            self.flashingThumb!.transform = CGAffineTransformMakeScale(2.0, 2.0)
            
            }) { (finished) -> Void in
                if (finished) {
                    self.flashingThumb!.removeFromSuperview()
                }
        }
    }
}

