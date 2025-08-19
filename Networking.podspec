Pod::Spec.new do |s|
  s.name             = 'Networking'
  s.version          = '0.1.3'
  s.summary          = 'Camada de rede do app.'
  s.homepage         = 'https://github.com/suaorg/Networking'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Thiago' => 'email@suaempresa.com' }
  s.source           = { :git => 'git@github.com:thiagoSouza-CE/EmperorGameNetwokingModule.git', :tag => s.version.to_s }
  s.ios.deployment_target = '14.0'
  s.source_files     = 'Sources/**/*.{swift,h,m}'
end
