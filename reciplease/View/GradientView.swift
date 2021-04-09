//
//  GradientView.swift
//  reciplease
//
//  Created by Mosma on 09/04/2021.
//

import UIKit

class GradientView: UIView {
    
    private var gradientLayer: CAGradientLayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = frame
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addAGradientToLayer()
    }
    
    
    
    
    private func addAGradientToLayer() {
        gradientLayer = CAGradientLayer()
        
        gradientLayer?.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer?.startPoint = CGPoint(x: 0, y: 0.1)
        gradientLayer?.endPoint = CGPoint(x: 0, y: 0.8)
        
        if let gradientLayer = gradientLayer {
            layer.insertSublayer(gradientLayer, at: 3)
        }
    }
}
