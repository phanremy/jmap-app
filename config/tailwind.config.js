const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  darkMode: 'selector',
  theme: {
    extend: {
      fontFamily: {
        sans: ['Roboto', ...defaultTheme.fontFamily.sans], // Catamaran // Righteous
        heading: ['Noto Sans JP', ...defaultTheme.fontFamily.sans],
        body: ['Kosugi Maru', ...defaultTheme.fontFamily.sans]
      },
      colors: {
        primary: { // Call to Actions (Create)
          DEFAULT: '#8E354A',
          darker:  '#8E354A',
          foreground: '#FFFFFF'
        },
        secondary: { // Call to Options (Edit)
          DEFAULT: '#E16B8C',
          darker:  '#E16B8C',
          foreground: '#FFFFFF'
        },
        ternary: { // Navigation Panel, no darker
          DEFAULT: '#F4A7B9',
          foreground: '#8E354A'
        },
        black: {
          DEFAULT: '#8E354A'
        },
        white: {
          DEFAULT: '#F8C3CD'
        },
        destructive: {
          DEFAULT: '#A63030',
          darker:  '#7F2424',
          foreground: '#FFFFFF'
        },
        muted: {
          foreground: '#637083'
        }
        // White: '#FFFFFF'
        // Black : '#000000'
      }
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/container-queries')
  ]
}
