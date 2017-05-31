//
//  PresenterProtocols.swift
//  Architectures
//
//  Created by Fabijan Bajo on 31/05/2017.
//
//

import Foundation

protocol ResultsPresenterInterface: class {
    func updateView()
    func collectionConfiguration() -> CollectionViewConfigurable
}