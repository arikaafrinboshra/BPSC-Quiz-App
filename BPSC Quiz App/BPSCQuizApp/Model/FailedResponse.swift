

import Foundation
struct FailedResponse : Codable {
	let error : Int?
	let token : String?

	enum CodingKeys: String, CodingKey {

		case error = "error"
		case token = "token"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		error = try values.decodeIfPresent(Int.self, forKey: .error)
		token = try values.decodeIfPresent(String.self, forKey: .token)
	}

}
