//
//  ContentView.swift
//  BetterRest
//
//  Created by 문준민 on 11/5/26.
//

import SwiftUI
import CoreML

struct ContentView: View {
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    //    @State private var alertTitle = ""
    //    @State private var alertMessage = ""
    //    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                header: {
                    Text("When do you want to wake up?")
                        .font(.headline)
                }
                
                Section {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                header: {
                    Text("Desired amount of sleep")
                }
                
                Section {
                    //                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
                    Picker("^[\(coffeeAmount) cup](inflect: true)", selection: $coffeeAmount) {
                        ForEach (1..<21, id: \.self) { number in
                            Text("^[\(number) cup](inflect: true)")
                                .tag(number)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                header: {
                    Text("Daily coffee intake")
                }
                
                Section {
                    if let result = calculateBedtime() {
                        HStack(spacing: 12) {
                            Text("\(Image(systemName: "moon")) \(result.bedtime)")
                                .lineLimit(1)
//                                .minimumScaleFactor(0.7)

                            VStack(spacing: 4) {
                                Text("\(result.hours)시간 \(result.minutes)분")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)

                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 65, height: 12)
                            }

                            Text("\(Image(systemName: "sunrise")) \(result.wakeTime)")
                                .lineLimit(1)
//                                .minimumScaleFactor(0.7)
                        }
                        .font(.title2)
                        .minimumScaleFactor(0.6)
                        .frame(maxWidth: .infinity)
                    } else {
                        Text("Calculation Error")
                    }
                } header: {
                    Text("Your sleep schedule")
                }
            }
            .navigationTitle("BetterRest")
            //            .toolbar {
            //                Button("Calculate", action: calculateBedtime)
            //            }
            //            .alert(alertTitle, isPresented: $showingAlert) {
            //                Button("OK") { }
            //            } message: {
            //                Text(alertMessage)
            //            }
        }
    }
    
    func calculateBedtime() -> (
        bedtime: String,
        wakeTime: String,
        hours: Int,
        minutes: Int
    )? {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents(
                [.hour, .minute],
                from: wakeUp
            )

            let hour = (components.hour ?? 0) * 3600
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(
                coffee: Double(coffeeAmount),
                estimatedSleep: sleepAmount,
                wake: Double(hour + minute)
            )

            let sleepTime = wakeUp - prediction.actualSleep
            let totalMinutes = Int(
                (prediction.actualSleep / 60).rounded()
            )

            return (
                bedtime: sleepTime.formatted(date: .omitted, time: .shortened),
                wakeTime: wakeUp.formatted(date: .omitted, time: .shortened),
                hours: totalMinutes / 60,
                minutes: totalMinutes % 60
            )
        } catch {
            return nil
        }
    }
}

#Preview {
    ContentView()
}
