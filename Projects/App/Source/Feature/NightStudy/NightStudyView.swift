//
//  NightStudyView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/28/24.
//

import SwiftUI
import DDS

struct NightStudyView: View {
    
    @InjectObject var viewModel: NightStudyViewModel
    @Flow var flow
    
    var body: some View {
        DodamScrollView {
            HStack {
                Text("외출/외박")
                    .font(.headline(.small))
                    .dodamColor(.onBackground)
                    .padding(.leading, 20)
                Spacer()
                Button {
                    flow.push(Text("신청"))
                } label: {
                    Dodam.icon(.plus)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .dodamColor(.tertiary)
                }
                .frame(width: 44, height: 44)
                .padding(.trailing, 12)
            }
            .frame(height: 58)
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
        } content: {
            VStack(spacing: 20) {
                if let datas = viewModel.nightStudyDatas {
                    ForEach(datas, id: \.self) { data in
                        Text(data.status)
                    }
                } else {
                    DodamEmptyView(
                        .nightStudy
                    ) {
                        flow.push(Text("신청"))
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    NightStudyView()
}
