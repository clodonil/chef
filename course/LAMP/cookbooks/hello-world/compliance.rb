['telnet', 'telnet-client'].each do |p|
  package p do
     action :remove
  end
end

file "/deleteme" do
    action :delete
end
