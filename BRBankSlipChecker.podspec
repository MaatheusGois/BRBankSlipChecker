Pod::Spec.new do |s|
  s.name             = 'BRBankSlipChecker'
  s.version          = '0.1.3'
  s.summary          = 'BRBankSlipChecker is a validator for Brazilian bank slips.'
  s.description      = <<-DESC
  BRBankSlipChecker is a validator for Brazilian bank slips.
                       DESC
  s.homepage         = 'https://github.com/maatheusgois/BRBankSlipChecker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'maatheusgois' => 'matheusgoislimasilva@gmail.com' }
  s.source           = { :git => 'https://github.com/maatheusgois/BRBankSlipChecker.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'
  s.source_files = 'Sources/BRBankSlipChecker/**/*'
  s.swift_versions = [5.0]
end
