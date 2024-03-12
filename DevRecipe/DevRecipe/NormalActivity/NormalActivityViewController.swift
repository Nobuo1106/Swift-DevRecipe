//
//  NormalActivityViewController.swift
//  DevRecipe
//
//  Created by 五十嵐伸雄 on 2024/02/29.
//

import UIKit

class NormalActivityViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func share() {
        let shareImage = UIImage(named: "sample")
        guard let image = shareImage,
            let imageData = image.jpegData(compressionQuality: image.scale) else {
            return
        }
        
        let activity = UIActivityViewController(
            activityItems: [imageData],
            applicationActivities: nil
        )
        activity.excludedActivityTypes = [
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType(rawValue: "com.apple.NanoTimeKitCompanion.CreateWatchFace"),
        ]
        activity.popoverPresentationController?.sourceView = button
        activity.popoverPresentationController?.sourceRect = button.bounds

        present(activity, animated: true, completion: nil)
    }
    @IBAction func buttonDidTap(_ sender: Any) {
        share()
    }
}
