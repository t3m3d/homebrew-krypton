cask "kryoterm" do
  version "1.5.0"
  sha256 "d27bdd87ebc8d1c9c2f5da7f0b4449f4ad757e650e19a94c776033c6e5f3a648"

  url "https://github.com/t3m3d/kryoterm/releases/download/#{version}/kryoterm-#{version}-macos.app.zip"
  name "kryoterm"
  desc "Pure-Krypton terminal emulator (clickable .app)"
  homepage "https://github.com/t3m3d/kryoterm"

  depends_on arch: :arm64

  app "kryoterm.app"

  # Ad-hoc signed (not notarized) -> on macOS Sequoia/Tahoe the Gatekeeper popup
  # has no "Open" button. Strip the quarantine flag on install so it just launches.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/kryoterm.app"]
  end

  caveats <<~EOS
    kryoterm.app is ad-hoc signed (not notarized). The installer strips the
    quarantine flag so it launches directly. If macOS still blocks it:
    System Settings -> Privacy & Security -> "Open Anyway", or run:
      xattr -dr com.apple.quarantine "/Applications/kryoterm.app"
  EOS
end
