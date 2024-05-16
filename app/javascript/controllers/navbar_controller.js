import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["menu"]

  connect() {
    this.toggleMenu = this.toggleMenu.bind(this)
    this.checkScreenWidth = this.checkScreenWidth.bind(this)
    window.addEventListener('resize', this.checkScreenWidth)
    this.checkScreenWidth()
  }

  disconnect() {
    window.removeEventListener('resize', this.checkScreenWidth)
  }

  toggleMenu() {
    this.menuTarget.classList.toggle('hidden')
  }

  checkScreenWidth() {
    if (window.innerWidth >= 640) {
      this.menuTarget.classList.add('hidden')
    }
  }
}
