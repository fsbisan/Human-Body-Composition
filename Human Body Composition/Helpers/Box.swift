//
//  Box.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 24.06.2022.
//

import Foundation

final class Box<T> {
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    typealias Listener = ((T) -> Void)
    
    var listener: Listener?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
}
