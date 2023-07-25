//
//  AddJurnalViewModel.swift
//  bc
//
//  Created by Evgeny Hailov on 21.07.2023.
//

import Foundation
import UIKit

public class AddJurnalViewModel: ObservableObject {
    
    @Published public var object: [String] = []
    @Published public var selectedObject = ""
    @Published public var sheet = false
    @Published public var images: [UIImage] = []
    @Published public var image: UIImage? = nil
    @Published public var typeOfWork: String = ""
    @Published public var isProgressBar: Bool = false
    @Published public var isAlert: Bool = false
    @Published public var isComplete: Bool = false
    @Published public var localizedDescription: String = ""
    @Published public var selectedDate: Date = Date()
    
    init() {
        self.getData()
    }
    
    private func getData() {
        EHDataHelper.share().getObject {
            if $0 != nil {
                self.object = $0!
                self.selectedObject = self.object.last!
            }
        }
    }
    
    public func setJurnal(result: @escaping () -> ()) {
        self.isProgressBar.toggle()
        DispatchQueue.global().async {
            let parameters = self.getPareametrs()
            EHDataHelper.share().setJurnal(parameters: parameters) { data, error in
                if error != nil {
                    EHLogger.verbose("save jurnal", error)
                    self.completeFailure(localizedDescription: error!.localizedDescription)
                    return
                }
                result()
                self.completeSuccess()
            }
        }
    }
    
    private func completeFailure(localizedDescription: String) {
        DispatchQueue.main.async {
            self.localizedDescription = localizedDescription
            self.isProgressBar.toggle()
            self.isAlert.toggle()
        }
    }
    
    private func completeSuccess() {
        DispatchQueue.main.async {
            EHDataHelper.share().updateData()
            self.isProgressBar.toggle()
        }
    }
    
    private func getPareametrs() -> [String: Any] {
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
