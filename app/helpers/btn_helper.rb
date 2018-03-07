module BtnHelper
  def btn(anchor, link, btn_role)
    case btn_role

      when 'create'
        add_class = "btn btn-success btn__icon btn__create"

      when 'edit'
        add_class = "btn btn-success btn__icon btn__edit"

      when 'delete'
        add_class = "btn btn-danger btn__icon btn__delete"
        method = ':delete'
        data_confirm = 'Are you sure?'

      else
        add_class = "btn"
    end
    link_to anchor, link, class: add_class, method: method, data: {confirm: data_confirm}
  end
end
