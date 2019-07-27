Pod::Spec.new do |s|
  s.name             = 'UIKitLib'
  s.version          = '0.1.4'
  s.summary          = 'This is UIKitLib'

  s.description      = <<-DESC
  This is FoundationKit.
                       DESC

  s.homepage         = 'https://github.com/idapgroup/uikitlib'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Artem Chabannyi' => 'atem.chabanniy@idapgroup.com' }
  ## WARNING: incorrect source address
  s.source           = { :git => 'https://github.com/idapgroup/uikitlib.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'

  s.source_files = '**/*'

end
