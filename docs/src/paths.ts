// The site's own links, written from its root and resolved against wherever the site is actually served from.

/** A link written from the site's root, resolved against the base the site is built for. */
export function path(href: string): string {
  return import.meta.env.BASE_URL.replace(/\/$/, "") + href;
}

/** Whether a link is the page being viewed. */
export function isHere(pathname: string, href: string): boolean {
  return pathname.replace(/\/$/, "") === path(href).replace(/\/$/, "");
}
