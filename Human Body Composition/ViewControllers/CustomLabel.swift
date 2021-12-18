//
//  CustomLabel.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 18.12.2021.
//

import UIKit

class CustomLabel: UILabel {
    init(text: String, width: Double, height: Double) {
        let frame = CGRect(x: 100, y: 100, width: width, height: height)
        super.init(frame: frame)
        self.text = text
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
