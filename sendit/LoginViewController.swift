//
//  LoginViewController.swift
//  circme
//
//  Created by John T. Jackson on 2/21/17.
//  Copyright © 2017 Rohit Sharma. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI

class LoginViewController: UIViewController, UITextFieldDelegate {
   
   
   var userEmail = ""
   var userPassword = ""
   var user: FIRUser?
   
   @IBOutlet weak var textFieldLoginEmail: UITextField!
   @IBOutlet weak var textFieldLoginPassword: UITextField!
   
   //action for login button
   @IBAction func loginDidTouch(_ sender: Any) {
      //check if the user has input anything into the email and password space and give proper pop up if not
      if textFieldLoginEmail.text == "" || textFieldLoginPassword.text == "" {
         let alertController = UIAlertController(title: "Oops!", message: "Please enter an email and password.", preferredStyle: .alert)
         let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
         alertController.addAction(defaultAction)
         self.present(alertController, animated: true, completion: nil)
      }
         
         //verify email and password and notify user if there is an error
      else {
         userEmail = textFieldLoginEmail.text!
         userPassword = textFieldLoginPassword.text!
         FIRAuth.auth()?.signIn(withEmail: userEmail, password: userPassword, completion: { (user, error) in
            if error == nil {
               self.user = user
               self.performSegue(withIdentifier: "goToNextView", sender: nil)
            }
            else {
               let alertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .alert)
               let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
               alertController.addAction(defaultAction)
               self.present(alertController, animated: true, completion: nil)
            }
         })
      }
   }
   
   @IBAction func signUpDidTouch(_ sender: Any) {
      //check if the user has input anything into the email and password space and give proper pop up if not
      if textFieldLoginEmail.text == "" || textFieldLoginPassword.text == "" {
         let alertController = UIAlertController(title: "Oops!", message: "Please enter an email and password.", preferredStyle: .alert)
         let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
         alertController.addAction(defaultAction)
         self.present(alertController, animated: true, completion: nil)
      }
         
         //verify email and password and notify user if there is an error
      else {
         userEmail = textFieldLoginEmail.text!
         userPassword = textFieldLoginPassword.text!
         
         FIRAuth.auth()?.createUser(withEmail: userEmail, password: userPassword, completion: { (user, error) in
            
            if error == nil {
               self.textFieldLoginEmail.text = ""
               self.textFieldLoginPassword.text = ""
               self.user = user
               let alertController = UIAlertController(title: "Congrats!", message: "You have successfully an account with the email address: \(self.textFieldLoginEmail.text)", preferredStyle: .alert)
               let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
               alertController.addAction(defaultAction)
               self.present(alertController, animated: true, completion: nil)
               
               self.performSegue(withIdentifier: "goToNextView", sender: nil)
            }
            else {
               let alertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .alert)
               let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
               alertController.addAction(defaultAction)
               self.present(alertController, animated: true, completion: nil)
               
            }
         })
      }
      
   }
   
   //Calls this function when the tap is recognized.
   func dismissKeyboard() {
      //Causes the view (or one of its embedded text fields) to resign the first responder status.
      view.endEditing(true)
   }
   
   //call upon loading the view
   override func viewDidLoad() {
      super.viewDidLoad()
      
      //configure keyboard dismissal
      let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
      view.addGestureRecognizer(tap)
      
      //if there is a user logged in go to next view
      if (FIRAuth.auth()?.currentUser) != nil {
         print("in login view controller")
         self.user = FIRAuth.auth()?.currentUser
         self.performSegue(withIdentifier: "goToNextView", sender: nil)
      }
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   //dismiss keyboard helper function
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      self.view.endEditing(true)
      return false
   }
   
   //pass user over to the next view
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "goToNextViewController" {
         if let vc = segue.destination as? NextViewController {
            vc.user = self.user!
         }
      }
   }
   
}
