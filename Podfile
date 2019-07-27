# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def reactiveSwift
    pod 'ReactiveSwift', '~> 4.0'
end

def reactiveCocoa
    pod 'ReactiveCocoa', '~> 8.0'
end

def ui
    reactiveCocoa
    pod 'JTAppleCalendar', '~> 7.0'
    pod 'IDPRootViewGettable', :git => 'https://github.com/idapgroup/IDPRootViewGettable.git', :commit => '4cd3852'
    pod 'MZFormSheetPresentationController'
    uiKitLib
    pod 'Nuke', '~> 7.5.2'
    pod 'IQKeyboardManager', '~> 6'
    pod 'IDPDesign', :git => 'https://github.com/idapgroup/IDPDesign.git'
    pod 'SnapKit', '~> 4.2.0'
    pod 'Toucan', '~> 1.1.0'
    fabric
end

def alamofire
    pod 'Alamofire', '~> 4.8.1'
end

def alamofireReactive
    pod 'AlamofireReactive', :path => 'AlamofireReactive/'
end

def uiKitLib
    pod 'UIKitLib', :path => 'UIKitLib/'
end

def foundationKit
    pod 'FoundationKit', :path => 'FoundationKit/'
end

def reactiveSwiftKit
    pod 'ReactiveSwiftKit', :path => 'ReactiveSwiftKit/'
end

def reactiveCocoaKit
    pod 'ReactiveCocoaKit', :path => 'ReactiveCocoaKit/'
end

def googleSignIn
    pod 'GoogleSignIn', '~> 4.0'
end

def result
    pod 'Result', '~> 4.0'
end

def sourcery
    pod 'Sourcery'
end

def fabric
    pod 'Fabric'
    pod 'Crashlytics'
end

def swiftGen
    pod 'SwiftGen', '~> 6.0'
end

target 'Workshop_2019' do
    use_frameworks!
    reactiveSwift
    ui
    foundationKit
    reactiveSwiftKit
    result
    swiftGen
end

target 'StorageServices' do
    use_frameworks!
    reactiveSwift
    pod 'RealmSwift', '~> 3.0'
    foundationKit
    pod 'Valet', '~> 3.0'
end

target 'Services' do
    use_frameworks!
    reactiveSwift
end

target 'BackendServices' do
    use_frameworks!
    reactiveSwift
    alamofire
    alamofireReactive
    reactiveSwiftKit
    foundationKit
end

target 'GoogleSignInProvider' do
    use_frameworks!
    googleSignIn
    reactiveSwift
end

target 'Validators' do
    use_frameworks!
    result
    reactiveSwift
end

target 'PresentationModels' do
    use_frameworks!
    reactiveSwift
    reactiveCocoa
    reactiveSwiftKit
    sourcery
    foundationKit
end

target 'Stores' do
    use_frameworks!
    reactiveSwift
    reactiveSwiftKit
    foundationKit
    sourcery
end

target 'SharedLocalization' do
    use_frameworks!
    swiftGen
end
