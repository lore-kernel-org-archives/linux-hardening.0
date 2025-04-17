Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A44254868
	for <linux-hardening@vger.kernel.org>; Thu, 17 Apr 2025 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744908068; cv=none; b=gX8yQKO90zgXCkCaxw+xK1NCXbLgnR3o+NJhqK9+ugfwrAJ/zW18Dxsgw28Lkq2E4MEdbcLsvKEVrJYrP5X757LLbwH5TpL3x6pM3UsYjjkux+XAOQSCgc3yXLSpVxcudLG7IaaI9ZchfiBbn0om6tNNHVpKddqeDb7MGoRyvpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744908068; c=relaxed/simple;
	bh=Cmws64+ZxMzbbyNXTYJucL/4NmPbYEAODTkS40Qb4zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VzNU/CzANpfFzVE7/pOeoNMX9bFSRUngUd5qOvzL+yEhvyaG1immAp+TdgjGKTtLY16JK1tvIyavxBFMFeEA8o5XrtNPbDM9YbRtODjeW4POslpbmIDtft7xqloBOJNiM0uwFZ6FSUJbFVwRZp34du0HhFOttz8PZc4+A3eXzVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AppLjyk2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AppLjyk2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744908065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MVkVweXyhN8uWsQkQsYLwmRjnYv2NnfH0NHhh2MVCeo=;
	b=AppLjyk2gIBG2obYhOs7Pm4Vow2VbNtDXh4S5ZlEOR+0ayBZlnp5mhp33TyA7+QdmzwSbC
	lc4b026NTeMTGTsza1q/Oz0TLUWDiCPSaHlqsIKUsgOcmGeesqbO+SpwIM0NS++d/A7wk8
	mgDPgGTg97SjcSeA57sJrm4B4qBwTXE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-l4RkTimuPlqyfjeKFpSTMQ-1; Thu,
 17 Apr 2025 12:40:55 -0400
X-MC-Unique: l4RkTimuPlqyfjeKFpSTMQ-1
X-Mimecast-MFC-AGG-ID: l4RkTimuPlqyfjeKFpSTMQ_1744908052
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 920691801BD5;
	Thu, 17 Apr 2025 16:40:50 +0000 (UTC)
Received: from [10.44.33.28] (unknown [10.44.33.28])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DBC6B30002C2;
	Thu, 17 Apr 2025 16:40:45 +0000 (UTC)
Message-ID: <335003db-49e5-4501-94e5-4e9c6994be7d@redhat.com>
Date: Thu, 17 Apr 2025 18:40:44 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 8/8] mfd: zl3073x: Register DPLL sub-device
 during init
To: Lee Jones <lee@kernel.org>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-9-ivecera@redhat.com>
 <20250417162044.GG372032@google.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250417162044.GG372032@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4



On 17. 04. 25 6:20 odp., Lee Jones wrote:
> On Wed, 16 Apr 2025, Ivan Vecera wrote:
> 
>> Register DPLL sub-devices to expose this functionality provided
>> by ZL3073x chip family. Each sub-device represents one of the provided
>> DPLL channels.
>>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>>   drivers/mfd/zl3073x-core.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
>> index 0bd31591245a2..fda77724a8452 100644
>> --- a/drivers/mfd/zl3073x-core.c
>> +++ b/drivers/mfd/zl3073x-core.c
>> @@ -6,6 +6,7 @@
>>   #include <linux/device.h>
>>   #include <linux/export.h>
>>   #include <linux/math64.h>
>> +#include <linux/mfd/core.h>
>>   #include <linux/mfd/zl3073x.h>
>>   #include <linux/mfd/zl3073x_regs.h>
>>   #include <linux/module.h>
>> @@ -774,6 +775,20 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
>>   	if (rc)
>>   		return rc;
>>   
>> +	/* Add DPLL sub-device cell for each DPLL channel */
>> +	for (i = 0; i < chip_info->num_channels; i++) {
>> +		struct mfd_cell dpll_dev = MFD_CELL_BASIC("zl3073x-dpll", NULL,
>> +							  NULL, 0, i);
> 
> Create a static one of these with the maximum amount of channels.

Like this?

static const struct mfd_cell dpll_cells[] = {
	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 1),
	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 2),
	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 3),
	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 4),
	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 5),
};

rc = devm_mfd_add_devices(zldev->dev, PLATFORM_DEVID_AUTO, dpll_cells,
                           chip_info->num_channels, NULL, 0, NULL);

Ivan
> 
>> +
>> +		rc = devm_mfd_add_devices(zldev->dev, PLATFORM_DEVID_AUTO,
>> +					  &dpll_dev, 1, NULL, 0, NULL);
> 
> Then pass chip_info->num_channels as the 4th argument.
> 
>> +		if (rc) {
>> +			dev_err_probe(zldev->dev, rc,
>> +				      "Failed to add DPLL sub-device\n");
>> +			return rc;
>> +		}
>> +	}
>> +
>>   	/* Register the device as devlink device */
>>   	devlink = priv_to_devlink(zldev);
>>   	devlink_register(devlink);
>> -- 
>> 2.48.1
>>
> 

