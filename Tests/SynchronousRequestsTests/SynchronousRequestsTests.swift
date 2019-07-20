import XCTest
@testable import SynchronousRequests

final class SynchronousRequestsTests: XCTestCase {

    let validURL = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
    let invalidURL = URL(string: "http://www.thisdoesntexistatallblahblahblah234.com.au/")!

    func testRequestingSucceeds() {

            do {
                _ = try URLSession.shared.throwingSynchronousDataTask(with: validURL)
                XCTAssertTrue(true)
            } catch {
                XCTFail()
            }
    }

    func testThrowingErrorSucceeds() {

        do {
            _ = try URLSession.shared.throwingSynchronousDataTask(with: invalidURL)
            XCTFail()
        } catch {
            XCTAssertTrue(true)
        }
    }

    func testJSONDecodingSucceeds() {

        struct Model: Decodable {
            let userId: Int
            let title: String
        }

        do {
            if #available(OSX 10.15, *) {
                let response: Model = try URLSession.shared.synchronousDataTask(with: validURL, decoder: JSONDecoder())
                print(response)
            } else {
                let response: Model = try URLSession.shared.synchronousDataTask(with: validURL, jsonDecoder: JSONDecoder())
                print(response)
            }

            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }

    static var allTests = [
        ("testRequestingSucceeds", testRequestingSucceeds),
        ("testThrowingErrorSucceeds", testThrowingErrorSucceeds),
    ]
}
