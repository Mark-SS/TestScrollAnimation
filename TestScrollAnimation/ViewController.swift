//
//  ViewController.swift
//  TestScrollAnimation
//
//  Created by gongliang on 2016/12/28.
//  Copyright © 2016年 GL. All rights reserved.
//

import UIKit

enum ABVPanDirection  {
    case down
    case up
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var footView: ABHomeFootView!
    @IBOutlet weak var footViewBottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var footViewHeightLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var containerView: UIView!
    
    let dataSource = ABHomeViewDataSource()
    
    var direction = ABVPanDirection.down
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        containerView.alpha = 0.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func panAction(_ pan: UIPanGestureRecognizer) {
        let footViewUpMinY = self.view.bounds.height - ABHomeFootViewConfig.defaultHeight
        let footViewDownMinY = self.view.bounds.height - ABHomeFootViewConfig.defaultShowHeight
        switch pan.state {
        case .began:
            print("began")
        case .changed:
            let transViewPoint  = pan.translation(in: pan.view)
            direction = transViewPoint.y > 0 ? .down : .up
//            print("centerY: \(footView.center.y ) transViewPoint.y: \(transViewPoint.y) height: \(self.view.bounds.height)")
            if (footView.frame.origin.y >= footViewUpMinY && footView.frame.origin.y <= footViewDownMinY) {
                let fCenter = footView.center
                let tCenter = CGPoint(x: fCenter.x, y: fCenter.y + transViewPoint.y)
                footView.center = tCenter
                footView.offset = footView.offset + transViewPoint.y
            }
            pan.setTranslation(CGPoint(x: 0, y: 0), in: pan.view)
        case .ended:
            print("ended \(footView.frame.origin.y) footViewUpMinY: \(footViewUpMinY)")
            let offset = (ABHomeFootViewConfig.defaultHeight - ABHomeFootViewConfig.defaultShowHeight) / 2
            if footView.frame.origin.y - footViewUpMinY <= offset {
                footView.offset = 0
                UIView.animate(withDuration: 0.3, animations: {
                    self.footView.frame.origin.y = footViewUpMinY
                })
                UIView.animate(withDuration: 0.6, animations: { 
                    self.containerView.alpha = 1.0
                })
            } else {
                footView.offset = ABHomeFootViewConfig.defaultOffset
                UIView.animate(withDuration: 0.3, animations: {
                    self.footView.frame.origin.y = footViewDownMinY
                })
                UIView.animate(withDuration: 0.3, animations: {
                    self.containerView.alpha = 0.0
                })
            }
           
        default:
            print("default")
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.sections().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.sections()[section].rows()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = dataSource.sections()[indexPath.section]
        return CGFloat(section.rowHeight())
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = dataSource.sections()[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: section.cellIdentifier(), for: indexPath)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let a = scrollView.contentOffset.y * (-1.0 / 3) + (-4.0 / 3)
    }
}
