import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'calendar', 'schedule', 'question' ];
  // 
  toggleActive(event) {
    // console.log(window.location.pathname)
    const user_id = document.getElementById("user").dataset.userId;
    if(event.target.checked) {
      document.location.href = `/monitor_schedule/${user_id}`;
    } else {
      document.location.href = `/monitorings`;
    }
  }
}
