import SwiftUI

extension UnitDuration {
    // 1일 = 86,400초를 기준으로 하는 새로운 단위 생성
    static let days = UnitDuration(symbol: "days", converter: UnitConverterLinear(coefficient: 86400))
}

struct ContentView: View {
    
    let shiftModeList: [String] = ["Temperature", "Length", "Time", "Volume"]
    var unitMode: [String] {
        if currentMode == "Temperature" {
            return ["Celsius", "Fahrenheit", "Kelvin"]
        } else if currentMode == "Length" {
            return ["meters", "kilometers", "feet", "yards", "miles"]
        } else if currentMode == "Time" {
            return ["seconds", "minutes", "hours", "days"]
        } else {
            return ["milliliters", "liters", "cups", "pints", "gallons"]
        }
    }
    
    @State private var currentMode = "Temperature"
    @State private var fromUnit = "Celsius"
    @State private var toUnit = "Fahrenheit"
    @State private var input = 0.0
    
    @FocusState private var inputIsFocused:Bool
    
    func temperatureUnit(for unitString: String) -> UnitTemperature {
        switch unitString {
        case "Celsius": return .celsius
        case "Fahrenheit": return .fahrenheit
        case "Kelvin": return .kelvin
        default: return .celsius
        }
    }
    
    func lengthUnit(for unitString: String) -> UnitLength {
        switch unitString {
        case "meters": return .meters
        case "kilometers": return .kilometers
        case "feet": return .feet
        case "yards": return .yards
        case "miles": return .miles
        default: return .meters
        }
    }
    
    
    
    func timeUnit(for unitString: String) -> UnitDuration {
        switch unitString {
        case "seconds": return .seconds
        case "minutes": return .minutes
        case "hours": return .hours
        case "days": return .days
        default: return .seconds
        }
    }
        
        
    func volumeUnit(for unitString: String) -> UnitVolume {
        switch unitString {
        case "milliliters": return .milliliters
        case "liters": return .liters
        case "cups": return .cups
        case "pints": return .pints
        case "gallons": return .gallons
        default: return .milliliters
        }
    }
        
    var output:Double {
        let inputValue = input
        
        if currentMode == "Temperature" {
            let inputUnit = temperatureUnit(for: fromUnit)
            let targetUnit = temperatureUnit(for: toUnit)
            
            let measurement = Measurement(value: inputValue, unit:inputUnit)
            return measurement.converted(to: targetUnit).value
        } else if currentMode == "Length" {
            let inputUnit = lengthUnit(for: fromUnit)
            let targetUnit = lengthUnit(for: toUnit)
            
            let measurement = Measurement(value: inputValue, unit:inputUnit)
            return measurement.converted(to: targetUnit).value
        } else if currentMode == "Time" {
            let inputUnit = timeUnit(for: fromUnit)
            let targetUnit = timeUnit(for: toUnit)
            
            let measurement = Measurement(value: inputValue, unit:inputUnit)
            return measurement.converted(to: targetUnit).value
        } else {
            let inputUnit = volumeUnit(for: fromUnit)
            let targetUnit = volumeUnit(for: toUnit)
            
            let measurement = Measurement(value: inputValue, unit:inputUnit)
            return measurement.converted(to: targetUnit).value
        }
    }
        
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Shift Mode", selection: $currentMode ) {
                        ForEach(shiftModeList, id: \.self) {
                            Text($0)
                        }
                    }
                    .onChange(of: currentMode) {
                        // unitMode 배열의 첫 번째와 두 번째 항목으로 자동 초기화
                        fromUnit = unitMode[0]
                        toUnit = unitMode[1]
                    }
                }
                Section {
                    Picker("From", selection: $fromUnit) {
                        ForEach(unitMode, id: \.self) {
                            Text($0)
                        }
                    }
                    Picker("To", selection: $toUnit) {
                        ForEach(unitMode, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section ("Value"){
                    TextField("Input Here", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                }
                Section ("Result") {
                    Text(output.formatted())
                }
            }
            .navigationTitle("UniShift")
            .toolbar {
                if inputIsFocused {
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
