// The site's table of contents, in reading order. The sidebar draws it and the pager walks it, so the two agree.

import { getCollection } from "astro:content";
import { hosts, modules } from "./repo";

export interface NavItem {
  label: string;
  href: string;
}

export interface NavSection {
  title: string;
  items: NavItem[];
}

export async function navigation(): Promise<NavSection[]> {
  const spec = (await getCollection("spec")).sort((a, b) => a.data.order - b.data.order);
  return [
    {
      title: "Overview",
      items: [
        { label: "Introduction", href: "/" },
        { label: "Changelog", href: "/changelog" },
      ],
    },
    { title: "Spec", items: spec.map((p) => ({ label: p.data.title, href: `/spec/${p.id}` })) },
    { title: "Hosts", items: hosts.map((h) => ({ label: h.name, href: `/hosts/${h.name}` })) },
    {
      title: "Modules",
      items: [
        { label: "All modules", href: "/modules" },
        ...modules.map((m) => ({ label: m.name, href: `/modules/${m.name}` })),
      ],
    },
  ];
}
