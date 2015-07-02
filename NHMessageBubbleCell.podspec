#
# Be sure to run `pod lib lint NHMessageBubbleCell.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "NHMessageBubbleCell"
  s.version          = "0.5.0"
  s.summary          = "Custom table view cell for displaying message bubbles"
#s.description      = <<-DESC
#                       An optional longer description of NHMessageBubbleCell
#
#                       * Markdown format.
#                       * Don't worry about the indent, we strip it!
#                       DESC
  s.homepage         = "https://github.com/naithar/NHMessageBubbleCell"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Naithar" => "devias.naith@gmail.com" }
  s.source           = { :git => "https://github.com/naithar/NHMessageBubbleCell.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/naithar'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resources = ['Pod/Assets/*']
end
