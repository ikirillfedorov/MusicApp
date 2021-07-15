//
// Copyright © 2021 CleverPumpkin. All rights reserved.
//

import SwiftUI

struct Library: View {
	
	@State private var savedTracks = StorageService.tracks
	
	private func deleteRow(at indexSet: IndexSet) {
		indexSet.forEach { StorageService.remove(at: $0) }
		indexSet.forEach { savedTracks.remove(at: $0) }
	}

	var body: some View {
		NavigationView {
			VStack {
				GeometryReader { geometry in
					HStack(spacing: 20) {
						Button(action: {
							print("12345")
						}, label: {
							Image(systemName: "play.fill")
								.frame(width: abs(geometry.size.width / 2 - 10), height: 50)
								.accentColor(Color.init(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
								.background(Color.init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
								.cornerRadius(10)
						})
						Button(action: {
							print("54321")
						}, label: {
							Image(systemName: "arrow.2.circlepath")
								.frame(width: abs(geometry.size.width / 2 - 10), height: 50)
								.accentColor(Color.init(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
								.background(Color.init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
								.cornerRadius(10)
						})
					}
				}
				.padding().frame(height: 65)
				Divider()
				
				List {
					ForEach(savedTracks, content: { track in
						LibraryCell(cell: track)
					})
					.onDelete(perform: deleteRow)
//					ForEach(animals, id: \.self) { animal in
//						Text(animal)
//					}
					// 3.
//					.onDelete(perform: self.deleteRow)
				}

				
//				List(savedTracks) { track in
//					LibraryCell(cell: track)
//				}
			}
			.navigationBarTitle("Library")
		}
	}
}

struct Library_Previews: PreviewProvider {
	static var previews: some View {
		Library()
			.tabItem {
				Image("library")
				Text("Library")
			}
	}
}
