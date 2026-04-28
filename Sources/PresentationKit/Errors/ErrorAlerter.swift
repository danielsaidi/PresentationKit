//
//  ErrorAlerter.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-23.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This protocol can be implemented by any type that can be
/// used to present error alerts.
///
/// Types that implement this protocol can use the extension
/// ``tryWithErrorAlert(_:)`` to perform async functions and
/// automatically alert any thrown error.
public protocol ErrorAlerter {

    /// The alert context to use to present errors.
    var errorAlertContext: PresentationContext<Error> { get }
}

@MainActor
public extension ErrorAlerter {

    /// Alert an error error.
    func alert(
        error: Error,
        okButtonText: String = "OK"
    ) {
        errorAlertContext.present(error)
    }

    /// Try to perform a throwing async operation, and alert any thrown error.
    func tryWithErrorAlert(_ operation: @escaping AsyncOperation) {
        Task {
            do {
                try await operation()
            } catch {
                alert(error: error)
            }
        }
    }

    /// Try to perform a throwing async operation, and alert any thrown error.
    func tryWithErrorAlert(
        _ operation: @escaping BlockOperation<Error>,
        completion: @escaping BlockCompletion<Error>
    ) {
        operation { result in
            switch result {
            case .failure(let error): alert(error: error)
            case .success: break
            }
            completion(result)
        }
    }
}

public extension ErrorAlerter {

    /// This typealias describes an async operation.
    typealias AsyncOperation = () async throws -> Void

    /// This typealias describes a block completion.
    typealias BlockCompletion<ErrorType: Error> = (BlockResult<ErrorType>) -> Void

    /// This typealias describes a block completion result.
    typealias BlockResult<ErrorType: Error> = Result<Void, ErrorType>

    /// This typealias describes a block operation.
    typealias BlockOperation<ErrorType: Error> = (BlockCompletion<ErrorType>) -> Void
}
