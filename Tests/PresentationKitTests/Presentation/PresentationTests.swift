import Testing
@testable import PresentationKit

private struct Model: Identifiable, Equatable {

    let id: Int
}

@Test func presentationCanPresentItem() async throws {
    let val = Model(id: 1)
    let context = Presentation<Model>()

    #expect(context.item == nil)
    context.present(val)
    #expect(context.item == val)
}
