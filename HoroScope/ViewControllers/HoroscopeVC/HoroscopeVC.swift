//
//  HomeVC.swift
//  FakeWeather
//
//  Created by Luy Nguyen on 1/14/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class HoroscopeVC: GLViewPagerViewController {
    
    var viewControllers: NSArray = NSArray()
    var tabTitles: NSArray = NSArray()
    let fonDefault: UIFont = Common.getFontForDeviceWithFontDefault(fontDefault: UIFont.systemFont(ofSize: 20))
    var zodiac: ZodiacObj = ZodiacObj(name: Zodiac.Aquarius.rawValue, date:               ZodiacDate.Aquarius.rawValue, img: #imageLiteral(resourceName: "Aquarius"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension HoroscopeVC {
    func initUI() {
        SwiftyAd.shared.delegate = self
        Common.addNotificationCenter(observer: self, selector: #selector(showZodiacVC), key: NotificationCenterKey.ShowZodiacsVC)
        Common.addNotificationCenter(observer: self, selector: #selector(reloadData(notifi:)), key: NotificationCenterKey.ReloadData)
    }
    
    func initData() {
        ZodiacService.shared.getDataZodiac(zodiac: self.zodiac) {
            readJsonShared.getContentZodiac(zodiac: self.zodiac, success: {
                self.initTabPage()
                print("success")
            })
        }
    }
    
    func initTabPage() {
        self.setDataSource(newDataSource: self)
        self.setDelegate(newDelegate: self)
        self.padding = 10
        self.leadingPadding = 10
        self.trailingPadding = 10
        self.defaultDisplayPageIndex = 0
        self.kTabHeight = 44*heightRatio
        self.tabHeight = self.kTabHeight
        self.tabAnimationType = GLTabAnimationType.GLTabAnimationType_WhileScrolling
        
        self.tabTitles = [ "General",
                           "Today",
                           "Week" ,
                           "Month",
                           "Year"]
        
        self.viewControllers = [ ContentHomeVC(type: .general, zodiac: self.zodiac),
                                 ContentHomeVC(type: .today, zodiac: self.zodiac),
                                 ContentHomeVC(type: .week, zodiac: self.zodiac),
                                 ContentHomeVC(type: .month, zodiac: self.zodiac),
                                 ContentHomeVC(type: .year, zodiac: self.zodiac) ]
        
        self.fixTabWidth = isIPad
        self.tabWidth = UIScreen.main.bounds.width/CGFloat((self.viewControllers.count))
//        self.reloadData()
    }
    
    @objc func showZodiacVC() {
        let vc = ZodiacsVC.init(nibName: "ZodiacsVC", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func reloadData(notifi: Notification) {
        if let obj = notifi.object as? ZodiacObj {
            self.zodiac = obj
            initTabPage()
        }
    }
}

extension HoroscopeVC: GLViewPagerViewControllerDataSource {
    func numberOfTabsForViewPager(_ viewPager: GLViewPagerViewController) -> Int {
        return self.viewControllers.count
    }
    
    func viewForTabIndex(_ viewPager: GLViewPagerViewController, index: Int) -> UIView {
        let label:UILabel = UILabel()
        label.font = fonDefault
        label.text = self.tabTitles.object(at: index) as? String
        label.textColor = UIColor.white
        if index == 0 {
            label.textColor = .black
        }
        label.textAlignment = NSTextAlignment.center
        label.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        label.layer.masksToBounds = true
        return label
    }
    
    func contentViewControllerForTabAtIndex(_ viewPager: GLViewPagerViewController, index: Int) -> UIViewController {
        return self.viewControllers.object(at: index) as! UIViewController
    }
    
    func contentViewForTabAtIndex(_ viewPager: GLViewPagerViewController, index: Int) -> UIView {
        return UIView()
    }
}

extension HoroscopeVC: GLViewPagerViewControllerDelegate {
    func didChangeTabToIndex(_ viewPager: GLViewPagerViewController, index: Int, fromTabIndex: Int) {
        guard fromTabIndex != index else { return }
        let prevLabel:UILabel = viewPager.tabViewAtIndex(index: fromTabIndex) as! UILabel
        let currentLabel:UILabel = viewPager.tabViewAtIndex(index: index) as! UILabel
        prevLabel.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
        currentLabel.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
        prevLabel.textColor = UIColor.white
        currentLabel.textColor = UIColor.black
        currentLabel.backgroundColor = UIColor.white
        prevLabel.backgroundColor = UIColor.clear
        
        GCDCommon.mainQueueWithDelay(0.1) {
            SwiftyAd.shared.showInterstitial(from: self, withInterval: 3)
        }
    }
    
    func willChangeTabToIndex(_ viewPager: GLViewPagerViewController, index: Int, fromTabIndex: Int, progress: CGFloat) {
        if fromTabIndex == index {
            return
        }
        
        let prevLabel:UILabel = viewPager.tabViewAtIndex(index: fromTabIndex) as! UILabel
        let currentLabel:UILabel = viewPager.tabViewAtIndex(index: index) as! UILabel
        prevLabel.transform = CGAffineTransform.identity.scaledBy(x: 1.0 - (0.1 * progress), y: 1.0 - (0.1 * progress))
        currentLabel.transform = CGAffineTransform.identity.scaledBy(x: 0.9 + (0.1 * progress), y: 0.9 + (0.1 * progress))
        //        currentLabel.textColor =   UIColor.init(colorLiteralRed: Float(0.3 + 0.2 * progress), green: Float(0.3 - 0.3 * progress), blue: Float(0.3 + 0.2 * progress), alpha: 1.0)
        //        prevLabel.textColor = UIColor.init(colorLiteralRed: Float(0.5 - 0.2 * progress), green: Float(0.0 + 0.3 * progress), blue: Float(0.5 - 0.2 * progress), alpha: 1.0)
    }
    
    func widthForTabIndex(_ viewPager: GLViewPagerViewController, index: Int) -> CGFloat {
        let prototypeLabel:UILabel = UILabel.init()
        prototypeLabel.text = self.tabTitles.object(at: index) as? String
        prototypeLabel.textAlignment = NSTextAlignment.center
        prototypeLabel.font = fonDefault
        if index == 0 {
            self.tabViews[0].backgroundColor = .white
        }
        return prototypeLabel.intrinsicContentSize.width + (isIPad ? 80 : 25)
    }
}

extension HoroscopeVC: SwiftyAdDelegate {
    func swiftyAdDidOpen(_ swiftyAd: SwiftyAd) {
        
    }
    
    func swiftyAdDidClose(_ swiftyAd: SwiftyAd) {
        
    }
    
    func swiftyAd(_ swiftyAd: SwiftyAd, didRewardUserWithAmount rewardAmount: Int) {
        
    }
    
    
}

//class GLPresentViewController: UIViewController {
//
//    var presentLabel: UILabel = UILabel()
//
//    internal var _title : NSString = "Page Zero"
//    internal var _setupSubViews:Bool = true
//
//    init(title : NSString) {
//        _title = title
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.presentLabel.text = self._title as String
//        self.presentLabel.textColor = .white
//        self.presentLabel.sizeToFit()
//        self.view.addSubview(self.presentLabel)
//        self.presentLabel.center = self.view.center
//        //    self.view.backgroundColor = .white
//    }
//
//    override func viewWillLayoutSubviews() {
//        self.presentLabel.center = self.view.center
//    }
//}
