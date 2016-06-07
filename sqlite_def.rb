require 'yaml'
require 'erb'
require 'pp'

#テーブル定義
DEF_DIR = './def.d/'

#テンプレート
TMPL_DIR = './template.d/'
TMPL_CREATE_TABLE = 'create_table.template.erb'

#SQL文
SQL_DIR = './sql.d/'

#テンプレートを読み込み、SQL文を生成する
def build(hash)
  File.open(TMPL_DIR + TMPL_CREATE_TABLE) { |file|
    return ERB.new(file.read, nil, '%>').result(binding)
  }
end

def save(content)
  File.open(SQL_DIR + 'test.sql', 'w') { |file|
    puts file.puts content
  }
end

#定義ファイルを読み込む
sql = ''
Dir[DEF_DIR + '*.yaml'].each {|file|
  defi = YAML.load_file(file)
  defi["tables"].each { |table|
     sql += build(table)
  }
}

save sql
