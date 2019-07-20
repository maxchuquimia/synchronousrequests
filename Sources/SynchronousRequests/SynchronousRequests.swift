import Foundation

public extension URLSession {

    typealias StandardURLSessionCompletionArguments = (data: Data?, response: URLResponse?, error: Error?)
    typealias EnhancedURLSessionCompletionArguments = (data: Data, response: URLResponse)

    func synchronousDataTask(with request: URLRequest) -> StandardURLSessionCompletionArguments {
        let semaphore = DispatchSemaphore(value: 0)

        var data: Data?
        var response: URLResponse?
        var error: Error?

        let task = self.dataTask(with: request) {
            data = $0
            response = $1
            error = $2
            semaphore.signal()
        }

        task.resume()
        semaphore.wait()

        return (data, response, error)
    }

    func throwingSynchronousDataTask(with request: URLRequest) throws -> EnhancedURLSessionCompletionArguments {

        let result: StandardURLSessionCompletionArguments = synchronousDataTask(with: request)

        guard result.error == nil else {
            throw result.error!
        }

        guard let response = result.response else {
            throw SynchronousRequestsError.noResponse
        }

        guard let data = result.data else {
            throw SynchronousRequestsError.noData
        }

        return (data, response)
    }
}
