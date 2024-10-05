import { Controller } from '@hotwired/stimulus'

/*
 * Values:
 *
 * Notes:
 *
 * Example:
 *
 */
export default class extends Controller {
  static targets = ['modal']

  call () {
    if (document.getElementById('post_form_modal'))
      return

    document.getElementById('modal').insertAdjacentHTML('afterbegin', this.modalTarget.innerHTML)
  }
}
