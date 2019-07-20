# SynchronousRequests

An extension on `URLSession` to allow requesting data synchronously.

### Standard Use

```swift
    let (data, response, error) = URLSession.shared.synchronousDataTask(with: request)
    // ... unwrap `data`, `response`, and `error` as per usual
```

### Throwing Example

```swift
do {
    let (data, response) = try URLSession.shared.throwingSynchronousDataTask(with: request)
    // ... `data` and `response` are not `Optional`
} catch {
     print(error)
}
```

### Auto-Decoding

```swift
do {
    let decoder = JSONDecoder() // or any `TopLevelDecoder`
    let model: SomeCodableModel = try URLSession.shared.synchronousDataTask(with: request, decoder: decoder)
    // .. proceed with `model`, a `SomeCodableModel` instance
catch {
    print(error)
}
```
