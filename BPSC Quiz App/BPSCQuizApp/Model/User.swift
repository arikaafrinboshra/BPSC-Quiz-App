/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct User : Codable {
	
    let userID : Int
	let firstName : String?
	let lastName : String?
	let userName : String?
	let role : String?
	let address : String?
	let phoneNumber : String?
	let email : String?
	let profilePicture : String?

//	enum CodingKeys: String, CodingKey {
//
//		case userID = "userID"
//		case firstName = "firstName"
//		case lastName = "lastName"
//		case userName = "userName"
//		case role = "role"
//		case address = "address"
//		case phoneNumber = "phoneNumber"
//		case email = "email"
//		case profilePicture = "profilePicture"
//	}

//	init(from decoder: Decoder) throws {
//		let values = try decoder.container(keyedBy: CodingKeys.self)
//		userID = try values.decodeIfPresent(Int.self, forKey: .userID)
//		firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
//		lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
//		userName = try values.decodeIfPresent(String.self, forKey: .userName)
//		role = try values.decodeIfPresent(String.self, forKey: .role)
//		address = try values.decodeIfPresent(String.self, forKey: .address)
//		phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
//		email = try values.decodeIfPresent(String.self, forKey: .email)
//		profilePicture = try values.decodeIfPresent(String.self, forKey: .profilePicture)
//	}

}

