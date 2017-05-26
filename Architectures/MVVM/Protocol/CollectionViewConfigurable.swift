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
    var topInset: Int? { get }
    var bottomInset: Int? { get }
    var horizontalInsets: Int? { get }
    var interItemSpacing: Int? { get }
    var lineSpacing: Int? { get }
    var cornerRadius: Double? { get }
    
    // Required
    var widthDivisor: Double { get }
    var heightDivisor: Double { get }
    var cellID: String { get }
}


// MARK: - Default values

extension CollectionViewConfigurable {
    
    // Provide default values: optional protocol workaround for non @objc structures
    var topInset: Int? { return nil }
    var bottomInset: Int? { return nil }
    var horizontalInsets: Int? { return nil }
    var interItemSpacing: Int? { return nil }
    var lineSpacing: Int? { return nil }
    var cornerRadius: Double? { return nil }
}
