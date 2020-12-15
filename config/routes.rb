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
  resources :university_classes, only: %i[index show]

  # Monitorias do monitor
  get 'monitor_schedule/:user_id', to: 'monitorings#list', as: 'monitor_schedule'

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

  # Monitorias do dia selecionado pelo monitor
  get 'day_monitorings/:id', to: 'monitorings#day_monitorings', as: 'day_monitorings'
end
