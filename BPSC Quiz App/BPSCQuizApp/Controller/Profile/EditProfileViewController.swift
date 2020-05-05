//
//  EditProfileViewController.swift
//  BPSCQuizApp
//
//  Created by Arika Afrin Boshra on 23/3/20.
//  Copyright © 2020 Arika Afrin Boshra. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var colorderBgView: UIView!
    
    @IBOutlet weak var pwClorderBgView: UIView!
    
    @IBOutlet weak var profileImage: RoundFrameImageView!
    
    var userName = String()
    var firstname = String()
    var lastName = String()
    var email = String()
    var address = String()
    var phone = String()
    var imageString = String()
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var adddressLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emaiTextFiels: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var currentPasswordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    var addesstext = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        colorderBgView.layer.cornerRadius = 20
        pwClorderBgView.layer.cornerRadius = 20
        
        print(userName)
        
        userNameLabel.text = "\(firstname) \(lastName)"
        adddressLabel.text = "\(address)"
        
        usernameTextField.text = "\(userName)"
        firstNameTextField.text = "\(firstname)"
        lastNameTextField.text = "\(lastName)"
        emaiTextFiels.text = "\(email)"
        phoneTextField.text = "\(phone)"
        getProfileImage()
         navigationController?.setNavigationBarHidden(false, animated: true)
        
        
        
    }
  
    @IBAction func dismisButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func editAddressButton(_ sender: Any) {
        //        let alert = UIAlertController(title: "valid login", message: "User created successfully. now you can login with your username and password ", preferredStyle: .alert)
        //
        //        alert.addAction(UIAlertAction(title: "Cancle", style: .default, handler: nil))
        //        alert.addAction(UIAlertAction(title: "Change", style: .default, handler: {(_: UIAlertAction!) in
        //            self.dismiss(animated: true, completion: nil)
        //        }))
        //
        //
        //        self.present(alert, animated: true)
        //
        
        
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            let answer = ac.textFields![0]
            // do something interesting with "answer" here
            self.addesstext = answer.text ?? ""
        
            
        }
        
        ac.addAction(submitAction)
        
        present(ac, animated: true)
        
        
        
        
    }
    
    @IBAction func updateProfile(_ sender: Any) {
        
        updateProfile()
    }
    
    @IBAction func updatePassword(_ sender: Any) {
        updatePassword()
        
    }
    
  
    
}
extension EditProfileViewController{
    func updateProfile() {
        let apiUrl = "http://103.192.157.61:85/api/ApplicationUser/UpdateUser"
        print(apiUrl)
        var param:[String:Any] = [:]
        param["firstName"] = firstNameTextField.text
        param["lastName"] = lastNameTextField.text
        param["address"] = addesstext
        param["phoneNumber"] = phoneTextField.text
        
        print(param)
        postDatawithNSDictionarywithToken(urlString:apiUrl,parameters:param,baseURL: "") { (jsonDict) in
            do {
                print(Data.self)
                
                //    let responseModel = try JSONDecoder().decode(UpdateUserBase.self, from: jsonDict )
                
                //  print(responseModel)
                
                self.viewDidLoad()
                
                
            }
            catch{
                
            }
            
        }
    }
    
    func updatePassword() {
        let apiUrl = "http://103.192.157.61:85/api/ApplicationUser/UpdatePassword"
        var param:[String:Any] = [:]
        param["currentPassword"] = currentPasswordTextField.text
        param["newPassword"] = confirmPasswordTextField.text
        
        print(param)
        postDatawithNSDictionarywithToken(urlString:apiUrl,parameters:param,baseURL: "") { (jsonDict) in
            do {
                print(Data.self)
                
                //    let responseModel = try JSONDecoder().decode(UpdateUserBase.self, from: jsonDict )
                
                //  print(responseModel)
                
            
                
                self.viewDidLoad()
                
                
            }
            catch{
                
            }
            
        }
    }

    func getProfileImage() {
        
        let imageUrl = URL(string: imageString)
        
        if imageUrl != nil {
            UIImage.getImage(url: imageUrl!) { (profileImg) in
                
                self.profileImage.image = profileImg
            }
        }
    }
    
}
