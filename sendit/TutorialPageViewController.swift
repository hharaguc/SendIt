//
//  TutorialPageViewController.swift
//  sendit
//
//  Created by John T. Jackson on 4/5/17.
//  Copyright © 2017 Holly Haraguchi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI

class TutorialPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
   
   var user: FIRUser?
   
   static var firAppConf = true
   
   //create an array of all the view controllers
   lazy var VCArr: [UIViewController] = {
      return [self.VCInstance(name: "first"),
              self.VCInstance(name: "third"),
              self.VCInstance(name: "fourth"),
              self.VCInstance(name: "fifth"),
              self.VCInstance(name: "sixth")]
   }()
   
   //helper function to create instance of each view controller
   private func VCInstance(name: String) -> UIViewController {
      return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
   }
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      self.dataSource = self
      self.delegate = self
      
      //initialize first view controller
      if let firstVC = VCArr.first {
         setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
      }
   }
  
   //configure firebase and go to next view if user logged in already
   override func viewWillAppear(_ animated: Bool){
      if (TutorialPageViewController.firAppConf == true) {
         FIRApp.configure()
         TutorialPageViewController.firAppConf = false
      }
      
      //if there is a user already logged in skip tutorial and go to login view
      //will have to change later to go to the next view controller after the login screeen
      if (FIRAuth.auth()?.currentUser) != nil {
         self.user = FIRAuth.auth()?.currentUser
         self.performSegue(withIdentifier: "goToNextViewController", sender: nil)
      }
   }
   
   //what vc to display on a swipe right
   public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
      guard let viewControllerIndex = VCArr.index(of: viewController) else {
         return nil
      }
      
      let nextIndex = viewControllerIndex + 1
      
      guard nextIndex < VCArr.count else {
         return VCArr.first
      }
      
      guard VCArr.count > nextIndex else {
         return nil
      }
      
      return VCArr[nextIndex]
      
   }
   
   //what vc to display on a swipe left
   public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
      guard let viewControllerIndex = VCArr.index(of: viewController) else {
         return nil
      }
      
      let previousIndex = viewControllerIndex - 1
      
      guard previousIndex >= 0 else {
         return VCArr.last
      }
      
      guard VCArr.count > previousIndex else {
         return nil
      }
      
      return VCArr[previousIndex]
      
   }
   
   //configure subviews
   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      for view in self.view.subviews {
         if view is UIScrollView {
            view.frame = UIScreen.main.bounds
         } else if view is UIPageControl {
            view.backgroundColor = UIColor.clear
         }
      }
   }
   
   //configure dots at the bottom of the screen
   public func presentationCount(for pageViewController: UIPageViewController) -> Int {
      return VCArr.count
   }
   
   //configures highlighted dot at bottom of the screen
   public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
      guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = VCArr.index(of: firstViewController) else {
         return 0
      }
      return firstViewControllerIndex
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   //give the next view controller the current user if there is one
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "goToNextViewController" {
         if let vc = segue.destination as? NextViewController {
            vc.user = self.user!
         }
      }
   }
   
}
