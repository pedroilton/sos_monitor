import { Controller } from "stimulus";
import { fetchWithToken } from "../utils/fetch_with_token";

export default class extends Controller {

  static targets = [ 'calendar', 'schedule', 'question', 'monitorings' ];
  connect(){
    $('.custom-select').on("select2:select", this.filterDiscipline)
  }
  

  // Acoes do agendamento ------------------------------------------------------------------------------------------
  filterDiscipline(event) {
    if(event.target.value !== 'Disciplina') {
      fetchWithToken(`/monitoring_days/${event.target.value}`, { headers: { accept: "application/json" } })
        .then(response => response.json())
        .then((data) => {
          const formattedDates = []
          data.monitorings.forEach((monitoring) => {
            let date = new Date(Date.parse(monitoring.date_time));
            let formattedDate = `${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear()}`;
            if(!formattedDates.includes(formattedDate)) {
              formattedDates.push(formattedDate);
            }
          });
          // console.log(data.monitorings);
          // Codigo a ser alterado pelo calendario ------------
          // console.log(formattedDates);
          let calendarHTML = '<br><p>teste</p><select class="custom-select" data-action="change->monitorings#filterDate">'
          calendarHTML += '<option selected="">Data</option>';
          formattedDates.forEach((formattedDate) => {
            calendarHTML += `<option value="${formattedDate}">${formattedDate}</option>`;
          });
          calendarHTML += '</select>'
          calendarHTML += '<div data-monitorings-target="schedule">'
          // --------------------------------------------------
          // console.log(this.calendarTarget)
          calendarHTML = calendarHTML + document.getElementById("fixed").outerHTML + '</div>'
          document.querySelector(".form-calendar").innerHTML = calendarHTML
        });
    }
  }

  filterDate(event) {
    if(event.target.value !== 'Data') {
      const discipline_id = document.getElementById("disciplines").value;
      fetchWithToken(`/monitoring_days/${discipline_id}`, { headers: { accept: "application/json" } })
      .then(response => response.json())
      .then((data) => {
        const dayMonitorings = [];
        const dayMonitors = [];
        let index = 0;
        data.monitorings.forEach((monitoring) => {
          let date = new Date(Date.parse(monitoring.date_time));
          date = new Date(date.getTime() + (date.getTimezoneOffset() * 60000));
          if(`${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear()}` === event.target.value) {
            dayMonitorings.push(monitoring);
            let found = false;
            dayMonitors.forEach((dayMonitor) => {
              if(dayMonitor.monitor_id === data.monitors[index].id) {
                found = true;
              }
            });
            if(!found) {
              if(data.users[index].nickname) {
                dayMonitors.push({ monitor_id: data.monitors[index].id, name: data.users[index].nickname });
              } else {
                dayMonitors.push({ monitor_id: data.monitors[index].id, name: data.users[index].name });
              }
            }
          }
          index += 1;
        });

        // Codigo a ser alterado --------------------------------
        // console.log(dayMonitorings);
        // console.log(dayMonitors);
        let monitoringsHTML = '<br><p>Escolha o monitor e o horário:</p><div class="radio" data-action="change->monitorings#filterSchedule">'
        dayMonitors.sort((a,b) => (a.name > b.name) ? 1 : ((b.name > a.name) ? -1 : 0)).forEach((dayMonitor) => {
          monitoringsHTML += `<p>${dayMonitor.name}</p>`
          dayMonitorings.forEach((dayMonitoring) => {
            if(dayMonitoring.class_monitor_id === dayMonitor.monitor_id) {
              let date = new Date(Date.parse(dayMonitoring.date_time));
              date = new Date(date.getTime() + (date.getTimezoneOffset() * 60000));
              monitoringsHTML += `<input type="radio" id="${dayMonitoring.id}" class="schedule-option" name="schedule" value="${dayMonitoring.id}">`
              monitoringsHTML += `<label for="${dayMonitoring.id}">
                ${date.getHours().toString().padStart(2, "0")}:${date.getMinutes().toString().padStart(2, "0")}
                </label><br>`
            }
          });
        });
        monitoringsHTML += '</div>'
        monitoringsHTML += '<div data-monitorings-target="question">'
        // console.log(this.scheduleTarget)
        monitoringsHTML = monitoringsHTML + document.getElementById("fixed").outerHTML + '</div>'
        this.scheduleTarget.innerHTML = monitoringsHTML
      });
    }
  }

  filterSchedule(event) {
    // Captura dos elementos a serem vistos e alteração do style
    document.getElementById("submit").disabled = false;
    document.getElementById("submit").style.visibility = 'visible';
    document.getElementById("form-duvidas").style.visibility = 'visible';
    // 
    let scheduleOptions = document.querySelectorAll(".schedule-option");
    let monitoringId = 0
    scheduleOptions.forEach((scheduleOption) => {
      if(scheduleOption.checked) {
        monitoringId = scheduleOption.value;
        // console.log(monitoringId);
      }
    });
    //
    let questionHTML = `<form class="simple_form edit_monitoring" id="edit_monitoring_${monitoringId}" novalidate="novalidate" action="/schedule/${monitoringId}" accept-charset="UTF-8" method="post">`
    questionHTML = questionHTML + '<p>teste</p>' + document.getElementById("fixed").outerHTML + '</form>'
    this.questionTarget.innerHTML = questionHTML
  }

