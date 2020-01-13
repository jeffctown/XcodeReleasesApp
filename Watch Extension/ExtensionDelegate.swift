//
//  ExtensionDelegate.swift
//  Watch Extension
//
//  Created by Jeff Lett on 1/11/20.
//  Copyright © 2020 Jeff Lett. All rights reserved.
//

import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    
    var appState = AppState()

    func applicationDidFinishLaunching() {
        appState.userNotifications.applicationDidFinishLaunching()
    }
    
    func applicationDidBecomeActive() {
        let complicationServer = CLKComplicationServer.sharedInstance()
        for complication in complicationServer.activeComplications ?? [] {
            complicationServer.reloadTimeline(for: complication)
        }
        appState.userNotifications.applicationDidBecomeActive()
        appState.releasesService.refresh()
    }
    
    func didRegisterForRemoteNotifications(withDeviceToken deviceToken: Data) {
        appState.userNotifications.application(didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }

    func didFailToRegisterForRemoteNotificationsWithError(_ error: Error) {
        appState.userNotifications.didFailToRegisterForRemoteNotificationsWithError(error)
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                backgroundTask.setTaskCompletedWithSnapshot(false)
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompletedWithSnapshot(false)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            case let relevantShortcutTask as WKRelevantShortcutRefreshBackgroundTask:
                // Be sure to complete the relevant-shortcut task once you're done.
                relevantShortcutTask.setTaskCompletedWithSnapshot(false)
            case let intentDidRunTask as WKIntentDidRunRefreshBackgroundTask:
                // Be sure to complete the intent-did-run task once you're done.
                intentDidRunTask.setTaskCompletedWithSnapshot(false)
            default:
                // make sure to complete unhandled task types
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }

}