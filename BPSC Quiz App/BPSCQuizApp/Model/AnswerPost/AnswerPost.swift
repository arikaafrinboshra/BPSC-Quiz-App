//
//  AnswerPost.swift
//  BPSCQuizApp
//
//  Created by Fahim Rahman on 31/3/20.
//  Copyright © 2020 AL Mustakim. All rights reserved.
//

import Foundation

struct Quiz: Codable {
        let quizId: Int
        let quizQuestionBanks: [QuizQuestionBank]
    }

struct QuizQuestionBank: Codable {
    let quizQuestionBankId: Int
    let question: String
    let option1: String
    let option2: String
    let option3: String
    let option4: String
    let answer: String
    let explanation: String

}
