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
   
   
   @IBAction func loginDidTouch(_ sender: Any) {
      if textFieldLoginEmail.text == "" || textFieldLoginPassword.text == "" {
         let alertController = UIAlertController(title: "Oops!", message: "Please enter an email and password.", preferredStyle: .alert)
         let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
         alertController.addAction(defaultAction)
         self.present(alertController, animated: true, completion: nil)
      }
      else {
         userEmail = textFieldLoginEmail.text!
         userPassword = textFieldLoginPassword.text!
         FIRAuth.auth()?.signIn(withEmail: userEmail, password: userPassword, completion: { (user, error) in
            if error == nil {
               self.user = user
               self.performSegue(withIdentifier: "goToTutorialViewController", sender: nil)
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
      if textFieldLoginEmail.text == "" || textFieldLoginPassword.text == "" {
         let alertController = UIAlertController(title: "Oops!", message: "Please enter an email and password.", preferredStyle: .alert)
         let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
         alertController.addAction(defaultAction)
         self.present(alertController, animated: true, completion: nil)
      }
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
               
               self.performSegue(withIdentifier: "goToTutorialViewController", sender: nil)
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
   
   override func viewDidLoad() {
      super.viewDidLoad()
      FIRApp.configure()
      
      
       let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
       view.addGestureRecognizer(tap)
       
       //if there is a user logged in
       if (FIRAuth.auth()?.currentUser) != nil {
         self.user = FIRAuth.auth()?.currentUser
         self.performSegue(withIdentifier: "goToTutorialViewController", sender: nil)
       }
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool
   {
      self.view.endEditing(true)
      return false
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      /*
       if segue.identifier == "mapViewIdentifier" {
       if let vc = segue.destination as? MainMapViewController {
       vc.user = self.user!
       vc.userEmail = self.userEmail
       }
       }
       */
   }
   
}
