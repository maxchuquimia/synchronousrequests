//
//  Helpers.swift
//  SynchronousRequests
//
//  Created by Max Chuquimia on 20/7/19.
//

import Foundation

public extension URLSession {

    func synchronousDataTask(with url: URL) -> StandardURLSessionCompletionArguments {
        return synchronousDataTask(with: URLRequest(url: url))
    }

    func throwingSynchronousDataTask(with url: URL) throws -> EnhancedURLSessionCompletionArguments {
        return try throwingSynchronousDataTask(with: URLRequest(url: url))
    }
}
