//
//  PlayingCardView.swift
//  DrawPractice
//
//  Created by Will Fletcher on 6/30/19.
//  Copyright © 2019 Will Fletcher. All rights reserved.
//

import UIKit

@IBDesignable
class PlayingCardView: UIView {
    
    
    var number = 2 {
        didSet {
            setNeedsDisplay(); setNeedsLayout()
        }
    }
    var drawColor = 2 {
        didSet {
            setNeedsDisplay(); setNeedsLayout()
        }
    }
    
    var getColer: UIColor {
        if drawColor == 0 {
            return UIColor.green
        } else if drawColor == 1 {
            return UIColor.red
        } else {
            return UIColor.purple
        }
    }
    
    var backColor = UIColor.white {
        didSet {
            setNeedsDisplay(); setNeedsLayout()
        }
    }
    
    var fill = 2 {
        didSet {
            setNeedsDisplay(); setNeedsLayout()
        }
    }
    
    var shape = 2 {
        didSet {
            setNeedsDisplay(); setNeedsLayout()
        }
    }
    var invisableColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    var isShown = true {
        didSet {
            setNeedsDisplay(); setNeedsLayout()
        }
    }
    var isHint = false {
        didSet {
            setNeedsDisplay(); setNeedsLayout()
        }
    }
    var isSelected = false {
        didSet {
            setNeedsDisplay(); setNeedsLayout()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 16.0)
        roundedRect.addClip()
        invisableColor.setFill()
        roundedRect.fill()
        if isShown {
            backColor.setFill()
            roundedRect.fill()
            for drawingArea in createDrawingAreas(number: number, inDrawableZone: bounds) {
                drawShape(area: drawingArea, color: getColer)
            }
        }
    }
    
    func drawShape(area: CGRect, color: UIColor) {
        if fill == 0 {
            if shape == 0 {
                outline(shape: makeDiamond(inDrawingArea: area), withColor: color)
            } else if shape == 1 {
                outline(shape: makeOval(inDrawingArea: area), withColor: color)
            } else {
                outline(shape: makeSquiggle(inDrawingArea: area), withColor: color)
            }
        } else if fill == 1 {
            if shape == 0 {
                stripe(shape: makeDiamond(inDrawingArea: area), withColor: color)
            } else if shape == 1 {
                stripe(shape: makeOval(inDrawingArea: area), withColor: color)
            } else {
                stripe(shape: makeSquiggle(inDrawingArea: area), withColor: color)
            }
        } else {
            if shape == 0 {
                fill(shape: makeDiamond(inDrawingArea: area), withColor: color)
            } else if shape == 1 {
                fill(shape: makeOval(inDrawingArea: area), withColor: color)
            } else {
                fill(shape: makeSquiggle(inDrawingArea: area), withColor: color)
            }
        }
    }
    
