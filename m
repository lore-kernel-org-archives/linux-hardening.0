Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC274F4D13;
	Tue, 22 Sep 2026 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071937; cv=none; b=kC4mvIaA1T7JT3PQBX0Zcq3SJgz5hwc3i4nV5Kq52lEtCVsu4/Cg14G/wNMel3REHTbMHIWywxyu57Tmtq6+WutBS1XHi9zeBGyPu7V1Cb7PsCGcQDezD9PnnJS6LpOdn+g2cRY0y+AvdpfnYG4mh6tgHsWXUjyfWhZgcCfJ2xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071937; c=relaxed/simple;
	bh=8Gnn0pIiy/aRytE8lzwwFJTjMOX7+jel1eYT0/O9T2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qABTDKeOoYqLplEeNGfKzOVdEpKVZkPsP5g4G2JfN5DQJotmg7QsIS51Li3QVulq/MCeHqRCqBTEtbrAx/33gGoGjgoGjkd5loacZsLuqZGIju75jGZfgJXRGQdsspVa0FGz/Za+lCFU++drwWUJWFpL4w2f1ABlsXaC+QUY4ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jqIdH4Q6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EtmhcwJL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Hz2OXK42; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=M+BtSL9c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jqIdH4Q6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EtmhcwJL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Hz2OXK42";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="M+BtSL9c"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 99FE621BF6;
	Tue, 22 Sep 2026 10:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790071929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4V2W84nnZxZtsNLlJYzmWJXrEP0iK8clXop5+Bi29YM=;
	b=jqIdH4Q6tJxawmvcDiwlcQAq3m0O3CQyCs9kSSU4Q7mhSNtMiPh3jPjKWPk/T7DIXu8SsH
	bazakabGgOM+9sAtQxqOOw1Rhf87NTbCUIN0G+JxlNH0nCwwymD3H+QyrmpER0Bl/ydSzE
	g2bQUtE3raIbD32dG5XamvIHmzpDx7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790071929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4V2W84nnZxZtsNLlJYzmWJXrEP0iK8clXop5+Bi29YM=;
	b=EtmhcwJLKOGJvdHEPn+hdXgNEw7TbIu+LOzjSBpVWCH6uALQ4lOgdEvm0qwTqjysFpRfi9
	MP6c/cuWhWJMZhBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790071925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4V2W84nnZxZtsNLlJYzmWJXrEP0iK8clXop5+Bi29YM=;
	b=Hz2OXK42rVLTCxsOsLAVeEBwSg0oiwfqZJ3JC1N0xa5BSdeeMieW1KlQ5efaeXK9UjYasP
	V5AaceXaYxpspqwKPeApJVC77KFER9YxajkEhB8cidfsUBdlusq29EZSh9ZnMmf3CQWlc/
	87EWDe1kz99N8iYE6PFSySWEWHhTlWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790071925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4V2W84nnZxZtsNLlJYzmWJXrEP0iK8clXop5+Bi29YM=;
	b=M+BtSL9czFqWAAJUSt5EqlMB7CKZiyhY+XEsU0po3W212ggTvnYkrRlYv5dQDdtOZYF1rO
	iPE3SzQyU7Sie/BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC5D0136D9;
	Tue, 22 Sep 2026 10:12:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I3LsGXFUsmqrFgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 22 Sep 2026 10:12:01 +0000
Date: Tue, 22 Sep 2026 11:11:58 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	Kuniyuki Iwashima <kuniyu@google.com>, linux-hardening@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Willem de Bruijn <willemb@google.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 5/7] mm/slab: Provide kmalloc type fallback for bucket
 allocations
Message-ID: <arJSz0r5u_78NWKe@pedro-suse.tail5790ac.ts.net>
References: <20260921075811.too.775-kees@kernel.org>
 <20260921075820.1718334-5-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921075820.1718334-5-kees@kernel.org>
