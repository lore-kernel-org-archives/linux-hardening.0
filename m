Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6519E2561AE
	for <linux-hardening@vger.kernel.org>; Tue, 11 Nov 2025 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851070; cv=none; b=XUICyjZiNnWqvTyzKc+k8BpdMzub0KoIeKQYCq0MLrYlpmk7sjp4Hm4dOeZQMXC6Ezk46fa6YWhd2MYsihQmE4xFa1oaxCf6Mo6KtxIrJavpSXbJcyFzfNdtXq5G6Fjb6tO/y5Up2S8ylTaRuW5i81Z7oGube48rw2otWZ2+LLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851070; c=relaxed/simple;
	bh=3KgTt8ZAoJFGlhBsCdLEdKHx84sD5ovia/hV0vx1TVg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V7HKXpsk6X2XjixCg4SdodW4w+ieE7ERyzPvnHUEg6s7nm3Lzfh+InynYeyfUy5xHbC5dByaZDzTFuv9Ag6BYM+WevKyK1JJAN6d3K+2vFFuTLhavquNmGYPZMhbQtcbSMHKB0IxVgeXgZjEN0YdBkRAjMQWJQ/VXeGuvPQDjyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=mL/VzBHa; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="mL/VzBHa"
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id IhhxvHF8hVCBNIk4CvsVsG; Tue, 11 Nov 2025 08:49:32 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Ik4BvkUL3ji5HIk4BvTsXD; Tue, 11 Nov 2025 08:49:31 +0000
X-Authority-Analysis: v=2.4 cv=P6s6hjAu c=1 sm=1 tr=0 ts=6912f89c
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=F0GicbU7tRTSLTLZ85HXVw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=7T7KSl7uo7wA:10
 a=nIWqaF5DGeDNdwXvIUwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XU9jZyuTWIB29Sv+8FJ4Bsp2R0KnLhXHALKjykygo7M=; b=mL/VzBHamT4V0Unxgjx7l5za+A
	s1Um8KTNsCO9Gkfg8USgz/lMr+Afy05+Z/QcOE6UyTDcLYGLofhzARrF3GVifY8g+Xv86YQlDoY5D
	+YLhfYjQ9g+SxWBItLeRyFP0DxTvZ7kAzYhH9vIZSv7DE6okwfpMCXqwT28mWp7WsIGCWDkNpcmKl
	8/6a/gEBTK3YYnAd3vHP+HSFMzH6IpvAMU6BZ+52OKcDWcxIjoyG7Z2Ud4/irbjT/UfDyZEQl5iKI
	ToZVOo1qh6AdE49MMzy4LdFCQArSj8mZBu5rXg7ee5sySZFqemCJH+PZ0H3gTrsDBPIYx7V8rgQPi
	KepuOaTA==;
Received: from m106072098064.v4.enabler.ne.jp ([106.72.98.64]:53302 helo=[10.221.86.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vIk4A-00000002W6u-3V16;
	Tue, 11 Nov 2025 02:49:31 -0600
Message-ID: <3d50e0a2-77fd-4c87-bf74-8ab8b6b15ce2@embeddedor.com>
Date: Tue, 11 Nov 2025 17:49:20 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] iommufd/iommufd_private.h: Avoid
 -Wflex-array-member-not-at-end warning
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Nicolin Chen <nicolinc@nvidia.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aRHOAwpATIE0oajj@kspp> <aRIoufDcyohFWQz1@Asurada-Nvidia>
 <36cc3b51-601d-4412-9dca-9752e2d77a51@embeddedor.com>
Content-Language: en-US
In-Reply-To: <36cc3b51-601d-4412-9dca-9752e2d77a51@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 106.72.98.64
X-Source-L: No
X-Exim-ID: 1vIk4A-00000002W6u-3V16
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: m106072098064.v4.enabler.ne.jp ([10.221.86.44]) [106.72.98.64]:53302
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFGtcH6Io++ZFGrK21rLbx05Em6YVBQhXTFd3yWz3DIQmP3bMV45k1/Y6cuTjA0DSPrngALlpk2MtYTL/vSs6C7naWZGADkb/pCukk2+4qqOSxrD+ky3
 /7XME041MKJb4Qgf4C4Lc2Yyja5rYrcmS8kGuGkqcJM9STZTHQYE/uUPvHxYaq3q3lxtmKsL1762zh1607gEzSEViQCS0XWnffABjMsiZtyo4HE4beFcYQEQ



On 11/11/25 16:20, Gustavo A. R. Silva wrote:
> 
> 
> On 11/11/25 03:02, Nicolin Chen wrote:
>> On Mon, Nov 10, 2025 at 08:35:31PM +0900, Gustavo A. R. Silva wrote:
>>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>>> getting ready to enable it, globally.
>>>
>>> Move the conflicting declaration to the end of the corresponding
>>> structure. Notice that struct iommufd_vevent is a flexible
>>> structure, this is a structure that contains a flexible-array
>>> member.
>>>
>>> Fix the following warning:
>>>
>>> drivers/iommu/iommufd/iommufd_private.h:621:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array- 
>>> member-not-at-end]
>>
>> IIUIC, there might be data corruption due to this? If so, I think

Okay, I didn't find evidence of data corruption. So, this patch can be applied to
a -next tree.

> 
> Yep. Also, after taking a look at the commit you mention, the counted_by annotation
> in struct iommufd_vevent is wrong in commit e8e1ef9b77a7 ("iommufd/viommu: Add
> iommufd_viommu_report_event helper"). The counter, in this case vevent->data_len
> must always be initialized before the first reference to the flexible array:
> 
> diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
> index 6f1010da221c..21d4a35538f6 100644
> --- a/drivers/iommu/iommufd/driver.c
> +++ b/drivers/iommu/iommufd/driver.c
> @@ -161,8 +161,8 @@ int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
>                  vevent = &veventq->lost_events_header;
>                  goto out_set_header;
>          }
> -       memcpy(vevent->event_data, event_data, data_len);
>          vevent->data_len = data_len;
> +       memcpy(vevent->event_data, event_data, data_len);
>          veventq->num_events++;
> 
>   out_set_header:

I will submit the above as a separate patch.

Thanks
-Gustavo

