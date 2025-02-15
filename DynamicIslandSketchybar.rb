class Dynamicislandsketchybar < Formula
  desc "Dynamic Island on iPhone 14 Pro implementation on Mac using Sketchybar"
  homepage "https://github.com/crissNb/Dynamic-Island-Sketchybar"
  url "https://github.com/crissNb/Dynamic-Island-Sketchybar/archive/refs/tags/alpha-05.tar.gz"
  sha256 "1884993a12c3e846619c7eca012e4c031ce352716cfc8a0a05b11e77214c7ae0"

  depends_on "sketchybar"
  depends_on "jq"

  def install
    # Create the necessary directories in /etc
    (etc/"dynamic-island-sketchybar").mkpath

    # Install the files in the /etc/dynamic-island-sketchybar directory
    (etc/"dynamic-island-sketchybar").install "helper.sh"
    (etc/"dynamic-island-sketchybar").install "item.sh"
    (etc/"dynamic-island-sketchybar").install "listener.sh"
    (etc/"dynamic-island-sketchybar").install "process.sh"
    (etc/"dynamic-island-sketchybar").install "sketchybarrc"
    (etc/"dynamic-island-sketchybar").install "scripts"
    (etc/"dynamic-island-sketchybar").install "helper"
    (etc/"dynamic-island-sketchybar").install "userconfigs"

    sketchybar_path = Utils.safe_popen_read("which", "sketchybar").chomp
    bin.install_symlink sketchybar_path => "dynamic-island-sketchybar"

    # Create symlink for sketchybarrc with ALWAYS parameter
    (bin/"dynamic-island").write <<~EOS
      #!/bin/bash
      dynamic-island-sketchybar -c #{etc}/dynamic-island-sketchybar/sketchybarrc
    EOS
  end

  def caveats
    <<~EOS
      Installation complete! To get started:

      Copy an appropriate userconfig file for your machine to userconfig.sh.
      For example, for 2021 MacBook Pro 14 Inch:
      
      cp #{etc}/dynamic-island-sketchybar/userconfigs/mbp2021_14.sh ~/.config/dynamic-island-sketchybar/userconfig.sh

      If the directory does not exist, create it first with:

      mkdir -p ~/.config/dynamic-island-sketchybar

      Then you can run the dynamic island using:
      dynamic-island
    EOS
  end

  test do
    assert_predicate "#{HOMEBREW_PREFIX}/bin/dynamic-island-sketchybar", :exist?
    assert_predicate "#{ENV["HOME"]}/.config/dynamic-island-sketchybar", :directory?
  end
end
