//
//  Actor.swift
//  Architectures
//
//  Created by Fabijan Bajo on 30/05/2017.
//
//

import Foundation

struct Actor: Transportable {
    
    
    // MARK: - Properties
    
    let name: String
    let thumbURL: URL
    let fullURL: URL
    let actorID: Int
}


// MARK: - Equatable

extension Actor: Equatable {
    static func == (lhs: Actor, rhs: Actor) -> Bool {
        return lhs.actorID == rhs.actorID
    }
}
