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
/// Types that implement this protocol can perform any async
/// operation with the varioys `tryWithErrorAlert` functions,
/// to automatically alert any thrown errors.
///
/// When an ``ErrorAlerter`` type alerts an ``AlertableError``
/// using the ``SwiftUICore/View/alert(for:)`` modifier, the
/// ``AlertableError/alertMessage`` is automatically alerted,
/// while other errors will alert the localized description.
@MainActor
public protocol ErrorAlerter {

    /// The alert context to use to present errors.
    var errorContext: PresentationContext<Error> { get }
}

public extension ErrorAlerter {

    /// Alert an error error.
    func alert(error: Error) {
        errorContext.present(error)
    }

    /// Try to perform a throwing async operation, and alert
    /// any thrown error.
    func tryWithErrorAlert(
        _ operation: @escaping AsyncOperation
    ) {
        Task {
            do {
                try await operation()
            } catch {
                alert(error: error)
            }
        }
    }

    /// Try to perform a throwing async operation, and alert
    /// any thrown error.
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

#Preview {

    return MyView()

    enum MyError: String, AlertableError {
        case minor, major

        var id: String { rawValue }

        var alertMessage: AlertMessage<AnyView, AnyView> {
            AlertMessage(
                title: "A \(rawValue) error occured",
                message: { Text("Please try again.") },
                actions: { Button("OK", action: {}) }
            )
        }
    }

    struct MyView: View, @MainActor ErrorAlerter {

        @State var errorContext = PresentationContext<Error>()

        func simulateOperation(error: Error?) async throws {
            if let error { throw error }
        }

        var body: some View {
            List {
                Button("Perform a successful operation") {
                    tryWithErrorAlert {
                        try await simulateOperation(error: nil)
                    }
                }
                Button("Perform a minor failing operation") {
                    tryWithErrorAlert {
                        try await simulateOperation(error: MyError.minor)
                    }
                }
                Button("Perform a major failing operation") {
                    tryWithErrorAlert {
                        try await simulateOperation(error: MyError.major)
                    }
                }
            }
            .alert(for: $errorContext)
        }
    }
}
