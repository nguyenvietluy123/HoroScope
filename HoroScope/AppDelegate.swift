//
//  AppDelegate.swift
//  HoroScope
//
//  Created by Luy Nguyen on 2/19/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit
import CoreData
import GoogleMobileAds

let kAdmobAppID         = "ca-app-pub-1947012962477196~8459063867"
let kAdmobBanner        = "ca-app-pub-1947012962477196/2412530261"
let kAdmobInterstitial  = "ca-app-pub-1947012962477196/2272929463"
let APPSTORE_ID = "1446879801"
let APPSTORE_LINK = "https://itunes.apple.com/app/id\(APPSTORE_ID)"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var tabVC: UITabBarController?
    var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        initMainVC()
        initTabVC(0)
        GADMobileAds.configure(withApplicationID: kAdmobAppID)
        SwiftyAd.shared.setup(withBannerID: kAdmobBanner, interstitialID: kAdmobInterstitial, rewardedVideoID: nil)
        return true
    }
    
    func initMainVC() {
        let vc = BabyPredictionVC.init(nibName: "BabyPredictionVC", bundle: nil)
        let navi = UINavigationController.init(rootViewController: vc)
        window?.rootViewController = navi
        window?.makeKeyAndVisible()
    }
    
    func initTabVC(_ index: Int){
        tabVC = UITabBarController()
        tabVC?.tabBar.backgroundImage = nil
        tabVC?.tabBar.shadowImage = nil
        tabVC?.tabBar.layer.borderWidth = 0.0
        tabVC?.tabBar.clipsToBounds = true
        tabVC?.tabBar.contentMode = .scaleToFill
        tabVC?.tabBar.isTranslucent = true
        
        let tabHoro = HoroscopeVC(nibName:"HoroscopeVC",bundle: nil)
        tabHoro.tabBarItem = UITabBarItem(title: "Horoscope", image: #imageLiteral(resourceName: "tabbar_horoscope").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "tabbar_horoscopeSelected").withRenderingMode(.alwaysOriginal))
        let navHoro = UINavigationController(rootViewController: tabHoro)
        navHoro.isNavigationBarHidden = true
        let tabCompatibility = CompatibilityVC(nibName:"CompatibilityVC",bundle: nil)
        tabCompatibility.tabBarItem = UITabBarItem(title: "Compatibility", image: #imageLiteral(resourceName: "tabbar_compatibility").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "tabbar_compatibilitySelected").withRenderingMode(.alwaysOriginal))
        let navCompatibility = UINavigationController(rootViewController: tabCompatibility)
        navCompatibility.isNavigationBarHidden = true
        let tabFeatures = FeaturesVC(nibName:"FeaturesVC",bundle: nil)
        tabFeatures.tabBarItem = UITabBarItem(title: "Features", image: #imageLiteral(resourceName: "tabbar_features").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "tabbar_featuresSelected").withRenderingMode(.alwaysOriginal))
        let navFeatures = UINavigationController(rootViewController: tabFeatures)
        navFeatures.isNavigationBarHidden = true
        let tabSetting = SettingVC(nibName:"SettingVC",bundle: nil)
        tabSetting.tabBarItem = UITabBarItem(title: "Setting", image: #imageLiteral(resourceName: "tabbar_setting").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "tabbar_settingSelected").withRenderingMode(.alwaysOriginal))
        let navSetting = UINavigationController(rootViewController: tabSetting)
        navSetting.isNavigationBarHidden = true
        tabVC?.viewControllers = [navHoro, navCompatibility, navFeatures, navSetting]
        tabVC?.selectedIndex = index
        window?.rootViewController = tabVC
        window?.makeKeyAndVisible()
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "FakeWeather")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

