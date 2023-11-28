module BtnHelper
  def btn_create(anchor, link)
    link_to anchor, link, class: 'btn btn-success btn__icon btn__create'
  end

  def btn_edit(anchor, link)
    link_to anchor, link, class: 'btn btn-success btn__icon btn__edit'
  end

  def btn_delete(anchor, link, confirm = 'Are you sure?')
    link_to anchor, link,
            method: :delete, data: { confirm: },
            class: 'btn btn-danger btn__icon btn__delete'
  end
end
