import SwiftUI

struct ContentView: View {
    @State private var items = [
        ListItem(done: true, content: "Buy some milk"),
        ListItem(done: false, content: "Buy a boat"),
        ListItem(done: true, content: "Listen to Black Sabbath"),
        ListItem(done: false, content: "Relax")
    ]
    
    var body: some View {
        VStack {
            Text("Press Up ↑ and Down ↓ arrow keys to select the list item, Return ⏎ to create a new one.")
            ListEditor(items: $items)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
