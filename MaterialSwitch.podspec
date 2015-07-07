Pod::Spec.new do |s|
  s.name         = "MaterialSwitch"
  s.version      = "0.1.1"
  s.summary      = "A Material Design implementation of the UISwitch control paradigm."
  s.homepage     = "https://github.com/ArtSabintsev/MaterialSwitch"
  s.license      = "MIT"
  s.authors      = { "Arthur Sabintsev" => "arthur@sabintsev.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/ArtSabintsev/MaterialSwitch.git", :tag => s.version.to_s }
  s.source_files = 'MaterialSwitch.swift'
  s.requires_arc = true

end
