

import Foundation
struct Payload : Codable {
	let id : Int?
	let examName : String?
	let fileURL : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case examName = "examName"
		case fileURL = "fileURL"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		examName = try values.decodeIfPresent(String.self, forKey: .examName)
		fileURL = try values.decodeIfPresent(String.self, forKey: .fileURL)
	}

}
