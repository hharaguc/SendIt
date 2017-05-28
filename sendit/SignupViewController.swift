//
//  SignupViewController.swift
//  sendit
//
//  Created by Rohit Sharma on 5/27/17.
//  Copyright © 2017 Holly Haraguchi. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var bdayField: UITextField!
    
    var inputDict: [String: String] = [:]
    var ref = FIRDatabase.database().reference(withPath: "sendit/users")
    var user: FIRUser?
    
    @IBAction func signUp(_ sender: Any) {
        
        if emailField.text! == "" || passwordField.text! == "" || firstNameField.text! == "" || lastNameField.text! == "" || genderField.text! == "" || bdayField.text! == ""
        {
            let alertController = UIAlertController(title: "Oops!", message: "Please fill in all text fields.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            //let newUser = ref.child(firstNameField.text! + lastNameField.text!)
            let newUser = ref.child(self.user!.uid)
            inputDict["First Name"] = firstNameField.text!
            inputDict["Last Name"] = lastNameField.text!
            inputDict["Gender"] = genderField.text!
            inputDict["Birthday"] = bdayField.text!
            inputDict["Attending"] = "[]"
            inputDict["Attended"] = "[]"
            newUser.setValue(inputDict)
            
            FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
                
                if error == nil
                {
                    self.emailField.text = ""
                    self.passwordField.text = ""
                    self.firstNameField.text = ""
                    self.lastNameField.text = ""
                    self.genderField.text = ""
                    self.bdayField.text = ""
                    self.user = user

                    let alertController = UIAlertController(title: "Congrats!", message: "You have successfully created your account!", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                        (_)in
                        self.performSegue(withIdentifier: "goToNextViewFromSignup", sender: nil)
                    })
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
      
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
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        if (FIRAuth.auth()?.currentUser) != nil {
            print("in login view controller")
            self.user = FIRAuth.auth()?.currentUser
            self.performSegue(withIdentifier: "goToNextViewFromSignup", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
