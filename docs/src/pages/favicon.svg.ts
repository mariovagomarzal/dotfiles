// The site's favicon, the same mark as every other site of Mario's.

import { logoPresets, logoSvg } from "@mariovagomarzal/lattice/logo";
import type { APIRoute } from "astro";

export const GET: APIRoute = () =>
  new Response(logoSvg(logoPresets.favicon), {
    headers: { "Content-Type": "image/svg+xml" },
  });
