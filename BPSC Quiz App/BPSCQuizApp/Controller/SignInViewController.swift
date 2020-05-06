//
//  SignInViewController.swift
//  BPSCQuizApp
//
//  Created by Arika Afrin Boshra on 8/3/20.
//  Copyright © 2020 Arika Afrin Boshra. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    let tokenSave = UserDefaults.standard
    let refreshTokenSave = UserDefaults.standard
    let usernameSave = UserDefaults.standard
    let passwordSave = UserDefaults.standard

    var email = String()
    
    let baseURL = "http://103.192.157.61:85/api/"
    
    @IBOutlet weak var usenameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var goSignup: UILabel!
    
    var loginobj = [LoginBase]()
    var token: String = String()
    var refreshToken: String = String()
    
    override func viewDidLoad() {
        dismissKey()
        super.viewDidLoad()
        usenameTextField.becomeFirstResponder()
        navigationController?.isNavigationBarHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.tapFunction))
        goSignup.isUserInteractionEnabled = true
        goSignup.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        
        performSegue(withIdentifier: "signintosignup", sender: self)
        print("tap working")
    }
    
    @IBAction func forgetPassword(_ sender: Any) {
        let ac = UIAlertController(title: "Enter Your Email ", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            let answer = ac.textFields![0]
            // do something interesting with "answer" here
            self.email = answer.text ?? ""
            self.forgetPass()
            
        }
        
        ac.addAction(submitAction)
        
        present(ac, animated: true)
        
        
    }
    
    
    
    @IBAction func signInButton(_ sender: Any) {
        
        getpostDictionaryData()
        
    }
    
    
    
}
extension SignInViewController{
    
    func getpostDictionaryData() {
        let user = usenameTextField.text
        let pass = passwordTextField.text
        
        let apiUrl = "\(baseURL)Authenticate/login"
        var param:[String:Any] = [:]
        param["username"] = user
        param["password"] = pass
        
        
        postDatawithNSDictionary(urlString:apiUrl,parameters:param,baseURL: "") { (jsonDict) in
            do {
                
                
                let responseModel = try JSONDecoder().decode(LoginBase.self, from: jsonDict)
                
                if self.usenameTextField.text != "" && self.passwordTextField.text != ""{
                    
                    print(responseModel)
                    
                    if responseModel.failedResponse?.error == nil && responseModel.successResonse?.token != nil {
                        print("this is valid login")
                        
                        self.defaults.set(true, forKey: "First Launch")
                        
                        self.tokenSave.set(responseModel.successResonse?.token, forKey: "saveToken")
                        self.usernameSave.set(user, forKey: "saveUsername")
                        self.passwordSave.set(pass, forKey: "savePassword")
                        self.refreshTokenSave.set(responseModel.successResonse?.refreshToken, forKey: "refreshToken")
                        
                        //self.token = self.defaults.string(forKey: "saveToken")!
                        
                        TokenUrl.shared.token = self.defaults.string(forKey: "saveToken")!
                        
                        TokenUrl.shared.refreshToken = self.defaults.string(forKey: "refreshToken")!
                        
                        print(self.token)
                        
                        let vc = self.storyboard?.instantiateViewController(identifier: "TabController") as? TabController
                        self.navigationController?.pushViewController(vc!, animated: true)
                        
                    } else if responseModel.failedResponse?.error != nil {
                        print(responseModel)
                        let alert = UIAlertController(title: "Something wrong!", message: "Check your Username and Password internet connection also", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
                        self.present(alert, animated: true)
                    }
                }
                    
                else {
                    let alert = UIAlertController(title: "Something wrong!", message: "You cant signUp with an empty field ", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.present(alert, animated: true)
                    
                    print("You cant signUp with an empty field ")
                }
            }
            catch{
                
            }
            
        }
    }
}
extension SignInViewController{
    func forgetPass() {
        let apiUrl = "http://103.192.157.61:85/api//api/Authenticate/ForgetPassword"
        print(apiUrl)
        var param:[String:Any] = [:]
        param["email"] = email
        
        print(param)
        postDatawithNSDictionary(urlString:apiUrl,parameters:param,baseURL: "") { (jsonDict) in
            do {
                
                
                
            }
            catch{
                print(error)
            }
            
        }
    }
}

extension UIViewController {
    func dismissKey()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
