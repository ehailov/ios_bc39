//
//  JurnalFragment.swift
//  bc
//
//  Created by Evgeny Hailov on 29.06.2023.
//

import SwiftUI

struct JurnalView: View {
    
    @ObservedObject var model: JurnalViewModel = JurnalViewModel()
    
    var body: some View {
        ZStack {
            if model.error != nil {
                Text(model.error!.localizedDescription).foregroundColor(.primary)
            } else if model != nil {
                if model.model!.isEmpty {
                    Text("noData").foregroundColor(.primary)
                } else {
                    List(model.model!) { data in
                        JurnalItem(data: data)
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

struct JurnalItem: View {
    
    var data: JurnalModel
    
    var body: some View {
        HStack(spacing: 10) {
            VStack {
                AsyncImage(url: URL(string: String(format: "http://bc-24.ru/media/%@", data.file0))) {
                    $0.resizable().scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 70, height: 70)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                Text(data.date).font(.system(size: 10))
            }
            Spacer()
            VStack {
                LabeledContent(String(format: "%@:", data.worker), value: data.work).font(.system(size: 12))
                LabeledContent(String(format: "%@:", data.obj), value: data.typeOfWork).font(.system(size: 12))

            }
        }
    }
}