    func makeDiamond(inDrawingArea drawingRect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: drawingRect.minX, y: drawingRect.midY))
        path.addLine(to: CGPoint(x: drawingRect.midX, y: drawingRect.minY))
        path.addLine(to: CGPoint(x: drawingRect.maxX, y: drawingRect.midY))
        path.addLine(to: CGPoint(x: drawingRect.midX, y: drawingRect.maxY))
        path.addLine(to: CGPoint(x: drawingRect.minX, y: drawingRect.midY))
        return path
    }
    
    func makeSquiggle(inDrawingArea drawingRect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 104, y: 15));
        path.addCurve(to: CGPoint(x: 63, y: 54), controlPoint1: CGPoint(x: 112.4, y: 36.9), controlPoint2: CGPoint(x: 89.7, y: 60.8))
        path.addCurve(to: CGPoint(x: 27, y: 53), controlPoint1: CGPoint(x: 52.3, y: 51.3), controlPoint2: CGPoint(x: 42.2, y: 42))
        path.addCurve(to: CGPoint(x: 5, y: 40), controlPoint1: CGPoint(x: 9.6, y: 65.6), controlPoint2: CGPoint(x: 5.4, y: 58.3))
        path.addCurve(to: CGPoint(x: 36, y: 12), controlPoint1: CGPoint(x: 4.6, y: 22), controlPoint2: CGPoint(x: 19.1, y: 9.7))
        path.addCurve(to: CGPoint(x: 89, y: 14), controlPoint1: CGPoint(x: 59.2, y: 15.2), controlPoint2: CGPoint(x: 61.9, y: 31.5))
        path.addCurve(to: CGPoint(x: 104, y: 15), controlPoint1: CGPoint(x: 95.3, y: 10), controlPoint2: CGPoint(x: 100.9, y: 6.9))
        
        scaleAndTranslateShape(drawingRect, path)
        return path
    }
    
    func makeOval(inDrawingArea drawingRect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 10, y: 10))
        path.addLine(to: CGPoint(x: 30, y: 10))
        path.addArc(withCenter: CGPoint(x: 30, y: 20), radius: 10, startAngle: -CGFloat.pi / 2, endAngle: CGFloat.pi / 2, clockwise: true)
        path.addLine(to: CGPoint(x: 10, y: 30))
        path.addArc(withCenter: CGPoint(x: 10, y: 20), radius: 10, startAngle: CGFloat.pi / 2, endAngle: -CGFloat.pi / 2, clockwise: true)
        
        scaleAndTranslateShape(drawingRect, path)
        return path
    }
    
    func scaleAndTranslateShape(_ drawingRect: CGRect, _ path: UIBezierPath) {
        var scaleFactor: CGFloat = 0.0
        scaleFactor = drawingRect.height / path.bounds.height
        path.apply(CGAffineTransform(scaleX: scaleFactor, y: scaleFactor))
        if path.bounds.width > drawingRect.width {
            scaleFactor = drawingRect.width / path.bounds.width
            path.apply(CGAffineTransform(scaleX: scaleFactor, y: scaleFactor))
        }
        
        path.apply(CGAffineTransform(translationX: drawingRect.midX - path.bounds.width / 2 - path.bounds.minX, y: drawingRect.midY - path.bounds.height / 2 - path.bounds.minY))
    }
    
    func outline(shape path: UIBezierPath, withColor color: UIColor){
        path.lineWidth = 2.0
        color.setStroke()
        path.stroke()
    }
    
    func fill(shape path: UIBezierPath, withColor color: UIColor) {
        color.setFill()
        path.fill()
    }
    
    func stripe(shape path: UIBezierPath, withColor color: UIColor) {
        outline(shape: path, withColor: color)
        
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        
        path.addClip()
        for x in stride(from: path.bounds.minX, to: path.bounds.maxX, by: 3) {
            path.move(to: CGPoint(x: x, y: path.bounds.minY))
            path.addLine(to: CGPoint(x: x, y: path.bounds.maxY))
        }
        path.lineWidth = 1.0
        color.setStroke()
        path.stroke()
        
        context.restoreGState()
    }
    
    func createDrawingAreas(number: Int, inDrawableZone maxDrawableArea: CGRect) -> [CGRect] {
        let xDefaultCoordinate = maxDrawableArea.minX + internalBorderWidth
        let yDefaultCoordinate = maxDrawableArea.minY + internalBorderHeight
        
        var shapeHeight: CGFloat = 0
        var shapeWidth: CGFloat = 0
        var longestCardSide: CGFloat = 0
        longestCardSide = maxDrawableArea.height
        shapeHeight = (maxDrawableArea.height / 3) - (2 * internalBorderHeight)
        shapeWidth = maxDrawableArea.width - (2 * internalBorderWidth)
        
        var startingPointProportions = [CGFloat]()
        switch number {
        case 0:
            startingPointProportions = [CGFloat(1.0/3)]
        case 1:
            startingPointProportions = [CGFloat(1.0/6), CGFloat(1.0/2)]
        case 2:
            startingPointProportions = [CGFloat(0), CGFloat(1.0/3), CGFloat(2.0/3)]
        default:
            break
        }
        var drawingAreas = [CGRect]()
        for startingPoint in startingPointProportions {
            var shapeArea = CGRect.zero
            shapeArea = CGRect(x: xDefaultCoordinate, y: yDefaultCoordinate + (startingPoint * longestCardSide), width: shapeWidth, height: shapeHeight)
            drawingAreas.append(shapeArea)
        }
        return drawingAreas
    }
    
    
    private struct SizeRatio {
        static let cornerRadiusToMaximalBoundsDimension: CGFloat = 0.06
        static let cardBorderToBoundsRatio: CGFloat = 0.1
        static let internalBorderToBoundsRatio: CGFloat = 0.025
    }
    
    private var cornerRadius: CGFloat {
        if bounds.height > bounds.width {
            return SizeRatio.cornerRadiusToMaximalBoundsDimension * bounds.height
        } else {
            return SizeRatio.cornerRadiusToMaximalBoundsDimension * bounds.width
        }
    }
    
    private var borderHeight: CGFloat {
        return SizeRatio.cardBorderToBoundsRatio * bounds.height
    }
    
    private var borderWidth: CGFloat {
        return SizeRatio.cardBorderToBoundsRatio * bounds.width
    }
    
    private var internalBorderHeight: CGFloat {
        return SizeRatio.internalBorderToBoundsRatio * bounds.height
    }
    
    private var internalBorderWidth: CGFloat {
        return SizeRatio.internalBorderToBoundsRatio * bounds.width
    }
    
}
