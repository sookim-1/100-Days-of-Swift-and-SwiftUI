//
//  AddView.swift
//  iExpense
//
//  Created by 수킴 on 2022/11/24.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "개인"
    @State private var amount = 0.0
    
    @ObservedObject var expenses: Expenses      // @StateObject를 참조하는 경우 @ObservedObject사용
    
    @Environment(\.dismiss) var dismiss
    
    let types = ["사업", "개인"]

    var body: some View {
        NavigationView {
            Form {
                TextField("이름", text: $name)

                Picker("구분 타입", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("비용", value: $amount, format: .currency(code: "KRW"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("항목 추가")
            .toolbar {
                Button("저장하기") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
