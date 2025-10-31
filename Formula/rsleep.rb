class Rsleep < Formula
  desc "A prettier version of the sleep command that shows you something is going on"
  homepage "https://github.com/danielsan/rsleep"
  license "MIT"

  # Automation will replace these placeholder URLs and sha256 values on release.
  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/danielsan/rsleep/releases/download/v0.0.0/rsleep-v0.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "REPLACE_WITH_SHA256_X86_64_DARWIN"
    else
      url "https://github.com/danielsan/rsleep/releases/download/v0.0.0/rsleep-v0.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "REPLACE_WITH_SHA256_ARM64_DARWIN"
    end

    def install
      bin.install "rsleep"
    end
  end

  on_linux do
    url "https://github.com/danielsan/rsleep/releases/download/v0.0.0/rsleep-v0.0.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "REPLACE_WITH_SHA256_X86_64_LINUX"

    def install
      bin.install "rsleep"
    end
  end

  test do
    assert_match "rsleep", shell_output("#{bin}/rsleep --help")
  end
end