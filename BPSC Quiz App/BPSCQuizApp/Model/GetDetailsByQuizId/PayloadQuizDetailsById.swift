//
//  PayloadQuizDetailsById.swift
//  BPSCQuizApp
//
//  Created by Fahim Rahman on 22/3/20.
//  Copyright © 2020 AL Mustakim. All rights reserved.
//

import Foundation

struct PayloadQuizDetailsById : Codable {
    let thisQuiz : ThisQuiz?
    let quizDetails : QuizDetails?

    enum CodingKeys: String, CodingKey {

        case thisQuiz = "thisQuiz"
        case quizDetails = "quizDetails"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        thisQuiz = try values.decodeIfPresent(ThisQuiz.self, forKey: .thisQuiz)
        quizDetails = try values.decodeIfPresent(QuizDetails.self, forKey: .quizDetails)
    }

}
