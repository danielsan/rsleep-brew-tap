class Rsleep < Formula
  desc "A prettier version of the sleep command that shows you something is going on"
  homepage "https://github.com/danielsan/rsleep"
  license "MIT"
  version "0.1.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/danielsan/rsleep/releases/download/v0.1.0/rsleep-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "0a54397a2dc63586e4e287f2b408b6b09039db66b45d01c869c38f57110c25a0"
    else
      url "https://github.com/danielsan/rsleep/releases/download/v0.1.0/rsleep-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "cdaf03d139071a88c827a1ba94aae9436e0dbcb928de69a7bac18bc39476c751"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/danielsan/rsleep/releases/download/v0.1.0/rsleep-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4c96c8af14eb814259e6c4df8a4448cc96eaf82281dc7a848041030a21273ea9"
    end
  end

  def install
    bin.install "rsleep"
  end

  test do
    # Test that the binary exists and can be executed
    assert_match "rsleep", shell_output("#{bin}/rsleep --help")
    
    # Test that the binary runs without errors for a very short sleep
    system "#{bin}/rsleep", "0.1"
  end

  def caveats
    <<~EOS
      rsleep is a prettier version of the sleep command.
      Usage: rsleep <duration>
      Example: rsleep 5s
    EOS
  end

  livecheck do
    url :stable
    strategy :github_latest
  end
end