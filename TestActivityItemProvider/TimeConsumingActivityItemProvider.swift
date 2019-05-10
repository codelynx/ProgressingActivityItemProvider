//
//	TimeConsumingActivityItemProvider.swift
//	TestActivityItemProvider
//
//	Created by Kaz Yoshikawa on 5/10/19.
//	Copyright © 2019 Kaz Yoshikawa. All rights reserved.
//

import UIKit
import PDFKit

class TimeConsumingActivityItemProvider: UIActivityItemProvider {
	
	let outputUrl: URL
	let hostViewController: UIViewController
	var progressViewController: ProgressViewController?
	
	init(filename: String, hostViewController: UIViewController) {
		self.outputUrl = FileManager.default.temporaryDirectory.appendingPathComponent(filename).appendingPathExtension("pdf")
		self.hostViewController = hostViewController
		super.init(placeholderItem: outputUrl)
	}
	
 	// called on secondary thread when user selects an activity. you must subclass and return a non-nil value. The item can use the UIActivityItemSource protocol to return extra information

 	override var item: Any {
 		assert(!Thread.isMainThread)
		assert(hostViewController.presentingViewController == nil)

		let progressViewController = UIStoryboard(name: "Progress", bundle: nil).instantiateInitialViewController() as! ProgressViewController
		self.progressViewController = progressViewController
		DispatchQueue.main.async {
			progressViewController.modalPresentationStyle = .fullScreen
			let viewController = self.hostViewController.presentedViewController!
			viewController.present(progressViewController, animated: true, completion: nil)
		}

		let document = PDFDocument()
		let numberOfPages = 30
		var pages = Set<PDFPage>()
		for pageIndex in 0..<numberOfPages {
			DispatchQueue.main.async {
				let progress = Float(pageIndex) / Float(numberOfPages)
				progressViewController.progress = progress
				print(String(format: "%d%%", Int(progress * 100)))
			}
			let page = TestPDFPage()
			document.insert(page, at: pageIndex)
			pages.insert(page)
			Thread.sleep(forTimeInterval: 1) // assume it takes some time
		}
		document.write(to: self.outputUrl)
 		return outputUrl
	}

}


class TestPDFPage: PDFPage {
	override func bounds(for box: PDFDisplayBox) -> CGRect {
		return CGRect(x: 0, y: 0, width: 1654, height: 2339)
	}
	lazy var paragraphStyle: NSParagraphStyle = {
		let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
		paragraphStyle.alignment = NSTextAlignment.center
		return paragraphStyle
	}()
	lazy var textAttributes: [NSAttributedString.Key: Any] = {
		return [
			NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40),
			NSAttributedString.Key.paragraphStyle: self.paragraphStyle
		]
	}()
	override func draw(with box: PDFDisplayBox, to context: CGContext) {
		UIGraphicsPushContext(context)
		let bounds = self.bounds(for: .cropBox)
		let center = CGPoint(x: bounds.midX, y: bounds.midY)
		let textSize = CGSize(width: 600, height: 50)
		let textFrame = CGRect(x: center.x - textSize.width/2, y: center.y - textSize.height/2, width: textSize.width, height: textSize.height)
		context.translateBy(x: 0, y: bounds.height)
		context.scaleBy(x: 1, y: -1)
		("This page, intentionally left blank." as NSString).draw(in: textFrame, withAttributes: self.textAttributes)
		UIGraphicsPopContext()
	}
}
