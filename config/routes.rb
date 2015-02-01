PatientCareApp::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'


  get 'new/personal' => 'new_patients#personal_details', as: :new_patient_personal
  post 'new/personal' => 'new_patients#submit_personal_details', as: :new_patient_submit_personal

  get 'new/tumor' => 'new_patients#tumor_details', as: :new_patient_tumor
  post 'new/tumor' => 'new_patients#submit_tumor_details', as: :new_patient_submit_tumor

  get 'new/work' => 'new_patients#work_details', as: :new_patient_work
  post 'new/work' => 'new_patients#submit_work_details', as: :new_patient_submit_work

  get 'new/life' => 'new_patients#life_details', as: :new_patient_life
  post 'new/life' => 'new_patients#submit_life_details', as: :new_patient_submit_life

  get 'new/health' => 'new_patients#health_details', as: :new_patient_health
  post 'new/health' => 'new_patients#submit_health_details', as: :new_patient_submit_health


  get 'returning/personal' => 'returning_patients#personal_details', as: :returning_patient_personal
  post 'returning/personal' => 'returning_patients#submit_personal_details', as: :returning_patient_submit_personal

  get 'returning/health' => 'returning_patients#health_details', as: :returning_patient_health
  post 'returning/health' => 'returning_patients#submit_health_details', as: :returning_patient_submit_health


  get 'thank_you' => 'home#thank_you'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
