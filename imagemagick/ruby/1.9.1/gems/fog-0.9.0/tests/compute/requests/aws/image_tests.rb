Shindo.tests('Fog::Compute[:aws] | image requests', ['aws']) do

  @images_format = {
    'imagesSet'    => [{
      'architecture'        => String,
      'blockDeviceMapping'  =>[],
      'imageId'             => String,
      'imageLocation'       => String,
      'imageOwnerId'        => String,
      'imageState'          => String,
      'imageType'           => String,
      'isPublic'            => Fog::Boolean,
      'kernelId'            => String,
      'productCodes'        => [],
      'ramdiskId'           => String,
      'rootDeviceType'      => String,
      'tagSet'              => {},
      'virtualizationType'  => String
    }],
    'requestId'     => String,
  }

  tests('success') do

    # the result for this is HUGE and relatively uninteresting...
    # tests("#describe_images").formats(@images_format) do
    #   Fog::Compute[:aws].describe_images.body
    # end

    tests("#describe_images('ImageId' => '#{GENTOO_AMI}')").formats(@images_format) do
      pending if Fog.mocking?
      Fog::Compute[:aws].describe_images('ImageId' => GENTOO_AMI).body
    end

  end

end
