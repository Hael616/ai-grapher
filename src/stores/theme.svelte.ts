import { browser } from "$app/environment";

class ThemeStore {
  theme: string;

  private getInitialTheme = () => {
    if (browser) {
      const savedTheme = localStorage.getItem("theme");
      if (savedTheme) return savedTheme;
      return window.matchMedia("(prefers-color-scheme: dark)").matches
        ? "dark"
        : "light";
    }
    return "light";
  };

  constructor() {
    this.theme = this.getInitialTheme();

    if (browser) {
      localStorage.setItem("theme", this.theme);
      document.documentElement.classList.toggle("dark", this.theme === "dark");
    }
  }

  updateTheme = (theme: string) => {
    this.theme = theme;
    localStorage.setItem("theme", theme);
    document.documentElement.classList.toggle("dark", theme === "dark");
  };

  toggleTheme = () => {
    this.updateTheme(this.theme === "dark" ? "light" : "dark");
  };
}

export const theme = new ThemeStore();
export default theme;
