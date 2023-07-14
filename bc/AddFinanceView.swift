//
//  AddFinanceView.swift
//  bc
//
//  Created by Evgeny Hailov on 10.07.2023.
//

import SwiftUI

struct AddFinanceView: View {
    
    @State private var showImagePicker: Bool = false
    @State private var showCameraView: Bool = false
    @State private var image: Image? = nil
    
    @State private var article: [String] = []
    @State private var object: [String] = []
    @State private var counterparty: [String] = []
    @State private var contractNumber: [String] = []
    
    @State private var selectedArticle = ""
    @State private var selectedObject = ""
    @State private var selectedCounterparty = ""
    @State private var selectedContractNumber = ""
    
    @State private var cash: String = ""
    @State private var direction: String = ""
    @State private var typeOfWork: String = ""
    @State var isOn: Bool = false
    
    var body: some View {
        Form {
            TextField("cash", text: $cash)
                .padding(.all)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            TextField("direction", text: $direction)
                .padding(.all)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            TextField("typeOfWork", text: $typeOfWork)
                .padding(.all)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            
            Picker("article", selection: $selectedArticle) {
                ForEach(article, id: \.self) {
                    Text($0)
                }
            }
            .padding(.all)
            
            Picker("anObject", selection: $selectedObject) {
                ForEach(object, id: \.self) {
                    Text($0)
                }
            }
            .padding(.all)
            
            Picker("counterparty", selection: $selectedCounterparty) {
                ForEach(counterparty, id: \.self) {
                    Text($0)
                }
            }
            .padding(.all)
            
            Picker("contractNumber", selection: $selectedContractNumber) {
                ForEach(contractNumber, id: \.self) {
                    Text($0)
                }
            }
            .padding(.all)
            
            Toggle(isOn: $isOn) {
                Text("searchForCompletedDeals")
            }
            .padding(.all)
            
            image?
                .resizable()
                .scaledToFit()
                .padding(.all)
            
            HStack {
                Button {
                    self.showCameraView = true
                } label: {
                    Image(systemName: "camera.circle.fill").frame(minWidth: 50,minHeight: 50)
                }
                Button {
                    self.showImagePicker = true
                } label: {
                    Image(systemName: "paperclip").frame(minWidth: 50,minHeight: 50)
                }
            }
            .padding(.all)
        }.onAppear() {
            getData()
        }
        .sheet(isPresented: self.$showImagePicker) {
            PhotoCaptureView(showImagePicker: self.$showImagePicker, image: self.$image)
        }
    }
    
    func getData() {
        DataHelper.share().getArticle {
            if $0 != nil {
                self.article = $0 ?? ["-"]
                self.selectedArticle = self.article[0]
            }
        }
        
        DataHelper.share().getObject {
            if $0 != nil {
                self.object = $0 ?? ["-"]
                self.selectedObject = self.object[0]
            }
        }
        
        DataHelper.share().getCounterparty {
            if $0 != nil {
                self.counterparty = $0 ?? ["-"]
                self.selectedCounterparty = self.counterparty[0]
            }
        }
        
        DataHelper.share().getContractNumber {
            if $0 != nil {
                self.contractNumber = $0 ?? ["-"]
                self.selectedContractNumber = self.contractNumber[0]
            }
        }
    }
}

