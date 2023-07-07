//
//  JurnalViewModel.swift
//  bc
//
//  Created by Evgeny Hailov on 03.07.2023.
//

import Foundation
import SwiftUI

public class JurnalViewModel: ObservableObject, BaseViewModel {
    
    @Published public var model: [JurnalModel]? = nil
    @Published public var error: NSError? = nil
    
    
    init() {
        let rx = DataHelper.share().rxData
        rx?.subscribe(onNext: { [self] data in
            self.subscribe(data, error: nil)
        }, onError: { [self] error in
            self.subscribe(nil, error: error as NSError)
        })
    }
    
    internal func reloadView() {
        objectWillChange.send()
    }
    
    internal func subscribe(_ model: DataModel?, error: NSError?) {
        self.model = model?.jurnal ?? nil
        self.error = error
        reloadView()
    }
    
    public func updateData() {
        model = nil
        reloadView()
    }
    
}
