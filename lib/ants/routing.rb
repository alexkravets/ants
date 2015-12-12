module ActionDispatch::Routing
  class Mapper
    def mount_ants_redirects
      get "/*id" => 'redirects#show', :constraints => ::Constraints::Redirects
    end

    def mount_ants_admin_users_crud
      resources :admin_users, controller: "admin_users" do
        member do
          patch :update_password
        end
      end
    end

    def mount_ants_redirects_crud
      resources :redirects, controller: "redirects"
    end

    def mount_ants_settings_crud
      resources :settings_objects, controller: "settings_objects"
    end

    def mount_ants_menus_crud
      resources :menus, controller: "menus"
    end
  end
end
