import Testing
@testable import PresentationKit

private struct Model: Identifiable, Equatable {

    let id: Int
}

@Test func presentationContextsCanPresentModel() async throws {
    let val = Model(id: 1)
    let alert = AlertContext<Model>()
    let cover = FullScreenCoverContext<Model>()
    let sheet = SheetContext<Model>()

    #expect(alert.value == nil)
    #expect(cover.value == nil)
    #expect(sheet.value == nil)

    alert.present(val)
    #expect(alert.value == val)
    #expect(cover.value == nil)
    #expect(sheet.value == nil)

    cover.present(val)
    #expect(alert.value == val)
    #expect(cover.value == val)
    #expect(sheet.value == nil)

    sheet.present(val)
    #expect(alert.value == val)
    #expect(cover.value == val)
    #expect(sheet.value == val)
}