X-Spam-Score: 0.70
X-Spam-Level: 
X-Spamd-Result: default: False [0.70 / 50.00];
	ABUSE_SURBL(5.00)[linux-foundation.org:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,linux.dev,gentwo.org,google.com,kvack.org,vger.kernel.org,davemloft.net,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pedro-suse.tail5790ac.ts.net:mid,imap1.dmz-prg2.suse.org:helo,suse.de:email,linux-foundation.org:email,linux.dev:email]
X-Spam-Flag: NO

Hi Kees,

Big thanks for continuing this effort :))

On Mon, Sep 21, 2026 at 12:58:16AM -0700, Kees Cook wrote:
> kmem_buckets_create() clones kmalloc_caches[KMALLOC_NORMAL].
> kmalloc_slab() figures out the kmalloc type the caller asks for, but
> then ignored it whenever a bucket set was in use, returning a normal
> cache regardless. This would be a problem if a caller asked for GFP_DMA,
> __GFP_ACCOUNT, etc. None of the current users do this, so there is
> problem, but it makes adding new users fragile. For example, skb data[1]
> needs to handle GFP_DMA (rarely) and __GFP_ACCOUNT (often).
> 
> Send those allocations to the general caches instead so nothing breaks and
> regular allocations remain isolated with the bucket. The kmem_bucket_type
> enum contains only a single item here, but will be expanded in the next
> patch.
> 
> Built and tests pass with ARCH=x86_64 defconfig with GCC 16.2.0, with
> CONFIG_SLAB_BUCKETS as y and n.
> 
> Assisted-by: LLM
> Link: https://lore.kernel.org/all/04debe19-bbe8-4b5f-9668-753d1f97832d@redhat.com/ [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Harry Yoo <harry@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Hao Li <hao.li@linux.dev>
> Cc: Christoph Lameter <cl@gentwo.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: <linux-mm@kvack.org>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: <linux-hardening@vger.kernel.org>
> ---
>  include/linux/slab.h   | 13 +++++++++++
>  mm/slab.h              | 23 ++++++++++++++++--
>  lib/tests/slub_kunit.c | 53 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 87 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 18a2351f9084..ab9ab3d34847 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -742,6 +742,19 @@ typedef struct kmem_cache * kmem_buckets[KMALLOC_SHIFT_HIGH + 1];
>  
>  extern kmem_buckets kmalloc_caches[NR_KMALLOC_TYPES];
>  
> +/*
> + * The kmalloc types a bucket set can hold a copy of. This is deliberately not
> + * enum kmalloc_cache_type: the KMALLOC_PARTITION copies are all "normal" to a
> + * bucket set, which already separates what they were there to separate, so
> + * indexing by those would mean up to KMALLOC_PARTITION_CACHES_NR unusable
> + * rows per set. Allocations of any type not listed here are served by the
> + * general caches.
> + */

This sounds odd. Is there a good reason why KMALLOC_PARTITIONs are kmalloc_cache_types?
Perhaps that bit should be reworked instead?

> +enum kmem_bucket_type {
> +	KMEM_BUCKET_NORMAL = 0,
> +	NR_KMEM_BUCKET_TYPES
> +};
> +
>  /*
>   * Define gfp bits that should not be set for KMALLOC_NORMAL.
>   */
> diff --git a/mm/slab.h b/mm/slab.h
> index 8fd6835e4235..7f1bfee83b92 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -421,6 +421,26 @@ static inline unsigned int size_index_elem(unsigned int bytes)
>  	return (bytes - 1) / 8;
>  }
>  
> +/*
> + * Which set of buckets to use for the given kmalloc_cache_type. If not
> + * handled by the kmem_buckets, fall back to general caches.
> + */
> +static inline kmem_buckets *
> +kmalloc_choose_bucket(kmem_buckets *bucket, enum kmalloc_cache_type type)
> +{
> +	enum kmem_bucket_type btype;
> +
> +	if (!bucket)
> +		return &kmalloc_caches[type];
> +
> +	if (type <= KMALLOC_PARTITION_END)
> +		btype = KMEM_BUCKET_NORMAL;
> +	else
> +		return &kmalloc_caches[type];	/* No set holds a row for it. */

Hitting this case sounds like a bug in the kernel. WARN_ON_ONCE()?

Otherwise LGTM.

-- 
Pedro
