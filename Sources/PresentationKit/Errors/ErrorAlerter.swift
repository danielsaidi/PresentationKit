//
//  ErrorAlerter.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-23.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This protocol can be implemented by any type that can be used to alert errors.
///
/// The protocol can be implemented by views that should be able to perform any
/// throwing async function. It can then use ``tryWithErrorAlert(_:)`` to
/// perform any async functions and alert all thrown errors.
///
/// If you throw an ``ErrorAlertConvertible``, that type will automatically
/// determine which alert that is shown.
public protocol ErrorAlerter {

    associatedtype ErrorType: Error

    /// The alert context to use to present errors.
    var errorAlertContext: AlertContext<ErrorType> { get }
}

@MainActor
public extension ErrorAlerter {

    /// Alert an error error.
    func alert(
        error: ErrorType,
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
                if let error = error as? ErrorType {
                    alert(error: error)
                }
            }
        }
    }

    /// Try to perform a throwing async operation, and alert any thrown error.
    func tryWithErrorAlert(
        _ operation: @escaping BlockOperation<ErrorType>,
        completion: @escaping BlockCompletion<ErrorType>
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
