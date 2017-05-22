//
//  DetailRepresentable.swift
//  Architectures
//
//  Created by Fabijan Bajo on 19/05/2017.
//
//

import UIKit

protocol DetailRepresentable {
    
    
    // MARK: - Properties
    
    var fullImageURL: URL { get }
    
    
    // MARK: - Methods
    
    func updateFullImage(completion: @escaping (_ image: UIImage) -> Void)
}
