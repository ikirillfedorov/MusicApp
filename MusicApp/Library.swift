//
// Copyright © 2021 CleverPumpkin. All rights reserved.
//

import SwiftUI

struct Library: View {
	var body: some View {
		NavigationView {
			GeometryReader { geometry in
				HStack {
					Button(action: {
						print("123")
					}, label: {
						Image(systemName: "play.fill")
							.frame(
								width: geometry.size.width / 2,
								height: 50
							)
							.accentColor(.red)
							.background(Color.init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
							.cornerRadius(16)
					})
//					.padding().frame(height: 50)
					Button(action: {
						print("123")
					}, label: {
						Image(systemName: "arrow.2.circlepath")
							.frame(
								width: geometry.size.width / 2,
								height: 50
							)
							.accentColor(.red)
							.background(Color.init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
							.cornerRadius(16)
					})
//					.padding().frame(height: 50)
				}
			}
			.navigationBarTitle("Library")
		}
	}
}

struct Library_Previews: PreviewProvider {
	static var previews: some View {
		Library()
	}
}
