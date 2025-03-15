import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['trigger', 'menu']

  static classes = ['open']

  connect () {
    this.open = false
    this.triggerTarget.addEventListener('click', this.toggle.bind(this))
  }

  disconnect () {
    this.triggerTarget.removeEventListener('click', this.toggle.bind(this))
  }

  toggle () {
    this.open ? this.closeMenu() : this.openMenu()
  }

  openMenu () {
    this.open = true
    this.menuTarget.classList.add(...this.openClasses)
    document.addEventListener('click', this.handleClickOutside.bind(this))
  }

  closeMenu () {
    this.open = false
    this.menuTarget.classList.remove(...this.openClasses)
    document.removeEventListener('click', this.handleClickOutside.bind(this))
  }

  handleClickOutside (event) {
    if (!this.element.contains(event.target)) this.closeMenu()
  }
}
