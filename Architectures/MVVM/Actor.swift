//
//  Actor.swift
//  Architectures
//
//  Created by Fabijan Bajo on 19/05/2017.
//
//

import Foundation

struct Actor {
    
    
    // MARK: - Properties
    
    let name: String
    let profilePath: String
    let actorID: Int
}


// MARK: - Equatable

extension Actor: Equatable {
    static func == (lhs: Actor, rhs: Actor) -> Bool {
        return lhs.actorID == rhs.actorID
    }
}
