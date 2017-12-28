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
        showNavigation(action : "launchingApplication");

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

    func showNavigation(action : String) -> Void {
        window = UIWindow(frame: UIScreen.main.bounds);
        window?.makeKeyAndVisible();

        //tab bar navigation controllers
        if (Auth.auth().currentUser != nil)
        {
            let navigationControllerHome = UINavigationController();
            let homeViewController = IAHomeViewController();
            homeViewController.title = "InstaAd";
            navigationControllerHome.viewControllers = [homeViewController];
            navigationControllerHome.navigationBar.isTranslucent = false;
            navigationControllerHome.tabBarItem = UITabBarItem(title: "Home", image: UIImage (named: "instaAd_home"), selectedImage: nil);

            let navigationControllerFavourites = UINavigationController();
            let favouritesViewController = IAFavouritesViewController();
            favouritesViewController.title = "Favourites";
            navigationControllerFavourites.viewControllers = [favouritesViewController];
            navigationControllerFavourites.navigationBar.isTranslucent = false;
            navigationControllerFavourites.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage (named: "instaAd_favourites"), selectedImage: nil);

            let navigationControllerPlaces = UINavigationController();
            let placesViewController = IAPlacesViewController();
            placesViewController.title = "Places";
            navigationControllerPlaces.viewControllers = [placesViewController];
            navigationControllerPlaces.navigationBar.isTranslucent = false;
            navigationControllerPlaces.tabBarItem = UITabBarItem(title: "Places", image: UIImage (named: "instaAd_places"), selectedImage: nil);

            let navigationControllerSettings = UINavigationController();
            let settingsViewController = IASettingsViewController();
            settingsViewController.title = "Settings";
            navigationControllerSettings.viewControllers = [settingsViewController];
            navigationControllerSettings.navigationBar.isTranslucent = false;
            navigationControllerSettings.tabBarItem = UITabBarItem(title: "Settings", image: UIImage (named: "instaAd_settings"), selectedImage: nil);

            let navigationControllerAbout = UINavigationController();
            let aboutViewController = IAAboutViewController();
            aboutViewController.title = "About";
            navigationControllerAbout.viewControllers = [aboutViewController];
            navigationControllerAbout.navigationBar.isTranslucent = false;
            navigationControllerAbout.tabBarItem = UITabBarItem (title: "About", image: UIImage (named: "instaAd_about"), selectedImage: nil);

            let tabBar = UITabBarController();
            tabBar.tabBar.isTranslucent = false;
            tabBar.tabBar.barStyle = UIBarStyle.black;
            tabBar.viewControllers = [navigationControllerHome, navigationControllerFavourites, navigationControllerPlaces, navigationControllerSettings, navigationControllerAbout];
            window?.rootViewController = tabBar;
        }
        else if (action == "skip")
        {
            let navigationControllerHome = UINavigationController();
            let homeViewController = IAHomeViewController();
            homeViewController.title = "InstaAd";
            navigationControllerHome.viewControllers = [homeViewController];
            navigationControllerHome.navigationBar.isTranslucent = false;
            navigationControllerHome.tabBarItem = UITabBarItem(title: "Home", image: UIImage (named: "instaAd_home"), selectedImage: nil);

            let tabBar = UITabBarController();
            tabBar.tabBar.isTranslucent = false;
            tabBar.tabBar.barStyle = UIBarStyle.black;
            tabBar.viewControllers = [navigationControllerHome];
            window?.rootViewController = tabBar;
        }
        else
        {
            window?.rootViewController = IALoginViewController();
        }
    }
}

