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
    @Published public var sheet1 = false
    @Published public var sheet2 = false
    @Published public var inputImage: UIImage? = nil
    @Published public var cash: String = ""
    @Published public var direction: String = ""
    @Published public var typeOfWork: String = ""
    @Published public var isProgressBar: Bool = false
    @Published public var isAlert: Bool = false
    @Published public var isComplete: Bool = false
    @Published public var localizedDescription: String = ""
    @Published public var isImage: Bool = false
   
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
        var data: [String: Any] = [:]
        data["file"] = inputImage?.pngData() ?? ""
        data["id_article"] = selectedArticle
        data["id_objects"] = selectedObject
        data["id_acon"] = selectedCounterparty
        data["number"] = selectedContractNumber
        data["sum"] = cash
        data["text"] = direction
        data["type_of_work"] = typeOfWork
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
    
    private func completeFailure(localizedDescription: String) {
        self.localizedDescription = localizedDescription
        isProgressBar.toggle()
        isAlert.toggle()
    }
    
    private func completeSuccess() {
        EHDataHelper.share().updateData()
        isProgressBar.toggle()
    }
    
    public func loadImage() {
        if isImage == false {
            isImage.toggle()
        }
    }
}
