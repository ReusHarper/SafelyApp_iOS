// ==================== Dependencies ====================
import Foundation

struct NotificationsModel {
    
    var username : String
    var message : String
    
    static var list = [
        NotificationsModel(username: "Kevin", message: "San Peter"),
        NotificationsModel(username: "Ale", message: "Naucalpan york"),
        NotificationsModel(username: "Erick", message: "Ecatepunk"),
        NotificationsModel(username: "Dan", message: "Los prados"),
    ]
    
    static func getList() -> [NotificationsModel] {
        return list
    }
    
}
