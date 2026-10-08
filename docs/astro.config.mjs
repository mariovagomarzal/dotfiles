import { shikiThemes } from "@mariovagomarzal/lattice/palette/shiki";
import { defineConfig, fontProviders } from "astro/config";

export default defineConfig({
  site: "https://dotfiles.mariovagomarzal.com",
  markdown: {
    shikiConfig: {
      themes: { light: shikiThemes.light, dark: shikiThemes.dark },
      defaultColor: false,
    },
  },
  fonts: [
    {
      provider: fontProviders.fontsource(),
      name: "Space Grotesk",
      cssVariable: "--font-sans",
      weights: [400, 500, 700],
      fallbacks: ["system-ui", "sans-serif"],
    },
    {
      provider: fontProviders.fontsource(),
      name: "Space Mono",
      cssVariable: "--font-mono",
      weights: [400, 700],
      fallbacks: ["ui-monospace", "monospace"],
    },
  ],
});
