import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {

  static targets = ["toggle"]

  highlight() {
    this.toggleTarget.classList.toggle("active")
  }
}
