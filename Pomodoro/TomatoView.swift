//
//  CircleImage.swift
//  Pomodoro
//
//  Created by yongyou on 2020/4/29.
//  Copyright © 2020 yongyou. All rights reserved.
//

import SwiftUI
import UserNotifications
import AVFoundation

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

struct TomatoView: View {
	var countDownSeconds: CGFloat //总的倒计时长，单位 seconds
	@State var endAngleDegree: CGFloat = 270.0
	@State var showTimeSeconds: CGFloat = 0
	@State var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
	@State var timerRunning: Bool = false
	@State var player: AVAudioPlayer?

	var body: some View {
		VStack(alignment:.center, spacing: 0) {
			ZStack() {
				Circle()
					.foregroundColor (.gray)
				Sector(endAngleDegree: endAngleDegree)
					.animation(.easeInOut)
				Text(self.timeString(second: Int(self.showTimeSeconds)))
					.foregroundColor(.black)
					.fontWeight(.medium)
					.font(.system(size: 50))
					.frame(width: 150,  alignment: .center)
					.transition(.opacity)
			}
			.environment(\.colorScheme, .dark)
			.onReceive(timer, perform: { _ in
				if self.showTimeSeconds > 0 {
					self.showTimeSeconds -= 0.1
					print(String(format: "%.f",self.showTimeSeconds))
					self.endAngleDegree  +=  (0.1 / (self.countDownSeconds)) * 360
				} else {
					self.timer.upstream.connect().cancel()
					self.showTimeSeconds  = self.countDownSeconds
					self.endAngleDegree = 270.0
                    self.notify()
				}
			})
                .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 20, trailing: 0))
                .frame(width:UIScreen.screenWidth, height: UIScreen.screenWidth, alignment: .center)
			Button(action: {
				self.timerRunning.toggle()
				let path = Bundle.main.path(forResource:"music", ofType:"wav")
				do {
					self.player =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
				} catch {
				}
				let session = AVAudioSession.sharedInstance()
				do{
					try session.setCategory(AVAudioSession.Category.playback)
				}
				catch{
				}
				if self.timerRunning {
					self.timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
					self.player!.prepareToPlay()
					self.player?.numberOfLoops = -1
					self.player!.play()
				} else {
					self.timer.upstream.connect().cancel()
					self.player?.stop()
				}
			}) {
				Text("")
				if self.timerRunning {
					Image(systemName: "pause").renderingMode(.original).font(.system(size: 50))
				} else {
					Image(systemName: "play").renderingMode(.original).font(.system(size: 50))
				}
			}
		}
		.environment(\.colorScheme, .dark)

        .onDisappear {
            Tool.showTabBar()
            self.timer.upstream.connect().cancel()
        }
        .onAppear() {
            Tool.hiddenTabBar()
            self.showTimeSeconds = self.countDownSeconds
        }
	}
	
	func timeString(second:Int) -> String {
		let mm = second / 60
		let ss = second % 60
		return String(format: "%02d:%02d", mm,ss)
	}
	
	func notify(){
		let content = UNMutableNotificationContent()
		content.title = "Message"
		content.body = "Timer Is Completed Successfully In Background !!!"
		
		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
		
		let req = UNNotificationRequest(identifier: "MSG", content: content, trigger: trigger)
		
		UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
	}
}

struct CircleImage_Previews: PreviewProvider {
	static var previews: some View {
		TomatoView(countDownSeconds: 25 * 60)
	}
}
