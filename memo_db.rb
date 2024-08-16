# frozen_string_literal: true

class MemoDB
  CONN = PG.connect(dbname: 'memo_db')

  class << self
    def read
      CONN.exec('SELECT * FROM memos ORDER BY id')
    end

    def write(title, body)
      CONN.exec_params(
        'INSERT INTO memos(title, body) VALUES($1, $2)',
        [title, body]
      )
    end

    def fetch(id)
      CONN.exec_params(
        'SELECT * FROM memos WHERE id = $1',
        [id]
      ).first
    end

    def update(id, title, body)
      CONN.exec_params(
        'UPDATE memos SET title = $1, body = $2 WHERE id = $3',
        [title, body, id]
      )
    end

    def delete(id)
      CONN.exec_params('DELETE FROM memos WHERE id = $1', [id])
    end
  end
end
