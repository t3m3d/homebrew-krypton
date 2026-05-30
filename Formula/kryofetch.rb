class Kryofetch < Formula
  desc "System fetch tool for macOS and Linux, built with the Krypton language"
  homepage "https://github.com/t3m3d/kryofetch"
  version "1.3.7"
  license "MIT"

  # CLI binary -> Formula (NOT a Cask: Homebrew Cask is macOS-only, so a cask
  # would drop Linux entirely). on_macos/on_linux pick the right native build.
  on_macos do
    on_arm do
      url "https://github.com/t3m3d/kryofetch/releases/download/v1.3.7/kryofetch-1.3.7-macos-arm64.tar.gz"
      sha256 "398c88f19665d935a4697af55ba3ebcfa86d4666d4c61fd78825dfd4b4cbe93d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/t3m3d/kryofetch/releases/download/v1.3.7/kryofetch-1.3.7-linux-x86_64.tar.gz"
      sha256 "14e392a0e96f8d60042dc899f9c17b27d4d4229f9e4bad803d877211f5a49594"
    end
  end

  def install
    bin.install "kryofetch"
    # macOS ad-hoc codesign so Gatekeeper runs the unsigned native binary.
    # The Linux build is a static syscall-only ELF — nothing to sign.
    system "codesign", "-s", "-", "-f", "#{bin}/kryofetch" if OS.mac?
  end

  test do
    output = shell_output("#{bin}/kryofetch 2>&1 || true")
    assert_includes output, "KryoFetch"
  end
end
