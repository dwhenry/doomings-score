import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["submit"]

  connect() {
    this.token = document.querySelector(
      'meta[name="csrf-token"]'
    ).content;
  }

  add(event) {
    event.preventDefault();
    this.processAction('add_card')
  }

  remove(event) {
    event.preventDefault();
    this.processAction('remove_card')
  }

  processAction(event_type) {
    let userId = document.querySelector(".selected-user").getAttribute("data-user-id")

    fetch(this.submitTarget.href, {
      method: 'PATCH',
      headers: {
        'X-CSRF-Token': this.token,
        'Content-Type': 'application/json'
      },
      credentials: 'same-origin',
      body: JSON.stringify({
        user_id: userId,
        event_type: event_type,
      })
    }).then (response => response.text())
    .then(html => Turbo.renderStreamMessage(html));
  }

  delete(event) {
    event.preventDefault();
    this.processAction('remove_all')
  }
}
