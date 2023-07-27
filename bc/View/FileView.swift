//
//  FileView.swift
//  bc
//
//  Created by Evgeny Hailov on 29.06.2023.
//

import SwiftUI

struct FileView: View {
    
    @Binding var path: [Int]
    @ObservedObject var model = FileViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if model.error != nil {
                    Text(model.error!.localizedDescription).foregroundColor(.primary)
                } else if model.model != nil {
                    if model.model!.isEmpty {
                        Text("noData").foregroundColor(.primary)
                    } else {
                        List(model.model!) { data in
                            FileItem(data: data)
                        }.refreshable {
                            model.updateData()
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("Files")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                FileCustomBarItem(path: $path)
            }
        }
    }
}

struct FileItem: View {
    
    var data: FileModel
    
    var body: some View {
        HStack(spacing: 10) {
            VStack {
                Image(getImege(data.type))
                    .frame(width: 60, height: 60)
            }
            Text(data.name).font(.system(size: 12))
            Spacer()
            VStack {
                Text(data.obj).font(.system(size: 12))
                Text(data.work).font(.system(size: 12))
            }
        }
    }
    
    func getImege(_ type: String) -> String {
        if type == "pdf" {
            return "Pdf"
        } else if type == "xlsx" {
            return "Xlsx"
        } else if type == "docx" {
            return "Docx"
        } else if type == "jpg" {
            return "Jpg"
        } else {
            return "None"
        }
    }
}

struct FileCustomBarItem: ToolbarContent {
    
    @Binding var path: [Int]
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Image("Logo2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 18, alignment: .leading)
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                path = [5]
            } label: {
                Image(systemName: "plus.circle.fill")
            }
        }
    }
}
