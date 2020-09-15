//
//  ContentView.swift
//  Pomodoro
//
//  Created by yongyou on 2020/4/29.
//  Copyright © 2020 yongyou. All rights reserved.
//

import SwiftUI
//By default, SwiftUI view files declare two structures. The first structure conforms to the View protocol and describes the view’s content and layout. The second structure declares a preview for that view.

struct ContentView: View {
	var body: some View {
		TabView {
			NavigationView {
				ListClockView()
				.navigationBarTitle(Text("任务"))
			}.tabItem({
				Image.init(systemName: "list.dash")
				Text("任务")
                })
			NavigationView {
				StatisticsView()
					.navigationBarTitle(Text("统计"))
			}.tabItem({
				Image.init(systemName: "timer")
				Text("统计")
                })
			NavigationView {
				AnalysisView()
					.navigationBarTitle(Text("统计"))
			}.tabItem({
				Image.init(systemName: "waveform")
				Text("分析")
                })
			NavigationView {
				SettingView()
					.navigationBarTitle(Text("统计"))
			}.tabItem({
				Image.init(systemName: "person")
				Text("我的")
                })
        }
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
