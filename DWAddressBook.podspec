Pod::Spec.new do |s|
  s.name         = "DWAddressBook"
  s.version      = "0.0.1"
  s.summary      = "DWAddressBook."
  s.description  = <<-DESC
                    适用于iphone端的通讯录，最低适配iOS8.0
                   DESC

  s.homepage     = "https://github.com/CoderDwang/DWAddressBook"
  s.license      = "MIT"
  s.author             = { "CoderDwang" => "dwang.hello@outlook.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/CoderDwang/DWAddressBook.git", :tag => s.version.to_s }
  s.source_files  = "DWAddressBook", "DWAddressBook/**/*.{h,m}"
  s.exclude_files = "DWAddressBook/defult.png"
  s.frameworks = "AddressBook", "Foundation", "UIKit"

end
