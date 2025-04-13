//
//  ImageListViewModel.swift
//  ImageGallery
//
//  Created by Abhinav Soni on 12/04/25.
//

import Foundation
import Foundation


class ImageListViewModel {
    
    // MARK: - Properties
    private let network = Networking.shared
    
   
    var images: [Image] = []
    
    // MARK: - Data Fetching
    func getImageList() async throws {
        let imageListResponse = try await network.hitApiGetRequest(
            type: ImageListResponse.self,
            endPoint: Constants.Endpoints.nowPlaying
        )
        self.images = imageListResponse.results
    }
}
