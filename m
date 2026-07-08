Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B89143E4B5
	for <linux-hardening@vger.kernel.org>; Wed,  8 Jul 2026 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783509415; cv=none; b=gcjtj22WnXtqBSHOkm66vMNgsjsCSilxx8Mjys2vPzqDn6ZHwVOL2vBtrQ+X034xPEOKhauk1NV1BXNUUQ/MDMOF89H7eXpalFeGpK8ItBttc5rCzWRp628bAxnub/Ci6/bv0JKdB8IazQ00GGt6naWT1TKlF89tp+4Ww+d7+MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783509415; c=relaxed/simple;
	bh=3PInDbf4JbfgTmFx+PN8mNEA88VRjgw5io2se7ift1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHfHJwWonx8vBxPcvDjQPoIUZjaoAazpS00ecn+U/Rqq/NaqtBhjkzbyNzJ4ll4qH8kaPGy5WS1Fr8DnDfUnXmldHPaWpQaR7M/uDdysPJe0Yn1K60OO6j9FfeOv79qKJI30mhrUutBQIt5BJ6i0yXUxwC5hw42IhNuO8m+8nOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Za4DuOW8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6r1x0ynR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i0hMqNmj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Aj3XLAhY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Za4DuOW8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6r1x0ynR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i0hMqNmj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Aj3XLAhY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D033D759DC;
	Wed,  8 Jul 2026 11:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783509408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zf0N7hyL9ieefPaK1hQyYaoHoBFLf71w/CV6PNdQScA=;
	b=Za4DuOW8aViDWdGKSRqUx+4l0Wiat9bfqmZmUpcJU4asPLP2SHTX5SRpROgsQ08eJN1xBi
	qY3On68ubhYOTy4etsXYgv/c32bIZQGW+2iDNmvI4CtOn5ojw4nE2pMXfUJTy8nRjeiYcm
	lD4lqTtj3TUUTUSMzpPF5psGnesq2AU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783509408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zf0N7hyL9ieefPaK1hQyYaoHoBFLf71w/CV6PNdQScA=;
	b=6r1x0ynRj86u7sQ1VQIc9IRfOk/cBqFF9KRYm+28V22F8wBxU+EUCOncVAtBQ1OtmqH5eI
	EI4VRIkQK9uUlGCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=i0hMqNmj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Aj3XLAhY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783509407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zf0N7hyL9ieefPaK1hQyYaoHoBFLf71w/CV6PNdQScA=;
	b=i0hMqNmjGuh18zyd9w7EBeCsH3kQW85vULtgyHNjuKGx+sz2m8SL74PJLqYEReu9RZbtv+
	OMnuopjq1kf3VMNu1oF9xcqtPGRKZ6u6Sp041aF9TbrJvcx0CeAUP5g95t2Rpu+TewoSVm
	38IEf9OIvW51n7bf1Nz5bDcochaADvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783509407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zf0N7hyL9ieefPaK1hQyYaoHoBFLf71w/CV6PNdQScA=;
	b=Aj3XLAhYXjGFu1orWSrMrTIBuRA+FR70+NILNlEteFudv028P9a5xA0UZdzNJLRM8qzlKX
	KwpBM+z5LjKsQABA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0590779AE;
	Wed,  8 Jul 2026 11:16:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GMK9Mp4xTmriQQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 08 Jul 2026 11:16:46 +0000
Date: Wed, 8 Jul 2026 12:16:44 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
	Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>
Subject: Re: [PATCH net-next v3] net: skb: isolate skb data area allocations
 into a separate bucket
Message-ID: <ak4w2k4Woj55E0On@pedro-suse>
References: <20260702170728.168755-1-pfalcato@suse.de>
 <04debe19-bbe8-4b5f-9668-753d1f97832d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04debe19-bbe8-4b5f-9668-753d1f97832d@redhat.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D033D759DC
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org,kvack.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,sashiko.dev:url,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed, Jul 08, 2026 at 10:30:50AM +0200, Paolo Abeni wrote:
> On 7/2/26 7:07 PM, Pedro Falcato wrote:> @@ -586,6 +586,8 @@ struct
> sk_buff *napi_build_skb(void *data, unsigned int frag_size)
> >  }
> >  EXPORT_SYMBOL(napi_build_skb);
> >  
> > +static kmem_buckets *skb_data_buckets __ro_after_init;
> > +
> >  static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int node)
> >  {
> >  	if (!gfp_pfmemalloc_allowed(flags))
> > @@ -593,7 +595,8 @@ static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int node)
> >  	if (!obj_size)
> >  		return kmem_cache_alloc_node(net_hotdata.skb_small_head_cache,
> >  					     flags, node);
> > -	return kmalloc_node_track_caller(obj_size, flags, node);
> > +	return kmem_buckets_alloc_node_track_caller(skb_data_buckets, obj_size,
> > +						    flags, node);
> 
> Sashiko noted that some drivers may require GFP_DMA buckets, and the
> above may break them:
> 
> https://sashiko.dev/#/patchset/20260702170728.168755-1-pfalcato%40suse.de

Oh, this is really awkward. Adding linux-mm and slab maintainers for input here.

Considering the current slab bucketing does not seem to duplicate DMA or
CGROUP caches, could it make sense to duplicate those as well? Otherwise we
could add a branch like:

if (gfp_flags & __GFP_DMA)
	/* use the global dma kmalloc caches */

> 
> >  }
> >  
> >  /*
> > @@ -634,7 +637,7 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
> >  	 * Try a regular allocation, when that fails and we're not entitled
> >  	 * to the reserves, fail.
> >  	 */
> > -	obj = kmalloc_node_track_caller(obj_size,
> > +	obj = kmem_buckets_alloc_node_track_caller(skb_data_buckets, obj_size,
> >  					flags | __GFP_NOMEMALLOC | __GFP_NOWARN,
> >  					node);
> 
> Minor nit: checkpatch laments WRT brackets alignment.

Will fix, thanks.

-- 
Pedro
