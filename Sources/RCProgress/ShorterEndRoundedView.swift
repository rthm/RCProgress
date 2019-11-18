//
//  ShorterEndRoundedView.swift
//  
//
//  Created by Wenzhong Zhang on 2019-11-18.
//

#if canImport(UIKit)

import UIKit

open class ShorterEndRoundedView: UIView {
    private var shorterMiddle: CGFloat {
        let capture = bounds
        return min(capture.midX, capture.midY)
    }
    open override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = shorterMiddle
        if clipsToBounds {
            return
        }
        clipsToBounds = true
    }
}

#endif
