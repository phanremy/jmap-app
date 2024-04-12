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
        heading: ['Bebas Neue', ...defaultTheme.fontFamily.sans],
        body: ['Montserrat', ...defaultTheme.fontFamily.sans]
      },
      colors: {
        primary: { // Call to Actions (Create)
          DEFAULT: '#FBA834',
          darker:  '#E0962E',
          foreground: '#000000'
        },
        secondary: { // Call to Options (Edit)
          DEFAULT: '#333A73',
          darker:  '#2B3264',
          foreground: '#FFFFFF'
        },
        ternary: { // Navigation Panel, no darker
          DEFAULT: '#387ADF',
          foreground: '#000000'
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
