import { Controller } from "stimulus"
import bulmaTagsinput from "bulma-tagsinput"

export default class extends Controller {
  static targets = [ "input" ]

  connect() {
    bulmaTagsinput.attach();
  }
}
