//
//  BaseViewModel.swift
//  bc
//
//  Created by Evgeny Hailov on 06.07.2023.
//

import Foundation

protocol BaseViewModel {
    
    func reloadView()
    
    func subscribe(_ model: DataModel?, error: NSError?)
    
    func updateData()
       
}
