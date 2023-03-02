//
//  UIImageView+LoadFromURL.swift
//  e-store
//
//  Created by Sonic on 2/3/23.
//

import UIKit

extension UIImageView {
    func loadFrom(_ url: URL) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else {
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
        task.resume()
        return task
    }
}
