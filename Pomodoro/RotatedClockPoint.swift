//
//  RotatedClockPoint.swift
//  Pomodoro
//
//  Created by yongyou on 2020/4/30.
//  Copyright © 2020 yongyou. All rights reserved.
//

import SwiftUI

struct RotatedClockPoint: View {
	let angle: Angle
	let padding: CGFloat
	let width: CGFloat
	var body: some View {
		ClockPoint(width: self.width)
			.padding(.all,padding)
			.rotationEffect(angle, anchor: .center)
	}
}

struct RotatedClockPoint_Previews: PreviewProvider {
    static var previews: some View {
		RotatedClockPoint(angle: .init(degrees: 90),padding: 30,width: 5.0)
    }
}
