class Krypton < Formula
  desc "Krypton programming language compiler and toolchain"
  homepage "https://github.com/t3m3d/krypton"
  version "2.0.0"
  license "MIT"

  on_arm do
    url "https://github.com/t3m3d/krypton/releases/download/2.0.0/krypton-2.0.0-macos-arm64.tar.gz"
    sha256 "f47ecd4e7d5572ea23eb73e9ca4e9e986daaef84d37e925a1c7485cbd393cf61"
  end

  def install
    libexec.install Dir["*"]

    # kcc and kcc.sh resolve symlinks to find their sibling files in libexec,
    # so symlinking them into bin is enough — headers, compiler, bootstrap all
    # stay in libexec and are found automatically.
    # kcc.sh is the full pipeline driver — symlink it as kcc (no .sh)
    # so users run `kcc file.k` like any real compiler.
    # The internal kcc dispatcher stays in libexec and is found via SCRIPT_DIR.
    bin.install_symlink libexec/"kcc.sh" => "kcc"

    # krypton alias matches the Chocolatey package name on Windows
    bin.install_symlink libexec/"kcc.sh" => "krypton"
  end

  test do
    (testpath/"hello.k").write <<~KRYPTON
      just run {
        kp("hello from krypton")
      }
    KRYPTON
    output = shell_output("#{bin}/kcc #{testpath}/hello.k -o #{testpath}/hello && #{testpath}/hello")
    assert_includes output, "hello from krypton"
  end
end
