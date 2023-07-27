//
//  JurnalViewModel.swift
//  bc
//
//  Created by Evgeny Hailov on 03.07.2023.
//

import Foundation
import SwiftUI

public class JornalViewModel: ObservableObject, BaseViewModel {
    
    @Published public var model: [JurnalModel]? = nil
    @Published public var error: NSError? = nil
    
    init() {
        let rx = EHDataLayer.share().rxData
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
        EHDataLayer.share().updateData()
        reloadView()
    }
    
    public func isNil() -> Bool {
        return model == nil ? true : false
    }
    
}
