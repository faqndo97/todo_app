import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="flowbite--drawer"
export default class extends Controller {
  static targets = ['trigger', 'container']

  connect () {
    if (this.element.querySelector('meta[name="turbo-permanent-placeholder"][content="sidebar"]')) {
      document.addEventListener('turbo:render', this.initializeDrawer.bind(this))
    } else {
      this.initializeDrawer()
    }
  }

  initializeDrawer () {
    // eslint-disable-next-line no-undef
    const Drawer = window.Drawer
    this.drawer = new Drawer(this.containerTarget)
    this.triggerTarget.addEventListener('click', this.toggle.bind(this))
    document.addEventListener('turbo:before-visit', this.hide.bind(this))
  }

  disconnect () {
    this.triggerTarget.removeEventListener('click', this.toggle.bind(this))
    this.hide()
  }

  hide () {
    this.drawer.hide()
  }

  toggle () {
    this.drawer.toggle()
  }
}
