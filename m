Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A7A3845C5
	for <linux-hardening@vger.kernel.org>; Tue, 17 Mar 2026 23:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773790632; cv=none; b=UhFwzq+RnZY1AnYiCOckJZkW21Xbr3ew0omiJPIIlHEzy9yNR8/23tMrzq9BI7Dop6o4Wjm1IO7sCH4OXFqzrCFPPNV+QTYhfTLYxICYpCbLgysXRuMMOdeTxUXshbKfTEEnvli7G5p174bPUe8vy1tioXQea9pc1PptQST3UAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773790632; c=relaxed/simple;
	bh=4N87Bkgtb0/aGn4yfIfymyt96koi5R0U5OOrJR6hay8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qykzHf0ZLCv7YwrPAVKYdgpGmmy4huVm6tUMkCRyQIBLgqeUlyFbBJgJbNCS+NO2WJ0ZZRFj+UMnHz4X4+iWqLDhspoQ+vzysPGXFTfK+Eo+qt+rnK7htk3HluwotX9Sq4vdRVK8fKUflgrYYb/75jyfOdhjgnv+1335F1TbviE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=LUyho57F; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="LUyho57F"
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id 2aaEwYMtbJ9SZ2dyDwbX8k; Tue, 17 Mar 2026 23:37:05 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 2dyCwTQBd2l0k2dyCwhGnC; Tue, 17 Mar 2026 23:37:05 +0000
X-Authority-Analysis: v=2.4 cv=UfRRSLSN c=1 sm=1 tr=0 ts=69b9e5a1
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=5vZi_tIctBNeQFYZvx8A:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sDIz43D4MTuOarQG71u0YgFU0v977L2RxVybNkE8u+4=; b=LUyho57FaqByRfJY7uhMTFmu2S
	JtvA8JfGgXdiudXrchA0Ne/x/yclFIlMivpsXOevHirW5mjG/icJGiTomPM944RHVFmL96nWTmfbf
	0OHakIJxjnSoVrU4ROHvZ6m6HnQGzW17aca0t5fDloRsihkysr7Gh1NC13gYw5ykkbNKanAPYAwX3
	ZOl6Fnzyv+XdMK8DiJpToUkVbAaVXuNLyL90Cnml9v2GZJ+wQyyhgc3WQAUWQQT4YWd9f7CZoNVUx
	IbnseujQlUkv6pZY5YwQvJt7q72HYKUyhCFr0WLWS+v0YgGP388H1jJ7N+E3jkXuLlpo6PdDlVIkD
	xU9H6wJw==;
Received: from [177.238.16.13] (port=58304 helo=[192.168.0.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1w2dy9-00000004JzL-3q9f;
	Tue, 17 Mar 2026 18:37:02 -0500
Message-ID: <bde61932-9c7e-4139-8d6a-8059c205a217@embeddedor.com>
Date: Tue, 17 Mar 2026 17:35:39 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: nx - annotate struct nx842_crypto_header with
 __counted_by
To: Thorsten Blum <thorsten.blum@linux.dev>, Haren Myneni <haren@us.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260317201804.1393389-3-thorsten.blum@linux.dev>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260317201804.1393389-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.13
X-Source-L: No
X-Exim-ID: 1w2dy9-00000004JzL-3q9f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.104]) [177.238.16.13]:58304
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPEXtIjuJ06e6YLFbEm9QyAqyEa3NzAfe2YrFfRo2U/4IpdxdzhTrum6p+FwnmMBY2E0TI0PZzicdiSdx95tRUyKY4felT78gXfjdlfweRHIVb4ib5j2
 /rZ5fkcYsme2YvuEP7jB9reKhtPGg9D7HopKuWR/Z3zADPvkx02B3FMWhayy7cCncF3D0oPthEWK89/gcunaakALjWmtRFHye9rFDuCY49aUQF2xtvt+h0SP



On 3/17/26 14:18, Thorsten Blum wrote:
> Add the __counted_by() compiler attribute to the flexible array member
> 'group' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> ---
>   drivers/crypto/nx/nx-842.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/nx/nx-842.h b/drivers/crypto/nx/nx-842.h
> index f5e2c82ba876..a04e85e9f78e 100644
> --- a/drivers/crypto/nx/nx-842.h
> +++ b/drivers/crypto/nx/nx-842.h
> @@ -164,7 +164,7 @@ struct nx842_crypto_header {
>   		__be16 ignore;		/* decompressed end bytes to ignore */
>   		u8 groups;		/* total groups in this header */
>   	);
> -	struct nx842_crypto_header_group group[];
> +	struct nx842_crypto_header_group group[] __counted_by(groups);
>   } __packed;
>   static_assert(offsetof(struct nx842_crypto_header, group) == sizeof(struct nx842_crypto_header_hdr),
>   	      "struct member likely outside of struct_group_tagged()");
> 

