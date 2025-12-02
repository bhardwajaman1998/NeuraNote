//
//  ViewExtension.swift
//  NeuraNote
//
//  Created by Aman Bhardwaj on 2025-12-02.
//
import UIKit

extension UIView {
    func addShadowAndCornerRadius(shadowColor: UIColor = .white,
                                  shadowOpacity: Float = 0.15,
                                  shadowRadius: CGFloat = 8,
                                  shadowOffset: CGSize = .init(width: 0, height: 4),
                                  cornerRadius: CGFloat = 12) {
        
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
    }
}
