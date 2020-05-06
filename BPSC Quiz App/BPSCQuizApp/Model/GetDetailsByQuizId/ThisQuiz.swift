
import Foundation

struct ThisQuiz : Codable {
	let title : String?
	let questionCount : Int?
	let id : Int?

	enum CodingKeys: String, CodingKey {

		case title = "title"
		case questionCount = "questionCount"
		case id = "id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		questionCount = try values.decodeIfPresent(Int.self, forKey: .questionCount)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
	}

}
