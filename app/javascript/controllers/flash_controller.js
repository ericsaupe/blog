import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "notification" ]

  connect() {
    this.refreshTimer = setInterval(() => {
      this.deleteNotification()
    }, 5000);
  }

  disconnect() {
    if (this.refreshTimer) {
      clearInterval(this.refreshTimer)
    }
  }

  close() {
    this.deleteNotification()
  }

  deleteNotification() {
    const element = this.notificationTarget
    element.parentNode.removeChild(element)
  }
}
