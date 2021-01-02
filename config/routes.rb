Rails.application.routes.draw do
  devise_for :users

  resources :imported_media_logs
  resources :media_logs
  resources :medias
  resources :media_installments

  # Medias
  get 'medias/:id/installments' => 'medias#installments'
  get 'medias/:id/installments/:media_installment_id' => 'media_installments#show'
  get 'medias/:id/groups' => 'medias#media_groups'
  get 'medias/:id/groups/:media_group_id' => 'medias#media_group'
  get 'medias/:id/group_installments/:media_group_id' => 'medias#group_installments'
  post 'medias/:id/refresh' => 'medias#refresh'
  post 'medias/search' => 'medias#search'
  post 'medias/import' => 'medias#import'

  # Media Types
  get 'media_types' => 'medias#media_types'

  # Preliminary subclass indexes
  get 'film' => 'medias#index_by_type', media_type: 'Film'
  get 'tv' => 'medias#index_by_type', media_type: 'Tv'

  # Import support.
  get 'users/:id/imported_media_logs/' => 'users#imported_media_logs'
  post 'users/:id/import_logs/:media_type_id' => 'users#import_media_logs'
  post 'films/import' => 'medias#import', params: { media_type: 'Film' }
  post 'tv/import' => 'medias#import', params: { media_type: 'Tv' }

  # Ledger Entries
  get 'medias/:media_id/logs' => 'ledger_entries#logs'
  get 'medias/:media_id/media_groups/:media_group_id/logs' => 'ledger_entries#media_group_logs'
  get 'medias/:media_id/media_installments/:media_installment_id/logs' => 'ledger_entries#media_installment_logs'
  post 'medias/:media_id/log' => 'ledger_entries#create_media_log'
  post 'medias/:media_id/medias_groups/:media_group_id/log' => 'ledger_entries#create_media_group_log'
  post 'medias/:media_id/media_installments/:media_installment_id/log' => 'ledger_entries#create_media_log'

  # Imported Ledger Entries
  post 'imported_media_logs/:id/match' => 'imported_media_logs#match'
  delete 'reset_imported_media_log_entries' => 'imported_media_logs#reset'
  delete 'pending_imported_media_logs' => 'imported_media_logs#delete_pending'

  # Users
  post 'users/reset_password' => 'users#reset_password'
  post 'users/:id/search_ledger_entries' => 'users#search_ledger_entries'
  delete 'users/:id/reset_logs' => 'users#reset_logs'

  # Admin
  # Admin Debug
  post 'admin/delete_media' => 'admin_debug#destroy_all_media'

  root to: "users#dashboard"
end
