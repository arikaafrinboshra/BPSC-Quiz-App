//
//  Base.swift
//  BPSCQuizApp
//
//  Created by Fahim Rahman on 22/3/20.
//  Copyright © 2020 AL Mustakim. All rights reserved.
//

import UIKit

struct Base : Codable {
    let requestTime : String?
    let responseTime : String?
    let requestURL : String?
    let success : Bool?
    let message : String?
    let payload : PayloadQuizDetailsById?
    let payloadType : String?

    enum CodingKeys: String, CodingKey {

        case requestTime = "requestTime"
        case responseTime = "responseTime"
        case requestURL = "requestURL"
        case success = "success"
        case message = "message"
        case payload = "payload"
        case payloadType = "payloadType"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        requestTime = try values.decodeIfPresent(String.self, forKey: .requestTime)
        responseTime = try values.decodeIfPresent(String.self, forKey: .responseTime)
        requestURL = try values.decodeIfPresent(String.self, forKey: .requestURL)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        payload = try values.decodeIfPresent(PayloadQuizDetailsById.self, forKey: .payload)
        payloadType = try values.decodeIfPresent(String.self, forKey: .payloadType)
    }

}
