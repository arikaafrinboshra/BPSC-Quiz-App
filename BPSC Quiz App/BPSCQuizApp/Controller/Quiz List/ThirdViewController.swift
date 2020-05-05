//
//  ThirdViewController.swift
//  BPSCQuizApp
//  Created by Arika Afrin Boshra on 27/2/20.
//  Copyright © 2020 Arika Afrin Boshra. All rights reserved.
//

import UIKit

var quizQuestionBankId: [Int]? = [Int]()

class ThirdViewController: UIViewController {
    
    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    
    var obtainedMarks: Double = Double()
    var percentage: Double = Double()
    var totalMarks: Int = Int()
    
    var quizId: Int? = nil
    var numberOfQuizzes: Int? = nil
    
    
    var questionBanks = [QuizQuestionBanks]()
    var confirmed = Confirmed()
    
    
    
    @IBOutlet weak var submitView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var totalMarkLabel: UILabel!
    @IBOutlet weak var markObtainLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        
        submitView.isHidden = true
        centerView.layer.cornerRadius = 20
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        if (quizId != 0 && quizId != nil) {
            getQuizDetailsByQuizId(quizId: self.quizId!)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        selectedStates.selectedRowsForButton1.removeAll()
        selectedStates.selectedRowsForButton2.removeAll()
        selectedStates.selectedRowsForButton3.removeAll()
        selectedStates.selectedRowsForButton4.removeAll()
        
    }
    var allQuiz : Quiz?
    var quiz = [QuizQuestionBank]()
    
    @IBAction func submitButton(_ sender: UIButton) {
        let count: Int = confirmed.confirmedAnswer.count
        
        
        
        if confirmed.confirmedAnswer.count > 0 {
            quiz.removeAll()
            
            
            for answer in 0...count - 1 {
                
                let q = QuizQuestionBank(quizQuestionBankId:confirmed.confirmedQuizQuestionBankId[answer], question: "", option1: "", option2: "", option3: "", option4: "", answer: confirmed.confirmedAnswer[answer], explanation: "")
                quiz.append(q)
                
            }
            
            allQuiz = Quiz(quizId: self.quizId!, quizQuestionBanks: quiz)
            
        }
        
        submitResult()
        
        submitView.isHidden = false
        animationResult()
        
    }
    
    @IBAction func okButton(_ sender: UIButton) {
        
        tableView.reloadData()
        submitView.isHidden = true
        shapeLayer.isHidden = true
        trackLayer.isHidden = true
        
        totalMarks = 0
        obtainedMarks = 0
        percentage = 0
        quizQuestionBankId?.removeAll()
        confirmed.confirmedQuizQuestionBankId.removeAll()
    }
    
    
    
    
    @objc private func animationResult() {
        
        let center = view.center
        
        // create my track layer
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 80, startAngle: -CGFloat.pi , endAngle:  CGFloat.pi, clockwise: true)
        trackLayer.path = circularPath.cgPath
        
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        view.layer.addSublayer(trackLayer)
        
        
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        shapeLayer.strokeEnd = 0
        
        view.layer.addSublayer(shapeLayer)
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = obtainedMarks
        
        basicAnimation.duration = 2
        
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    
    
    
}
extension ThirdViewController : UITableViewDataSource,UITableViewDelegate, SelectedOptionDelegate {
    
    
    func selectedOption(option: String, quizQBID: Int) {
        
        confirmed.confirmedQuizQuestionBankId.append(quizQBID)
        confirmed.confirmedAnswer.append(option)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return numberOfQuizzes ?? 0
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: detailsQuizTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! detailsQuizTableViewCell
        
        DispatchQueue.main.async {
            
            cell.qsnLabel.text = self.questionBanks[indexPath.row].question
            
            cell.op1.setTitle(self.questionBanks[indexPath.row].option1, for: .normal)
            
            cell.op2.setTitle(self.questionBanks[indexPath.row].option2, for: .normal)
            
            cell.op3.setTitle(self.questionBanks[indexPath.row].option3, for: .normal)
            
            cell.op4.setTitle(self.questionBanks[indexPath.row].option4, for: .normal)
            
            
            if selectedStates.selectedRowsForButton1.contains(indexPath.row) {
                
                
                cell.op1.setTitleColor(.red, for: .normal)
                cell.userInteraction(isEnabled: false)
                
            }
            if selectedStates.selectedRowsForButton2.contains(indexPath.row) {
                
                
                cell.op2.setTitleColor(.red, for: .normal)
                cell.userInteraction(isEnabled: false)
                
            }
            
            if selectedStates.selectedRowsForButton3.contains(indexPath.row) {
                
                cell.op3.setTitleColor(.red, for: .normal)
                cell.userInteraction(isEnabled: false)
                
            }
            
            if selectedStates.selectedRowsForButton4.contains(indexPath.row) {
                
                cell.op4.setTitleColor(.red, for: .normal)
                cell.userInteraction(isEnabled: false)
                
            }
        }
        
        cell.delegate = self
        
        return cell
    }
    
    
    func getQuizDetailsByQuizId(quizId: Int) {
        
        let apiUrl = UrlManager.baseURL() + "Quiz/GetQuizDetailsByQuizId/\(quizId)"
        
        fetchDatawithNSDictionary(apitype: "GET", urlString: apiUrl, baseURL: "") { (jsonDict) in
            
            do {
                
                let quizDetailsResponse = try JSONDecoder().decode(Base.self, from: jsonDict)
                
                self.numberOfQuizzes = (quizDetailsResponse.payload?.thisQuiz?.questionCount ?? nil)!
                self.questionBanks = (quizDetailsResponse.payload?.quizDetails?.quizQuestionBanks)!
                
                let count = quizDetailsResponse.payload?.thisQuiz?.questionCount
                
                for i in 0...count! - 1 {
                    
                    quizQuestionBankId?.append(self.questionBanks[i].quizQuestionBankId!)
                    
                }
                
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch {
                print(error)
            }
        }
    }
    
    func submitResult() {
        
        
        
        guard let uploadData = try? JSONEncoder().encode(self.allQuiz) else {
            return
        }
        print(uploadData)
        
        
        
        let postUrl = UrlManager.baseURL() + "Quiz/AnswerQuiz"
        let url = URL(string: postUrl)! //PUT Your URL
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(String(describing: token))", forHTTPHeaderField: "Authorization")
        
        
        
        URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            
            
            if error == nil {
                
                let responseModel = try! JSONDecoder().decode(AnswerAfterResponse.self, from: data!)
                
                print(responseModel)
                
                self.totalMarks = (responseModel.answerPayload?.totalMark) ?? 100
                self.obtainedMarks = (responseModel.answerPayload?.obtainedMark) ?? 0
                
                DispatchQueue.main.async {
                    
                    self.totalMarkLabel.text = String(self.totalMarks)
                    self.markObtainLabel.text = String(self.obtainedMarks)
                    
                    if self.obtainedMarks > 0 {
                        self.percentage = Double(self.totalMarks)/self.obtainedMarks
                    }
                    else {
                        self.percentageLabel.text = "0 %"
                    }
                    
                    if self.percentage > 0 {
                        self.percentageLabel.text = "\(self.percentage * 100) %"
                    }
                    else {
                        self.percentageLabel.text = "0 %"
                    }
                }
            }
        }.resume()
    }
}
