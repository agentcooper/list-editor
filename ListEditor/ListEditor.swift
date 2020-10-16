import Foundation
import SwiftUI

struct ListItem: Hashable, Identifiable {
    var id = UUID()
    var done: Bool
    var content: String
}

struct ListEditor: View {
    @Binding var items: [ListItem]
    @State private var currentListItem: ListItem? = nil
    @State private var focusedIndex: Int = 0
    
    var body: some View {
        VStack {
        List(selection: $currentListItem) {
            ForEach(items.indices, id: \.self) { item in
                Toggle(isOn: self.$items[item].done) {
                    CustomTextField(
                        text: self.$items[item].content,
                        index: item,
                        focusedIndex: focusedIndex,
                        onCommand: { command in
                            if command == "insertNewline" {
                                items.insert(ListItem(done: false, content: ""), at: item + 1)
                                focusedIndex += 1
                            }
                            if command == "moveUp" {
                                focusedIndex -= 1
                            }
                            if command == "moveDown" {
                                focusedIndex += 1
                            }
                        },
                        onFocus: {
                            focusedIndex = item
                        }
                    )
                }
            }
        }
        }
    }
}
