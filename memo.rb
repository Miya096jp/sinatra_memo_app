# frozen_string_literal: true

require 'json'

class Memo
  def initialize
    @json_file = 'data.json'
  end

  def read
    content = File.read(@json_file)
    content.empty? ? [] : JSON.parse(content)
  end

  def write(title, body)
    all_memos = read
    new_memo = { 'id' => create_new_id, 'title' => title, 'body' => body }
    all_memos << new_memo
    File.write(@json_file, JSON.generate(all_memos))
  end

  def create_new_id
    all_memos = read
    all_memos.empty? ? 1 : all_memos.max_by { |memo| memo['id'] }['id'] + 1
  end

  def show(id)
    all_memos = read
    all_memos.find { |memo| memo['id'] == id.to_i }
  end

  def update(id, title, body)
    all_memos = read
    idx = all_memos.index { |memo| memo['id'] == id.to_i }
    all_memos[idx]['title'] = title
    all_memos[idx]['body'] = body
    File.write(@json_file, JSON.generate(all_memos))
    all_memos
  end

  def delete(id)
    all_memos = read
    idx = all_memos.index { |memo| memo['id'] == id.to_i }
    all_memos.delete_at(idx)
    File.write(@json_file, JSON.generate(all_memos))
  end
end
