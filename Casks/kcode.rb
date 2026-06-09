cask "kcode" do
  version "0.3.0"
  sha256 "e5a980c763e395f22aaa418ba720a37da556d5d329645ac2db6dd346c1a2b01b"

  url "https://github.com/t3m3d/kcode/releases/download/#{version}/kcode-#{version}-macos.app.zip"
  name "kcode"
  desc "Native macOS IDE for Krypton + 80+ languages"
  homepage "https://github.com/t3m3d/kcode"

  depends_on arch: :arm64

  app "kcode.app"

  # ad-hoc signed (not notarized) -> strip quarantine so it launches on Tahoe
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "/Applications/kcode.app"]
  end

  caveats <<~CAV
    kcode.app is ad-hoc signed (not notarized). The installer strips the quarantine
    flag so it launches directly. If macOS still blocks it: System Settings ->
    Privacy & Security -> "Open Anyway", or:
      xattr -dr com.apple.quarantine "/Applications/kcode.app"
  CAV
end
