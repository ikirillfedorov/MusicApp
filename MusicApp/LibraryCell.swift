//
// Copyright © 2021 CleverPumpkin. All rights reserved.
//

import SwiftUI


struct LibraryCell: View {
	var body: some View {
		HStack {
			Image("Image").resizable().frame(width: 60, height: 60).cornerRadius(2)
			VStack {
				Text("Track Name")
				Text("Artist Name")
			}
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
