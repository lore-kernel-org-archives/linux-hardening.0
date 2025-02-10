Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED8B1CBA18;
	Mon, 10 Feb 2025 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739181940; cv=none; b=Nrh81FSSp6OtiZLpKpahTGwdtEfCjgj5mjwh8Wf9t1WC+mpSyco1Js57OGtqHOJyFBjeHOKuaMSaUpjU/CXqwI9zQmJ8Cc8tOrvAzIVHL9nNsoxG6PitXc6JMqaiwN6gAJijkVjbhRDP4AcNTPyjl9hzY8cfpCN0dhPzs8IFI4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739181940; c=relaxed/simple;
	bh=9V+c79Ybc3Afm0xKGUjzL9b8/mtJ5DL7Y1eYTLnsLyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f298unKXJSlI3X/XDG36J3jdodIZXG1BgOREsXmIs9EnyOZXT0P0OUfN8Ud5M+BLcq9Pm0hjhITqyGzQam7zrmN5yT3eOPc5MbsDFYG94ozvRZbKjqPd76GcwSpqp2Z2oqVKtLzIzKo8n9Y18T/SHwjZRRW8dwA8YXSHuLcpfhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P0skPLgB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=br+kPhgb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oRTxJ/qZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MNd/v9BC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P0skPLgB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="br+kPhgb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oRTxJ/qZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MNd/v9BC"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D0FF01F38F;
	Mon, 10 Feb 2025 10:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739181936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YVnSoIkwfv52XVW57m0P3SMuTTbAAGCE1tva5T3FlZ4=;
	b=P0skPLgByfEvF+nvLzFdKb83b7psUJSalW92rjRY669FcgsozNM6QG6T8NOFnNAAqUuZP0
	01YEvOq3Hq1cutiqwNSPDa9yM+OtXAOOwwdIbLQki8PtpS8tifEei0yQq1048fOwfchLCs
	ctSQjysnxO+BveFqvwBUqkKEFIubw5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739181936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YVnSoIkwfv52XVW57m0P3SMuTTbAAGCE1tva5T3FlZ4=;
	b=br+kPhgbpWNzZhEqnp+YiXH1PgxDj7ui5+8zy8159rRNMj8shMhwMRny+CVWcS9Ln5zwj2
	yRT7/zU7CQ7FkHAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="oRTxJ/qZ";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="MNd/v9BC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739181935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YVnSoIkwfv52XVW57m0P3SMuTTbAAGCE1tva5T3FlZ4=;
	b=oRTxJ/qZ/52dDkc78mdeNgXsCDMWSXsmo7Erpfuqqv8VLDq5lOGNyRknHtQNETk9fstpz2
	CBNCTxJnuW2HnlBJODbkHlTPqCi+/EiprbpfxFz+UNO0lRj6rGNouGkAwzNlJBwmUFZS5u
	xJVGNFovP/zP/lQ2hM/7RfcwryX7IoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739181935;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YVnSoIkwfv52XVW57m0P3SMuTTbAAGCE1tva5T3FlZ4=;
	b=MNd/v9BCzAxcKBtmCz4x1QIFAseTJtG60SL1TDARzYurgfIZxZKLxipZek3Zd3rNqTTaAp
	qlwHvPalYVqC+jAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A09AE13A62;
	Mon, 10 Feb 2025 10:05:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GCmXJm/PqWdsRAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 10 Feb 2025 10:05:35 +0000
Message-ID: <d50c3fae-1c2c-42b1-b622-fcd89c6b2dd3@suse.cz>
Date: Mon, 10 Feb 2025 11:05:35 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] slab: Achieve better kmalloc caches randomization
 in kvmalloc
Content-Language: en-US
To: GONG Ruiqi <gongruiqi1@huawei.com>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>
Cc: Tamas Koczka <poprdi@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Xiu Jianfeng <xiujianfeng@huawei.com>,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250208014723.1514049-1-gongruiqi1@huawei.com>
 <20250208014723.1514049-3-gongruiqi1@huawei.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20250208014723.1514049-3-gongruiqi1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D0FF01F38F
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linux.dev,gmail.com,huawei.com,kvack.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/8/25 02:47, GONG Ruiqi wrote:
> As revealed by this writeup[1], due to the fact that __kmalloc_node (now
> renamed to __kmalloc_node_noprof) is an exported symbol and will never
> get inlined, using it in kvmalloc_node (now is __kvmalloc_node_noprof)
> would make the RET_IP inside always point to the same address:
> 
>     upper_caller
>         kvmalloc
>         kvmalloc_node
>         kvmalloc_node_noprof
>         __kvmalloc_node_noprof	<-- all macros all the way down here
>             __kmalloc_node_noprof
>                 __do_kmalloc_node(.., _RET_IP_)
>             ...			<-- _RET_IP_ points to
> 
> That literally means all kmalloc invoked via kvmalloc would use the same
> seed for cache randomization (CONFIG_RANDOM_KMALLOC_CACHES), which makes
> this hardening unfunctional.

                 non-functional?

> The root cause of this problem, IMHO, is that using RET_IP only cannot
> identify the actual allocation site in case of kmalloc being called
> inside wrappers or helper functions.

inside non-inlined wrappers... ?

>  And I believe there could be
> similar cases in other functions. Nevertheless, I haven't thought of
> any good solution for this. So for now let's solve this specific case
> first.

Yeah it's the similar problem with shared allocation wrappers as what
allocation tagging has.

> For __kvmalloc_node_noprof, replace __kmalloc_node_noprof and call
> __do_kmalloc_node directly instead, so that RET_IP can take the return
> address of kvmalloc and differentiate each kvmalloc invocation:
> 
>     upper_caller
>         kvmalloc
>         kvmalloc_node
>         kvmalloc_node_noprof
>         __kvmalloc_node_noprof	<-- all macros all the way down here
>             __do_kmalloc_node(.., _RET_IP_)
>         ...			<-- _RET_IP_ points to
> 
> Thanks to Tamás Koczka for the report and discussion!
> 
> Link: https://github.com/google/security-research/pull/83/files#diff-1604319b55a48c39a210ee52034ed7ff5b9cdc3d704d2d9e34eb230d19fae235R200 [1]

This should be slightly better? A permalink for the file itself:
https://github.com/google/security-research/blob/908d59b573960dc0b90adda6f16f7017aca08609/pocs/linux/kernelctf/CVE-2024-27397_mitigation/docs/exploit.md

Thanks.

> Reported-by: Tamás Koczka <poprdi@google.com>
> Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>
> ---
>  mm/slub.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 0830894bb92c..46e884b77dca 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4903,9 +4903,9 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
>  	 * It doesn't really make sense to fallback to vmalloc for sub page
>  	 * requests
>  	 */
> -	ret = __kmalloc_node_noprof(PASS_BUCKET_PARAMS(size, b),
> -				    kmalloc_gfp_adjust(flags, size),
> -				    node);
> +	ret = __do_kmalloc_node(size, PASS_BUCKET_PARAM(b),
> +				kmalloc_gfp_adjust(flags, size),
> +				node, _RET_IP_);
>  	if (ret || size <= PAGE_SIZE)
>  		return ret;
>  

