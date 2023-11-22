//
//  ContentView.swift
//  Converter
//
//  Created by 수킴 on 2022/11/07.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputValue: Double = 0.0
    @State private var inputDetailUnit: Dimension = UnitLength.kilometers
    @State private var outputDetailUnit: Dimension = UnitLength.miles
    @FocusState private var inputIsFocused: Bool
    
    private let inputUnitArray = ["길이", "부피", "온도", "시간"]
    private let unitTypes = [
        [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles],
        [UnitMass.grams, UnitMass.kilograms, UnitMass.ounces, UnitMass.pounds],
        [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin],
        [UnitDuration.hours, UnitDuration.minutes, UnitDuration.seconds]
    ]
    
    @State var selectedUnits = 0
    let formatter: MeasurementFormatter
    
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
    }
    
    var resultValue: String {
        let inputLength = Measurement(value: inputValue, unit: inputDetailUnit)
        let outputLength = inputLength.converted(to: outputDetailUnit)
        return formatter.string(from: outputLength)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("변환단위", selection: $selectedUnits) {
                        ForEach(0..<inputUnitArray.count, id: \.self) {
                            Text(inputUnitArray[$0])
                        }
                    }
                } header: {
                    Text("입력단위를 선택하세요")
                }
                
                Section {
                    Picker("세부 변환단위", selection: $inputDetailUnit) {
                        ForEach(unitTypes[selectedUnits], id: \.self) {
                            Text(formatter.string(from: $0).capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("세부적인 단위를 선택하세요")
                }
                
                Section {
                    TextField("값을 입력하세요", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                } header: {
                    Text("변환할 값을 입력하세요")
                }
                
                Section {
                    Picker("출력 변환단위", selection: $outputDetailUnit) {
                        ForEach(unitTypes[selectedUnits], id: \.self) {
                            Text(formatter.string(from: $0).capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("출력 단위를 선택하세요")
                }
                
                Section {
                    Text(resultValue)
                } header: {
                    Text("출력 결과")
                }
            }
            .navigationTitle("Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
            .onChange(of: selectedUnits) { newSelection in
                let units = unitTypes[newSelection]
                inputDetailUnit = units[0]
                outputDetailUnit = units[1]
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
