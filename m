Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0322F2A
	for <linux-hardening@vger.kernel.org>; Wed, 16 Apr 2025 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744762830; cv=none; b=VBp+ZVFUMogRuPRAevTVRQFCOL0cSTCNZlausRt8xBeq5LLfqwns+yf5TJXgWEiIbHQT1IKnj0yZfsWBpY8rwDL9rTa6YIwrkgiTuwAvAWNCYWW01WmyXP3u5hcuh2IQWm7q5FWpdX236OokVYp9nI0MTa/+yhnQlT/Cqki1Fmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744762830; c=relaxed/simple;
	bh=pEcAvlgMDveQLVt1s66C/EGs9ZNANsyG4xv9UpvaSnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F92R/pYTPm76r9yTKasClVeUXDU9CuOQfmamv58zCfqzdB6CpMRl1iaIC7ie/XHVfa/+rK1EYJ+RO//2sZIDoxF7qLA4Bea0iP6FG8CP8YybZRXc+IQFQBAN3MhO/H4Ook1s6AWtDFoUlMl2Sq2Wi9UybTec4G7NaQNjC2HGn/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Tus3AVpu; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Tus3AVpu"
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id 4ftguYNWHXshw4qVpuNHtf; Wed, 16 Apr 2025 00:20:21 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 4qVnuzpXdWbZN4qVouT8Mu; Wed, 16 Apr 2025 00:20:20 +0000
X-Authority-Analysis: v=2.4 cv=NvrXcddJ c=1 sm=1 tr=0 ts=67fef7c4
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=B3fuDwYyW55wTQKIj88FGw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=CpFGIHgWpZrg6UVlTl0A:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s1BeglVl5V4o/Bv4MNYA8HZfcp4/8kdwxBCW7kEmm38=; b=Tus3AVpuBOJzRWt/kY+9xi+3BS
	WhuaVT6hUU4KACDczFzoFwIJK44rC7YwdfOJbU9gCRQgBIeFCTvroZclz0p07WxBBUI1TFNKmoPFS
	bR16XKnSjc/ZkF6RzKcGjW1nBNgWFbeRxGlUNjMpicjR/rwBPqyAaJq5I7rA6LeXUdpsoiFoELjSy
	BMXW+8zHq0VtzNdeelXjytqQ6wasRoH8i6AQx9YpOWy4KMVm/mYvP++CQaGPCjcv+llWZVxHVK8G1
	6vKx3knYXo3D+tTBj0tr/dC4ShqcQ6DLIH8263qVeZcEvVIgRErNsEGPpQuQriS9mtp+M/NCoqk/z
	QnFbtNrg==;
Received: from [201.172.174.147] (port=56116 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1u4qVm-00000000nFf-2h71;
	Tue, 15 Apr 2025 19:20:19 -0500
Message-ID: <a1c6fd4e-69b4-4698-bc5d-ef02cf7312e4@embeddedor.com>
Date: Tue, 15 Apr 2025 18:20:03 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] nvme-loop: Avoid -Wflex-array-member-not-at-end
 warning
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <Z-axRObjXYjIHGQC@kspp>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <Z-axRObjXYjIHGQC@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.147
X-Source-L: No
X-Exim-ID: 1u4qVm-00000000nFf-2h71
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.174.147]:56116
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCfH5QxiZJ5UxOgMgWMk23duNLyUGFZgobAou8kOcDn5V5w3HKQ6uL4D1Ybqs/dZGFay8wDIG6EwNWBEgoJ5mErEpJDO7ebZkxvVw4zz1n7I15uZdpX6
 cO/zK9VsTp6zwzMKRmDQA4ouYXbo9TiKQ13f6RV1WTUyAK6c3hC8KTU2l1nyvEJMpbmyW5wCfklalk+n2Xx7O95onKZrcTcXoD2NTm/d1yjCrjThKLjZRBOI

Hi all,

Friendly ping: who can take this patch, please? :)

Thanks!
-Gustavo

On 28/03/25 08:25, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the structure. Notice
> that `struct nvme_loop_iod` is a flexible structure --a structure
> that contains a flexible-array member.
> 
> Fix the following warning:
> 
> drivers/nvme/target/loop.c:36:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   drivers/nvme/target/loop.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index a5c41144667c..d02b80803278 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -33,10 +33,12 @@ struct nvme_loop_ctrl {
>   
>   	struct list_head	list;
>   	struct blk_mq_tag_set	tag_set;
> -	struct nvme_loop_iod	async_event_iod;
>   	struct nvme_ctrl	ctrl;
>   
>   	struct nvmet_port	*port;
> +
> +	/* Must be last --ends in a flexible-array member. */
> +	struct nvme_loop_iod	async_event_iod;
>   };
>   
>   static inline struct nvme_loop_ctrl *to_loop_ctrl(struct nvme_ctrl *ctrl)

