Pod::Spec.new do |s|
  s.name             = 'ReactiveCocoaKit'
  s.version          = '0.1.0'
  s.summary          = 'This is ReactiveCocoaKit'

  s.description      = <<-DESC
  This is ReactiveCocoaKit.
                       DESC

  s.homepage         = 'https://github.com/idapgroup/ReactiveCocoaKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Artem Chabannyi' => 'atem.chabanniy@idapgroup.com' }
  ## WARNING: incorrect source address
  s.source           = { :git => 'https://github.com/idapgroup/ReactiveCocoaKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'

  s.source_files = '**/*'

  s.dependency 'ReactiveCocoa', '~> 8.0'
end
