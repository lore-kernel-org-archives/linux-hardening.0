Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2620B13C679
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jul 2024 23:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720653428; cv=none; b=uTABrHz+pDm4D/UrExDhJBnun9KdFCE5E9z2obmWLVmm52BDnlAB4mDN0zCCSKJ5toO4u+OwgR5QOYeruyVBwWF00AkFlEosnKb17Uyc5fob0FfTfgz3r5EzlTndqwNd5MvFuSiyaoFEU9zkYXTqRG4dt8FVbslbjB04wLUrmnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720653428; c=relaxed/simple;
	bh=/Z3LhZV9FBdTa0nv078PPSOZZz1Eynyr/1qLnzPpDH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mi+JEunTWjy95Xy88JzfqTDFOaNHielbhQBURQIKLFoX5Tftkv2nv7yM+13Bi1U8ZPOUO3eWaXVmeMGClFUxs7JGtlJEb8McnFrik4+kKrDLPw6sQtmYLCk6/FoSdfyNtxf2BDZDK66HBQwAZigRliDZ+9Rz/BGIuszYbODpJu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Yey7/kAu; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Yey7/kAu"
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id RcXHs4cJdnNFGRgYcs94oX; Wed, 10 Jul 2024 23:17:06 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RgYbsvxLaRn6WRgYbs5oOX; Wed, 10 Jul 2024 23:17:05 +0000
X-Authority-Analysis: v=2.4 cv=KbTUsxYD c=1 sm=1 tr=0 ts=668f1671
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=twV4k4tpM6jbvoAuFuAA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=TjNXssC_j7lpFel5tvFf:22
 a=cvBusfyB2V15izCimMoJ:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kMfEEDYKHMIokzjHcMS3uX5TREDWKTeMbnyO8Tlp8ZQ=; b=Yey7/kAuGkQWaUkXdzhvE7MtbZ
	Fka+U097WBwjTUiHBRvkS59k3pur9fzY9FFUlCRPABTGH+bzL+WvfkesEIPKKG9qW2Mrcrt/3UKym
	lLz7nONovpggW4DRyTPjijfclbmwWoHFwgfPbCZsQ2COIDoF3jePJKC766jLAtGVsILezxjq3/XCV
	xI25a0KqoFVGfL2NFar7pbc/Xk0VTG77NNJg1h1hWJqYvpLUbL7r8qSiT+l+qUfmje4n5MWMi4CcQ
	wZ5tICMMdXUSIBGOFyfy3mtjBK5q7WvbkMgmmFO+Sg6Udb24FLQgwhV0H6A72zfOnReKdHtlsfOY0
	m5d9xXNA==;
Received: from [201.172.173.139] (port=39968 helo=[192.168.15.4])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sRgYa-004DUh-1x;
	Wed, 10 Jul 2024 18:17:04 -0500
Message-ID: <21e3d039-a447-4779-b751-4cbf9a4e7584@embeddedor.com>
Date: Wed, 10 Jul 2024 17:17:03 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: venus: hfi_cmds: struct
 hfi_session_release_buffer_pkt: Add __counted_by annotation
To: Kees Cook <kees@kernel.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Cc: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240710230728.work.977-kees@kernel.org>
 <20240710230914.3156277-2-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240710230914.3156277-2-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sRgYa-004DUh-1x
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.4]) [201.172.173.139]:39968
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMox8HCS9kHx7oxKSqhLGBkViSvwtrWtMAMA44PoJ9HXd/pdn9rZeYcA+b7Rkl2xgBXM1tYLYbAcYkHFYLj1/YY6mqLOPgYegQUTwY8/TJzp7Uqp74BN
 MfWUfqteMq/zWqugZUr7K9dcoYA9WHeUo0QYVcK7lyAWybJIsMIAsO5iErvzrt3kevdL9OYb0PryADVwwl76QrzVcO/Gt4qHiB3qHYGW//iz4bbpbnFVxbUa



On 10/07/24 17:09, Kees Cook wrote:
> The only direct user of struct hfi_session_release_buffer_pkt is
> pkt_session_unset_buffers() which sets "num_buffers" before using it
> as a loop counter for accessing "buffer_info". Add the __counted_by
> annotation to reflect the relationship.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
> Cc: Vikash Garodia <quic_vgarodia@quicinc.com>
> Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-media@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
> index 42825f07939d..1adf2d2ae5f2 100644
> --- a/drivers/media/platform/qcom/venus/hfi_cmds.h
> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
> @@ -227,7 +227,7 @@ struct hfi_session_release_buffer_pkt {
>   	u32 extradata_size;
>   	u32 response_req;
>   	u32 num_buffers;
> -	u32 buffer_info[];
> +	u32 buffer_info[] __counted_by(num_buffers);
>   };
>   
>   struct hfi_session_release_resources_pkt {
