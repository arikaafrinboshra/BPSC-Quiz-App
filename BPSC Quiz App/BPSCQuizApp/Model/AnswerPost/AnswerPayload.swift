//
//  Payload.swift
//  BPSCQuizApp
//
//  Created by Fahim Rahman on 1/4/20.
//  Copyright © 2020 AL Mustakim. All rights reserved.
//

import Foundation

struct AnswerPayload : Codable {
    
    let totalMark : Int?
    let obtainedMark : Double?
    let correctAnswer : Int?
    let comment : String?

    enum CodingKeys: String, CodingKey {

        case totalMark = "totalMark"
        case obtainedMark = "obtainedMark"
        case correctAnswer = "correctAnswer"
        case comment = "comment"
    }

    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalMark = try values.decodeIfPresent(Int.self, forKey: .totalMark)
        obtainedMark = try values.decodeIfPresent(Double.self, forKey: .obtainedMark)
        correctAnswer = try values.decodeIfPresent(Int.self, forKey: .correctAnswer)
        comment = try values.decodeIfPresent(String.self, forKey: .comment)
    }
}
