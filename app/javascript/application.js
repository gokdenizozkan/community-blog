// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "trix";
import "@rails/actiontext";
import "@hotwired/turbo-rails";
import "controllers";
import LocalTime from "local-time";

LocalTime.config.i18n['tr'] = {
  date: {
    dayNames: ["Pazar", "Pazartesi", "Salı", "Çarşamba", "Perşembe", "Cuma", "Cumartesi"],
    abbrDayNames: ["Paz", "Pzt", "Sal", "Çar", "Per", "Cum", "Cmt"],
    monthNames: ["Ocak", "Şubat", "Mart", "Nisan", "Mayıs", "Haziran", "Temmuz", "Ağustos", "Eylül", "Ekim", "Kasım", "Aralık"],
    abbrMonthNames: ["Oca", "Şub", "Mar", "Nis", "May", "Haz", "Tem", "Auğ", "Eyl", "Eki", "Kas", "Ara"],
    yesterday: "dün",
    today: "bugün",
    tomorrow: "yarın",
    on: "{date} tarihinde",
    formats: {
      "default": "%b %e, %Y",
      thisYear: "%b %e"
    }
  },
  time: {
    am: " (öğleden önce)",
    pm: " (öğleden sonra)",
    singular: "{time}",
    singularAn: "{time}",
    elapsed: "{time} önce",
    second: "saniye",
    seconds: "saniye",
    minute: "dakika",
    minutes: "dakika",
    hour: "saat",
    hours: "saat",
    formats: {
      "default": "%l:%M%P",
      default_24h: "%H:%M"
    }
  },
  datetime: {
    at: "{date} saat {time}",
    formats: {
      "default": "%B %e, %Y at %l:%M%P %Z",
      default_24h: "%B %e, %Y at %H:%M %Z"
    }
  }
}

LocalTime.config.locale = 'tr';
LocalTime.start();