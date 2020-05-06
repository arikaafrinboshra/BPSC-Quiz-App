

import Foundation
struct UpdateUserPayload : Codable {
	let firstName : String?
	let lastName : String?
	let address : String?
	let phoneNumber : String?

	enum CodingKeys: String, CodingKey {

		case firstName = "firstName"
		case lastName = "lastName"
		case address = "address"
		case phoneNumber = "phoneNumber"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
		lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
	}

}
