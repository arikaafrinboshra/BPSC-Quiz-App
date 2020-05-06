
import Foundation
struct CreateUserPayload : Codable {
	let userName : String?
	let firstName : String?
	let lastName : String?
	let email : String?
	let password : String?
	let address : String?
	let phoneNumber : String?
    let profilePicture: String?

	enum CodingKeys: String, CodingKey {

		case userName = "userName"
		case firstName = "firstName"
		case lastName = "lastName"
		case email = "email"
		case password = "password"
		case address = "address"
		case phoneNumber = "phoneNumber"
        case profilePicture = "profilePicture"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		userName = try values.decodeIfPresent(String.self, forKey: .userName)
		firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
		lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		password = try values.decodeIfPresent(String.self, forKey: .password)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        profilePicture = try values.decodeIfPresent(String.self, forKey: .profilePicture)
	}

}
