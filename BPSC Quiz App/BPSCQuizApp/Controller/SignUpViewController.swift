//
//  SignUpViewController.swift
//  BPSCQuizApp
//
//  Created by Arika Afrin Boshra on 16/3/20.
//  Copyright © 2020 Arika Afrin Boshra. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    
    @IBOutlet weak var userName: UITextField!
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var goSignIn: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissKey()
        
        // Do any additional setup after loading the view.
        tapActionToSignIn()
        
    }
    func tapActionToSignIn(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.tapFunction))
        goSignIn.isUserInteractionEnabled = true
        goSignIn.addGestureRecognizer(tap)
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func signUpButton(_ sender: Any) {
        let user = userName.text
        let firstName = firstNameTextField.text
        let lastName = lastNameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        let confirmPassword = confirmPasswordTextField.text
        signup()
        print(user ,firstName,lastName, email, password , confirmPassword)
    }
    
    
}

extension SignUpViewController{
    func signup(){
        
        guard let userName = userName.text else {
            print("username not found")
            return
        }
        guard let firstName = firstNameTextField.text else {
            print("firstname not found")
            return
        }
        guard let lastName = lastNameTextField.text else {
            print("lastname not found")
            return
        }
        guard let email = emailTextField.text else {
            print("email not found")
            return
        }
        guard let password = passwordTextField.text else {
            print("password not found")
            return
        }
        guard let confirmPassword = confirmPasswordTextField.text else {
            print("password not found")
            return
        }
        
        print(userName)
        print(email)
        print(password)
        print(confirmPassword)
        
        //    let json: [String: Any] = ["username": "\(userName)",
        //      "email": "\(email)","password": "\(password)",
        //     "password2": "\(confirmPassword)"]
        let apiUrl = "http://103.192.157.61:85/api/ApplicationUser/CreateUser"
        var param:[String:Any] = [:]
        param["userName"] = userName
        param["firstName"] = firstName
        param["lastName"] = lastName
        param["email"] = email
        param["password"] = password
        postDatawithNSDictionary(urlString:apiUrl,parameters:param,baseURL: "") { (jsonDict) in
            do {
                
                let responseModel = try JSONDecoder().decode(CreateUserBase.self, from: jsonDict)
                
                var title = String()
                var massage = String()
                
                if self.userName.text != nil && self.passwordTextField.text != nil && self.emailTextField.text != nil{
                    if responseModel.success == true{
                        
                        
                        let alert = UIAlertController(title: "valid login", message: "User created successfully. now you can login with your username and password ", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "SIGN IN NOW", style: .default, handler: {(_: UIAlertAction!) in
                            self.dismiss(animated: true, completion: nil)
                        }))
                        self.present(alert, animated: true)
                        
                        
                    }
                    else if responseModel.message == "User creation failed as this email has already taken.."{
                        
                        title = "Email wrong!"
                        massage = "Check your Email, This email is already taken "
                        
                        
                    } else if responseModel.message == "User creation failed as this username has already taken."{
                        
                        title = "Username wrong!"
                        massage = "Check your Username, This Username is already taken "
                        
                    }
                    else {
                        
                        title = "Something wrong!"
                        massage = "Check your Username, Password , all Field and internet connection also"
                    }
                    
                    let alert = UIAlertController(title: "\(title)", message: "\(massage)", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.present(alert, animated: true)
                    
                }
                
            }
            catch{
                
            }
            
        }
        
    }
}



