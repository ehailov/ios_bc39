//
//  FileViewModel.swift
//  bc
//
//  Created by Evgeny Hailov on 03.07.2023.
//

import Foundation
import SwiftUI

public class FileViewModel: ObservableObject, BaseViewModel {

    @Published public var model: [FileModel]? = nil
    @Published public var error: NSError? = nil
    
    
    init() {
        let rx = EHDataLayer.share().rxData
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
        self.model = model?.file ?? nil
        self.error = error
        reloadView()
    }
    
    public func updateData() {
        model = nil
        EHDataLayer.share().updateData()
        reloadView()
    }
    
}
