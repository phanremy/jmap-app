import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [ "button", "content" ]
  static values = { listenClick: { type: Boolean, default: false } }

  connect () {
    if (this.listenClickValue) {
      this.setClickListenerOutOfContent()
    }
  }

  call () {
    this.contentTarget.classList.toggle('hidden')
  }

  setClickListenerOutOfContent () {
    window.addEventListener('click', (e) => {

      if (this.contentTarget.classList.contains('hidden')) {
        return
      }

      if (this.buttonTarget.contains(e.target)) {
        return
      }

      if (!this.contentTarget.contains(e.target)) {
        this.call()
      }
    })
  }
}
