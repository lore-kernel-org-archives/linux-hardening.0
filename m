Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2780183CCC;
	Fri, 24 May 2024 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716557944; cv=none; b=Nj2bH0dfDYVaQP8NqSg5qTF23X9Z3JzxdC1oreLtu0iYSV4msfNJWgOZRDsYT7ucIvkMnY4nrDqiLJgCwXaK98/BG19xbj8PxBZIM7e0/ly8/XltbWCQwNIzeo+SRUPFuQdJviU+cJ9pnjYPHUXnPShu/YcY9lavmMNMVUfK0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716557944; c=relaxed/simple;
	bh=nEUl1DoqdvIDPrYGngXugzAOMWJd2cfT1yWPy6X4IHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YVfM6UmUb1ZjQGCZbn69qLb9aAYK6QFh4Ssb3ouXaURCJwXE1BZLIU2t9OqZ/Kx30Hm1+ch2L3fSlVcK6BPthvzoolmv5I6uKBlRg5S5XnlLIPrVCc6vhTu79i9nioWh7x+vAQRiv4yFkPtGQqO6uwcWBBqJr4OFis6LmY4+830=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z7RkUxJ7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rfcOve+j; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z7RkUxJ7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rfcOve+j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z7RkUxJ7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rfcOve+j";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z7RkUxJ7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rfcOve+j"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1DD1333B32;
	Fri, 24 May 2024 13:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716557939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sr7QFX273aoyVkyQ2G7PSaznp9RsacGkzHrDqv37t+4=;
	b=z7RkUxJ75FaTQyG4dbyaqSHuxxgEgipVt/aureD0JYfBjK988LT73nc89yhoXJbUs4yDZz
	oq5U7fmwBNFdODyjlsvEw9pkDEgdZZ0lPi3ggux0hBHHmUmVu4rlrElgs/Fddate2mxFFf
	2iFPJcB9IpgHJ8KkO6f6JUICAVdnGjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716557939;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sr7QFX273aoyVkyQ2G7PSaznp9RsacGkzHrDqv37t+4=;
	b=rfcOve+j5R5pYqlcmUhqL374dcVvVDJqkcfjKuWNQNIXHOOOLwstGb+A64LRZESw2/P66j
	EmHuT+ty0xT87cCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716557939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sr7QFX273aoyVkyQ2G7PSaznp9RsacGkzHrDqv37t+4=;
	b=z7RkUxJ75FaTQyG4dbyaqSHuxxgEgipVt/aureD0JYfBjK988LT73nc89yhoXJbUs4yDZz
	oq5U7fmwBNFdODyjlsvEw9pkDEgdZZ0lPi3ggux0hBHHmUmVu4rlrElgs/Fddate2mxFFf
	2iFPJcB9IpgHJ8KkO6f6JUICAVdnGjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716557939;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sr7QFX273aoyVkyQ2G7PSaznp9RsacGkzHrDqv37t+4=;
	b=rfcOve+j5R5pYqlcmUhqL374dcVvVDJqkcfjKuWNQNIXHOOOLwstGb+A64LRZESw2/P66j
	EmHuT+ty0xT87cCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5DE213A3D;
	Fri, 24 May 2024 13:38:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rF69M3KYUGarSgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 24 May 2024 13:38:58 +0000
Message-ID: <fb2227dc-facb-4760-ba91-49abb54a991c@suse.cz>
Date: Fri, 24 May 2024 15:38:58 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] mm/slab: Plumb kmem_buckets into
 __do_kmalloc_node()
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org, "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
 Xiu Jianfeng <xiujianfeng@huawei.com>, Suren Baghdasaryan
 <surenb@google.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>,
 Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>,
 julien.voisin@dustri.org, linux-kernel@vger.kernel.org
References: <20240424213019.make.366-kees@kernel.org>
 <20240424214104.3248214-2-keescook@chromium.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240424214104.3248214-2-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -2.79
X-Spam-Level: 
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,huaweicloud.com,huawei.com,suug.ch,gondor.apana.org.au,dustri.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On 4/24/24 11:40 PM, Kees Cook wrote:
> To be able to choose which buckets to allocate from, make the buckets
> available to the lower level kmalloc interfaces by adding them as the
> first argument. Where the bucket is not available, pass NULL, which means
> "use the default system kmalloc bucket set" (the prior existing behavior),
> as implemented in kmalloc_slab().
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: linux-mm@kvack.org
> Cc: linux-hardening@vger.kernel.org
> ---
>  include/linux/slab.h | 16 ++++++++--------
>  lib/fortify_kunit.c  |  2 +-
>  mm/slab.h            |  6 ++++--
>  mm/slab_common.c     |  4 ++--
>  mm/slub.c            | 14 +++++++-------
>  mm/util.c            |  2 +-
>  6 files changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index c8164d5db420..07373b680894 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -569,8 +569,8 @@ static __always_inline void kfree_bulk(size_t size, void **p)
>  	kmem_cache_free_bulk(NULL, size, p);
>  }
>  
> -void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node) __assume_kmalloc_alignment
> -							 __alloc_size(1);
> +void *__kmalloc_node_noprof(kmem_buckets *b, size_t size, gfp_t flags, int node)
> +				__assume_kmalloc_alignment __alloc_size(2);
>  #define __kmalloc_node(...)			alloc_hooks(__kmalloc_node_noprof(__VA_ARGS__))
>  
>  void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t flags,
> @@ -679,7 +679,7 @@ static __always_inline __alloc_size(1) void *kmalloc_node_noprof(size_t size, gf
>  				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
>  				flags, node, size);
>  	}
> -	return __kmalloc_node_noprof(size, flags, node);
> +	return __kmalloc_node_noprof(NULL, size, flags, node);

This is not ideal as now every kmalloc_node() callsite will now have to add
the NULL parameter even if this is not enabled. Could the new parameter be
only added depending on the respective config?

>  }
>  #define kmalloc_node(...)			alloc_hooks(kmalloc_node_noprof(__VA_ARGS__))

