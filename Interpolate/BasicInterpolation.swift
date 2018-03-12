//
//  BasicInterpolation.swift
//  Interpolate
//
//  Created by Roy Marmelstein on 10/04/2016.
//  Copyright © 2016 Roy Marmelstein. All rights reserved.
//

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
    case easeInQuad
    /// Ease out Quad interpolation.
    @available(*, renamed: "easeOutQuad")
    case easeOut
    /// Ease out Quad interpolation.
    case easeOutQuad
    /// Ease in Quad interpolation.
    @available(*, renamed: "easeInOutQuad")
    case easeInOut
    /// Ease in Quad interpolation.
    case easeInOutQuad
    /// Ease in Quad interpolation.
    case easeInCubic
    /// Ease out Quad interpolation.
    case easeOutCubic
    /// Ease in out Quad interpolation.
    case easeInOutCubic
    /// Ease in Bounce interpolation.
    case easeInBounce
    /// Ease out Bounce interpolation.
    case easeOutBounce
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
        }
    }
}
