Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3483FB38
	for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705941961; cv=none; b=JwIVdRIVBAV7aZQIGiwPYHDjMIP3p324iR4QKe/y0be9Grdnrhu2Sc3hZUq4KAz0WsaYQvQtg8RBpxKlbpj1QF2ONb7DxkTlrAZdmNTGG8O1V9+wGd3Qc61Ypuontte4sr7vC0SgwNhMJtnpNRlYXPyBzFQg7paTU/vXpQt065k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705941961; c=relaxed/simple;
	bh=bOmyxojR3+oXa6teSWZQqPnpcVJXl6gQ3beLTvYaNNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=trpMBs74qEZA1K+6dEOEDKza658iKCBrNeaHOdiiK6CoETyJoljK/xsAnYaHzf3cVVS41ou0/9p3dgkVayqslTlVQv8H+612ODbr/WpNHCnU9f+S82FIxl+wkfoUKQmmmdtUuBLomO+PO3+YpH+Aol397aewjQYcQqUkEF4V3pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=CpdmXFW1; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="CpdmXFW1"
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id Rvrprgk5WMVQiRxQorhUZi; Mon, 22 Jan 2024 16:45:54 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RxQnrxhrYfPByRxQorlYhW; Mon, 22 Jan 2024 16:45:54 +0000
X-Authority-Analysis: v=2.4 cv=T+af8tGQ c=1 sm=1 tr=0 ts=65ae9bc2
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=7YfXLusrAAAA:8 a=ps32sclX-u3JLzBWafQA:9 a=QEXdDO2ut3YA:10
 a=9cHFzqQdt-sA:10 a=PUnBvhIW4WwA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=SLz71HocmBbuEhFRYD3r:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xUmqrSRHbxv53MrhsbK61lfGw0UBXJAtEIXR6/E0CJU=; b=CpdmXFW14Ut65dA/d7TajA+NjN
	er+uzY2rdtSFEn/ege72uebuTI1K4TtaeCE+EjzE6QR7HDsTUNJIz2zfdNAkb2cPCOtToqekVQBen
	C/LIZLfjnWTKu5c3745w8D6zdWTWAu+3Ep/fLdxBIkneE1b+wNHs439HZKydo/5qnYQnKKvpLpkWF
	q9njQKFarI31OvYq+S4H31FFF+1eoglpskI/FYjupjdJg4ZhWC91MhFB9QpNRsGQfoKN4815Wn+Pr
	B1OKXWD5dNWaoPbo+7jKOjNq8KfhrfRb8nh0IazN2PaOeCLYbvko7W8pip3xxqnnf85UKRaJDGAWW
	eZL7322Q==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:56808 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rRxQn-004JlJ-0e;
	Mon, 22 Jan 2024 10:45:53 -0600
Message-ID: <91e87233-3a10-43d6-b850-9cac083913e0@embeddedor.com>
Date: Mon, 22 Jan 2024 10:45:52 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/habanalabs: use kcalloc() instead of kzalloc()
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>, Oded Gabbay <ogabbay@kernel.org>,
 Marco Pagani <marpagan@redhat.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240120151028.11092-1-erick.archer@gmx.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240120151028.11092-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1rRxQn-004JlJ-0e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:56808
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJUHVv05wZnXqkL9+EmSJRr4uYSp6jSlQAkwKtFztFLUlBn4q27zC8y074WffcfwghTKeUcvVgAqnVFw10JiFwSQrqf18cQGhbgqyRCUFktCJ4PVRsS3
 T2H1M9mpdmq3SkT58SKIYdFXNXjaQgSGHZ9gqAfx6y6l9U4ARk3EgGQPexeJTnnt+w41tOcatoTSZoiyE1p5dySIygnbNb0cIJn2mQ0r80V56wE4tZxIT0Sb



On 1/20/24 09:10, Erick Archer wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific kcalloc() function instead of the argument
> size * count in the kzalloc() function.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> 
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   drivers/accel/habanalabs/common/mmu/mmu_v1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/habanalabs/common/mmu/mmu_v1.c b/drivers/accel/habanalabs/common/mmu/mmu_v1.c
> index d925dc4dd097..e3d42cfead27 100644
> --- a/drivers/accel/habanalabs/common/mmu/mmu_v1.c
> +++ b/drivers/accel/habanalabs/common/mmu/mmu_v1.c
> @@ -232,7 +232,7 @@ static int dram_default_mapping_init(struct hl_ctx *ctx)
>   	/* add hop1 and hop2 */
>   	total_hops = num_of_hop3 + 2;
> 
> -	ctx->dram_default_hops = kzalloc(HL_PTE_SIZE * total_hops,  GFP_KERNEL);
> +	ctx->dram_default_hops = kcalloc(total_hops, HL_PTE_SIZE,  GFP_KERNEL);
>   	if (!ctx->dram_default_hops)
>   		return -ENOMEM;
> 
> --
> 2.25.1
> 
> 
