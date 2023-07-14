//
//  FinanseView.swift
//  bc
//
//  Created by Evgeny Hailov on 29.06.2023.
//

import SwiftUI
import RxSwift

struct FinanseView: View {
    
    @ObservedObject var model: FinanseViewModel = FinanseViewModel()
    
    var body: some View {
        ZStack {
            if model.error != nil {
                Text(model.error!.localizedDescription).foregroundColor(.primary)
            } else if model.model != nil {
                if model.model!.isEmpty {
                    Text("noData").foregroundColor(.primary)
                } else {
                    List(model.model!) { data in
                        FinanseItem(data: data)
                            .listRowBackground(data.article == "Приход" ? Color.mint : Color.pink)
                            .listRowSeparator(.visible)
                            .listStyle(.automatic)
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
    
struct FinanseItem: View {
    
    var data: FinanseModel
    
    var body: some View {
        HStack() {
            VStack(alignment: .leading) {
                Image("Check").resizable()
                    .frame(width: 90, height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 30)
                        .stroke(lineWidth: 0)
                        .foregroundColor(Color.black))
                Text(data.date).font(.system(size: 12)).padding(.top).foregroundColor(Color.white)
            }
            Spacer()
            VStack {
                LabeledContent("direction", value: data.text)
                    .font(.system(size: 12)).foregroundColor(Color.white)
                LabeledContent("typeOfWork", value: data.typeOfWork)
                    .font(.system(size: 12)).foregroundColor(Color.white)
                LabeledContent("anObject", value: data.objects)
                    .font(.system(size: 12)).foregroundColor(Color.white)
                LabeledContent("counterparty", value: data.accoun)
                    .font(.system(size: 12)).foregroundColor(Color.white)
                LabeledContent("contractNumber", value: data.number)
                    .font(.system(size: 12)).foregroundColor(Color.white)
                LabeledContent("theAmount", value: data.sum)
                    .font(.system(size: 12)).foregroundColor(Color.white)
                LabeledContent("cash", value: data.kassa)
                    .font(.system(size: 12)).foregroundColor(Color.white)
            }
        }
    }
    
}
