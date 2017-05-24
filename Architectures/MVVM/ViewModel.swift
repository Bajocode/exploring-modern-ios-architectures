//
//  ViewModel.swift
//  Architectures
//
//  Created by Fabijan Bajo on 24/05/2017.
//
//

import Foundation

protocol ViewModel {
    func bind(didChange: @escaping () -> Void)
    func fetchNewData()
}
