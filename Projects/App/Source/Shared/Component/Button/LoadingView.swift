//
//  LoadingView.swift
//  DodamDodam
//
//  Created by Mercen on 3/12/24.
//

import SwiftUI

struct DodamLoadingView: View {
    
    @State private var loadingState: Int = -1
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<3) { idx in
                Circle()
                    .fill(idx != loadingState ? .tertiary : .secondary)
                    .frame(width: 8, height: 8)
            }
        }
        .onChange(of: loadingState) { newValue in
            Task {
                try? await Task.sleep(nanoseconds: 300_000_000)
                withAnimation(.spring(duration: 0.5)) {
                    loadingState = (newValue + 1) % 3
                }
            }
        }
        .onAppear {
            loadingState = 0
        }
    }
}

#Preview {
    DodamLoadingView()
}
