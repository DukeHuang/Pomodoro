//
//  SceneDelegate.swift
//  Pomodoro
//
//  Created by yongyou on 2020/4/29.
//  Copyright © 2020 yongyou. All rights reserved.
//

import UIKit
import SwiftUI
import BackgroundTasks

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	var count = 0
	var timer: Timer?
	var bgTask: UIBackgroundTaskIdentifier?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		// Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
		// If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
		// This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
		
		// Get the managed object context from the shared persistent container.
		let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

		// Create the SwiftUI view and set the context as the value for the managedObjectContext environment keyPath.
		// Add `@Environment(\.managedObjectContext)` in the views that will need the context.
		let contentView = ContentView().environment(\.managedObjectContext, context)

		// Use a UIHostingController as window root view controller.
		if let windowScene = scene as? UIWindowScene {
		    let window = UIWindow(windowScene: windowScene)
		    window.rootViewController = UIHostingController(rootView: contentView)
		    self.window = window
		    window.makeKeyAndVisible()
		}
	}

	func sceneDidDisconnect(_ scene: UIScene) {
		// Called as the scene is being released by the system.
		// This occurs shortly after the scene enters the background, or when its session is discarded.
		// Release any resources associated with this scene that can be re-created the next time the scene connects.
		// The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
	}

	func sceneDidBecomeActive(_ scene: UIScene) {
		// Called when the scene has moved from an inactive state to an active state.
		// Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
	}

	func sceneWillResignActive(_ scene: UIScene) {
		// Called when the scene will move from an active state to an inactive state.
		// This may occur due to temporary interruptions (ex. an incoming phone call).
	}

	func sceneWillEnterForeground(_ scene: UIScene) {
		// Called as the scene transitions from the background to the foreground.
		// Use this method to undo the changes made on entering the background.
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
		// Called as the scene transitions from the foreground to the background.
		// Use this method to save data, release shared resources, and store enough scene-specific state information
		// to restore the scene back to its current state.
		
//		timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
//		RunLoop.current.add(timer!, forMode: .common)
		
//		do not call this method at the end of your applicationDidEnterBackground(_:) method and expect your app to continue running
		
//		let application = UIApplication.shared
//		bgTask = application.beginBackgroundTask(expirationHandler: {
//			application.endBackgroundTask(self.bgTask!)
//			self.bgTask = .invalid
//			print("end task")
//		})
//		ProcessInfo.processInfo.performExpiringActivity(withReason: "Time") { suspended in
//			if suspended {
//
//			} else {
//
//			}
//		}
		self.scheduleAppRefresh()
		// Save changes in the application's managed object context when the application transitions to the background.
		(UIApplication.shared.delegate as? AppDelegate)?.saveContext()
	}
	
	
	func scheduleAppRefresh() {
		let request = BGAppRefreshTaskRequest(identifier: "com.sakuragi-Pomodoro.sample.refresh")
		request.earliestBeginDate = Date(timeIntervalSinceNow: 1)
		
		//		Submitting a task request for an unexecuted task that’s already in the queue replaces the previous task request.
		//		There can be a total of 1 refresh task and 10 processing tasks scheduled at any time. Trying to schedule more tasks returns BGTaskScheduler.Error.Code.tooManyPendingTaskRequests.
		
		do {
			try BGTaskScheduler.shared.submit(request)
		} catch {
			print("Could not schedule app refresh: \(error)")
		}
	}
	
	@objc func timerAction() {
		count = count + 1
		print("===================> \(count)")
		
		let str = String(format: "%.f",(UIApplication.shared.backgroundTimeRemaining))
		
		print("backgroundTimeRemaining===================> \(str)")
		if UIApplication.shared.backgroundTimeRemaining < 60.0 {
			print("+++++++++++++++++")
			let application = UIApplication.shared
			bgTask = application.beginBackgroundTask(expirationHandler: nil)
			
		}
	}


}

