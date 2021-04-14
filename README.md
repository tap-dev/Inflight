# Cancel in-flight network requests using Combine

A common requirement for many apps is to cancel a running network request that has not yet completed, if a new request to the same resource is made. This is extremely simple using the power of reactive programming and Combine.

```swift
var subscriptions = Set<AnyCancellable>()
let fireRecentSubject = PassthroughSubject<Int, Never>()

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

//prints (fire recent) todo: ToDo(userId: 1, id: 7, title: "illo expedita consequatur quia in", completed: false)
```

Checkout the full post on [tapdev][1]

[1]: https://tapdev.co/2021/04/14/cancel-in-flight-network-requests-using-combine/
