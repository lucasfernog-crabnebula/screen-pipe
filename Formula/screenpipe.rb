class Screenpipe < Formula
  desc "Library to build personalized AI powered by what you've seen, said, or heard."
  homepage "https://github.com/louis030195/screen-pipe"
  url "https://github.com/louis030195/screen-pipe/releases/download/v0.1.61/screenpipe-0.1.61-aarch64-apple-darwin.tar.gz"
  version "0.1.61"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/louis030195/screen-pipe/releases/download/v#{version}/screenpipe-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "75c1d91025a3e67fd0af2efa57e673fac10bd7a2f50b75dc624f476d5603183a" # arm64
    else
      url "https://github.com/louis030195/screen-pipe/releases/download/v#{version}/screenpipe-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "22ce24afea2c806df743469368fa1d78172c64576bb783457d95f699fc416439" # x86_64
    end
  end
  
  depends_on "ffmpeg"
  depends_on "tesseract"

  def install
    bin.install Dir["bin/*"]
    lib.install Dir["lib/*"]
  end

  test do
    system "#{bin}/screenpipe", "-h"
  end
end

# push stuff
# VERSION=0.1.35
# git tag v$VERSION
# git push origin v$VERSION
# wait linux release
# or create release
# gh release create v$VERSION --generate-notes
# then

# aarch64-apple-darwin
=begin
cargo build --release --features metal --target aarch64-apple-darwin
tar -czf screenpipe-${VERSION}-aarch64-apple-darwin.tar.gz -C target/release screenpipe
shasum -a 256 screenpipe-${VERSION}-aarch64-apple-darwin.tar.gz
gh release upload v${VERSION} screenpipe-${VERSION}-aarch64-apple-darwin.tar.gz
rm screenpipe-${VERSION}-aarch64-apple-darwin.tar.gz
=end

# x86_64-apple-darwin
=begin
export PKG_CONFIG_PATH="/usr/local/opt/ffmpeg/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_ALLOW_CROSS=1
cargo build --release --features metal --target x86_64-apple-darwin
tar -czf screenpipe-${VERSION}-x86_64-apple-darwin.tar.gz -C target/release screenpipe
shasum -a 256 screenpipe-${VERSION}-x86_64-apple-darwin.tar.gz
gh release upload v${VERSION} screenpipe-${VERSION}-x86_64-apple-darwin.tar.gz
rm screenpipe-${VERSION}-x86_64-apple-darwin.tar.gz
=end

# update the ruby code above (version and sha256)
=begin
git add Formula/screenpipe.rb
git commit -m "chore: update brew to version ${VERSION}"
git push
=end

# brew tap louis030195/screen-pipe https://github.com/louis030195/screen-pipe.git
# brew install screenpipe

# todo automate this in the future, not urgent for now ..