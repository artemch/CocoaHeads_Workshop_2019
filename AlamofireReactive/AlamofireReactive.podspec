Pod::Spec.new do |s|
  s.name             = 'AlamofireReactive'
  s.version          = '0.1.0'
  s.summary          = 'This is AlamofireReactive'

  s.description      = <<-DESC
  This is FoundationKit.
                       DESC

  s.homepage         = 'https://github.com/idapgroup/alamofireReactive'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Artem Chabannyi' => 'atem.chabanniy@idapgroup.com' }
  ## WARNING: incorrect source address
  s.source           = { :git => 'https://github.com/idapgroup/alamofireReactive.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'

  s.source_files = '**/*'

  s.dependency 'ReactiveSwift', '~> 4.0'
  s.dependency 'Alamofire', '~> 4.8.1'
end
