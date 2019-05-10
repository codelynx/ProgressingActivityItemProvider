//
//	ProgressViewController.swift
//	ProgressingActivityItemProvider
//
//	Created by Kaz Yoshikawa on 5/10/19.
//	Copyright © 2019 Kaz Yoshikawa. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {

	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var progressBar: UIProgressView!
	@IBOutlet weak var progressLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		assert(activityIndicator != nil)
		assert(progressBar != nil)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.activityIndicator.startAnimating()
	}

	var progress: Float = 0.0 {
		didSet {
			if self.isViewLoaded {
				self.progressBar.progress = self.progress
				self.progressLabel.text = String(format: "%d%%", Int(self.progress * 100))
			}
		}
	}

}

//		viewController.presentingViewController?.dismiss(animated: true, completion: nil)
