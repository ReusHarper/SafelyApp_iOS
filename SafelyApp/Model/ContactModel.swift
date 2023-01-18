// Dependencies
import Foundation

struct ContactModel {
    
    var username : String
    var email : String
    
    static func getList() -> [ContactModel] {
        let list = [
            ContactModel(username: "Yepeto", email: "yepeto@mail.com"),
            ContactModel(username: "Juan", email: "juan@mail.com"),
            ContactModel(username: "Maria Jose", email: "majo@mail.com"),
            ContactModel(username: "Asta", email: "kabasta@mail.com"),
            ContactModel(username: "Leo", email: "leo@mail.com"),
        ]
        return (list+list)
    }
    
}
