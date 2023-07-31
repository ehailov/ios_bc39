//
//  CashViewModel.swift
//  bc
//
//  Created by Evgeny Hailov on 13.07.2023.
//

import Foundation

class CashViewModel: ObservableObject{
    
    @Published public var article: [String] = []
    @Published public var object: [String] = []
    @Published public var counterparty: [String] = []
    @Published public var contractNumber: [String] = []
    @Published public var selectedArticle = ""
    @Published public var selectedObject = ""
    @Published public var selectedCounterparty = ""
    @Published public var selectedContractNumber = ""
    @Published public var selectedFrom: Date
    @Published public var selectedBefore: Date = Date()
    @Published public var isComplete: Bool = false
    @Published public var isProgressBar: Bool = false
    @Published public var isAlert: Bool = false
    @Published public var localizedDescription: String = ""
    @Published public var cashValue: String = "0"
    lazy var data = getDataLayer()
    lazy var logger = getLogger()
    
    init() {
        self.selectedFrom = Utils.getDateFrom(string: "2021-01-01", format: "yyyy-MM-dd") ?? Date()
        self.getData()
    }
    
    private func getData() {
        data.getArticle {
            if $0 != nil {
                self.article = $0!
                self.selectedArticle = self.article.last!
            }
        }
        
        data.getObject {
            if $0 != nil {
                self.object = $0!
                self.selectedObject = self.object.last!
            }
        }
        
        data.getCounterparty {
            if $0 != nil {
                self.counterparty = $0!
                self.selectedCounterparty = self.counterparty.last!
            }
        }
        
        data.getContractNumber {
            if $0 != nil {
                self.contractNumber = $0!
                self.selectedContractNumber = self.contractNumber.last!
            }
        }
    }
    
    public func setCash() {
        isProgressBar.toggle()
        var parametrs: [String: String] = [:]
        parametrs["f0"] = selectedArticle
        parametrs["f1"] = selectedObject
        parametrs["f2"] = selectedCounterparty
        parametrs["f3"] = selectedContractNumber
        parametrs["f4"] = Utils.stringFrom(date: selectedBefore)
        parametrs["f5"] = Utils.stringFrom(date: selectedFrom)
        data.setCash(parameters: parametrs, comleted: isComplete) { data, error in
            if error != nil {
                self.localizedDescription = error!.localizedDescription
                self.logger.verbose("setCash()", error: error!)
                self.isProgressBar.toggle()
                self.isAlert.toggle()
                return
            }
            if data != nil && data!["text"] != nil {
                let string = data!["text"] as! String
                self.cashValue = self.convertCashString(string: string)
            }
            self.isProgressBar.toggle()
        }
    }
    
    private func convertCashString(string: String) -> String {
        let subStrings = string.components(separatedBy: " ")
        if subStrings.isEmpty {
            return "-"
        }
        let number = NSNumber(floatLiteral: subStrings.last!.doubleValue)
        let value = getPriceFormat(number: number)
        return String(format: "%@ %@", subStrings.first!, value)
    }
    
    private func getPriceFormat(number: NSNumber) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: number) ?? "-"
    }
    
}
