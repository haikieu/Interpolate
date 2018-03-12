//
//  BasicInterpolation.swift
//  Interpolate
//
//  Created by Roy Marmelstein on 10/04/2016.
//  Copyright © 2016 Roy Marmelstein. All rights reserved.
//

/*
 *Mar 11 2018, updated by Hai Kieu : Added some algorithms of interpolation from:
    + https://github.com/robb/RBBAnimation/blob/a29cafe2fa91e62573cc9967990b0ad2a6b17a76/RBBAnimation/RBBEasingFunction.m
    + https://github.com/DavdRoman/Popsicle/blob/master/Popsicle/EasingFunction.swift
*/

import Foundation

/**
 Basic interpolation function.
 */
public enum BasicInterpolation: InterpolationFunction {
    /// Linear interpolation.
    case linear
    /// Ease in Quad interpolation.
    @available(*, renamed: "easeInQuad")
    case easeIn
    case easeInQuad     //New added on Mar 11,2018
    /// Ease out Quad interpolation.
    @available(*, renamed: "easeOutQuad")
    case easeOut
    /// Ease out Quad interpolation.
    case easeOutQuad    //New added on Mar 11,2018
    /// Ease in Quad interpolation.
    @available(*, renamed: "easeInOutQuad")
    case easeInOut
    /// Ease in Quad interpolation.
    case easeInOutQuad  //New added on Mar 11,2018
    /// Ease in Quad interpolation.
    case easeInCubic    //New added on Mar 11,2018
    /// Ease out Quad interpolation.
    case easeOutCubic   //New added on Mar 11,2018
    /// Ease in out Quad interpolation.
    case easeInOutCubic //New added on Mar 11,2018
    /// Ease in Bounce interpolation.
    case easeInBounce   //New added on Mar 11,2018
    /// Ease out Bounce interpolation.
    case easeOutBounce  //New added on Mar 11,2018
    /// Ease in Quart interpolation.
    case easeInQuart    //New added on Mar 11,2018
    /// Ease out Quart interpolation.
    case easeOutQuart   //New added on Mar 11,2018
    /// Ease in out Quart interpolation.
    case easeInOutQuart //New added on Mar 11,2018
    /// Ease in Expo interpolation.
    case easeInExpo     //New added on Mar 11,2018
    /// Ease out Expo interpolation.
    case easeOutExpo    //New added on Mar 11,2018
    /// Ease in out Expo interpolation.
    case easeInOutExpo  //New added on Mar 11,2018
    
    /**
     Apply interpolation function
     
     - parameter progress: Input progress value
     
     - returns: Adjusted progress value with interpolation function. 
     */
    public func apply(_ progress: CGFloat) -> CGFloat {
        switch self {
        case .linear:
            return progress
        case .easeIn, .easeInQuad:
            return progress*progress*progress
        case .easeOut, .easeOutQuad:
            return (progress - 1)*(progress - 1)*(progress - 1) + 1.0
        case .easeInOut, .easeInOutQuad:
            if progress < 0.5 {
                return 4.0*progress*progress*progress
            } else {
                let adjustment = (2*progress - 2)
                return 0.5 * adjustment * adjustment * adjustment + 1.0
            }
        case .easeInCubic:
            return progress * progress * progress
        case .easeOutCubic:
            return pow(progress - 1, 3) + 1
        case .easeInOutCubic:
            if (progress < 0.5) { return 4 * pow(progress, 3) }
            return ((progress - 1) * pow((2 * progress) - 2, 2)) + 1
        case .easeInBounce:
            return 1 - BasicInterpolation.easeOutBounce.apply(1 - progress)
        case .easeOutBounce:
            if (progress < (4.0 / 11.0)) {
                return pow((11.0 / 4.0), 2) * pow(progress, 2)
            }
            
            if (progress < (8.0 / 11.0)) {
                return (3.0 / 4.0) + (pow((11.0 / 4.0), 2) * pow(progress - (6.0 / 11.0), 2))
            }
            
            if (progress < (10.0 / 11.0)) {
                return (15.0 / 16.0) + (pow((11.0 / 4.0), 2) * pow(progress - (9.0 / 11.0), 2))
            }
            
            return (63.0 / 64.0) + (pow((11.0 / 4.0), 2) * pow(progress - (21.0 / 22.0), 2))
        case .easeInQuart:
            return progress * progress * progress * progress
        case .easeOutQuart:
            return 1 - pow(progress - 1, 4)
        case .easeInOutQuart:
            if (progress < 0.5) {
                return 8 * pow(progress, 4)
            } else {
                return -1 / 2 * pow(2 * progress - 2, 4) + 1
            }
        case .easeInExpo:
            return progress == 0 ? 0.0 : pow(2, 10 * (progress - 1))
        case .easeOutExpo:
            return progress == 1.0 ? 1 : 1 - pow(2, -10 * progress)
        case .easeInOutExpo:
            if (progress == 0) { return 0.0 }
            if (progress == 1) { return 1.0 }
            
            if (progress < 0.5) {
                return pow(2, 10 * (2 * progress - 1)) / 2;
            } else {
                return 1 - pow(2, -10 * (2 * progress - 1)) / 2;
            }
        }
    }
}
