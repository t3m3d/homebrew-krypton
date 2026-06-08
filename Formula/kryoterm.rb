class Kryoterm < Formula
  desc "Pure-Krypton terminal emulator for macOS"
  homepage "https://github.com/t3m3d/kryoterm"
  # Self-contained: a native Mach-O engine (built from Krypton, no runtime krypton
  # dep) + a thin Obj-C/Cocoa window shim. Apple Silicon only.
  url "https://github.com/t3m3d/kryoterm/releases/download/1.1.0/kryoterm-1.1.0-macos-arm64.tar.gz"
  version "1.1.0"
  sha256 "981cc7a2a50c42c7c6fb80ed4b9b2a64d21d2e40304a6cc0de7b01b711a16bfa"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    libexec.install Dir["*"]

    # Ad-hoc sign the arm64 Mach-O binaries so AMFI lets them run.
    %w[kryoterm kryoterm-gui].each do |b|
      f = libexec/b
      system "codesign", "-s", "-", "-f", f.to_s if f.exist?
    end

    # `kryoterm` launches the windowed terminal. The shim takes the engine path
    # as its argument and finds everything else relative to itself.
    (bin/"kryoterm").write <<~SH
      #!/bin/bash
      exec "#{libexec}/kryoterm-gui" "#{libexec}/kryoterm"
    SH
  end

  def caveats
    <<~EOS
      Run the terminal with:
        kryoterm
      A JetBrainsMono Nerd Font is recommended for powerline/icon glyphs
      (configurable in ~/.config/kryoterm/config).
    EOS
  end

  test do
    assert_predicate libexec/"kryoterm", :exist?
    assert_predicate libexec/"kryoterm-gui", :exist?
  end
end
