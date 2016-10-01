//
//  UISwitch.swift
//  Rex
//
//  Created by David Rodrigues on 07/04/16.
//  Copyright © 2016 Neil Pankey. All rights reserved.
//

import ReactiveSwift
import UIKit

extension Reactivity where Reactant: UISwitch {
	/// Wraps a switch's `on` value in a bindable property.
	public var isOn: MutablePropertyFacade<Bool> {
		return makePropertyProxy(getter: { $0.isOn }, setter: { $0.isOn = $1 })
	}
}