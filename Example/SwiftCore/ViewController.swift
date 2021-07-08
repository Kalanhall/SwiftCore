//
//  ViewController.swift
//  SwiftCore
//
//  Created by Kalanhall@163.com on 07/05/2021.
//  Copyright (c) 2021 Kalanhall@163.com. All rights reserved.
//

import UIKit
import MJRefresh

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let btn = UIButton()
        btn.backgroundColor = .orange
        btn.bounds = CGRect(x: 0, y: 0, width: 200, height: 100)
        btn.center = view.center
        let image = UIImage(named: "IMG_0651")
        btn.setImage(image, for: .normal)
        view.addSubview(btn)
        
        let label = UILabel(frame: btn.bounds)
        label.text = "Swift"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 50)
        label.shadow(color: .black, opacity: 1, offset: CGSize(width: 3, height: 3))
        btn.mask = label
        
        btn.maskedCorners([.topLeft, .topRight], radius: 10)
        
        btn.subscribe(.touchUpInside) { [weak self] sender in
            print("Swift - \(btn.controller!)")
            self?.view.endEditing(true)
        }
        
        
        let customView = UIImageView()
        customView.clipsToBounds = true
        customView.borderWidth = 1
        customView.contentMode = .scaleAspectFill
        customView.backgroundColor = .white
        customView.frame = CGRect(x: 0, y: UIScreen.navigationBarHeight + 10, width: 200, height: 100)
        view.addSubview(customView)
        
        customView.subscribeForTap { tap in
            print(tap)
        }
        
        let textf = UITextField()
        textf.borderWidth = 1
        textf.frame = CGRect(x: 0, y: customView.frame.origin.y + customView.frame.size.height + 30, width: 200, height: 100)
        view.addSubview(textf)
        
        textf.subscribe { textF in
            print(textF.text ?? "")
        }
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil).subscribe({ [weak self] item in
            print(item)
            // 截图
            customView.image = self?.view.snapshotImage(afterScreenUpdates: true)
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

