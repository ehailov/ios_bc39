//
//  FileView.swift
//  bc
//
//  Created by Evgeny Hailov on 29.06.2023.
//

import SwiftUI

struct FileView: View {
    
    @ObservedObject var model: FileViewModel = FileViewModel()
    
    var body: some View {
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
