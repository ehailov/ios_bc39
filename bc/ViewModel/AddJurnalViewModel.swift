//
//  AddJurnalViewModel.swift
//  bc
//
//  Created by Evgeny Hailov on 21.07.2023.
//

import Foundation
import UIKit

public class AddJurnalViewModel: AddModelView, EHAddProtocol {
    
    @Published public var object: [String] = []
    @Published public var selectedObject = ""
    @Published public var sheet = false
    @Published public var images: [UIImage] = []
    @Published public var image: UIImage? = nil
    @Published public var typeOfWork: String = ""
    @Published public var selectedDate: Date = Date()
    
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
    
    public func setJurnal(result: @escaping () -> ()) {
        self.isProgressBar.toggle()
        let parameters = self.getParameters()
        EHDataLayer.share().setJurnal(parameters: parameters) { data, error in
            if error != nil {
                EHLogger.verbose("save jurnal", error: error)
                self.failure(error!.localizedDescription)
                return
            }
            result()
            self.success()
               
        }
    }
    
    internal func getParameters() -> [String: Any] {
        var data: [String: Any] = ["file0":"","file1":"","file2":"","file3":"","file4":"","file5":"","file6":"","file7":"","file8":"","file9":""]
        for image in images {
            guard let index = images.firstIndex(of: image) else {
                continue
            }
            let key = String(format: "file%d", index)
            data[key] = image.pngData() ?? ""
        }
        data["obj"] = selectedObject
        data["text"] = typeOfWork
        data["data"] = Utils.stringFrom(date: selectedDate)
        return data
    }
    
    public func captureCamera() {
        if image != nil {
            images.append(image!)
        }
    }
    
    public func capturePhotoLabrary(data: Data) {
        guard let image = UIImage(data: data) else {
            return
        }
        images.append(image)
    }
    
    public func getSheetCamera() {
        if images.count < 11 {
            sheet.toggle()
        }
    }
    
}
