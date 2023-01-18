// Dependencies
import Foundation

struct RequestModel {
    
    var username : String
    var email : String
    
    static func getList() -> [RequestModel] {
        let list = [
            RequestModel(username: "Javier", email: "xavi@mail.com"),
            RequestModel(username: "Fabian", email: "fabian@mail.com"),
            RequestModel(username: "Madison", email: "madison@mail.com"),
            RequestModel(username: "Luke", email: "luke@mail.com"),
            RequestModel(username: "Pepe", email: "pepe@mail.com"),
        ]
        return (list+list)
    }
    
}
