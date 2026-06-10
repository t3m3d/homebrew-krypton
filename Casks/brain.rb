cask "brain" do
  version "0.10.0"
  sha256 "d041a56abc1e6acabf4fdfa2d51eccb7ae94d36ee190b1254af615194086c688"

  url "https://github.com/t3m3d/brain/releases/download/#{version}/brain-#{version}.dmg"
  name "brain"
  desc "Pure-Krypton macOS IDE (editor, tree, tabs, live highlighting) on the objk FFI"
  homepage "https://krypton-lang.org/programs/brain.html"

  depends_on arch: :arm64

  app "brain.app"

  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "/Applications/brain.app"]
  end
end
