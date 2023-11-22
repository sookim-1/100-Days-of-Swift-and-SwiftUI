//
//  Bundle-Decodable.swift
//  MoonShot
//
//  Created by 수킴 on 2022/12/12.
//

import Foundation

extension Bundle {
    
    func decode<T: Codable>(_ file: String) -> T {
        // 1. 번들에서 경로를 가져옵니다.
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        // 2. 경로를 이용하여 데이터를 가져옵니다.
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        // 3. 가져온 데이터를 디코딩합니다.
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
    
}
