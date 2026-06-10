cask "stem" do
  version "0.2.0"
  sha256 "500a5a898f176208481c7bb58c1b7f2872ffd08c60278c9b47025b461883e959"

  url "https://github.com/t3m3d/stem/releases/download/#{version}/stem-#{version}-macos.app.zip"
  name "stem"
  desc "Pure-Krypton terminal (zsh, p10k, true color) on the objk FFI"
  homepage "https://github.com/t3m3d/stem"

  depends_on arch: :arm64

  app "stem.app"

  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "/Applications/stem.app"]
  end

  caveats <<~CAV
    stem.app is ad-hoc signed (not notarized). The installer strips the quarantine
    flag so it launches directly. If macOS still blocks it: System Settings ->
    Privacy & Security -> "Open Anyway", or:
      xattr -dr com.apple.quarantine "/Applications/stem.app"
  CAV
end
