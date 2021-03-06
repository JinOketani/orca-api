if ![1].include?(ARGV.length)
  $stderr.puts(<<-EOS)
Usage:
  get.rb <patient_id>
  EOS
  exit(1)
end

require_relative "../../common"

patient_service = @orca_api.new_patient_service

patient_id = ARGV.shift

result = patient_service.get_care_certification(patient_id)
if result.ok?
  print_result(result)
else
  error(result)
  exit
end
