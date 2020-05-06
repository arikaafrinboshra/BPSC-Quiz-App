//
//  QuizDetails.swift
//
//  Created by  on 22/3/20
//  Copyright (c) . All rights reserved.
//

import UIKit
struct QuizDetails : Codable {
    let quizId : Int?
    let quizQuestionBanks : [QuizQuestionBanks]?

    enum CodingKeys: String, CodingKey {

        case quizId = "quizId"
        case quizQuestionBanks = "quizQuestionBanks"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        quizId = try values.decodeIfPresent(Int.self, forKey: .quizId)
        quizQuestionBanks = try values.decodeIfPresent([QuizQuestionBanks].self, forKey: .quizQuestionBanks)
    }

}
