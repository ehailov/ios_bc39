//
//  EHViewModelProtocol.swift
//  bc
//
//  Created by Evgeny Hailov on 26.07.2023.
//

import Foundation

//MARK: - AddViewModel
protocol EHAddProtocol {
    
    func getData()
    
    func getParameters() -> [String: Any]
    
}

//MARK: - BaseViewModel
protocol BaseViewModel {
    
    func reloadView()
    
    func subscribe(_ model: DataModel?, error: NSError?)
    
    func updateData()
       
}
