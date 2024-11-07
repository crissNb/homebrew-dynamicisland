class Dynamicislandsketchybar < Formula
  desc "Dynamic Island on iPhone 14 Pro implementation on Mac using Sketchybar"
  homepage "https://github.com/crissNb/Dynamic-Island-Sketchybar"
  url "https://github.com/crissNb/Dynamic-Island-Sketchybar/archive/refs/tags/alpha-01.tar.gz"
  sha256 "8844e22b3b999574594925ec0a2128d0157aa90385a0d6f2841436d1225a256f"

  depends_on "sketchybar"
  depends_on "jq"

  def install
    # Create config directory and install files
    # real_home = ENV.fetch("HOMEBREW_HOME", Dir.home)
    # config_dir = "#{real_home}/.config/dynamic-island-sketchybar"
    # puts "Creating config directory at #{config_dir}"
    # mkdir_p config_dir
    # cp_r "helper", config_dir
    # cp_r "scripts", config_dir
    # cp_r "userconfigs", config_dir
    # cp "helper.sh", config_dir
    # cp "item.sh", config_dir
    # cp "listener.sh", config_dir
    # cp "process.sh", config_dir
    # cp "sketchybarrc", config_dir

    # Create symlink in the formula's bin directory
    sketchybar_path = Utils.safe_popen_read("which", "sketchybar").chomp
    bin.install_symlink sketchybar_path => "dynamic-island-sketchybar"
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
