import type { User } from "@supabase/supabase-js";

export interface SidebarItem {
  label: string;
  href: string;
  icon: string;
}

export interface AppLayoutTheme {
  container?: string;
  sidebar?: string;
  main?: string;
  header?: string;
  content?: string;
}

export interface AppLayoutProps {
  title?: string;
  showSidebar?: boolean;
  sidebarItems?: SidebarItem[];
  theme?: AppLayoutTheme;
  loading?: boolean;
  user?: User;
  children?: unknown;
}
