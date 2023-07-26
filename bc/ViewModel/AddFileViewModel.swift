//
//  AddFileViewModel.swift
//  bc
//
//  Created by Evgeny Hailov on 25.07.2023.
//

import Foundation
import SwiftUI

class AddFileViewModel: AddModelView, EHAddProtocol {
    
    @Published public var object: [String] = []
    @Published public var selectedObject = ""
    @Published public var name = ""
    @Published public var openFile = false
    @Published public var url: URL?
    
    override init() {
        super.init()
        self.getData()
    }
    internal func getData() {
        EHDataLayer.share().getObject {
            if $0 != nil {
                self.object = $0!
                self.selectedObject = self.object.last!
            }
        }
    }
    
    public func set(url: URL) {
        self.url = url
        self.name = url.lastPathComponent
    }
    
    public func setFile(result: @escaping ()->()) {
        self.isProgressBar.toggle()
        let parameters = self.getParameters()
        EHDataLayer.share().setFile(parameters: parameters) { data, error in
            if error != nil {
                EHLogger.verbose("save jurnal", error: error)
                self.failure(error!.localizedDescription)
                return
            }
            result()
            self.success()
        }
    }
    
    func getParameters() -> [String : Any] {
        var data: [String: Any] = [:]
        data["file"] = url
        data["obj"] = selectedObject
        data["name"] = name
        return data
    }
    
}
