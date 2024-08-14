# frozen_string_literal: true

class MemoDB
  CONN = PG.connect(dbname: 'memo_db')

  class << self
    def read
      memos = CONN.exec('SELECT * FROM memos ORDER BY id')
      memos.map do |memo|
        [memo['id'], { 'title' => memo['title'], 'body' => memo['body'] }]
      end.to_h
    end

    def write(title, body)
      CONN.exec_params(
        'INSERT INTO memos(title, body) VALUES($1, $2)',
        [title, body]
      )
    end

    def fetch(id)
      all_memos = read
      all_memos[id]
    end

    def update(id, title, body)
      CONN.exec_params(
        'UPDATE memos SET title = $1, body = $2 WHERE id = $3',
        [title, body, id]
      )
    end

    def delete(id)
      CONN.exec('DELETE FROM memos WHERE id = $1', [id])
    end
  end
end
