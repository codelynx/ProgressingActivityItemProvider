//
//	ViewController.swift
//	ProgressingActivityItemProvider
//
//	Created by Kaz Yoshikawa on 5/10/19.
//	Copyright © 2019 Kaz Yoshikawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	@IBAction func activityAction(_ sender: Any) {
		let test1 = ProgressingActivityItemProvider(filename: "sample1", hostViewController: self)
		
		let activityItems: [Any] = [test1]
		let activities: [UIActivity] = []
		let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: activities)
		self.present(activityController, animated: true, completion: nil)
	}


}

