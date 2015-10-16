//
//  ViewController.swift
//  LEPP
//
//  Created by Garet McKinley on 10/15/15.
//  Copyright © 2015 Garet McKinley. All rights reserved.
//

import Cocoa
import Foundation

func shell(args: String...) -> String {
    let task = NSTask()
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    let pipe = NSPipe()
    task.standardOutput = pipe
    task.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output: String = NSString(data: data, encoding: NSUTF8StringEncoding) as! String

    return output
}

func nginxIsRunning() -> Bool {
    let out = shell("ps", "aux")
    if "nginx" >|< out {
        return true
    }
    return false
}

func phpIsRunning() -> Bool {
    let out = shell("ps", "aux")
    if "php-fpm" >|< out {
        return true
    }
    return false
}

func psqlIsRunning() -> Bool {
    let out = shell("ps", "aux")
    if "postgresql" >|< out {
        return true
    }
    return false
}


class ViewController: NSViewController {

    @IBOutlet weak var nginxStatus: NSLevelIndicator!
    @IBOutlet weak var phpStatus: NSLevelIndicator!
    @IBOutlet weak var psqlStatus: NSLevelIndicator!
    
    @IBOutlet weak var startNginxButton: NSButton!
    @IBOutlet weak var stopNginxButton: NSButton!
    @IBOutlet weak var restartNginxButton: NSButton!
    
    @IBOutlet weak var startPHPButton: NSButton!
    @IBOutlet weak var stopPHPButton: NSButton!
    @IBOutlet weak var restartPHPButton: NSButton!
    
    @IBOutlet weak var startPsqlButton: NSButton!
    @IBOutlet weak var stopPsqlButton: NSButton!
    @IBOutlet weak var restartPsqlButton: NSButton!
    
    func refreshStatuses() {
        if nginxIsRunning() {
            nginxStatus.intValue = 3
            startNginxButton.enabled = false
            stopNginxButton.enabled = true
            restartNginxButton.enabled = true
        } else {
            nginxStatus.intValue = 1
            startNginxButton.enabled = true
            stopNginxButton.enabled = false
            restartNginxButton.enabled = false
        }
        if phpIsRunning() {
            phpStatus.intValue = 3
            startPHPButton.enabled = false
            stopPHPButton.enabled = true
            restartPHPButton.enabled = true
        } else {
            phpStatus.intValue = 1
            startPHPButton.enabled = true
            stopPHPButton.enabled = false
            restartPHPButton.enabled = false
        }
        if psqlIsRunning() {
            psqlStatus.intValue = 3
            startPsqlButton.enabled = false
            stopPsqlButton.enabled = true
            restartPsqlButton.enabled = true
        } else {
            psqlStatus.intValue = 1
            startPsqlButton.enabled = true
            stopPsqlButton.enabled = false
            restartPsqlButton.enabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshStatuses()
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    @IBAction func startNginx(sender: AnyObject) {
        NSAppleScript(source: "do shell script \"sudo /usr/local/bin/nginx\" with administrator " +
            "privileges")!.executeAndReturnError(nil)
        refreshStatuses()
    }

    @IBAction func stopNginx(sender: AnyObject) {
        NSAppleScript(source: "do shell script \"sudo /usr/local/bin/nginx -s stop\" with administrator " +
            "privileges")!.executeAndReturnError(nil)
        refreshStatuses()
    }
    @IBAction func restartNginx(sender: AnyObject) {
        NSAppleScript(source: "do shell script \"sudo /usr/local/bin/nginx -s stop && sudo /usr/local/bin/nginx\" with administrator " +
            "privileges")!.executeAndReturnError(nil)
        refreshStatuses()
    }
    @IBAction func startPHP(sender: AnyObject) {
        NSAppleScript(source: "do shell script \"launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.php55.plist\"")!.executeAndReturnError(nil)
        refreshStatuses()
    }
    @IBAction func stopPHP(sender: AnyObject) {
        NSAppleScript(source: "do shell script \"launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.php55.plist\"")!.executeAndReturnError(nil)
        refreshStatuses()
    }
    @IBAction func restartPHP(sender: AnyObject) {
        NSAppleScript(source: "do shell script \"launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.php55.plist && launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.php55.plist\"")!.executeAndReturnError(nil)
        refreshStatuses()
    }
}

