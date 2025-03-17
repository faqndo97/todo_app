import { Controller } from '@hotwired/stimulus'
import { useClickOutside } from 'stimulus-use'

export default class extends Controller {
  static targets = ['trigger', 'menu']

  static classes = ['open']

  connect () {
    useClickOutside(this)
    this.open = false
    this.triggerTarget.addEventListener('click', this.toggle.bind(this))
  }

  disconnect () {
    this.triggerTarget.removeEventListener('click', this.toggle.bind(this))
    this.closeMenu()
  }

  toggle () {
    this.open ? this.closeMenu() : this.openMenu()
  }

  openMenu () {
    this.open = true
    this.menuTarget.classList.add(...this.openClasses)
  }

  closeMenu () {
    this.open = false
    this.menuTarget.classList.remove(...this.openClasses)
  }

  clickOutside (event) {
    this.closeMenu()
  }
}
