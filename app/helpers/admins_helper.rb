module AdminsHelper
  def change_role_button(user)
    if user.default?
      button_to 'Make Admin', admin_users_path(current_user, user_id: user.id, user: { role: "admin"}), method: :patch, class: "btn btn-default"
    else
      button_to 'Make Default', admin_users_path(current_user, user_id: user.id, user: { role: "default"}), method: :patch, class: "btn btn-warning"
    end
  end
  def change_status_button(user)
    if user.active?
      button_to 'Disable', admin_users_path(current_user, user_id: user.id, user: { status: "inactive"}), method: :patch, class: "btn btn-danger"
    else
      button_to 'Enable', admin_users_path(current_user, user_id: user.id, user: { status: "inactive"}), method: :patch, class: "btn btn-info"
    end
  end
end
