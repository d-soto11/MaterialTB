Pod::Spec.new do |s|

  s.name         = "MaterialTB"
  s.version      = "0.6.0"
  s.summary      = "Material Design TabBar made in Swift with beautiful animations."
  s.requires_arc = true

  s.description  = <<-DESC
iOS 11 has introduced TabBars into many of their apps, this style of navigation is becomming more and more popular nowadays. Still, iOS native TabBar can be a little dull if compared to Material Design. This Pod is meant to make your Tabbars look really cool and support Material Design's focus animations.
                   DESC

  s.homepage     = "https://github.com/d-soto11/MaterialTB"
  s.screenshots  = "https://i.imgflip.com/1wllsm.gif", "https://i.imgflip.com/1wlkxn.gif"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Daniel Soto" => "soto@tresastronautas.com" }
  # Or just: s.author    = "Daniel Soto"
  # s.authors            = { "Daniel Soto" => "d.soto11@uniandes.edu.co" }
  # s.social_media_url   = "https://www.linkedin.com/in/dansotorey/"

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/d-soto11/MaterialTB.git", :tag => "#{s.version}" }

  s.source_files  = "MaterialTapBar", "MaterialTapBar/**/*.{swift}"

# s.resources = "MaterialTapBar/*.png"
end
