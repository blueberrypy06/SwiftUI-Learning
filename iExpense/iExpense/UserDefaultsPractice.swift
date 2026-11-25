//
//  UserDefaultsPractice.swift
//  iExpense
//
//  Created by 문준민 on 11/25/26.
//

import SwiftUI

struct UserDefaultsPractice: View {
    @AppStorage("tapCount") private var tapCount = 0
    
    @State private var tap = UserDefaults.standard.integer(forKey: "Tap")
    
    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
        }
        Button("Tap : \(tap)") {
            tap += 1
            UserDefaults.standard.set(tap, forKey: "Tap")
        }
    }
}

#Preview {
    UserDefaultsPractice()
}
