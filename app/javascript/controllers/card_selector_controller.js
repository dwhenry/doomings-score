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

    let userId = document.querySelector(".selected-user").getAttribute("data-user-id")

    fetch(this.submitTarget.href, {
      method: 'PATCH',
      headers: {
        'X-CSRF-Token': this.token,
        'Content-Type': 'application/json'
      },
      credentials: 'same-origin',
      body: JSON.stringify({
       user_id: userId
      })
    }).then (response => response.text())
    .then(html => Turbo.renderStreamMessage(html));
  }

  delete(event) {
    event.preventDefault();

    fetch(this.submitTarget.href, {
      method: 'DELETE',
      headers: {
        'X-CSRF-Token': this.token,
        'Content-Type': 'application/json'
      },
      credentials: 'same-origin'
    }).then (response => response.text())
    .then(html => Turbo.renderStreamMessage(html));
  }
}
