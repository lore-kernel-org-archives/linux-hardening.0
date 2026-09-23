Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786553DDAE2
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 05:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142406; cv=none; b=NjV8sIORmbpZpsSGl1+cwSmvXcTu2VTZORMrzcCP5vdw+PvWef5YJ/a0vcTtD/7bSFoqeSNtLbT9j2n5jusZWuamVZMbLzNiqJ192lj8JGaAHIWipBy24vA0WSudpML6SDSPY21CMkjUQA9cpZtaRjf0YCww7JALzSdSyWA5L3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142406; c=relaxed/simple;
	bh=RFcuOwEqjf9SaP/OTSaZv2iojCmoDJVvJIjDiQ7k58Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUMLOsFSSLmQBfCQVLlRuvBJb8eeTvRG23saqSoM4oGsejWbjp/W0a9VbtroCJhhwS00bgA9Zhtog1ggFFOg/6/a+wbmsoK+MF6Nmbj9TXHVnRMrdAGPBj4OabXEkeZh8W0Hohj+ZU9eHe/6TRfs2saRcXNPTtO11NN16wzxMpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=UEfECF5T; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="UEfECF5T"
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id 9CHDxtUfec3Xs9FoYx9cfN; Wed, 23 Sep 2026 05:46:42 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id 9FoXxGrvdkH8b9FoXxuSjP; Wed, 23 Sep 2026 05:46:41 +0000
X-Authority-Analysis: v=2.4 cv=d6X1yQjE c=1 sm=1 tr=0 ts=6ab367c2
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=7T7KSl7uo7wA:10 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=GayhebFrRX0EwB9RMoAA:9 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=OTwx4w9402ve7XEVGULW94SFMv5Tl4N0r/phY59l/8k=; b=UEfECF5TgEW3
	KGIj5aT/C29st5hACjcHuxVLxBSR5tOuRMT/rmWCDjiSiI+BzQMiTkM0qDAMxbHWK0jWLqRxQEoAr
	ro+Og+0qw7/KJY6TDfCr4pB3RfKZ8OPRmY157FqncfrM24JAx8Vq1qu9OrVkMYXgVi9TNeOphlT6a
	4XmHPaMDFoirjhxsqZ4uTut9sorVP017tpwM+iI1+6BS5oO2mfQIrBgWaYEYcjTbj0xYX4QGH9Zpd
	5J3/hzOu3YEydLLXFA7/I/gyV41+wvDJxLQiZwGHasg9hWiT3sD7NJRft+6+8i0pYdAUSndXnjvkA
	87RFK8+svAIE2Wy1cUW05w==;
Received: from flh4-125-195-69-90.tky.mesh.ad.jp ([125.195.69.90]:43316 helo=[10.203.100.34])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100)
	(envelope-from <gustavo@embeddedor.com>)
	id 1x9FoW-0000000204S-0DM9;
	Wed, 23 Sep 2026 00:46:40 -0500
Message-ID: <3e9d09ef-5766-4f19-aa8c-641e15572950@embeddedor.com>
Date: Wed, 23 Sep 2026 14:46:35 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bus: fsl-mc: Annotate fsl_mc_io.portal_virt_addr with
 __counted_by_ptr
To: Bill Wendling <morbo@google.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Justin Stitt <justinstitt@google.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
 codemender-patching+linux@google.com
References: <20260922223538.2287676-1-morbo@google.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260922223538.2287676-1-morbo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 125.195.69.90
X-Source-L: No
X-Exim-ID: 1x9FoW-0000000204S-0DM9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: flh4-125-195-69-90.tky.mesh.ad.jp ([10.203.100.34]) [125.195.69.90]:43316
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 53
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPctvs8GpUxVUd+KIjwAPuXoUvZVght0A993cs2oaDuVamWb97ytUeE2KVUSeKcVx5xGpm1JFzkysA2H+ScNf3ObGrBfMATkVuiUADgRbxeRH4ZpSSpC
 hbU6H8Zmn46hOt7veb3g8c3JmdLH5SB0jAB0igSjkGQ4kKl/1jydPnY7AkwSYrpR13/CU+tFLX02uy5rTcdWJkRb+1+bJmwWyuGQ+C4qSZtsObQh/ZuIOMvo



On 9/23/26 07:35, Bill Wendling wrote:
> The GCC and Clang compilers provide the __counted_by_ptr attribute,
> which is used by KASAN and compiler bounds-checking to detect
> out-of-bounds accesses to pointer fields.
> 
> In "struct fsl_mc_io", the "portal_virt_addr" pointer points to the MC
> command portal virtual address. The size of this allocated portal in
> bytes is tracked by the "portal_size" field within the same structure.
> 
> Annotate the "portal_virt_addr" pointer field with
> "__counted_by_ptr(portal_size)" to enable compiler bounds-checking and
> harden against potential out-of-bounds accesses.
> 
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> ---
>   include/linux/fsl/mc.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
> index c25f0f7e6dd4..0b2c0eb9b605 100644
> --- a/include/linux/fsl/mc.h
> +++ b/include/linux/fsl/mc.h
> @@ -336,7 +336,7 @@ struct fsl_mc_io {
>   	u16 flags;
>   	u32 portal_size;
>   	phys_addr_t portal_phys_addr;
> -	void __iomem *portal_virt_addr;
> +	void __iomem *portal_virt_addr __counted_by_ptr(portal_size);
>   	struct fsl_mc_device *dpmcp_dev;
>   	union {
>   		/*

