//
//  ClockPoint.swift
//  Pomodoro
//
//  Created by yongyou on 2020/4/30.
//  Copyright © 2020 yongyou. All rights reserved.
//

import SwiftUI

struct ClockPoint: View {
	var width: CGFloat = 0.0
	var body: some View {
		GeometryReader { geometry in
			Path { path in
				let centX = geometry.size.width * 0.5
				let centY = geometry.size.height * 0.5
				let offset: CGFloat = self.width
				path.move(
					to:CGPoint(
						x: centX - offset,
						y: centY
					)
				)
				path.addLine(
					to: .init(x: centX - offset,
							  y: 0))
				
				path.addLine(
					to: .init(x: centX + offset,
							  y: 0))
				
				path.addLine(
					to: .init(x: centX + offset,
							  y: centY))
				path.addLine(
					to: .init(x: centX - offset,
							  y: centY))
			}
			.fill(Color.white)
		} .aspectRatio(1, contentMode: .fit)
	}
}


struct ClockPoint_Previews: PreviewProvider {
    static var previews: some View {
		ClockPoint(width: 5)
    }
}
