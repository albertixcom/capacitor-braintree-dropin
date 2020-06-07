
  Pod::Spec.new do |s|
    s.name = 'CapacitorBraintree'
    s.version = '0.0.1'
    s.summary = 'A Capacitor plugin for the Braintree mobile payment processing SDK'
    s.license = 'MIT'
    s.homepage = 'https://github.com/sumbria/capacitor-braintree'
    s.author = 'Balbinder Sumbria'
    s.source = { :git => 'https://github.com/sumbria/capacitor-braintree', :tag => s.version.to_s }
    s.source_files = 'ios/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}'
    s.ios.deployment_target  = '11.0'
    s.dependency 'Capacitor'
    s.dependency 'Braintree'
    s.dependency 'BraintreeDropIn'
    s.dependency 'Braintree/PayPal'
    s.dependency 'Braintree/Apple-Pay'
    s.dependency 'Braintree/Venmo'
  end
