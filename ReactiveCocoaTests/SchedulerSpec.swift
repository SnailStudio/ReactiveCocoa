//
//  SchedulerSpec.swift
//  ReactiveCocoa
//
//  Created by Justin Spahr-Summers on 2014-07-13.
//  Copyright (c) 2014 GitHub. All rights reserved.
//

import Foundation
import Nimble
import Quick
import ReactiveCocoa

class SchedulerSpec: QuickSpec {
	override func spec() {
		describe("ImmediateScheduler") {
			it("should run enqueued actions immediately") {
				var didRun = false
				ImmediateScheduler().schedule {
					didRun = true
				}

				expect(didRun).to(beTruthy())
			}
		}

		describe("MainScheduler") {
			it("should run enqueued actions on the main thread") {
				var didRun = false
				MainScheduler().schedule {
					didRun = true
					expect(NSThread.isMainThread()).to(beTruthy())
				}

				expect(didRun).to(beFalsy())
				expect{didRun}.toEventually(beTruthy())
			}
		}

		describe("QueueScheduler") {
			it("should run enqueued actions on a global queue") {
				var didRun = false
				QueueScheduler().schedule {
					didRun = true
					expect(NSThread.isMainThread()).to(beFalsy())
				}

				expect{didRun}.toEventually(beTruthy())
			}

			it("should run enqueued actions serially on the given queue") {
				let queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT)
				dispatch_suspend(queue)

				let scheduler = QueueScheduler(queue)
				var value = 0

				for i in 0..<5 {
					scheduler.schedule {
						value = value + 1
					}
				}

				expect(value).to(equal(0))

				dispatch_resume(queue)
				expect{value}.toEventually(equal(5))
			}
		}

		describe("TestScheduler") {
		}
	}
}