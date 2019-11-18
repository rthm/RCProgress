//
//  RingProgressView.swift
//  
//
//  Created by Wenzhong Zhang on 2019-11-18.
//

#if canImport(UIKit)
import UIKit

open class RingProgressView: UIView {
    @IBInspectable public var lineWidth: CGFloat = 8 {
        didSet { setNeedsLayout() }
    }
    @IBInspectable public var progress: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }
    @IBInspectable var progressColor: UIColor = .red {
        didSet {
            let capture = progressColor
            progressLayer.strokeColor = capture.cgColor
            setNeedsLayout()
        }
    }
    @IBInspectable var trackColor: UIColor = .white {
        didSet {
            let capture = trackColor
            trackLayer.strokeColor = capture.cgColor
            setNeedsLayout()
        }
    }
    private let twoPi: CGFloat = .pi + .pi
    private let progressLayer: CAShapeLayer = .init()
    private let trackLayer: CAShapeLayer = .init()
    var layersInOrder: [CAShapeLayer] {
        [trackLayer, progressLayer]
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    open override func layoutSubviews() {
        super.layoutSubviews()
        let layers = layersInOrder
        zip(layers, [1, progress]).forEach {
            let b = bounds
            let bezier = UIBezierPath(roundedRect: b, cornerRadius: b.midX)
            $0.0.frame = b
            $0.0.lineWidth = lineWidth
            $0.0.lineCap = .round
            $0.0.strokeEnd = $0.1
            $0.0.path = bezier.cgPath
        }
    }
    open override func tintColorDidChange() {
        super.tintColorDidChange()
        progressColor = tintColor
    }
    public func setProgress(_ prog: Float, animated: Bool = true) {
        progress = .init(prog)
    }
    private func commonInit() {
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = lineWidth
        progressLayer.strokeColor = progressColor.cgColor
        let layers = layersInOrder,
        scale = UIScreen.main.scale
        layers.forEach(layer.addSublayer)
        layers.forEach {
            $0.lineJoin = .round
            $0.strokeStart = 0
            $0.shouldRasterize = true
            $0.rasterizationScale = scale + scale
        }
        setNeedsLayout()
    }
}
#endif
