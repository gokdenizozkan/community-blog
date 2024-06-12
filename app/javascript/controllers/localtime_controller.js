import { Controller } from "@hotwired/stimulus"
import LocalTime from "local-time";

export default class extends Controller {
  connect() {}
  switchLocale(event) {
    const currentLocale = event.params['locale'];
    LocalTime.config.locale = currentLocale == 'tr' ? 'en' : 'tr';
  }
}
