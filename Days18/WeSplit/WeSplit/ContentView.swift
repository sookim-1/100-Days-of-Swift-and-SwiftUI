//
//  ContentView.swift
//  WeSplit
//
//  Created by 수킴 on 2022/11/03.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0     // 요금
    @State private var numberOfPeople = 2   // 인원수
    @State private var tipPercentage = 20   // 팁
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    var currencyFormat: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)

        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var totalPrice: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("요금", value: $checkAmount, format: currencyFormat)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                
                Section {
                    Picker("인원 수", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) 명")
                        }
                    }
                }
                
                Section {
                    Picker("팁", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.wheel)
                } header: {
                    Text("팁을 얼마를 남기시겠습니까?")
                }
                
                Section {
                    Text(totalPerPerson, format: currencyFormat)
                } header: {
                    Text("1인당 금액")
                }
                
                Section {
                    Text(totalPrice, format: currencyFormat)
                } header: {
                    Text("총 금액")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {              
                    Spacer()

                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
