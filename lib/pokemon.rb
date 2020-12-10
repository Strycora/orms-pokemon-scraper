require 'pry'
class Pokemon
    attr_reader :id
    attr_accessor :name, :type, :db

    def initialize(id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
        
    end

    def self.save(name, type, db)
        sql = <<-SQL
        INSERT INTO pokemon (name, type) 
        VALUES (?, ?)
        SQL

        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id, db)
        sql = <<-SQL
        SELECT * FROM pokemon 
        WHERE ? is #{id}
        SQL
        data = db.execute(sql, id).flatten
        
        pokemon = Pokemon.new(id: data[0], name: data[1], type: data[2], db: db)
    end


end
