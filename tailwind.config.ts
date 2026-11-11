import type { Config } from "tailwindcss";

export default {
  content: ["./src/**/*.{ts,tsx}"],
  theme: {
    extend: {
      colors: {
        tiger: {
          50: "#FFF5EE",
          100: "#FFE6D3",
          200: "#FFC9A3",
          300: "#FFA56B",
          400: "#FB8436",
          500: "#F26B1D",
          600: "#DC5410",
          700: "#B54210",
          800: "#8F3614",
          900: "#742F14",
        },
        ink: {
          DEFAULT: "#1C130E",
          900: "#1C130E",
          800: "#2A1D15",
          700: "#3B2A1F",
          600: "#5A4636",
          500: "#7A6656",
          400: "#9C8B7D",
          300: "#C7B9AC",
          200: "#E6DCD2",
          100: "#F3EDE6",
          50: "#FAF7F3",
        },
      },
      fontFamily: {
        sans: ["'Inter Variable'", "Inter", "system-ui", "sans-serif"],
        display: ["Oswald", "'Arial Narrow'", "sans-serif"],
      },
      boxShadow: {
        card: "0 1px 2px rgba(28,19,14,.06), 0 1px 1px rgba(28,19,14,.04)",
        lift: "0 8px 24px -8px rgba(28,19,14,.18)",
      },
      keyframes: {
        "fade-up": { from: { opacity: "0", transform: "translateY(6px)" }, to: { opacity: "1", transform: "none" } },
      },
      animation: { "fade-up": "fade-up .28s cubic-bezier(.2,.8,.2,1) both" },
    },
  },
  plugins: [],
} satisfies Config;
