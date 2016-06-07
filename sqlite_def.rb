require 'yaml'
require 'erb'
require 'pp'

DEF_DIR = './def.d/'

TMPL_DIR = './template.d/'
TMPL_CREATE_TABLE = 'create_table.template.erb'

#定義ファイルを読み込む
defs = []
Dir[DEF_DIR + '*.yaml'].each {|file|
  defs.push YAML.load_file(file)
}

#テンプレートを読み込み、SQL文を生成する
def build(hash)
  File.open(TMPL_DIR + TMPL_CREATE_TABLE) { |file|
    ERB.new(file.read, nil, '%>').run(binding)
  }
end

#確認用コードは以下

puts build(defs[0]["tables"][0])
puts build(defs[0]["tables"][1])
puts build(defs[1]["tables"][0])
puts build(defs[1]["tables"][1])


#pp defs[1].select {|k,v| k == "tables"}


#puts DEF_DIR

#puts '**********'
#pp defs
#puts '**********'


defs.each { |file|
  #puts "***** file *****"
  #pp file["tables"]

  file["tables"].each { |table|
    #pp table["name"]
    puts ""
  }


}
