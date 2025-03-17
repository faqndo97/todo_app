# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "stimulus-textarea-autogrow" # @4.1.0
pin "stimulus-use" # @0.52.3
pin "@rails/request.js", to: "@rails--request.js.js" # @0.0.11
pin "@stimulus-components/sortable", to: "@stimulus-components--sortable.js" # @5.0.2
pin "sortablejs" # @1.15.6

pin_all_from "app/javascript/controllers", under: "controllers"
pin "toastify-js" # @1.12.0
