import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [ 'element' ]

  call () {
    this.elementTargets.forEach(element => {
      element.classList.toggle(element.dataset.classToggleValue)
    })
  }
}
