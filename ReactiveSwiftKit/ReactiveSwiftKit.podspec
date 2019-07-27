Pod::Spec.new do |s|
  s.name             = 'ReactiveSwiftKit'
  s.version          = '0.1.3'
  s.summary          = 'This is ReactiveSwiftKit'

  s.description      = <<-DESC
  This is ReactiveSwiftKit.
                       DESC

  s.homepage         = 'https://github.com/idapgroup/ReactiveSwiftKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Artem Chabannyi' => 'atem.chabanniy@idapgroup.com' }
  ## WARNING: incorrect source address
  s.source           = { :git => 'https://github.com/idapgroup/ReactiveSwiftKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'

  s.source_files = '**/*'

  s.dependency 'ReactiveSwift', '~> 4.0'
end
