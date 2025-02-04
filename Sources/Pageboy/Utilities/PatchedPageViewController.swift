//
//  PatchedPageViewController.swift
//  Pageboy
//
//  Created by Arabia -IT on 8/25/19.
//

import UIKit

/// Fixes not updating dataSource on animated setViewControllers. See: https://stackoverflow.com/a/13253884/715593
internal class PatchedPageViewController: UIPageViewController {

    private var isSettingViewControllers = false

    override func setViewControllers(_ viewControllers: [UIViewController]?, direction: UIPageViewController.NavigationDirection, animated: Bool, completion: ((Bool) -> Void)? = nil) {
        guard !isSettingViewControllers else {
            completion?(false)
            return
        }
        isSettingViewControllers = true
        var didCallback = false
        super.setViewControllers(viewControllers, direction: direction, animated: animated) { (isFinished) in
            didCallback = true
            if isFinished && animated {
                DispatchQueue.main.async {
                    super.setViewControllers(viewControllers, direction: direction, animated: false, completion: { _ in
                        self.isSettingViewControllers = false
                    })
                }
            } else {
                self.isSettingViewControllers = false
            }
            completion?(isFinished)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            if !didCallback {
                self.isSettingViewControllers = false
                completion?(false)
            }
        }
    }
}
