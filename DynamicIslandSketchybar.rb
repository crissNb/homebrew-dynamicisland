class Dynamicislandsketchybar < Formula
  desc "Dynamic Island on iPhone 14 Pro implementation on Mac using Sketchybar"
  homepage "https://github.com/crissNb/Dynamic-Island-Sketchybar"
  url "https://github.com/crissNb/Dynamic-Island-Sketchybar/archive/refs/tags/alpha-01.tar.gz"
  sha256 "8844e22b3b999574594925ec0a2128d0157aa90385a0d6f2841436d1225a256f"

  depends_on "sketchybar"
  depends_on "jq"
  depends_on "cava" => :recommended
  depends_on "sf-symbols" => :cask
  depends_on "background-music" => :cask

  def install
    # Create symlink for sketchybar
    sketchybar_bin = Utils.safe_popen_read("which", "sketchybar").chomp
    system "ln", "-sf", sketchybar_bin, "#{HOMEBREW_PREFIX}/bin/dynamic-island-sketchybar"

    # Create config directory and install files
    config_dir = "#{ENV["HOME"]}/.config/dynamic-island-sketchybar"
    system "mkdir", "-p", config_dir
    system "cp", "-r", ".", config_dir
  end

  def caveats
    <<~EOS
      Installation complete! To get started:

      Copy an appropriate userconfig file for your machine to userconfig.sh.
      For example, for 2021 MacBook Pro 14 Inch:
      
      cp ~/.config/dynamic-island-sketchybar/userconfigs/mbp2021_14.sh ~/.config/dynamic-island-sketchybar/userconfig.sh

      Then you can run the dynamic island using:
      dynamic-island-sketchybar
    EOS
  end

  test do
    assert_predicate "#{HOMEBREW_PREFIX}/bin/dynamic-island-sketchybar", :exist?
    assert_predicate "#{ENV["HOME"]}/.config/dynamic-island-sketchybar", :directory?
  end
end
