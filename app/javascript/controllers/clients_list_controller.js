import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clients-list"
export default class extends Controller {
  static targets = ["client"]

  highlight(event) {
    this.clientTargets.forEach((client) => {
      client.classList.remove("active")
    });
    event.currentTarget.classList.add("active");
  }
}
