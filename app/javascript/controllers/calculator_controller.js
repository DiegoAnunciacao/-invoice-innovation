import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="calculator"
export default class extends Controller {
  static targets = ["amount", "subtotal", "total", "vat", "remove"]

  connect() {
    this.calculateSubtotal()
  }

  calculateSubtotal() {
    let subtotal = 0
    this.amountTargets.forEach( (amount)=> {
      subtotal += parseFloat(amount.value) || 0

    })

    const vat = parseFloat(this.vatTarget.value) || 0

    const total = subtotal + (subtotal * vat / 100) || 0

    this.subtotalTarget.innerText = subtotal.toFixed(2)
    this.totalTarget.innerText = total.toFixed(2)
  }

  updateVat() {
    this.calculateSubtotal()
  }
}
