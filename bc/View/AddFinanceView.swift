//
//  AddFinanceView.swift
//  bc
//
//  Created by Evgeny Hailov on 10.07.2023.
//

import SwiftUI
import PhotosUI

struct AddFinanceView: View {
    
    @State private var selectedItems: [PhotosPickerItem] = []
    @Binding var path: [Int]
    @ObservedObject private var model: AddFinanceViewModel = AddFinanceViewModel()
    
    var body: some View {
        if model.isProgressBar {
            ProgressView()
        } else {
            VStack {
                FFormView(model: model)
                Spacer()
                FPanelView(path: $path, selectedItems: $selectedItems, model: model)
            }
            .sheet(isPresented: $model.sheet) {
                EHCameraView(image: $model.image)
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

//MARK: - Form view

struct FFormView : View {
    
    @ObservedObject var model: AddFinanceViewModel
    
    var body: some View {
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
            
            TabView {
                Image(uiImage: model.image ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 300)
            }
            .frame(width: .infinity, height: 300)
            .tabViewStyle(.page)
            .background(Color.black)
        }
    }
    
}

//MARK: - Panel view

struct FPanelView : View {
    
    @Binding var path: [Int]
    @Binding var selectedItems: [PhotosPickerItem]
    @ObservedObject var model: AddFinanceViewModel
    
    var body: some View {
        HStack {
            Button {
                model.sheet.toggle()
            } label: {
                Image(systemName: "camera.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(.all)
            }
            PhotosPicker(selection: $selectedItems, maxSelectionCount: 1, matching: .images) {
                Image(systemName: "paperclip")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(.all)
            }
            .onChange(of: selectedItems) { newValue in
                for item in newValue {
                    Task {
                        if let data = try? await item.loadTransferable(type: Data.self) {
                            model.capturePhotoLabrary(data: data)
                        }
                    }
                }
            }
            Spacer()
            Button {
                model.setFinanse {
                    path = []
                }
            } label: {
                Text("save")
            }
            .padding(.all)
            .buttonStyle(EHRedButton())
        }
    }
    
}
