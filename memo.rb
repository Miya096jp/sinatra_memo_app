# frozen_string_literal: true

require 'json'

class MemoDB
  JSON_FILE = 'data.json'
  HIGHEST_ID = 'highest_id.json'

  class << self
    def read
      file_content = File.read(JSON_FILE)
      file_content.empty? ? {} : JSON.parse(file_content)
    end

    def write(title, body)
      all_memos = read
      new_id = create_new_id
      all_memos[new_id.to_s] = { 'title' => title, 'body' => body }
      File.write(JSON_FILE, JSON.generate(all_memos))
    end

    def fetch(id)
      all_memos = read
      all_memos[id.to_s]
    end

    def update(id, title, body)
      all_memos = read
      all_memos[id.to_s] = { 'title' => title, 'body' => body }
      File.write(JSON_FILE, JSON.generate(all_memos))
    end

    def delete(id)
      all_memos = read
      all_memos.delete(id.to_s)
      File.write(JSON_FILE, JSON.generate(all_memos))
    end

    private

    def create_new_id
      file_content = File.read(HIGHEST_ID)
      new_id = file_content.empty? ? 1 : JSON.parse(file_content) + 1
      File.write(HIGHEST_ID, JSON.generate(new_id))
      new_id
    end
  end
end
