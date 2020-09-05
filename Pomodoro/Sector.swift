//
//  Sector.swift
//  Pomodoro
//
//  Created by yongyou on 2020/5/3.
//  Copyright © 2020 yongyou. All rights reserved.
//

import SwiftUI

struct Sector: View {
	var endAngleDegree: CGFloat = 0.0
    var body: some View {
		GeometryReader { geometry in
			Path { path in
				//先找到中心点
				let centerX = geometry.size.width / 2
				let centerY = geometry.size.height / 2
				// 先画一条弧线
				path.addArc(center: CGPoint(x: centerX, y: centerY), radius: centerX, startAngle: Angle(degrees: 270), endAngle: Angle(degrees: Double(self.endAngleDegree)), clockwise: false)
				path.addLine(to: CGPoint(x: centerX, y: centerY))
				path.closeSubpath()
//				path.stroke(Color.black)
			}
			.fill(Color.green)
		}
    }
}

struct Sector_Previews: PreviewProvider {
    static var previews: some View {
		Sector(endAngleDegree: 0.0)
    }
}
