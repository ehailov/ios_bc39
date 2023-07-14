//
//  AddFinanceView.swift
//  bc
//
//  Created by Evgeny Hailov on 10.07.2023.
//

import SwiftUI

struct AddFinanceView: View {
    
    @Binding var path: [Int]
    @ObservedObject private var model: AddFinanceViewModel = AddFinanceViewModel()
    
    var body: some View {
        if model.isProgressBar {
            ProgressView()
        } else {
            Form {
                TextField("cash", text: $model.cash)
                    .padding(.all)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                TextField("direction", text: $model.direction)
                    .padding(.all)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                TextField("typeOfWork", text: $model.typeOfWork)
                    .padding(.all)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                Picker("article", selection: $model.selectedArticle) {
                    ForEach(model.article, id: \.self) {
                        Text($0)
                    }
                }
                .padding(.all)
                
                Picker("anObject", selection: $model.selectedObject) {
                    ForEach(model.object, id: \.self) {
                        Text($0)
                    }
                }
                .padding(.all)
                
                Picker("counterparty", selection: $model.selectedCounterparty) {
                    ForEach(model.counterparty, id: \.self) {
                        Text($0)
                    }
                }
                .padding(.all)
                
                Picker("contractNumber", selection: $model.selectedContractNumber) {
                    ForEach(model.contractNumber, id: \.self) {
                        Text($0)
                    }
                }
                .padding(.all)
                
                Toggle(isOn: $model.isComplete) {
                    Text("searchForCompletedDeals")
                }
                .padding(.all)
                
                if model.isImage {
                    Image(uiImage: model.inputImage!)
                    .resizable()
                        .scaledToFit()
                        .padding(.all)
                        .frame(maxWidth: 100, maxHeight: 100)
                }
                
                HStack {
                    VStack {
                        Image(systemName: "camera.circle.fill")
                            .padding(.all)
                            .buttonStyle(.plain)
                            .onTapGesture {
                                self.model.sheet1.toggle()
                            }
                    }
                    VStack {
                        Image(systemName: "paperclip")
                            .padding(.all)
                            .buttonStyle(.plain)
                            .onTapGesture {
                                self.model.sheet2.toggle()
                            }
                    }
                    Spacer()
                    VStack {
                        Button {
                            model.setFinanse() {
                                path = []
                            }
                        } label: {
                            Text("save")
                        }
                    }
                }
                .sheet(isPresented: $model.sheet1, onDismiss: model.loadImage) {
                    CameraView(image: $model.inputImage)
                }
                .sheet(isPresented: $model.sheet2, onDismiss: model.loadImage) {
                    PhotoView(showImagePicker: $model.sheet2, image: $model.inputImage)
                }
                .alert("BC", isPresented: $model.isAlert) {
                    Text(model.localizedDescription)
                    Button("close") {
                        model.isAlert.toggle()
                    }
                }
            }
        } 
    }
    
    
}
