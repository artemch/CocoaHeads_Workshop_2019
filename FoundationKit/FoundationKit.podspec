Pod::Spec.new do |s|
  s.name             = 'FoundationKit'
  s.version          = '0.1.0'
  s.summary          = 'This is FoundationKit'

  s.description      = <<-DESC
  This is FoundationKit.
                       DESC

  s.homepage         = 'https://github.com/idapgroup/FoundationKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Artem Chabannyi' => 'atem.chabanniy@idapgroup.com' }
  ## WARNING: incorrect source address
  s.source           = { :git => 'https://github.com/idapgroup/FoundationKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'

  s.source_files = '**/*'

end
