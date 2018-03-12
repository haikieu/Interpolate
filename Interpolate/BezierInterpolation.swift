//
//  BezierInterpolation.swift
//  Interpolate
//
//  Created by KIEU, HAI on 3/11/18.
//  Copyright © 2018 Roy Marmelstein. All rights reserved.
//

/*
 Origin is from: https://github.com/robb/RBBAnimation/blob/master/RBBAnimation/RBBCubicBezier.m
 */

import Foundation

open class BezierInterpolation: InterpolationFunction {
    
    let x1 : CGFloat
    let y1 : CGFloat
    let x2 : CGFloat
    let y2 : CGFloat
    
    public init(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat) {
        self.x1 = x1
        self.x2 = x2
        self.y1 = y1
        self.y2 = y2
    }
    
    public func apply(_ progress: CGFloat) -> CGFloat {
        if (x1 == y1 && x2 == y2) {
            return BasicInterpolation.linear.apply(progress)
        }
        //Warning: may need test this
        let binarySubdivide = cubicBezierBinarySubdivide(progress, x1, x2)
        return cubicBezierCalculate(binarySubdivide, y1, y2)
    }
    
    func A(_ a1: CGFloat,_ a2: CGFloat) -> CGFloat { return 1.0 - 3.0 * a2 + 3.0 * a1   }
    func B(_ a1: CGFloat,_ a2: CGFloat) -> CGFloat { return 3.0 * a2 - 6.0 * a1         }
    func C(_ a1: CGFloat) -> CGFloat              { return 3.0 * a1                    }
    
    func cubicBezierCalculate(_ t: CGFloat,_ a1: CGFloat,_ a2: CGFloat) -> CGFloat {
        return ((A(a1, a2) * t + B(a1, a2)) * t + C(a1)) * t
    }
    
    func cubicBezierSlope(_ t: CGFloat,_ a1: CGFloat,_ a2: CGFloat) -> CGFloat {
        return 3.0 * A(a1, a2) * t * t + 2.0 * B(a1, a2) * t + C(a1);
    }
    
    func cubicBezierBinarySubdivide(_ x: CGFloat,_ x1: CGFloat,_ x2: CGFloat) -> CGFloat {
        let epsilon : CGFloat = 0.0000001
        let maxIterations : UInt = 10
        
        var start : CGFloat = 0
        var end : CGFloat = 1
        
        var currentX : CGFloat
        var currentT : CGFloat
        
        var i : UInt = 0
        repeat {
            currentT = start + (end - start) / 2
            currentX = cubicBezierCalculate(currentT, x1, x2) - x
        
            if (currentX > 0) {
                end = currentT
            } else {
                start = currentT
            }
            i += 1
        } while (fabs(currentX) > epsilon && i < maxIterations)
        
        return currentT;
    }
}
