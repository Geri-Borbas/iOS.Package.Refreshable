//
//  RefreshModifier.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 14/03/2022.
//

import SwiftUI
import Introspect


extension UIScrollView {
	
	private struct Keys {
		static var onValueChanged: UInt8 = 0
	}
	
	typealias ValueChangedAction = ((_ refreshControl: UIRefreshControl) -> Void)
	
	private var onValueChanged: ValueChangedAction? {
		get {
			objc_getAssociatedObject(self, &Keys.onValueChanged) as? ValueChangedAction
		}
		set {
			objc_setAssociatedObject(self, &Keys.onValueChanged, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
	
	func onRefresh(_ onValueChanged: @escaping ValueChangedAction) {
		if refreshControl == nil {
			let refreshControl = UIRefreshControl()
			refreshControl.addTarget(
				   self,
				   action: #selector(self.onValueChangedAction),
				   for: .valueChanged
			   )
			self.refreshControl = refreshControl
		}
		self.onValueChanged = onValueChanged
	}
	
	@objc private func onValueChangedAction(sender: UIRefreshControl) {
		self.onValueChanged?(sender)
	}
}


struct OnListRefreshModifier: ViewModifier {
	
	let onValueChanged: UIScrollView.ValueChangedAction
	
	func body(content: Content) -> some View {
		content
			.introspectTableView { tableView in
				tableView.onRefresh(onValueChanged)
			}
	}
}


extension View {
	
	func onRefresh(onValueChanged: @escaping UIScrollView.ValueChangedAction) -> some View {
		self.modifier(OnListRefreshModifier(onValueChanged: onValueChanged))
	}
}
