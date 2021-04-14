
public struct ToDo: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

public extension ToDo {
    // simple error handling solution
    static let empty = ToDo(userId: 0, id: 0, title: "", completed: false)
}
