//
//  ContentView.swift
//  BetterRest
//
//  Created by Akash Sheelavant on 12/06/23.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    @State private var recommendedTimeToSleep = ""
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView  {
            Form {
                Section {
                    Text("Recommended BedTime: \(recommendedTimeToSleep)")
                        .font(.system(size: 24, weight: .heavy))
                }
                
                Section("Desired amout of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours",
                            value: $sleepAmount,
                            in: 4...12,
                            step: 0.25) {_ in
                        calculateBedTime()
                    }
                    
                    
                }
                
                Section("Daily coffee intake") {
                    Picker("Please select:",
                           selection: $coffeeAmount) {
                        ForEach(1..<21) {
                            Text($0 == 1 ? "1 cup" : "\($0) cups")
                            
                        }
                    }
                           .onReceive([self].publisher.first()) { _ in
                               calculateBedTime()
                           }
                }
            }
            .navigationTitle("BetterRest")
        }
    }
    
    func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour+minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            recommendedTimeToSleep = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            // something went wrong!
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
