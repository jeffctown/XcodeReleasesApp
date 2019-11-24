//
//  LinksSection.swift
//  XcodeReleases
//
//  Created by Jeff Lett on 7/3/19.
//  Copyright © 2019 Jeff Lett. All rights reserved.
//

import SwiftUI
import XcodeReleasesKit

struct LinksSection : View {
    let release: XcodeRelease
    
    var body: some View {
        Group {
            if release.links?.notes?.url != nil {
                Section(header: Text("Links")) {
                    NavigationLink("Release Notes", destination: SafariView(url: URL(string: release.links!.notes!.url)!))
                }
            } else {
                EmptyView()
            }
        }
    }
}

#if DEBUG
struct LinksSection_Previews : PreviewProvider {
    static var previews: some View {
        List(0..<5) { index in
            LinksSection(release: mockReleases[index])
        }
    }
}
#endif