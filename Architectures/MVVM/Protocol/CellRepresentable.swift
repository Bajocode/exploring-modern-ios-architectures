//
//  CellRepresentable.swift
//  Architectures
//
//  Created by Fabijan Bajo on 25/05/2017.
//
//

import Foundation

protocol CellRepresentable: class {
    
    
    // MARK: - Properties
    
    // Optional
    var verticalInsets: Int? { get }
    var horizontalInsets: Int? { get }
    var interItemSpacing: Int? { get }
    var lineSpacing: Int? { get }
    
    // Required
    var widthDivisor: Double { get }
    var heightDivisor: Double { get }
    var cellID: String { get }
}

extension CellRepresentable {
    
    var verticalInsets: Int? { return nil }
    var horizontalInsets: Int? { return nil }
    var interItemSpacing: Int? { return nil }
    var lineSpacing: Int? { return nil }
}
