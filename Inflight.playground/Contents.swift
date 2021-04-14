import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()
let fireAllSubject = PassthroughSubject<Int, Never>()
let fireRecentSubject = PassthroughSubject<Int, Never>()

fireAllSubject
    .map { request(for: $0) }
    .flatMap { dataPublisher(for: $0) }
    .decode(type: ToDo.self, decoder: JSONDecoder())
    .replaceError(with: .empty)
    .sink { print("(fire all) todo:", $0) }
    .store(in: &subscriptions)

fireAllSubject.send((1))
fireAllSubject.send((2))
fireAllSubject.send((3))
fireAllSubject.send((4))
fireAllSubject.send((5))
fireAllSubject.send((6))
fireAllSubject.send((7))

fireRecentSubject
    .map { request(for: $0) }
    .map { dataPublisher(for: $0) }
    .switchToLatest()
    .decode(type: ToDo.self, decoder: JSONDecoder())
    .replaceError(with: .empty)
    .sink { print("(fire recent) todo:", $0) }
    .store(in: &subscriptions)

fireRecentSubject.send((1))
fireRecentSubject.send((2))
fireRecentSubject.send((3))
fireRecentSubject.send((4))
fireRecentSubject.send((5))
fireRecentSubject.send((6))
fireRecentSubject.send((7))




