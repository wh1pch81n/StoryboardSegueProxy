//
//  ViewController.swift
//  nsObjectSegue
//
//  Created by Derrick  Ho on 7/31/16.
//  Copyright © 2016 Derrick  Ho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet var segueToViewController: StoryboardSegueProxy!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func tapped(sender: AnyObject) {
//		segueToViewController.presentModally()
		segueToViewController.performSegue()
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		print("will segue to \(segue.destinationViewController)")
	}

}

class StoryboardSegueProxy: NSObject {
	@IBOutlet weak var presentingViewController: UIViewController!
	@IBInspectable var storyboardName: String = "Main"
	@IBInspectable var viewControllerStoryboardID: String = ""
	@IBInspectable var bundleIdentifier: String = ""
	@IBOutlet weak var button: UIButton! {
		willSet {
			newValue.addTarget(self, action: #selector(self.performSegue), forControlEvents: .TouchUpInside)
		}
	}
	@IBOutlet weak var navigationController: UINavigationController! {
		willSet {
			let bundle = bundleIdentifier.isEmpty ? NSBundle.mainBundle() : NSBundle(identifier: bundleIdentifier)!
			let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
			let vc = storyboard.instantiateViewControllerWithIdentifier(viewControllerStoryboardID)
			newValue.setViewControllers([vc], animated: false)
		}
	}
	
	func presentModally(sender: AnyObject? = nil) {
		let bundle = bundleIdentifier.isEmpty ? NSBundle.mainBundle() : NSBundle(identifier: bundleIdentifier)!
		let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
		let vc = storyboard.instantiateViewControllerWithIdentifier(viewControllerStoryboardID)
		presentingViewController.presentViewController(vc, animated: true, completion: nil)
	}
	
	func performSegue() {
		let bundle = bundleIdentifier.isEmpty ? NSBundle.mainBundle() : NSBundle(identifier: bundleIdentifier)!
		let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
		let vc = storyboard.instantiateViewControllerWithIdentifier(viewControllerStoryboardID)
		let s = UIStoryboardSegue(identifier: nil, source: presentingViewController, destination: vc)
		presentingViewController.prepareForSegue(s, sender: self)
		presentingViewController.showViewController(vc, sender: presentingViewController)
	}
}