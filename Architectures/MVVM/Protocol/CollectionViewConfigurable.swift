//
//  CollectionViewConfigurable.swift
//  Architectures
//
//  Created by Fabijan Bajo on 26/05/2017.
//
//

import Foundation

protocol CollectionViewConfigurable: class {
    
    // MARK: - Properties
    
    // Optional
    var topInset: Double? { get }
    var bottomInset: Double? { get }
    var horizontalInsets: Double? { get }
    var interItemSpacing: Double? { get }
    var lineSpacing: Double? { get }
    
    // Required
    var widthDivisor: Double { get }
    var heightDivisor: Double { get }
    var cellID: String { get }
}


// MARK: - Default values

extension CollectionViewConfigurable {
    
    // Provide default values: optional protocol workaround for non @objc structures
    var topInset: Double? { return nil }
    var bottomInset: Double? { return nil }
    var horizontalInsets: Double? { return nil }
    var interItemSpacing: Double? { return nil }
    var lineSpacing: Double? { return nil }
}
