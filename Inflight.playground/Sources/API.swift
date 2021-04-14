import Foundation
import Combine

public func request(for id: Int) -> URLRequest {
    URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/todos/\(id)")!)
}

public func dataPublisher(for request: URLRequest) -> AnyPublisher<Data, URLError> {
    URLSession.shared
        .dataTaskPublisher(for: request)
        .map(\.data)
        .eraseToAnyPublisher()
}

