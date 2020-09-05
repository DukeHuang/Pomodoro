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
				Color.blue
				Text("番茄钟")
					.foregroundColor(Color.white)
				.padding()
//				NavigationLink(destination:  ClockView(ss: 25 * 60)) {
//					Text("")
//				}
				Button("") { self.presentingModal = true  }
					.sheet(isPresented: $presentingModal) {
						ClockView(ss: 25 * 60)
					}
			}.frame(height: 70)
				.listRowInsets(EdgeInsets())
			ZStack(alignment: .leading) {
				Color.red
				Text("背单词")
					.foregroundColor(Color.white)
					.padding()
				Button("") { self.presentingModal = true  }
					.sheet(isPresented: $presentingModal) {
						ClockView(ss: 60 * 60)
				}
			}.frame( height: 70)
				.listRowInsets(EdgeInsets())
			ZStack(alignment: .leading) {
				Color.orange
				Text("休息")
					.foregroundColor(Color.white)
				.padding()
				Button("") { self.presentingModal = true  }
					.sheet(isPresented: $presentingModal) {
						ClockView(ss: 5 * 60)
				}
			}.frame( height: 70)
				.listRowInsets(EdgeInsets())
		}
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ListClockView()
    }
}
