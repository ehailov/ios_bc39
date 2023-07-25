//
//  CashView.swift
//  bc
//
//  Created by Evgeny Hailov on 12.07.2023.
//

import SwiftUI

struct CashView: View {
    
    @ObservedObject private var model: CashViewModlel = CashViewModlel()
    
    var body: some View {
        if model.isProgressBar {
            ProgressView()
        } else {
            Form {
                HStack {
                    Text("cash")
                        .padding(.all)
                        .font(.headline)
                    Text(model.cashValue)
                        .font(.headline)
                        .foregroundColor(.indigo)
                }
                
                DatePicker("from", selection: $model.selectedFrom)
                    .datePickerStyle(.compact)
                    .padding(.all)
                
                DatePicker("before", selection: $model.selectedBefore)
                    .datePickerStyle(.compact)
                    .padding(.all)
                
                Toggle(isOn: $model.isComplete) {
                    Text("searchForCompletedDeals")
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
                
                Button {
                    model.setCash()
                } label: {
                    Text("calculate")
                }
                .padding(.all)
                .buttonStyle(EHBlueButton())
                
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
