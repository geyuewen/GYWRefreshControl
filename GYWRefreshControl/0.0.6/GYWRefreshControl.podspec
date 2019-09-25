

Pod::Spec.new do |s|
  s.name             = 'GYWRefreshControl'
  s.version          = '0.0.6'
  s.summary          = '自定义刷新控件'

  s.description      = <<-DESC
TODO: 自定义刷新控件 1231231
                       DESC

  s.homepage         = 'https://github.com/geyuewen/GYWRefreshControl'
  s.license          = 'MIT'
  s.author           = { 'geyuewen' => 'geyuewen1994@126.com' }
  s.source           = { :git => 'https://github.com/geyuewen/GYWRefreshControl.git', :tag => '0.0.6' }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Classes/**/*'
  
  s.resource_bundles = {
    'GYWRefreshControl' => ['Assets/*.png']
  }

  s.dependency 'MJRefresh'
end
