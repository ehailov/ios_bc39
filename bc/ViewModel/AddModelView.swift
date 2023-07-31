//
//  AddModelView.swift
//  bc
//
//  Created by Evgeny Hailov on 26.07.2023.
//

import Foundation

public class AddModelView : ObservableObject {
    
    @Published public var isProgressBar = false
    @Published public var isAlert = false
    @Published public var isComplete = false
    @Published public var localizedDescription  = ""
    var data: EHDataLayer?
    
    public func failure(_ localizedDescription: String) {
        self.localizedDescription = localizedDescription
        isProgressBar.toggle()
        isAlert.toggle()
    }
    
    public func success() {
        update()
        isProgressBar.toggle()
    }
    
    private func update() {
        data?.updateData()
    }
    
}
