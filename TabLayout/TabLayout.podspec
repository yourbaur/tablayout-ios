Pod::Spec.new do |spec|

  spec.name         = "TabLayout"
  spec.version      = "0.0.1"
  spec.summary      = "A CocoaPods library written in Swift"

  spec.description  = <<-DESC
This CocoaPods library helps you perform calculation.
                   DESC

  spec.homepage     = "https://github.com/yourbaur/tablayout-ios.git"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "jeantimex" => "taimanovb@gmail.com" }

  spec.ios.deployment_target = "12.1"
  spec.swift_version = "4.2"

  spec.source        = { :git => "https://github.com/yourbaur/tablayout-ios.git", :tag => "#{spec.version}" }
  spec.source_files  = "**/*.{h,m,swift}"

end