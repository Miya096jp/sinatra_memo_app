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
      parsed_hash = file_content.empty? ? { 'id' => nil } : JSON.parse(file_content)
      new_id = parsed_hash['id'].nil? ? 1 : parsed_hash['id'] + 1
      hash_to_save = { 'id' => new_id }
      File.write(HIGHEST_ID, JSON.generate(hash_to_save))
      new_id
    end
  end
end
