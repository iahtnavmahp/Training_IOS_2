//
//  PagesViewController.swift
//  Training_IOS_2
//
//  Created by Pham Van Thai on 25/03/2022.
//

import UIKit

class PagesViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = myController.firstIndex(of: viewController),index > 0  else {
            return nil
        }
        let before = index - 1
        return myController[before]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
       
            guard let index = myController.firstIndex(of: viewController),index < (myController.count - 1)  else {
                return nil
            }
            let after = index + 1
            return myController[after]
    }
    
    var myController = [UIViewController]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "DetailPageViewController") as! DetailPageViewController
        vc.str = "scr1"
        myController.append(vc)
        let vc2 = self.storyboard!.instantiateViewController(withIdentifier: "DetailPageViewController") as! DetailPageViewController
        vc2.str = "scr2"
        myController.append(vc2)
        let vc3 = self.storyboard!.instantiateViewController(withIdentifier: "DetailPageViewController") as! DetailPageViewController
        vc3.str = "scr3"
        myController.append(vc3)
        presentPageVC()
    }

    func presentPageVC(){
   
        guard let first = myController.first else {
            return
        }
        self.setViewControllers([first], direction: .reverse, animated: true, completion: nil)
        
    }
    


}
