
import Foundation
struct AllQuiz : Codable {
    let id : Int?
    let userQuizSubmissionId : Int?
    let questionCount : Int?
    let totalMarks : Int?
    let title : String?
    let hasParticipatedInQuiz : Bool?
    let obtainedMark : Int?
    let comment : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case userQuizSubmissionId = "userQuizSubmissionId"
        case questionCount = "questionCount"
        case totalMarks = "totalMarks"
        case title = "title"
        case hasParticipatedInQuiz = "hasParticipatedInQuiz"
        case obtainedMark = "obtainedMark"
        case comment = "comment"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        userQuizSubmissionId = try values.decodeIfPresent(Int.self, forKey: .userQuizSubmissionId)
        questionCount = try values.decodeIfPresent(Int.self, forKey: .questionCount)
        totalMarks = try values.decodeIfPresent(Int.self, forKey: .totalMarks)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        hasParticipatedInQuiz = try values.decodeIfPresent(Bool.self, forKey: .hasParticipatedInQuiz)
        obtainedMark = try values.decodeIfPresent(Int.self, forKey: .obtainedMark)
        comment = try values.decodeIfPresent(String.self, forKey: .comment)
    }

}
