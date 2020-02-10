//
//  IntroductionViewController.swift
//  EncuestaMarle
//
//  Created by Tatiana Castro on 5/21/19.
//  Copyright © 2019 Marle. All rights reserved.
//

import UIKit

class IntroductionViewController: UIPageViewController, UIPageViewControllerDataSource {
    let pageViewControllers: [UIViewController] = {
        let introOne = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "introOneViewController")
        let introThree = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "introThreeViewController")
        
        return [introOne, introThree]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        setViewControllers([pageViewControllers[0]], direction: .forward, animated: false, completion: nil)
    }
        
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = pageViewControllers.index(of: viewController)!
        
        if index - 1 >= 0 {
            return pageViewControllers[index - 1]
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = pageViewControllers.index(of: viewController)!
        
        if index + 1 < pageViewControllers.count {
            return pageViewControllers[index + 1]
        }
        
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
