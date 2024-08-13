# frozen_string_literal: true

class MemoDB
  MEMO_DB = PG.connect(dbname: 'memo_db')

  class << self
    def read
      memos = MEMO_DB.exec('SELECT * FROM memos')
      memos.each.with_object({}) do |memo, memos_hash|
        memos_hash[memo['id']] = { 'title' => memo['title'], 'body' => memo['body'] }
      end
    end

    def write(title, body)
      MEMO_DB.exec_params(
        'INSERT INTO memos(title, body) VALUES($1, $2)',
        [title, body]
      )
    end

    def fetch(id)
      all_memos = read
      all_memos[id.to_s]
    end

    def update(id, title, body)
      MEMO_DB.exec_params(
        'UPDATE memos SET title = $1, body = $2 WHERE id = $3',
        [title, body, id]
      )
    end

    def delete(id)
      MEMO_DB.exec('DELETE FROM memos WHERE id = $1', [id])
    end
  end
end
