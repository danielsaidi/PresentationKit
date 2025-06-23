//
//  ErrorAlerter.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-23.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This protocol can be implemented by any type that can be
/// used to alert errors.
///
/// The protocol can for instance be implemented by any view
/// that should be able to perform a throwing async function
/// with a failure alert.
///
/// By implementing this protocol, a type gets access to new
/// alert functions and ``tryWithErrorAlert(_:)``, which can
/// be used to perform an async function and alert any error.
///
/// If you throw errors that implement the custom error type
/// ``ErrorAlertConvertible`` you get full control over what
/// the alert will present.
public protocol ErrorAlerter {

    associatedtype ErrorType: Error

    /// The alert context to use to present errors.
    var errorAlertContext: AlertContext<ErrorType> { get }
}

@MainActor
public extension ErrorAlerter {

    /// Alert an error error.
    ///
    /// If you alert an ``ErrorAlertConvertible`` you should
    /// show its ``ErrorAlertConvertible/errorAlert`` in the
    /// alert context's view builder.
    func alert(
        error: ErrorType,
        okButtonText: String = "OK"
    ) {
        errorAlertContext.present(error)
    }

    /// Try to perform a throwing async operation, and alert
    /// any errors that are thrown.
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

    /// Try to perform a throwing async operation, and alert
    /// any errors that are thrown.
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
