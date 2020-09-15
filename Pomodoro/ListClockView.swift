//
//  SwiftUIView.swift
//  Pomodoro
//
//  Created by yongyou on 2020/5/8.
//  Copyright © 2020 yongyou. All rights reserved.
//

import SwiftUI

struct ListClockView: View {
	@State var presentingModal = false
	init() {
		UITableView.appearance().separatorColor = .clear
	}
    var body: some View {
		List {
            ZStack(alignment: .leading) {
                NavigationLink(destination: ClockView(countDownSeconds: 25 * 60)) {
                     EmptyView()
                }
                .buttonStyle(PlainButtonStyle())
                .hiddenTabBar()
                Color.blue
                Text("工作")
                    .foregroundColor(Color.white)
                    .padding()
            }.frame(height: 70)
                .listRowInsets(EdgeInsets())


			ZStack(alignment: .leading) {
				Color.red
				Text("背单词")
					.foregroundColor(Color.white)
					.padding()
                NavigationLink(destination: ClockView(countDownSeconds: 60 * 60)) {
                    EmptyView()
                }
                .buttonStyle(PlainButtonStyle())
                .hiddenTabBar()
			}.frame( height: 70)
				.listRowInsets(EdgeInsets())
			ZStack(alignment: .leading) {
				Color.orange
				Text("休息")
					.foregroundColor(Color.white)
				.padding()
                NavigationLink(destination: ClockView(countDownSeconds: 5 * 60)) {
                    EmptyView()
                }
                .buttonStyle(PlainButtonStyle())
                .hiddenTabBar()
			}.frame( height: 70)
				.listRowInsets(EdgeInsets())
        }.navigationBarTitle("任务")
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ListClockView()
    }
}
