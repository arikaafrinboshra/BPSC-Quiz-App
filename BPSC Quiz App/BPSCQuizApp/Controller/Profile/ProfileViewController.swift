//
//  ProfileViewController.swift
//  BPSCQuizApp
//
//  Created by Arika Afrin Boshra on 4/3/20.
//  Copyright © 2020 Arika Afrin Boshra. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let baseURL = "http://103.192.157.61:85/api/"
    let defaults = UserDefaults.standard
    
    var objectpayload = [AllQuiz]()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    var getImageString: String = String()
    
    var pickedProfileImage: UIImage? = nil
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var tableView: UITableView!
    
    let Progress = [0.20 , 0.50 , 0.80]
    let qid = [1,4,8]
    var number = Int()
    var comment = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getProfileData()
        getDictionaryDataforQuiz()
        tableView.delegate = self
        tableView.dataSource = self
        
        getProfileImageForProfile()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        getProfileData()
        getDictionaryDataforQuiz()
        getProfileImageForProfile()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        getProfileData()
        getDictionaryDataforQuiz()
        getProfileImageForProfile()
    }
    
    
    @IBAction func logOutButton(_ sender: UIButton) {
        
        
        self.dismiss(animated: false, completion: nil)
        
        TokenUrl.shared.token = String()
        TokenUrl.shared.username = String()
        TokenUrl.shared.password = String()
        
        defaults.removeObject(forKey: "saveUsername")
        defaults.removeObject(forKey: "savePassword")
        defaults.removeObject(forKey: "saveToken")
        defaults.removeObject(forKey: "refreshToken")
        defaults.set(false, forKey: "First Launch")

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "Signin")
        self.navigationController?.pushViewController(vc, animated: false)
        
        print("Logged Out")
    }
    
    
    @IBAction func whatsAppButton(_ sender: Any) {
        
        let phoneNumber =  "+8801780290571"
        
        let appURL = URL(string: "https://wa.me/\(phoneNumber)")!
        if UIApplication.shared.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(appURL)
            }
        }
        
    }
    @IBAction func messageButton(_ sender: Any) {
        UIApplication.shared.open(URL(string: "sms:")!, options: [:], completionHandler: nil)
        
    }
    
    @IBAction func editProfile(_ sender: Any) {
        
        
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "editProfileViewController") as! EditProfileViewController
        vc.address = address
        vc.userName = username
        vc.firstname = first
        vc.lastName = last
        vc.email = email
        vc.phone = phone
        vc.imageString = getImageString
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        //  performSegue(withIdentifier: "editProfile", sender: nil)
    }
    
    var username = String()
    var address = String()
    var first = String()
    var last = String()
    var email = String()
    var phone = String()
    
    
    @IBAction func imageUploadButton(_ sender: UIButton) {
        //###############################################
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                alert.popoverPresentationController?.sourceView = sender
                alert.popoverPresentationController?.sourceRect = sender.bounds
                alert.popoverPresentationController?.permittedArrowDirections = .up
            default:
                break
        }
        
        self.present(alert, animated: true, completion: nil)
        
        
        //###############################################
        
    }
    
    func openGallary() {
        
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    func postProfileImageToTheServer() {
        
        uploadImage(paramName: "", fileName: "profileImage", image: (pickedProfileImage ?? UIImage(named: "camera-2"))!)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            
            self.profileImage.image = editedImage
            pickedProfileImage = editedImage
            
            profileImage.layer.cornerRadius = profileImage.frame.height/2
            profileImage.clipsToBounds = true
            
        }
        
        picker.dismiss(animated: true, completion: postProfileImageToTheServer)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
extension ProfileViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return objectpayload.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileTableViewCell
        cell.quizName.text = objectpayload[indexPath.row].title
        cell.progressLabel.progress = Float(Double(objectpayload[indexPath.row].obtainedMark ?? 0))
        print(Float(Double(objectpayload[indexPath.row].obtainedMark ?? 0)))
        // print(Float(Double(Progress[indexPath.row])))
        let mark : Int = objectpayload[indexPath.row].obtainedMark ?? 0
        
        cell.markInPercentage.text = "\(mark) %"
        cell.markComment.text = objectpayload[indexPath.row].comment ?? "Not Given"
        cell.layer.borderWidth = 0
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
        
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    
}

extension ProfileViewController {
    
    func getProfileData() {
        let apiUrl = "http://103.192.157.61:85/api/ApplicationUser/GetUserProfileByUserId"
        
        fetchDatawithNSDictionary(apitype: "GET", urlString: apiUrl, baseURL: "") { (jsonDict) in
            
            do {
                
                
                let responseModel = try JSONDecoder().decode(CreateUserBase.self, from: jsonDict)
                
                
                //let temp:Int = responseModel.payload?.count ?? 0
                self.nameLabel.text = "\(responseModel.payload?.firstName ?? "") \((responseModel.payload?.lastName) ?? "")"
                self.addressLabel.text = responseModel.payload?.address
                
                
                self.address = responseModel.payload?.address ?? ""
                self.username = responseModel.payload?.userName ?? ""
                self.first = responseModel.payload?.firstName ?? ""
                self.last = responseModel.payload?.lastName ?? ""
                self.email = responseModel.payload?.email ?? ""
                self.phone = responseModel.payload?.phoneNumber ?? ""
                self.getImageString = responseModel.payload?.profilePicture ?? ""
                
            }
            catch {
                
            }
            
        }
        
    }
    
}

extension ProfileViewController{
    func getDictionaryDataforQuiz() {
        let apiUrl = "\(baseURL)Quiz/GetAllQuizListByUserId"
        //print(apiUrl)
        fetchDatawithNSDictionary(apitype: "GET", urlString: apiUrl, baseURL: "") { (jsonDict) in
            
            do {
                
                
                let responseModel = try JSONDecoder().decode(QuizBase.self, from: jsonDict)
                
                let temp:Int = responseModel.payload?.count ?? 0
                
                for response in 0...temp - 1 {
                    
                    if responseModel.payload?[response].hasParticipatedInQuiz == true {
                        for response in responseModel.payload!{
                            
                            self.objectpayload.append(response)
                            print(self.objectpayload)
                            
                        }
                    }
                }
                
                
                self.tableView.reloadData()
                
            }
            catch{
                
            }
        }
    }
    
    
    func getProfileImageForProfile() {
        
        let imageUrl = URL(string: getImageString)
        
        if imageUrl != nil {
            UIImage.getImage(url: imageUrl!) { (profileImg) in
                
                self.profileImage.image = profileImg
            }
        }
    }
}
