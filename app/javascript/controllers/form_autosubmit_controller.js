import { ApplicationController, useDebounce } from 'stimulus-use'

export default class extends ApplicationController {
  static debounces = ['submit']

  connect () {
    useDebounce(this)
  }

  submit (event) {
    event.preventDefault()
    this.element.requestSubmit()
  }
}
