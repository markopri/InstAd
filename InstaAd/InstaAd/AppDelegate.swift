//
//  AppDelegate.swift
//  InstaAd
//
//  Created by Marko Koprivnjak on 26/10/2017.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //Use Firebase library to configure APIs
        FirebaseApp.configure();

        window = UIWindow(frame: UIScreen.main.bounds);
        window?.makeKeyAndVisible();

        //tab bar navigation controllers
        if (Auth.auth().currentUser == nil)
        {
            let navigationControllerHome = UINavigationController();
            let homeViewController = IAHomeViewController();
            navigationControllerHome.viewControllers = [homeViewController];
            navigationControllerHome.tabBarItem = UITabBarItem(title: "Home", image: UIImage (named: "instaAd_home"), selectedImage: nil);

            let navigationControllerFavourites = UINavigationController();
            let favouritesViewController = IAFavouritesViewController();
            navigationControllerFavourites.viewControllers = [favouritesViewController];
            navigationControllerFavourites.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage (named: "instaAd_favourites"), selectedImage: nil);

            let navigationControllerSettings = UINavigationController();
            let settingsViewController = IASettingsViewController();
            navigationControllerSettings.viewControllers = [settingsViewController];
            navigationControllerSettings.tabBarItem = UITabBarItem(title: "Settings", image: UIImage (named: "instaAd_settings"), selectedImage: nil);

            let tabBar = UITabBarController();
            tabBar.viewControllers = [navigationControllerHome, navigationControllerFavourites, navigationControllerSettings];
            window?.rootViewController = tabBar;
        }
        else
        {
            window?.rootViewController = IALoginViewController();
        }

        return true
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
    }


}

