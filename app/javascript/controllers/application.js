import { Application } from '@hotwired/stimulus'
import TextareaAutogrow from 'stimulus-textarea-autogrow'
import Sortable from '@stimulus-components/sortable'

const application = Application.start()

application.register('textarea-autogrow', TextareaAutogrow)
application.register('sortable', Sortable)

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export { application }
