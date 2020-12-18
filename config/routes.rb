Rails.application.routes.draw do
  devise_for :users
  # root to: "pages#home"
  devise_scope :user do
    authenticated :user do
      root 'monitorings#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :monitorings, only: %i[index show edit update destroy] do
    resources :monitorings_students, only: :create
  end
  resources :monitorings_students, only: %i[destroy update]
  resources :university_classes, except: %i[destroy] do
    resources :class_monitors, only: :create
    resources :classes_students, only: :create
  end
  resources :class_monitors, only: %i[destroy edit update show]
  resources :disciplines, except: %i[show destroy]
  resources :classes_students, only: :destroy

  # Monitorias do monitor
  get 'monitor_schedule/:user_id', to: 'monitorings#list', as: 'monitor_schedule'
  # Monitorias do dia selecionado pelo monitor
  get 'day_monitorings/:id', to: 'monitorings#day_monitorings', as: 'day_monitorings'
  get 'monitor_day/:id', to: 'class_monitors#monitor_day', as: 'monitor_day', defaults: { format: 'json' }

  # Monitorias concluidas do aluno
  get 'monitorings_old', to: 'monitorings#old_index', as: 'monitorings_old'

  # Saida do aluno da monitoria
  delete 'monitoring_leave/:monitoring_id', to: 'monitorings_students#leave', as: 'monitoring_leave'

  # Agendamento de monitoria
  get 'student_disciplines', to: 'disciplines#student_disciplines'
  get 'monitoring_days/:discipline_id', to: 'monitorings#monitoring_days'
  patch 'schedule/:id', to: 'monitorings#schedule'

  # Cancelamento de monitoria pelo monitor
  patch 'monitoring_cancel/:id', to: 'monitorings#cancel', as: 'monitoring_cancel'

  # menu do professor/administrador
  get 'menu', to: 'pages#menu'

  # Exclusao de horario do monitor
  delete 'destroy_schedule/:id', to: 'class_monitors#destroy_schedule', as: 'destroy_schedule'

  # Edicao de lugar da monitoria
  patch 'edit_place/:id', to: 'monitorings#edit_place', as: 'edit_place'
end
