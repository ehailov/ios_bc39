//
//  FinanceViewModel.swift
//  bc
//
//  Created by Evgeny Hailov on 30.06.2023.
//

import Foundation
import SwiftUI

public class FinanсeViewModel: ObservableObject, BaseViewModel {
    
    @Published public var model: [FinanseModel]? = nil
    @Published public var error: NSError? = nil
    lazy var data = getDataLayer()
   
    init() {
        let rx = data.rxData
        rx?.subscribe(onNext: { data in
            self.subscribe(data, error: nil)
        }, onError: { error in
            self.subscribe(nil, error: error as NSError)
        })
    }
    
    internal func reloadView() {
        objectWillChange.send()
    }
    
    internal func subscribe(_ model: DataModel?, error: NSError?) {
        self.model = model?.finanse ?? nil
        self.error = error
        reloadView()
    }
    
    public func updateData() {
        model = nil
        self.data.updateData()
        reloadView()
    }
    
    public func isNil() -> Bool {
        return model == nil ? true : false
    }
    
}
