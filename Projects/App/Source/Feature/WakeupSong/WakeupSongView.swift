//
//  WakeupSongView.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import SwiftUI
import DDS

struct WakeupSongView: View {
    
    @InjectObject var viewModel: WakeupSongViewModel
    @Flow var flow
    
    var body: some View {
        DodamScrollView.medium(title: "기상송") {
            VStack(alignment: .leading, spacing: 0) {
                Text("내일의 기상송")
                    .font(.title(.medium))
                    .dodamColor(.onBackground)
                if let data = viewModel.allowedWakeupSongData,
                   !data.isEmpty {
                    LazyVStack(spacing: 4) {
                        ForEach(
                            Array(data.enumerated()),
                            id: \.element
                        ) { index, element in
                            TomorrowWakeupSongCell(
                                data: element,
                                id: index + 1
                            )
                        }
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 6)
                } else {
                    Text("승인된 기상송이 아직 없어요.")
                        .font(.label(.large))
                        .dodamColor(.tertiary)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .center
                        )
                        .padding(.vertical, 40)
                }
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    DodamTopTabView {
                        LazyVStack(spacing: 4) {
                            if let data = viewModel.pendingWakeupSongData,
                               !data.isEmpty {
                                ForEach(data, id: \.self) { data in
                                    WakeupSongCell(
                                        data: data
                                    )
                                }
                            } else {
                                Text("대기중인 기상송이 없어요")
                                    .font(.body(.medium
                                               ))
                                    .dodamColor(.tertiary)
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .center
                                    )
                                    .padding(.top, 40)
                            }
                            Spacer()
                        }
                        .padding(.top, 12)
                        .padding(.bottom, 150)
                        .page(.text("대기중"))
                        
                        LazyVStack(spacing: 4) {
                            if let data = viewModel.myWakeupSongData,
                               !data.isEmpty {
                                ForEach(data, id: \.self) { data in
                                    Button {
                                        viewModel.showDialog = true
                                    } label: {
                                        WakeupSongCell(
                                            data: data
                                        )
                                    }
                                    .scaledButtonStyle()
                                    .alert(
                                        "기상송을 삭제하시겠습니까?",
                                        isPresented: $viewModel.showDialog
                                    ) {
                                        Button("네", role: .none) {
                                            Task {
                                                await viewModel.deleteWakeupSong(
                                                    id: data.id
                                                )
                                                await viewModel.fetchMyWakeupSong()
                                                await viewModel.fetchPendingWakeupSong()
                                            }
                                        }
                                        Button("취소", role: .cancel) { }
                                    }
                                }
                            } else {
                                Text("기상송을 신청해 보세요")
                                    .font(.body(.medium
                                               ))
                                    .dodamColor(.tertiary)
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .center
                                    )
                                    .padding(.top, 40)
                            }
                            Spacer()
                        }
                        .padding(.top, 12)
                        .padding(.bottom, 150)
                        .page(.text("MY"))
                    }
                    .padding(.top, 15)
                    Spacer()
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 150)
        }
        .overlay(alignment: .bottom) {
            DodamButton.fullWidth(
                title: "기상송 신청하기"
            ) {
                flow.push(WakeupSongApplyView())
            }
            .padding([.bottom, .horizontal], 16)
        }
        .task {
            await viewModel.onAppear()
        }
        .refreshable {
            await viewModel.onAppear()
        }
    }
}

#Preview {
    FlowPreview {
        WakeupSongView()
    }
}
