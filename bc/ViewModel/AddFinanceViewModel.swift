//
//  AddFinanceViewModel.swift
//  bc
//
//  Created by Evgeny Hailov on 12.07.2023.
//

import Foundation
import UIKit

public class AddFinanceViewModel: AddModelView, EHAddProtocol {
    
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
    lazy var logger = getLogger()
   
    override init() {
        super.init()
        self.getData()
    }
    
    internal func getData() {
        data?.getArticle {
            if $0 != nil {
                self.article = $0!
                self.selectedArticle = self.article.last!
            }
        }
        
        data?.getObject {
            if $0 != nil {
                self.object = $0!
                self.selectedObject = self.object.last!
            }
        }
        
        data?.getCounterparty {
            if $0 != nil {
                self.counterparty = $0!
                self.selectedCounterparty = self.counterparty.last!
            }
        }
        
        data?.getContractNumber {
            if $0 != nil {
                self.contractNumber = $0!
                self.selectedContractNumber = self.contractNumber.last!
            }
        }
    }
    
    public func setFinanse(result: @escaping () -> ()) {
        self.isProgressBar.toggle()
        data?.setFinanse(parameters: self.getParameters()) { data, error in
            if error != nil {
                self.logger.verbose("save finanse", error: error! as NSError)
                self.failure(error!.localizedDescription)
                return
            }
            if self.isComplete {
                self.data?.setComleted(id: data!["id"]!) { _, error in
                    if error != nil {
                        self.logger.verbose("save comleted", error: error as? NSError)
                        self.failure(error!.localizedDescription)
                        return
                    }
                    result()
                    self.success()
                }
            } else {
                result()
                self.success()
            }
        }
    }
    
    public func capturePhotoLabrary(data: Data) {
        guard let image = UIImage(data: data) else {
            return
        }
        self.image = image
    }
    
    func getParameters() -> [String : Any] {
        var data: [String: Any] = [:]
        data["file"] = self.image?.pngData() ?? ""
        data["id_article"] = self.selectedArticle
        data["id_objects"] = self.selectedObject
        data["id_acon"] = self.selectedCounterparty
        data["number"] = self.selectedContractNumber
        data["sum"] = self.cash
        data["text"] = self.direction
        data["type_of_work"] = self.typeOfWork
        return data
    }
    
}
