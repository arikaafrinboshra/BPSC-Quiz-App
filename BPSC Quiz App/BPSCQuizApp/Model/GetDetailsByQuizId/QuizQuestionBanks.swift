//
//  QuizQuestionBanks.swift
//
//  Created by  on 22/3/20
//  Copyright (c) . All rights reserved.
//

import UIKit

struct QuizQuestionBanks : Codable {
    
    let quizQuestionBankId : Int?
    let question : String?
    let option1 : String?
    let option2 : String?
    let option3 : String?
    let option4 : String?
    let answer : String?
    let explanation : String?

    enum CodingKeys: String, CodingKey {

        case quizQuestionBankId = "quizQuestionBankId"
        case question = "question"
        case option1 = "option1"
        case option2 = "option2"
        case option3 = "option3"
        case option4 = "option4"
        case answer = "answer"
        case explanation = "explanation"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        quizQuestionBankId = try values.decodeIfPresent(Int.self, forKey: .quizQuestionBankId)
        question = try values.decodeIfPresent(String.self, forKey: .question)
        option1 = try values.decodeIfPresent(String.self, forKey: .option1)
        option2 = try values.decodeIfPresent(String.self, forKey: .option2)
        option3 = try values.decodeIfPresent(String.self, forKey: .option3)
        option4 = try values.decodeIfPresent(String.self, forKey: .option4)
        answer = try values.decodeIfPresent(String.self, forKey: .answer)
        explanation = try values.decodeIfPresent(String.self, forKey: .explanation)
    }

}
