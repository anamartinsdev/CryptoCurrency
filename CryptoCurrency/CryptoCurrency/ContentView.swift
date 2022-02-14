//
//  ContentView.swift
//  CryptoCurrency
//
//  Created by Ana Carolina Martins Pessoa on 14/02/22.
//

import SwiftUI
import MobileCoreServices

struct Item: Identifiable{
    let id = UUID()
    let title: String
}

struct ContentView: View {
    //MARK: - Variables/Constants
    @State private var items: [Item] = []
    @State private var editMode = EditMode.inactive
    private static var count = 0
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading, spacing: 6) {
                List {
                    ForEach(items) { item in
                        Text(item.title)
                    }
                    .onDelete(perform: onDelete)
                    .onMove(perform: onMove)
                    .onInsert(of: [String(kUTTypeURL)], perform: onInsert)
                }
                .navigationBarTitle(Text("Crypto Currency"), displayMode: .automatic)
                .navigationBarItems(leading: EditButton(), trailing: addButton)
                .colorScheme(colorScheme)
                .environment(\.editMode, $editMode)
            }
        }
    }
    private var addButton: some View {
        return AnyView(Button(action: onAdd) { Image(systemName: "plus") })
    }
    
    private func onAdd() {
        items.append (Item(title: "Item #\(Self.count)"))
        Self.count += 1
    }
    
    private func onDelete(offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    private func onMove (source: IndexSet, destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
    
    private func onInsert (at offset: Int, itemProvider: [NSItemProvider]) {
        for provider in itemProvider {
            if provider.canLoadObject(ofClass: URL.self) {
                _ = provider.loadObject(ofClass: URL.self) { url, error in DispatchQueue.main.async {
                    url.map { self.items.insert(Item(title: $0.absoluteString), at: offset) }
                }
                                                
                                                }
            }
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ContentView().preferredColorScheme($0)
        }
    }
}
