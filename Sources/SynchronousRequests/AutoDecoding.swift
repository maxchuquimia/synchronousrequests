//
//  AutoDecoding.swift
//  SynchronousRequests
//
//  Created by Max Chuquimia on 20/7/19.
//

import Foundation

#if canImport(Combine)
import Combine

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension URLSession {

    /// Performs a request synchronously and attempts to decode the response with the given decoder
    /// - Parameter url: the URL of the request
    /// - Parameter decoder: the `TopLevelDecoder` to use
    func synchronousDataTask<Model: Decodable, Decoder: TopLevelDecoder>(with url: URL, decoder: Decoder) throws -> Model where Decoder.Input == Data {
        return try synchronousDataTask(with: URLRequest(url: url), decoder: decoder)
    }

    /// Performs a request synchronously and attempts to decode the response with the given decoder
    /// - Parameter url: the request
    /// - Parameter decoder: the `TopLevelDecoder` to use
    func synchronousDataTask<Model: Decodable, Decoder: TopLevelDecoder>(with request: URLRequest, decoder: Decoder) throws -> Model where Decoder.Input == Data {

        let data = try throwingSynchronousDataTask(with: request).data
        let model: Model = try decoder.decode(Model.self, from: data)

        return model
    }
}
#endif

public extension URLSession {

    /// Performs a request synchronously and attempts to decode the response with the given JSONDecoder
    /// - Parameter url: the URL of the request
    /// - Parameter jsonDecoder: the `JSONDecoder` to use
    func synchronousDataTask<Model: Decodable>(with url: URL, jsonDecoder: JSONDecoder) throws -> Model {
        return try synchronousDataTask(with: URLRequest(url: url), jsonDecoder: jsonDecoder)
    }

    /// Performs a request synchronously and attempts to decode the response with the given JSONDecoder
    /// - Parameter url: the request
    /// - Parameter jsonDecoder: the `JSONDecoder` to use
    func synchronousDataTask<Model: Decodable>(with request: URLRequest, jsonDecoder: JSONDecoder) throws -> Model {

        let data = try throwingSynchronousDataTask(with: request).data
        let model: Model = try jsonDecoder.decode(Model.self, from: data)

        return model
    }
}
