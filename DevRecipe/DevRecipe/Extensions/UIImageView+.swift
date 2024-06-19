//
//  UIImageView+.swift
//  DevRecipe
//
//  Created by 五十嵐伸雄 on 2024/06/19.
//

import UIKit

extension UIImageView {
    func setImage(from url: URL) {
        // 既存の画像をクリアしておく
        self.image = nil

        // URLSessionを使用して非同期に画像をダウンロード
        URLSession.shared.dataTask(with: url) { data, response, error in
            // エラーチェック
            if let error = error {
                print("Error downloading image: \(error)")
                return
            }

            // HTTPレスポンスコードチェック
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid response")
                return
            }

            // 画像データチェック
            guard let data = data else {
                print("No data received")
                return
            }

            // 画像をUIImageに変換
            if let image = UIImage(data: data) {
                // メインスレッドでUIImageViewに画像を設定
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
                print("Error converting data to image")
            }
        }.resume() // タスクを開始
    }
}
