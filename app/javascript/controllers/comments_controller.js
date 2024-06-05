import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {}
  toggleForm(event) {
  	event.preventDefault();
  	event.stopPropagation();
  	
  	const formId = event.params["form"];
  	const commentBodyId = event.params["body"];
  	
  	const form = document.getElementById(formId);
  	form.classList.toggle("hidden");

  	const commentBody = document.getElementById(commentBodyId);
  	commentBody.classList.toggle("hidden");
  }
}
