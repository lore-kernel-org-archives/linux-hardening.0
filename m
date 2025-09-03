Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AD22E3391
	for <linux-hardening@vger.kernel.org>; Wed,  3 Sep 2025 08:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888598; cv=none; b=e5E5+1rMI7vhJhYfuhNIWZ2sxQqwBpdeSLKOuRrBqbo0VDJiI+5cmrlwi/3Hp6ilIxoQfnN8Gjepta1yYHuxlvUOyabBYA2islnVS64pcxYXjL7W1pVpmDRtWwXAOUD4AenuFn4K9wda7jAwl+QFpdpZsNzFnMbT6UhX6fo+oOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888598; c=relaxed/simple;
	bh=pfIOD2wihPkmDIOdlvguOBiN3hgM5Ymq26fkf8+/mLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkuFSzSrnrHqA3DWbHeCmPsjqqZ+doqp+kTEVUkg9e5wWIsRWPxgGuF+D8GKp91dTsHjnVREbBhS7ajBzyKU31o1H4L2dVDxmTJY0pCvkSuweeIXcblekRTFUXxus5wKGJjEEr2d/AOaqriiDmBZPkLA46uCpg+qPxxpVzYExNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=XDiO88T6; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="XDiO88T6"
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id tgXMu0PmUKXDJtiyku0f8o; Wed, 03 Sep 2025 08:36:30 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id tiyju9w0IM4Krtiyju3T37; Wed, 03 Sep 2025 08:36:29 +0000
X-Authority-Analysis: v=2.4 cv=KLNaDEFo c=1 sm=1 tr=0 ts=68b7fe0d
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=XW3vq5T86JFyMsJaYQInbg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=uY_jprAYB3ThRRmUuAoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xPOvRU10uK9ZVSCWCMReoRW7p5xBpgAQIHli3Z6J08M=; b=XDiO88T6B7hHpfDmMmWr7MKhOE
	/MJnEp8lWWDtzo9SXZ3rnysLZEAvqJkBXJZtB1hwpQ482HK9zxz7EqrtC0nmW9gv62piAsCrMDHHI
	dcLIlcnCfDC0pkD2S0tLKLaD3/hht+1pFoNbNnFCnOLPoy09zm3kvDBdMRZji4saGMLCthitVTTyf
	+JJtmLWQOzMixD8flw6YCp50vzNcKssfm7KfY1iBqTEM2Hy/NyQhk47km2cy5H7i8iNN19Zic3ylR
	zyOSEFfkdIFLEbloKZDFcaGk7Loz/f7N15PkOFByYOup990A/WKRCADmU0cOErAAnzLL1FHc1x7MQ
	jZ+uJtKg==;
Received: from d4b26982.static.ziggozakelijk.nl ([212.178.105.130]:50240 helo=[172.17.143.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1utiyi-000000047SS-2QJT;
	Wed, 03 Sep 2025 03:36:28 -0500
Message-ID: <3f7338c4-1737-4cf7-a789-252abe30bdc6@embeddedor.com>
Date: Wed, 3 Sep 2025 10:36:18 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] drm/amdgpu/amdkfd: Avoid a couple hundred
 -Wflex-array-member-not-at-end warnings
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aLF5vQv9P_vp0R6_@kspp>
 <7a25b5ae-b995-431b-bd46-6d2d58d18e36@amd.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <7a25b5ae-b995-431b-bd46-6d2d58d18e36@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 212.178.105.130
X-Source-L: No
X-Exim-ID: 1utiyi-000000047SS-2QJT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: d4b26982.static.ziggozakelijk.nl ([172.17.143.44]) [212.178.105.130]:50240
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBgPHvGBeyCPlJRMfw8yu1+7+cdC5M4W2iBcqMTmzCvM/w5JMMZn0YCKo2BCWlW1IByHCgZPRqiKCLx+UNzMSOpnbcYJ5F027SHzQaYlMtgS7EIr9Dno
 7XNvaOSzNawk1Bm8aNU422DBKlejtUu8ud+KvY4qMILuixqjA5icrpqpYXKbSMyw+DPZTFbpfxoEFpsFd8CS8WFjkb0o6ylxd9HARqtQ9T+Mo/HFhQYmxBwl



On 9/2/25 17:11, Kuehling, Felix wrote:
> On 2025-08-29 5:58 a.m., Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Move the conflicting declarations to the end of the corresponding
>> structures. Notice that `struct dev_pagemap` is a flexible structure,
>> this is a structure that contains a flexible-array member.
>>
>> Fix 283 of the following type of warnings:
>>      283 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h:111:28: warning: structure containing a flexible array member is not at the end of another structure [- 
>> Wflex-array-member-not-at-end]
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Thank you. I'll apply this to amd-staging-drm-next. I'll also add a note to the commit description that struct dev_pagemap always has space for at least one 
> range, and that amdgpu only uses a single range. Therefore no changes are needed in the way struct amdgpu_device is allocated.

Yep, that's correct. Thank you! :)

-Gustavo
