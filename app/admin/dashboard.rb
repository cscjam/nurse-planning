ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    tabs do
      Team.all.each do |team|
        tab team.name do
          tabs do
            team.users.each do |user|
              tab user.get_full_name do
                panel "Bilan" do
                  attributes_table_for user do
                    row("Visites Totales") {user.visits.count}
                    row("Visites Faites")  {user.visits.futures.count }
                    row("Visistes A Faire") {user.visits.pasts.count}
                  end
                end
              end
            end
          end
        end
      end
    end
    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
