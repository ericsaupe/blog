import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'container', 'trigger' ]

  connect() {
    this.close()
  }

  open() {
    // stop the background from being able to scroll.
    document.documentElement.classList.add('is-clipped')
    // open the sidebar
    this.triggerTarget.classList.add('is-active')
    this.containerTarget.classList.add('is-active')
  }

  close() {
    // allow the background to scroll again.
    document.documentElement.classList.remove('is-clipped')

    // close the sidebar
    this.triggerTarget.classList.remove('is-active')
    this.containerTarget.classList.remove('is-active')
  }
}
