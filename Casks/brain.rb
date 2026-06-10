cask "brain" do
  version "0.9.2"
  sha256 "8f7a784b6b7e06d29ef0dcb4300286e666a3273f316887d5e47204f313e13ae0"

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
