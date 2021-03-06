#execute "testing" do
#  command %Q{
#    echo "i ran at #{Time.now}" >> /root/cheftime
#  }
#end

#require_recipe "chmod_logs"
require_recipe 'fix_nginx_server_names'
require_recipe 'daemons'
#Do not override EY NodeJS install
#require_recipe 'python'
#require_recipe 'nodejs'
require_recipe 'juggernaut'
require_recipe 'wkhtmltopdf'

# uncomment to turn on thinking sphinx/ultra sphinx. Remember to edit cookbooks/sphinx/recipes/default.rb first!
# require_recipe "sphinx"

#uncomment to turn on memcached
# require_recipe "memcached"

#uncomment to run the authorized_keys recipe
#require_recipe "authorized_keys"

#uncomment to run the eybackup_slave recipe
#require_recipe "eybackup_slave"

#uncomment to run the ssmtp recipe
#require_recipe "ssmtp"

#uncomment to run the sunspot recipe
# require_recipe "sunspot"

#uncomment to run the exim recipe
#exim_auth "auth" do
#  my_hostname "my_hostname.com"
#  smtp_host "smtp.sendgrid.net"
#  username "username"
#  password "password"
#end

#uncomment to run the resque recipe
#require_recipe "resque"

#uncomment to run the redis recipe
# require_recipe "redis"

#require_recipe "logrotate"
#
#uncomment to use the solr recipe
#require_recipe "solr"

#uncomment to include the emacs recipe
#require_recipe "emacs"

#uncomment to include the eybackup_verbose recipe
#require_recipe "eybackup_verbose"

#uncomment to include the mysql_replication_check recipe
#require_recipe "mysql_replication_check"

#uncomment to include the mysql_administrative_tools recipe
# additional configuration of this recipe is required
#require_recipe "mysql_administrative_tools"

#enable contrib modules for a given Postgresql9 database
if ['solo','db_master', 'db_slave'].include?(node[:instance_role])
  # postgresql9_autoexplain "dbname"
  # postgresql9_chkpass "dbname"
  # postgresql9_citext "dbname"
  # postgresql9_cube "dbname"
  # postgresql9_dblink "dbname"
  # postgresql9_earthdistance "dbname"
  # postgresql9_fuzzystrmatch "dbname"
  # postgresql9_hstore "dbname"
  # postgresql9_intagg "dbname"
  # postgresql9_isn "dbname"
  # postgresql9_lo "dbname"
  # postgresql9_ltree "dbname"
  # postgresql9_pg_stat_statements"postgres_test" - Not done
  # postgresql9_pg_trgm "postgres_test"  
  # postgresql9_pgcrypto "postgres_test"
  # postgresql9_pgrowlocks "dbname"
  # postgresql9_postgis "dbname" 
  # postgresql9_seg "dbname"
  # postgresql9_tablefunc "dbname"
  # postgresql9_unaccent "dbname"
  # postgresql9_uuid_ossp "dbname"
  
  
  # postgresql9_pg_buffercache "postgres"
  # postgresql9_pg_freespacemap "postgres"
  
end
