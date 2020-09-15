//
//  SwiftUIView.swift
//  Pomodoro
//
//  Created by yongyou on 2020/5/8.
//  Copyright © 2020 yongyou. All rights reserved.
//

import SwiftUI


struct Task {
    var countDownMinute: Int
    var name: String
    var bgColor: Color
}

struct TaskListView: View {
	@State var presentingModal = false

    let tasks: [Task] = [Task(countDownMinute: 25, name: "工作", bgColor: .blue),
                         Task(countDownMinute: 60, name: "背单词",bgColor: .red),
                         Task(countDownMinute: 5, name: "休息", bgColor: .green),
    Task(countDownMinute: 1, name: "Test", bgColor: .yellow)]
	init() {
		UITableView.appearance().separatorColor = .clear
	}
    var body: some View {
		List {
            ForEach(tasks.indices) { index in
                ZStack(alignment: .leading) {
                    NavigationLink(destination: TomatoView(countDownSeconds: CGFloat(self.tasks[index].countDownMinute * 60))) {
                        EmptyView()
                    }
                    .buttonStyle(PlainButtonStyle())
                    self.tasks[index].bgColor
                    Text(self.tasks[index].name)
                        .foregroundColor(Color.white)
                        .padding()
                }.frame(height: 70)
                    .listRowInsets(EdgeInsets())
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
