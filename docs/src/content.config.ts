// The spec is plain Markdown under docs/spec, so agents read the same files the site renders.

import { defineCollection } from "astro:content";
import { glob } from "astro/loaders";
import { z } from "astro/zod";

const spec = defineCollection({
  loader: glob({ pattern: "*.md", base: "./spec" }),
  schema: z.object({
    title: z.string(),
    description: z.string(),
    order: z.number(),
  }),
});

export const collections = { spec };
