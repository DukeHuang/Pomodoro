//
//  CircleImage.swift
//  Pomodoro
//
//  Created by yongyou on 2020/4/29.
//  Copyright © 2020 yongyou. All rights reserved.
//

//			.overlay(Circle().stroke(Color.yellow,lineWidth: 4))
//			.shadow(radius: 10)
import SwiftUI

struct ClockView: View {
	let circle = Circle()
	var body: some View {
		ZStack {
			self.circle
				.foregroundColor (.black)
			RotatedClockPoint(angle: .init(degrees: 90.0),padding: 50)
			RotatedClockPoint(angle: .init(degrees: 0),padding: 10)
		}
	.padding()
	}
}


struct CircleImage_Previews: PreviewProvider {
	static var previews: some View {
		ClockView()
	}
}
