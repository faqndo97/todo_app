import { Turbo } from '@hotwired/turbo-rails'

const { StreamActions } = Turbo

StreamActions.reset_form = function () {
  this.targetElements.forEach((form) => {
    form.reset()
    form.querySelector('.errors').remove()
    form.querySelectorAll('[data-invalid-classes]').forEach((element) => {
      element.classList.remove(...element.dataset.invalidClasses.split(' '))
      element.classList.add(...element.dataset.validClasses.split(' '))
    })
  })
}
