

import Foundation
struct LoginBase : Codable {
	let successResonse : SuccessResonse?
	let failedResponse : FailedResponse?

	enum CodingKeys: String, CodingKey {

		case successResonse = "successResonse"
		case failedResponse = "failedResponse"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		successResonse = try values.decodeIfPresent(SuccessResonse.self, forKey: .successResonse)
		failedResponse = try values.decodeIfPresent(FailedResponse.self, forKey: .failedResponse)
	}

}
