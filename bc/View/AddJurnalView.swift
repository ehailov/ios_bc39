//
//  AddJurnalView.swift
//  bc
//
//  Created by Evgeny Hailov on 14.07.2023.
//

import SwiftUI
import PhotosUI

struct AddJurnalView: View {
    
    @State private var selectedItems: [PhotosPickerItem] = []
    @Binding var path: [Int]
    @ObservedObject private var model: AddJurnalViewModel = AddJurnalViewModel()
    
    var body: some View {
        if model.isProgressBar {
            ProgressView()
        } else {
            VStack {
                FormView(model: model)
                Spacer()
                PanelView(path: $path, selectedItems: $selectedItems, model: model)
            }
            .sheet(isPresented: $model.sheet, onDismiss: model.captureCamera) {
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

struct FormView : View {
    
    @ObservedObject var model: AddJurnalViewModel
    
    var body: some View {
        Form {
            TextField("typeOfWork", text: $model.typeOfWork)
                .padding(.all)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            Picker("anObject", selection: $model.selectedObject) {
                ForEach(model.object, id: \.self) {
                    Text($0)
                }
            }
            .padding(.all)
            
            DatePicker("date", selection: $model.selectedDate)
                .datePickerStyle(.compact)
                .padding(.all)
            
            
            TabView {
                ForEach(model.images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                }
            }
            .frame(width: .infinity, height: 300)
            .tabViewStyle(.page)
            .background(Color.black)
        }
    }
    
}

//MARK: - Panel view

struct PanelView : View {
    
    @Binding var path: [Int]
    @Binding var selectedItems: [PhotosPickerItem]
    @ObservedObject var model: AddJurnalViewModel
    
    var body: some View {
        HStack {
            Button {
                model.getSheetCamera()
            } label: {
                Image(systemName: "camera.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(.all)
            }
            PhotosPicker(selection: $selectedItems, maxSelectionCount: 10, matching: .images) {
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
                model.setJurnal {
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
