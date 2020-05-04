//
//  LoggedViewController.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 03/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import UIKit

class LoggedViewController: UIViewController {

    // MARK: - Instance Properties

    private(set) final var isViewAppeared = false

    // MARK: - Initializers

    deinit {
        Log.high("deinit", from: self)
    }

    // MARK: - Instance Methods

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        Log.high("didReceiveMemoryWarning()", from: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        Log.high("viewDidLoad()", from: self)

        self.isViewAppeared = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        Log.high("viewWillAppear()", from: self)

        self.isViewAppeared = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        Log.high("viewDidAppear()", from: self)

        self.isViewAppeared = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        Log.high("viewWillDisappear()", from: self)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        Log.high("viewDidDisappear()", from: self)

        self.isViewAppeared = false
    }

    // MARK: -

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        Log.high("prepare(for: \(String(describing: segue.identifier)))", from: self)
    }
}
