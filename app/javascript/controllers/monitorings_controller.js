import { Controller } from "stimulus";
import { fetchWithToken } from "../utils/fetch_with_token";
import { calendar } from "../plugins/flatpickr"

export default class extends Controller {

  static targets = ['schedule', 'question', 'monitorings'];
  connect(){
    $('.custom-select').on("select2:select", this.filterDate)
  }

  filterDate(event) {
    const discipline_id = document.getElementById("disciplines").value;
    if(document.getElementById("disciplines").value) {
      document.getElementById("modal").classList.add("loading");
      fetch(`/monitoring_days/${discipline_id}?date=${document.getElementById("date").value}`,
        { headers: { accept: "application/json" } })
      .then(response => response.json())
      .then((data) => {
        document.getElementById("modal").classList.remove("loading");
        // console.log(data);
        document.getElementById("dates").dataset.dates = data.dates;
        calendar();
      });
    }
    if(document.getElementById("disciplines").value && document.getElementById("date").value) {
      // const discipline_id = document.getElementById("disciplines").value;
      document.getElementById("modal").classList.add("loading");
      fetch(`/monitoring_days/${discipline_id}?date=${document.getElementById("date").value}`,
        { headers: { accept: "application/json" } })
      .then(response => response.json())
      .then((data) => {
        document.getElementById("modal").classList.remove("loading");
        let monitoringsHTML = '<div class="radio" data-action="change->monitorings#filterSchedule">';
        if(data.monitorings.length > 0) {
          const dayMonitorings = [];
          const dayMonitors = [];
          let index = 0;
          data.monitorings.forEach((monitoring) => {
            let date = new Date(Date.parse(monitoring.date_time));
            date = new Date(date.getTime() + (date.getTimezoneOffset() * 60000));
            if(`${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear()}` === document.getElementById("date").value) {
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
          if(dayMonitors.length > 0) {
            monitoringsHTML += '<br><p class="text-form-options">Escolha o monitor e o horário:<br><br></p>'
            dayMonitors.sort((a,b) => (a.name > b.name) ? 1 : ((b.name > a.name) ? -1 : 0)).forEach((dayMonitor) => {
              monitoringsHTML += `<p class="container">${dayMonitor.name}</p>`
              monitoringsHTML += `<div class="d-flex">`
              dayMonitorings.forEach((dayMonitoring) => {
                if(dayMonitoring.class_monitor_id === dayMonitor.monitor_id) {
                  let date = new Date(Date.parse(dayMonitoring.date_time));
                  date = new Date(date.getTime() + (date.getTimezoneOffset() * 60000));
                  monitoringsHTML += `<input type="radio" id="${dayMonitoring.id}" class="schedule-option card-input-element" name="schedule" value="${dayMonitoring.id}">`;
                  // Inserindo card no lugar dos Radio Buttoms:
                  monitoringsHTML += `<div class="panel panel-default card-input">`
                  //
                  monitoringsHTML += `<div class="panel-body"><label for="${dayMonitoring.id}">`;
                  monitoringsHTML += `${date.getHours().toString().padStart(2, "0")}:${date.getMinutes().toString().padStart(2, "0")}`;
                  monitoringsHTML += '</div></div></label><br>';
                }
              });
              monitoringsHTML += '</div><br>'
            });
          } else {
            console.log('1');
            monitoringsHTML += '<p>Não há monitorias disponíveis nesse dia</p>';
          }
        } else {
          monitoringsHTML += '<p>Não há monitorias disponíveis nesse dia</p>';
        }
        monitoringsHTML += '</div>';
        monitoringsHTML += '<div data-monitorings-target="question">';
        monitoringsHTML = monitoringsHTML + document.getElementById("fixed").outerHTML + '</div>';
        document.getElementById("schedule").innerHTML = monitoringsHTML;
        // this.scheduleTarget.innerHTML = monitoringsHTML;
      });
    }
  }

  filterSchedule(event) {
    // console.log('opa');
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
    questionHTML = questionHTML + document.getElementById("fixed").outerHTML + '</form>'
    this.questionTarget.innerHTML = questionHTML
  }

  // Acoes da edicao -----------------------------------------------------------------------------------------
  editDate(event) {
    const discipline_id = document.getElementById("disciplines").dataset.disciplineId;
    fetchWithToken(`/monitoring_days/${discipline_id}?date=${document.getElementById("date").value}`,
      { headers: { accept: "application/json" } })
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
      if(dayMonitors.length > 0) {
        dayMonitors.sort((a,b) => (a.name > b.name) ? 1 : ((b.name > a.name) ? -1 : 0)).forEach((dayMonitor) => {
          monitoringsHTML += `<p>${dayMonitor.name}</p>`
          dayMonitorings.forEach((dayMonitoring) => {
            if(dayMonitoring.class_monitor_id === dayMonitor.monitor_id) {
              let date = new Date(Date.parse(dayMonitoring.date_time));
              date = new Date(date.getTime() + (date.getTimezoneOffset() * 60000));
              monitoringsHTML += `<input type="radio" id="${dayMonitoring.id}" class="schedule-option" name="schedule" value="${dayMonitoring.id}">`
              monitoringsHTML += `<label for="${dayMonitoring.id}">`
              monitoringsHTML += `${date.getHours().toString().padStart(2, "0")}:${date.getMinutes().toString().padStart(2, "0")}`
              monitoringsHTML += '</label><br>'
            }
          });
        });
      } else {
        monitoringsHTML += '<p>Não há monitorias disponíveis nesse dia</p>'
      }
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
    // console.log(`/monitor_day/${user_id}?date=${event.target.value}`);
    // console.log(Date.now());
    fetch(`/monitor_day/${user_id}?date=${event.target.value}`, { headers: { accept: "application/json" } })
    .then(response => response.json())
    .then((data) => {
      // console.log(data);
      let index = 0;
      // let monitoringsHTML = `<input type="hidden" name="user_id" value="${user_id}">`
      let monitoringsHTML = ''
      if(data.monitorings.length > 0) {
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
      } else {
        monitoringsHTML += '<p>Não há monitorias nesse dia</p>'
      }
      this.monitoringsTarget.innerHTML = monitoringsHTML
    });
  }
}