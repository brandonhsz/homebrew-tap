cask "topotools" do
  version "1.0.0"
  sha256 "9229b49aa21c721bf2975b275d5f4d5c7c86e53b2f54093810ec1f5a69301dea"

  url "https://github.com/brandonhsz/swift-base-claude-tools/releases/download/v#{version}/TopoTools-#{version}.dmg",
      verified: "github.com/brandonhsz/swift-base-claude-tools/"
  name "TopoTools"
  desc "Menu bar app with Claude token usage and modular tools"
  homepage "https://github.com/brandonhsz/swift-base-claude-tools"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "TopoTools.app"

  # La app está firmada ad-hoc pero NO notarizada. Sin quitar el atributo de
  # quarantine, Gatekeeper la bloquea al abrir.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/TopoTools.app"]
  end

  zap trash: [
    "~/Library/Application Support/TopoTools",
    "~/Library/Caches/com.topotools.TopoTools",
    "~/Library/Preferences/com.topotools.TopoTools.plist",
    "~/Library/Saved Application State/com.topotools.TopoTools.savedState",
  ]

  caveats <<~EOS
    TopoTools no está notarizada por Apple. Este cask quita el atributo de
    quarantine tras instalar para que la app pueda abrir. Si prefieres no
    delegar eso, instala el .dmg manualmente y autoriza la app en
    Ajustes del Sistema → Privacidad y seguridad.
  EOS
end
