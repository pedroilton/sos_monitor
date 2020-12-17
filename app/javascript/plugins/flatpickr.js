import flatpickr from "flatpickr";

const calendar = () => {
  flatpickr(".datepicker", {
    dateFormat: 'd/m/Y',
    locale: {
      firstDayOfWeek: 0,
      weekdays: {
        shorthand: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'],
        longhand: ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'],         
      },
      months: {
        shorthand: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Аgo', 'Set', 'Оut', 'Nov', 'Dez'],
        longhand: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
      },
    },
    disableMobile: "true",
    enable: [function(date) {
      // return true to disable
      return document.getElementById("dates").dataset.dates.split('-').includes(`${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear()}`);
  }] 
  });
}

export { calendar };