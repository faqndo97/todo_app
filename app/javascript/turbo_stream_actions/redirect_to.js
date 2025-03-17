import { Turbo } from '@hotwired/turbo-rails'

const { StreamActions } = Turbo

StreamActions.redirect_to = function () {
  const url = this.getAttribute('url') || '/'
  const options = { action: (this.getAttribute('turbo-action') || 'advance') }
  const toast = this.getAttribute('toast')

  const turboFrame = this.getAttribute('turbo-frame')
  if (turboFrame) options.frame = turboFrame

  if (toast !== undefined) {
    document.addEventListener('turbo:load', () => {
      setTimeout(() => {
        const toastContainer = document.querySelector('#toast_container')

        toastContainer.insertAdjacentHTML('beforeend', toast)
      }, 1000)
    }, { once: true })
  }

  window.Turbo.visit(url, options)
}
