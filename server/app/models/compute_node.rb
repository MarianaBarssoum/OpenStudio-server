class ComputeNode
  include Mongoid::Document
  include Mongoid::Timestamps

  field :node_type, :type => String
  field :ip_address, :type => String
  field :hostname, :type => String
  field :user, :type => String
  field :password, :type => String
  field :cores, :type => Integer
  field :ami_id, :type => String
  field :instance_id, :type => String
  field :valid, :type => Boolean, default: false

  # Indexes
  index({hostname: 1}, unique: true)
  index({ip_address: 1}, unique: true)
  index({node_type: 1})

  # Return all the worker IP addresses as a hash in prep for writing to a dataframe
  def self.to_hash
    worker_ips_hash = {}
    worker_ips_hash[:worker_ips] = []

    ComputeNode.where(valid: true).each do |node|
      (1..node.cores).each { |i| worker_ips_hash[:worker_ips] << node.ip_address }
    end
    Rails.logger.info("worker ip hash: #{worker_ips_hash}")

    worker_ips_hash
  end
end
