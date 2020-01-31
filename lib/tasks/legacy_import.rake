# frozen_string_literal: true

namespace :legacy do
  desc 'Loads legacy posts from Markdown into database'
  task import: :environment do
    Dir.glob(Rails.root.join('lib/assets/legacy_source/*.md')) do |page|
      contents = File.read(page)
      config_text = contents.split('---')[1]
      body = contents.split('---')[2]
      config = YAML.safe_load(config_text)

      post = Post.create!(
        title: config['title'],
        slug: File.basename(page, '.md'),
        created_at: Time.zone.parse(config['date'])
      )
      post.content = ActionText::RichText.create(
        name: 'content',
        body: body,
        record: post
      )
      tags = config['tags']
      tags.each do |name|
        cleaned_name = name.strip.titleize
        tag = Tag.find_or_create_by!(name: cleaned_name)
        post.tags << tag
      end
    end
  end
end
