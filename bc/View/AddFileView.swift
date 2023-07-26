//
//  AddFileView.swift
//  bc
//
//  Created by Evgeny Hailov on 14.07.2023.
//

import SwiftUI

struct AddFileView: View {
    
    @ObservedObject private var model = AddFileViewModel()
    @Binding var path: [Int]
    
    var body: some View {
        if model.isProgressBar {
            ProgressView()
        } else {
            VStack {
                FileFormView(model: model)
                Spacer()
                FilePanelView(path: $path, model: model)
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

struct FileFormView : View {
    
    @ObservedObject var model: AddFileViewModel
    
    var body: some View {
        Form {
            TextField("name", text: $model.name)
                .padding(.all)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            Picker("anObject", selection: $model.selectedObject) {
                ForEach(model.object, id: \.self) {
                    Text($0)
                }
            }
            .padding(.all)
            .frame(width: .infinity, height: 100)
            .tabViewStyle(.page)
        }
    }
    
}

//MARK: - Panel view

struct FilePanelView : View {
    
    @Binding var path: [Int]
    @ObservedObject  var model: AddFileViewModel
    
    var body: some View {
        HStack {
            Button {
                model.openFile.toggle()
            } label: {
                Image(systemName: "paperclip")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(.all)
            }.fileImporter(isPresented: $model.openFile, allowedContentTypes: [.pdf, .jpeg, .png, .applicationExtension]) { result in
                do {
                    let url = try result.get()
                    model.set(url: url)
                }
                catch {
                    model.name = (error.localizedDescription)
                }
            }
            
            
            Spacer()
            Button {
                model.setFile() {
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


