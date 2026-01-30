Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7DA330662
	for <linux-hardening@vger.kernel.org>; Fri, 30 Jan 2026 21:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769809303; cv=none; b=eVOtfAA3IElsfCuDamHQaMosEG2s62tSIfgwbAI9fL1kfm9hTq3k74HzYKriU0ZIh0lEGQfr+dJA46vjOf8Ms6zIPH9BjNmpFxSp50tl/meGiCkQKhx61GqqwjGw9EOeZFD32vH+7raRVHFQkNPCFyGcNxM+MeJ7B9hbq68a5mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769809303; c=relaxed/simple;
	bh=d151nPhV/og8GP7fl9WfBTcaZ8tdSVrTU+4LsAva8ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/AlZX4DloAWNOj06ooD2a/dEc/sdSb1H3gLy6fx3GM64d0B0tJpwfmunlOlW0jV0hjpFPFI3QJtV8RA+b/3OT3js1gqanJTpOne/aZcIpC/RIVcOa7fwQ9YoqXsf3nhyBwoL5crtpirRDamKjvsbuWcqxssoQyLQ0HY1B7jDXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=unRIMCNu; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="unRIMCNu"
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id luJZv5gcEipkClwFEvboUN; Fri, 30 Jan 2026 21:41:36 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id lwFDvUKpZhoT4lwFEvBKuL; Fri, 30 Jan 2026 21:41:36 +0000
X-Authority-Analysis: v=2.4 cv=XZyJzJ55 c=1 sm=1 tr=0 ts=697d2590
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=boSZjC74iCM+AjoU0vq/6A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=ajYwpdcRSMJ5fXWETOcA:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FVdo6peTxUwsOnHuBQDXdxvyZZx91dKKbw9Za1mv6Ec=; b=unRIMCNutEWq0yx4wXSCP4FwKL
	Ks/LLSb25eea1AJhVAICnn8hTljrasodhMJ9PRpQ68h2+T98XnU/FbtDtrkESL3cPN7yuQugt/F6p
	9zCwH1ov4SOGBj1md5ILytxogOP5EJYXoixu+AMfTDDvcHYXMcZ0k1zyOPm1VmPDMM+aZtkdcSm3c
	yhnLF+QoOkkAtT6gvRvIAFEB69AVaXJNGyFRTZ2km7RLPZo4/HCnBd5TVUzD00JgTq7Ruio1/23kx
	vxfXObHJ4Jx/+21FHxpzEu5BMrfmhrM9KhznVqU6lu4jQVmq6/wSmStHod30MZQ5kb+/yEfFUd2N1
	4jqERDww==;
Received: from [177.238.18.27] (port=38706 helo=[192.168.0.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vlwFD-00000004Kr6-0wMJ;
	Fri, 30 Jan 2026 15:41:35 -0600
Message-ID: <7d712992-e006-4787-95ee-e82cfa25f8ff@embeddedor.com>
Date: Fri, 30 Jan 2026 15:40:57 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] dlm: Avoid -Wflex-array-member-not-at-end warning
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aNFbP3UaRokBxruI@kspp>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <aNFbP3UaRokBxruI@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.18.27
X-Source-L: No
X-Exim-ID: 1vlwFD-00000004Kr6-0wMJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.104]) [177.238.18.27]:38706
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLN+ekJkiC3M0d4w3OvYbMWtcwemoUtFf5f5yw6k9eI6SiG9EWnPvzY/AKJQ08+60htFhYeE4duQcPPvZ4T6Nm/seeAREtuuDER977wNCPMRgXmltQT6
 nmNYqDwfmOb2fIKp3PWglA/1Xa1TMhXqfBGjJaKYx+ab/ENN2FZLQ6QQaENI+cXSEiV9MnLiI+WYAOp6ch1H1NgYoaDmR6Wd1UHaR5Y3SrryBtFJErdP7rLV

Hi all,

Who can take this, please?

Thanks
-Gustavo

On 9/22/25 23:20, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the corresponding
> structure. Notice that `struct dlm_message` is a flexible
> structure, this is a structure that contains a flexible-array
> member.
> 
> Fix the following warning:
> 
> fs/dlm/dlm_internal.h:609:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   fs/dlm/dlm_internal.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
> index d534a4bc162b..9df842421ae0 100644
> --- a/fs/dlm/dlm_internal.h
> +++ b/fs/dlm/dlm_internal.h
> @@ -606,7 +606,6 @@ struct dlm_ls {
>   
>   	struct dlm_rsb		ls_local_rsb;	/* for returning errors */
>   	struct dlm_lkb		ls_local_lkb;	/* for returning errors */
> -	struct dlm_message	ls_local_ms;	/* for faking a reply */
>   
>   	struct dentry		*ls_debug_rsb_dentry; /* debugfs */
>   	struct dentry		*ls_debug_waiters_dentry; /* debugfs */
> @@ -665,6 +664,9 @@ struct dlm_ls {
>   
>   	int			ls_namelen;
>   	char			ls_name[DLM_LOCKSPACE_LEN + 1];
> +
> +	/* Must be last --ends in a flexible-array member.*/
> +	struct dlm_message	ls_local_ms;	/* for faking a reply */
>   };
>   
>   /*

