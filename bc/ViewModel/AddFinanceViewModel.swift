//
//  AddFinanceViewModel.swift
//  bc
//
//  Created by Evgeny Hailov on 12.07.2023.
//

import Foundation
import UIKit

public class AddFinanceViewModel: ObservableObject {
    
    @Published public var article: [String] = []
    @Published public var object: [String] = []
    @Published public var counterparty: [String] = []
    @Published public var contractNumber: [String] = []
    @Published public var selectedArticle = ""
    @Published public var selectedObject = ""
    @Published public var selectedCounterparty = ""
    @Published public var selectedContractNumber = ""
    @Published public var sheet = false
    @Published public var image: UIImage? = nil
    @Published public var cash: String = ""
    @Published public var direction: String = ""
    @Published public var typeOfWork: String = ""
    @Published public var isProgressBar: Bool = false
    @Published public var isAlert: Bool = false
    @Published public var isComplete: Bool = false
    @Published public var localizedDescription: String = ""
    
    init() {
        self.getData()
    }
    
    private func getData() {
        EHDataHelper.share().getArticle {
            if $0 != nil {
                self.article = $0!
                self.selectedArticle = self.article.last!
            }
        }
        
        EHDataHelper.share().getObject {
            if $0 != nil {
                self.object = $0!
                self.selectedObject = self.object.last!
            }
        }
        
        EHDataHelper.share().getCounterparty {
            if $0 != nil {
                self.counterparty = $0!
                self.selectedCounterparty = self.counterparty.last!
            }
        }
        
        EHDataHelper.share().getContractNumber {
            if $0 != nil {
                self.contractNumber = $0!
                self.selectedContractNumber = self.contractNumber.last!
            }
        }
    }
    
    public func setFinanse(result: @escaping () -> ()) {
        self.isProgressBar.toggle()
        DispatchQueue.global().async {
            var data: [String: Any] = [:]
            data["file"] = self.image?.pngData() ?? ""
            data["id_article"] = self.selectedArticle
            data["id_objects"] = self.selectedObject
            data["id_acon"] = self.selectedCounterparty
            data["number"] = self.selectedContractNumber
            data["sum"] = self.cash
            data["text"] = self.direction
            data["type_of_work"] = self.typeOfWork
            EHDataHelper.share().setFinanse(parameters: data) { data, error in
                if error != nil {
                    EHLogger.verbose("save finanse", error)
                    self.completeFailure(localizedDescription: error!.localizedDescription)
                    return
                }
                if self.isComplete {
                    EHDataHelper.share().setComleted(id: data!["id"]!) { _, error in
                        if error != nil {
                            EHLogger.verbose("save comleted", error)
                            self.completeFailure(localizedDescription: error!.localizedDescription)
                            return
                        }
                        result()
                        self.completeSuccess()
                    }
                } else {
                    result()
                    self.completeSuccess()
                }
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
    
    public func capturePhotoLabrary(data: Data) {
        guard let image = UIImage(data: data) else {
            return
        }
        self.image = image
    }
    
}
