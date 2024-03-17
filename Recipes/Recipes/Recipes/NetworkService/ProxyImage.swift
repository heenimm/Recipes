// ProxyImage.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Прокси загрузки изображений
final class ProxyImage: LoadImageServiceProtocol {
    private var loadImageService: LoadImageServiceProtocol

    init(service: LoadImageServiceProtocol) {
        self.loadImageService = service
    }

    func loadImage(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let manager = FileManager.default
        guard let documentsDirectory = manager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let imageUrl = documentsDirectory.appendingPathComponent(url.lastPathComponent)
        if manager.fileExists(atPath: imageUrl.path) {
            do {
                let data = try Data(contentsOf: imageUrl)
                completion(data, nil, nil)
            } catch {
                completion(nil, nil, error)
            }
        } else {
            loadImageService.loadImage(url: url) { data, responce, error in
                do {
                    try data?.write(to: imageUrl)
                    completion(data, responce, error)
                } catch {
                    completion(nil, responce, error)
                }
            }
        }
    }
}
