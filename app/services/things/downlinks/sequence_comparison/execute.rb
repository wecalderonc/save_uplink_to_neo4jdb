module Downlinks::SequenceComparison
  _, Execute = Common::TxMasterBuilder.new do
    step :get_thing              with: Things::Get.new
    step :last_uplink,           with: Uplinks::Get.new
    step :last_downlink,         with: Downlinks::Get.new
    step :comparison,            with: Downlinks::SequenceComparison::Comparison.new
  end.Do
end
