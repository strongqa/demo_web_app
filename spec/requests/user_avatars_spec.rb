require 'rails_helper'

# image_tag treats any non-String source as a model and calls polymorphic_url,
# which raises for a CarrierWave uploader. A single user with an avatar used to
# turn every page that lists users or their comments into a 500.
RSpec.describe 'Pages rendering user avatars' do
  let(:avatar) do
    Rack::Test::UploadedFile.new(Rails.root.join('app/assets/images/users/defaut_avatar.png'), 'image/png')
  end
  let(:admin) { create(:user, name: 'Admin', is_admin: true, confirmed_at: Time.current) }
  let(:user_with_avatar) { create(:user, name: 'Avatar Owner', confirmed_at: Time.current, avatar:) }

  before { sign_in admin }

  it 'renders the users list' do
    user_with_avatar

    get users_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(user_with_avatar.avatar.url)
  end

  it 'renders an article commented by the user' do
    comment = create(:comment, user: user_with_avatar)

    get article_path(comment.article)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(user_with_avatar.avatar.url)
  end
end
