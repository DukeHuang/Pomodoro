//
//  AppDelegate.swift
//  Pomodoro
//
//  Created by yongyou on 2020/4/29.
//  Copyright © 2020 yongyou. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import BackgroundTasks

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		//	Register a launch handler for the task with the associated identifier
		//  that’s executed on the specified queue
		
		// 使用在指定队列上执行的关联标识符 为任务 注册启动处理程序
		// 使用 "com.sakuragi-Pomodoro.sample.refresh" 这个标识符 为 任务 task 注册启动处理程序
		// 这个标识符在指定的队列上执行
		
//		The system runs the block of code for the launch handler when it launches the app in the background. The block takes a single parameter, a BGTask object used for assigning an expiration handler and for setting a completion status. The block has no return value
		
		
		BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.sakuragi-Pomodoro.sample.refresh", using: nil) { task in
			self.handleAppRefresh(task: task)
		}
		return true
	}
	func handleAppRefresh(task:BGTask) -> Void {
		//Schedule a new refresh task
		scheduleAppRefresh()
		
		//Creates an operation that performs the main part of the background task
		// 创建一个操作，这个操作执行后台任务的主要部分
		let operation = RefreshAppContentsOperation()
		
		//Provide an expiration handler for the background task
		//that cancels the operation
		task.expirationHandler = {
			operation.cancel()
		}
		 
		//Inform the system that the background task is complete
		//When the operation completes
		operation.completionBlock = {
			task.setTaskCompleted(success: !operation.isCancelled)
		}
		
		//start the operation
		let operationQueue = OperationQueue()
		operationQueue.maxConcurrentOperationCount = 1
		operationQueue.addOperation(operation)
	}
	
	func RefreshAppContentsOperation() -> Operation {
		let operation = Operation()
		return operation
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
	
	func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		do {
			try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [.mixWithOthers, .allowAirPlay])
			print("Playback OK")
			try AVAudioSession.sharedInstance().setActive(true)
			print("Session is Active")
		} catch {
			print(error)
		}
		return true
	}
	
	func applicationDidEnterBackground(_ application: UIApplication) {
		self.scheduleAppRefresh()
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}

	// MARK: - Core Data stack

	lazy var persistentContainer: NSPersistentCloudKitContainer = {
	    /*
	     The persistent container for the application. This implementation
	     creates and returns a container, having loaded the store for the
	     application to it. This property is optional since there are legitimate
	     error conditions that could cause the creation of the store to fail.
	    */
	    let container = NSPersistentCloudKitContainer(name: "Pomodoro")
	    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
	        if let error = error as NSError? {
	            // Replace this implementation with code to handle the error appropriately.
	            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	             
	            /*
	             Typical reasons for an error here include:
	             * The parent directory does not exist, cannot be created, or disallows writing.
	             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
	             * The device is out of space.
	             * The store could not be migrated to the current model version.
	             Check the error message to determine what the actual problem was.
	             */
	            fatalError("Unresolved error \(error), \(error.userInfo)")
	        }
	    })
	    return container
	}()

	// MARK: - Core Data Saving support

	func saveContext () {
	    let context = persistentContainer.viewContext
	    if context.hasChanges {
	        do {
	            try context.save()
	        } catch {
	            // Replace this implementation with code to handle the error appropriately.
	            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	            let nserror = error as NSError
	            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
	        }
	    }
	}

}

