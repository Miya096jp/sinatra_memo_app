# frozen_string_literal: true

require 'json'

class Memo
  JSON_FILE = 'data.json'
  HIGHEST_ID = 'highest_id.json'

  def read
    content = File.read(JSON_FILE)
    content.empty? ? {} : JSON.parse(content)
  end

  def write(title, body)
    all_memos = read
    id = create_new_id
    all_memos[id['highest_id'].to_s] = { 'title' => title, 'body' => body }
    File.write(JSON_FILE, JSON.generate(all_memos))
  end

  def create_new_id
    current_id = File.read(HIGHEST_ID)
    current_id = current_id.empty? ? { 'highest_id' => nil } : JSON.parse(current_id)
    highest_id = current_id['highest_id'].nil? ? 1 : current_id['highest_id'] += 1
    current_id['highest_id'] = highest_id
    File.write(HIGHEST_ID, JSON.generate(current_id))
    current_id
  end

  # def read
  #   content = File.read(JSON_FILE)
  #   content.empty? ? { 'highest_id' => nil, 'memos' => {} } : JSON.parse(content)
  # end

  # def write(title, body)
  #   all_memos = read
  #   all_memos['highest_id'] = create_new_id
  #   all_memos['memos'][create_new_id] = { 'id' => create_new_id, 'title' => title, 'body' => body }
  #   File.write(JSON_FILE, JSON.generate(all_memos))
  # end

  # def create_new_id
  #   all_memos = read
  #   !all_memos['highest_id'] ? 1 : all_memos['highest_id'] += 1
  # end

  def fetch(id)
    all_memos = read
    id_str = id.to_s
    all_memos['memos'][id_str]
  end

  def update(id, title, body)
    all_memos = read
    id_str = id.to_s
    all_memos['memos'][id_str]['title'] = title
    all_memos['memos'][id_str]['body'] = body
    File.write(JSON_FILE, JSON.generate(all_memos))
  end

  def delete(id)
    all_memos = read
    id_str = id.to_s
    all_memos['memos'].delete(id_str)
    File.write(JSON_FILE, JSON.generate(all_memos))
  end
end
