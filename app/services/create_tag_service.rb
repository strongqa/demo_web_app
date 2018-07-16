class CreateTagService
  def call
    Tag.find_or_create_by!(name: FFaker::Food.fruit)
  end
end
