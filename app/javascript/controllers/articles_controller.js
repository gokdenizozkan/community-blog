import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {}
  toggleDiv(event) {
    event.preventDefault();
    event.stopPropagation();
    
    const divId = event.params["advanced_fields_div"];
    
    const div = document.getElementById(formId);
    div.classList.toggle("hidden");
  }
}
