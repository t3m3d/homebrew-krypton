class Krypton < Formula
  desc "Krypton programming language compiler and toolchain"
  homepage "https://github.com/t3m3d/krypton"
  version "2.1.1"
  license "MIT"

  on_arm do
    # 2.1.1: stdlib + headers + kcc-arm64 + kcc.sh + bootstrap, tarball.
    # Bumped from 2.0.0 to ship the KRYPTON_ROOT install fix + UTF-8
    # fromCharCode fix + the actual stdlib (the 2.0.0 tarball shipped
    # without stdlib/ and forced users into the C:\krypton workaround).
    url "https://github.com/t3m3d/krypton/releases/download/2.1.1/krypton-2.1.1-macos-arm64.tar.gz"
    sha256 "87744b8d998c86bd32ae9e592ae5817ac34b509c0df090b1a7a634b0fe0cf871"
  end

  def install
    libexec.install Dir["*"]

    # kcc and kcc.sh resolve symlinks to find their sibling files in libexec,
    # so symlinking them into bin is enough — headers, compiler, bootstrap,
    # stdlib all stay in libexec and are found via KRYPTON_ROOT (set by kcc.sh
    # from $SCRIPT_DIR; see compile.k 2.1.1 changes).
    # kcc.sh is the full pipeline driver — symlink it as kcc (no .sh)
    # so users run `kcc file.k` like any real compiler.
    bin.install_symlink libexec/"kcc.sh" => "kcc"

    # krypton alias matches the Chocolatey package name on Windows
    bin.install_symlink libexec/"kcc.sh" => "krypton"

    # 2.1.1: kweb is Windows-only this release. Mac port of stdlib/fs.k
    # required first (it has ungated FindFirstFileA / WIN32_FIND_DATAA
    # calls that don't compile under clang). Deferred to 2.1.2.
    if (libexec/"web/kweb").exist?
      bin.install_symlink libexec/"web/kweb" => "kweb"
    end
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
