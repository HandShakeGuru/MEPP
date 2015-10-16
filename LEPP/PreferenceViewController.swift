//
//  PreferenceViewController.swift
//  MEPP
//
//  Created by Garet McKinley on 10/16/15.
//  Copyright © 2015 Garet McKinley. All rights reserved.
//

import Cocoa


class PreferenceViewController: NSViewController {

    @IBOutlet weak var nginxPathField: NSTextField!
    @IBOutlet weak var phpPathField: NSTextField!
    @IBOutlet weak var psqlPathField: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        nginxPathField.stringValue = defaults.objectForKey("nginx")! as! String
        phpPathField.stringValue = defaults.objectForKey("php-fpm")! as! String
        psqlPathField.stringValue = defaults.objectForKey("psql")! as! String
    }
    
    @IBAction func saveNginx(sender: AnyObject) {
        defaults.setObject(nginxPathField.stringValue, forKey: "nginx")
    }
    @IBAction func savePHP(sender: AnyObject) {
        defaults.setObject(phpPathField.stringValue, forKey: "php-fpm")
    }
    @IBAction func savePsql(sender: AnyObject) {
        defaults.setObject(psqlPathField.stringValue, forKey: "postgresql")
    }
}
