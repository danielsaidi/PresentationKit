//
//  AnyErrorAlerter.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2022-05-04.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This protocol can be implemented by types that can alert errors.
///
/// This protocol extends types with a ``tryWithErrorAlert(_:)`` function,
/// which can be used to perform any throwing async function and alert any errors.
///
/// If you throw an ``ErrorAlertConvertible`` error type, then that type is
/// responsible for determining the alert that is shown.
public protocol AnyErrorAlerter {

    var alert: AnyAlertContext { get }
}

@MainActor
public extension AnyErrorAlerter {

    /// Alert the provided error.
    ///
    /// If the error implements ``ErrorAlertConvertible`` it will use that
    /// specific alert, otherwise the localized error description will be used.
    func alert(
        error: Error,
        okButtonText: String = "OK"
    ) {
        if let error = error as? ErrorAlertConvertible {
            return alert.present(error.errorAlert)
        }
        alert.present(
            Alert(
                title: Text(error.localizedDescription),
                dismissButton: .default(Text(okButtonText))
            )
        )
    }
}

public extension AnyErrorAlerter {

    /// This typealias describes an async operation.
    typealias AsyncOperation = () async throws -> Void

    /// This typealias describes a block completion.
    typealias BlockCompletion<ErrorType: Error> = (BlockResult<ErrorType>) -> Void

    /// This typealias describes a block completion result.
    typealias BlockResult<ErrorType: Error> = Result<Void, ErrorType>

    /// This typealias describes a block operation.
    typealias BlockOperation<ErrorType: Error> = (BlockCompletion<ErrorType>) -> Void

    /// Alert the provided error asynchronously.
    @MainActor func alertAsync(
        error: Error,
        okButtonText: String = "OK"
    ) {
        alert(
            error: error,
            okButtonText: okButtonText
        )
    }

    /// Try to perform a block-based operation, and alert any thrown errors.
    @MainActor func tryWithErrorAlert<ErrorType: Error>(
        _ operation: @escaping BlockOperation<ErrorType>,
        completion: @escaping BlockCompletion<ErrorType>
    ) {
        operation { result in
            switch result {
            case .failure(let error): alertAsync(error: error)
            case .success: break
            }
            completion(result)
        }
    }
    
    /// Try to perform an async operation, and alert any thrown errors.
    @MainActor func tryWithErrorAlert(_ operation: @escaping AsyncOperation) {
        Task {
            do {
                try await operation()
            } catch {
                alert(error: error)
            }
        }
    }
}
