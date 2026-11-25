//
//  SheetPractice.swift
//  iExpense
//
//  Created by 문준민 on 11/25/26.
//

import SwiftUI

struct SheetPractice: View {
    @State private var showingSheet = false
    
    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            ClassObsevablePractice()
        }
    }
}

#Preview {
    SheetPractice()
}