  // Acoes da edicao -----------------------------------------------------------------------------------------
  editDate(event) {
    const discipline_id = document.getElementById("disciplines").dataset.disciplineId;
    fetchWithToken(`/monitoring_days/${discipline_id}`, { headers: { accept: "application/json" } })
    .then(response => response.json())
    .then((data) => {
      const dayMonitorings = [];
      const dayMonitors = [];
      let index = 0;
      data.monitorings.forEach((monitoring) => {
        let date = new Date(Date.parse(monitoring.date_time));
        date = new Date(date.getTime() + (date.getTimezoneOffset() * 60000));
        if(`${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear()}` === event.target.value) {
          dayMonitorings.push(monitoring);
          let found = false;
          dayMonitors.forEach((dayMonitor) => {
            if(dayMonitor.monitor_id === data.monitors[index].id) {
              found = true;
            }
          });
          if(!found) {
            if(data.users[index].nickname) {
              dayMonitors.push({ monitor_id: data.monitors[index].id, name: data.users[index].nickname });
            } else {
              dayMonitors.push({ monitor_id: data.monitors[index].id, name: data.users[index].name });
            }
          }
        }
        index += 1;
      });

      // Codigo a ser alterado ----------------------------------------------
      // console.log(dayMonitorings);
      // console.log(dayMonitors);
      let monitoringsHTML = '<div class="radio" data-action="change->monitorings#editSchedule">'
      dayMonitors.sort((a,b) => (a.name > b.name) ? 1 : ((b.name > a.name) ? -1 : 0)).forEach((dayMonitor) => {
        monitoringsHTML += `<p>${dayMonitor.name}</p>`
        dayMonitorings.forEach((dayMonitoring) => {
          if(dayMonitoring.class_monitor_id === dayMonitor.monitor_id) {
            let date = new Date(Date.parse(dayMonitoring.date_time));
            date = new Date(date.getTime() + (date.getTimezoneOffset() * 60000));
            monitoringsHTML += `<input type="radio" id="${dayMonitoring.id}" class="schedule-option" name="schedule" value="${dayMonitoring.id}">`
            monitoringsHTML += `<label for="${dayMonitoring.id}">
              ${date.getHours().toString().padStart(2, "0")}:${date.getMinutes().toString().padStart(2, "0")}
              </label><br>`
          }
        });
      });
      monitoringsHTML += '</div>'
      monitoringsHTML += '<div data-monitorings-target="question">'
      console.log(this.scheduleTarget)
      monitoringsHTML = monitoringsHTML + document.getElementById("fixed").outerHTML + '</div>'
      this.scheduleTarget.innerHTML = monitoringsHTML
    });
  }

  editSchedule(event) {
    let scheduleOptions = document.querySelectorAll(".schedule-option");
    let monitoringId = 0
    scheduleOptions.forEach((scheduleOption) => {
      if(scheduleOption.checked) {
        monitoringId = scheduleOption.value;
        // console.log(monitoringId);
      }
    });
    let questionHTML = `<form class="simple_form edit_monitoring" id="edit_monitoring_${monitoringId}" novalidate="novalidate" action="/monitorings/${monitoringId}" accept-charset="UTF-8" method="post">`
    questionHTML = questionHTML + document.getElementById("fixed").outerHTML + '</form>'
    this.questionTarget.innerHTML = questionHTML
  }

  monitorDate(event) {
    const user_id = document.getElementById("monitor-user").dataset.userId;
    // console.log(`/day_monitorings/${event.target.value}?user_id=${user_id}`);
    // console.log(Date.now());
    fetch(`/day_monitorings/${event.target.value}?user_id=${user_id}`, { headers: { accept: "application/json" } })
    .then(response => response.json())
    .then((data) => {
      // console.log(data);
      let index = 0;
      // let monitoringsHTML = `<input type="hidden" name="user_id" value="${user_id}">`
      let monitoringsHTML = ''
      data.monitorings.forEach((monitoring) => {
        let date = new Date(Date.parse(monitoring.date_time));
        date = new Date(date.getTime() + (date.getTimezoneOffset() * 60000));
        monitoringsHTML += '<h5>'
        monitoringsHTML += `<a href="/monitorings/${monitoring.id}">${data.disciplines[index].title}`
        monitoringsHTML += '</a></h5>'
        monitoringsHTML += `<p>${date}</p>`
        monitoringsHTML += `<p>${monitoring.place}</p>`
        if(data.users[index].length === 0) {
          if(date > Date.now()) {
            monitoringsHTML += `<p>Horário disponível</p>`
          } else {
            monitoringsHTML += `<p>Monitoria não agendada</p>`
          }
        } else {
          if(data.users[index].length > 1) {
            monitoringsHTML += `<p>${data.users[index][0].name} + ${data.users[index].length - 1}</p>`
          } else {
            monitoringsHTML += `<p>${data.users[index][0].name}</p>`
          }
        }
        monitoringsHTML += `<br>`
        index += 1;
      });
      this.monitoringsTarget.innerHTML = monitoringsHTML
    });
  }
}