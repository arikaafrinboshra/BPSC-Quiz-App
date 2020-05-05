//
//  SecondViewController.swift
//  BPSCQuizApp
//
//  Created by Arika Afrin Boshra on 27/2/20.
//  Copyright © 2020 Arika Afrin Boshra. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    let baseURL = "http://103.192.157.61:85/api/"
    var objectpayload = [AllQuiz]()
    
    @IBOutlet weak var quizListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDictionaryData()
        
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        quizListTableView.reloadData()
        
    }
    
    
}

extension SecondViewController : UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectpayload.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath) as! QuizTableViewCell
        //cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.qView.layer.cornerRadius = 8
        
        //cell.questionArchiveLabel.text = objectpayload[indexPath.row].examName ?? ""
        cell.quizTitle.text = objectpayload[indexPath.row].title
        cell.layer.borderWidth = 0
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
        navigationController?.pushViewController(vc, animated: true)
        vc.quizId = objectpayload[indexPath.row].id ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 8
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0,width: tableView.bounds.size.width, height: 8))
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
}

extension SecondViewController{
    
    func getDictionaryData() {
        let apiUrl = "\(baseURL)Quiz/GetAllQuizListByUserId"
        print(apiUrl)
        fetchDatawithNSDictionary(apitype: "GET", urlString: apiUrl, baseURL: "") { (jsonDict) in
            
            do {
                
                let responseModel = try JSONDecoder().decode(QuizBase.self, from: jsonDict)
                
                let temp:Int = responseModel.payload?.count ?? 0
                
                if(temp>0) {
                    
                    for response in responseModel.payload!{
                        
                        self.objectpayload.append(response)
                    }
                }
                
                self.quizListTableView.reloadData()
                
            }
            catch{
                
            }
            
        }
    }
}
