import { Controller } from '@hotwired/stimulus'
import Toastify from 'toastify-js'

const GRAVITY = {
  TOP: 'top',
  BOTTOM: 'bottom'
}

const POSITION = {
  LEFT: 'left',
  CENTER: 'center',
  RIGHT: 'right'
}

export default class extends Controller {
  static values = {
    text: String,
    duration: { type: Number, default: 3000 },
    destination: String,
    newWindow: Boolean,
    close: Boolean,
    gravity: { type: String, default: GRAVITY.TOP },
    position: { type: String, default: POSITION.CENTER },
    stopOnFocus: Boolean,
    className: String,
    style: Object
  }

  connect () {
    if (!Object.values(GRAVITY).includes(this.gravityValue)) {
      console.error(`${this.gravityValue} it's not a valid gravity`)
      return
    }

    if (!Object.values(POSITION).includes(this.positionValue)) {
      console.error(`${this.positionValue} it's not a valid position`)
      return
    }

    Toastify({
      text: this.textValue,
      duration: this.durationValue,
      destination: this.destinationValue,
      newWindow: this.newWindowValue,
      close: this.closeValue,
      gravity: this.gravityValue,
      position: this.positionValue,
      stopOnFocus: this.stopOnFocusValue,
      className: this.classNameValue,
      style: this.styleValue
    }).showToast()
  }
}
