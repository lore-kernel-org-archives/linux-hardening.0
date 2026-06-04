Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5886814883F
	for <linux-hardening@vger.kernel.org>; Thu,  4 Jun 2026 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600331; cv=none; b=CetQerIhVnNY7N3zxzTDkhAZe/gRcRKOCaIFDV7+E/yHJfOLD/4QXLkIHFOCSozVlDj9qS5iHPr92st+M2AGqtZ7wl4LEY5b/BwHlaLd5J8hAAl7tOU8bQwS5kD2i4l5OiubPBXpklmPE1152mDwCUBZQ2BDWGDFYMwhxW6V3sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600331; c=relaxed/simple;
	bh=ykembX4DnSNgKL3XfltodtBr2NEGN0VjjMVEs45i9AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zj769Jgkgt/P1HzppVkLUKs29xC/o5itHW2zYOPu1cGn7osdMmNABW0iSYmXoPkvBf5yg8REgYqcegNIWJxwtK1x+5UXt7vxqi94MeP4ZhFT3NDjNoRuMpTZtG9oNwYWa7/0g+whk4OYVLMA4STjIGsj051ZE+RzJEjxMpJ7lEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=du+BNIwg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MIZ1n7v5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=du+BNIwg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MIZ1n7v5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="du+BNIwg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MIZ1n7v5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="du+BNIwg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MIZ1n7v5"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 71F816B029;
	Thu,  4 Jun 2026 19:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780600327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9L7i2swvOC+jyqEqBi6J71Dz7ZL2TF4c4yN/go0BL5o=;
	b=du+BNIwgZkPrCHvZZp6Z5pgYTtbhQg6LVpneHU5VcpuZUPHfCuNNJJxDn08F6cRF8XjfEg
	kpwU2X5A5fBjRAkEaQx2ZvKzsCBjTktKKMF8uRkANugAs8Lr+LvgrAVxAreIEihf045E0z
	+B447SxeQm16FMgnEJ7FVzy/TqQ7cW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780600327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9L7i2swvOC+jyqEqBi6J71Dz7ZL2TF4c4yN/go0BL5o=;
	b=MIZ1n7v5OoSUdcDUgR1RvEt12w6lYFbzx5nExRtHBJkzaCfLmp/gyJmNpZoCjbgRfzoaIy
	SLLWM/u6shUkS6BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=du+BNIwg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MIZ1n7v5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780600327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9L7i2swvOC+jyqEqBi6J71Dz7ZL2TF4c4yN/go0BL5o=;
	b=du+BNIwgZkPrCHvZZp6Z5pgYTtbhQg6LVpneHU5VcpuZUPHfCuNNJJxDn08F6cRF8XjfEg
	kpwU2X5A5fBjRAkEaQx2ZvKzsCBjTktKKMF8uRkANugAs8Lr+LvgrAVxAreIEihf045E0z
	+B447SxeQm16FMgnEJ7FVzy/TqQ7cW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780600327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9L7i2swvOC+jyqEqBi6J71Dz7ZL2TF4c4yN/go0BL5o=;
	b=MIZ1n7v5OoSUdcDUgR1RvEt12w6lYFbzx5nExRtHBJkzaCfLmp/gyJmNpZoCjbgRfzoaIy
	SLLWM/u6shUkS6BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFEFC779A8;
	Thu,  4 Jun 2026 19:12:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F7e4LQXOIWr4fQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 04 Jun 2026 19:12:05 +0000
Date: Thu, 4 Jun 2026 20:12:03 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Harry Yoo <harry@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hao Li <hao.li@linux.dev>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH 2/2] net: skb: isolate skb data area allocations into a
 separate bucket
Message-ID: <aiHIQ4ZxnMSifhmi@pedro-suse>
References: <20260602183122.747759-1-pfalcato@suse.de>
 <20260602183122.747759-3-pfalcato@suse.de>
 <6d70757a-a849-4828-89e7-f3d51bf8c9f8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d70757a-a849-4828-89e7-f3d51bf8c9f8@kernel.org>
X-Spam-Flag: NO
X-Rspamd-Action: no action
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,davemloft.net,google.com,redhat.com,vger.kernel.org,kvack.org,linux.dev,gentwo.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 71F816B029
X-Spam-Score: -4.01

On Thu, Jun 04, 2026 at 02:30:34PM +0900, Harry Yoo wrote:
> 
> 
> On 6/3/26 3:31 AM, Pedro Falcato wrote:
> > SKB data area allocations (as done from alloc_skb()) use kmalloc().
> > These allocations can be variably sized and their contents can be more
> > or less controlled from userspace, which makes them useful for attackers
> > that want to overwrite a use-after-free'd object from the same kmalloc slab
> > (which often just requires the sizes to roughly match into the same kmalloc
> > bucket). [0] is an easy example of an exploit that uses netlink skb
> > allocation to target another similarly-sized accidentally freed object.
> > 
> > While other mitigations like CONFIG_RANDOM_KMALLOC_CACHES exist, these are
> > probabilistic. Use the existing kmem buckets API to further isolate these
> > allocations in a guaranteed fashion, when CONFIG_SLAB_BUCKETS=y.
> > 
> > Link: https://github.com/google/security-research/blob/master/pocs/linux/kernelctf/CVE-2023-4207_lts_cos_mitigation_2/docs/exploit.md [0]
> > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> > ---
> >  net/core/skbuff.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 44a7f8401468..1f6c6b531ece 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -594,6 +594,8 @@ static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int node)
> >  	return kmalloc_node_track_caller(obj_size, flags, node);
> >  }
> >  
> > +static kmem_buckets *skb_data_buckets __ro_after_init;
> > +
> >  /*
> >   * kmalloc_reserve is a wrapper around kmalloc_node_track_caller that tells
> >   * the caller if emergency pfmemalloc reserves are being used. If it is and
> > @@ -632,7 +634,7 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
> >  	 * Try a regular allocation, when that fails and we're not entitled
> >  	 * to the reserves, fail.
> >  	 */
> > -	obj = kmalloc_node_track_caller(obj_size,
> > +	obj = kmem_buckets_alloc_node_track_caller(skb_data_buckets, obj_size,
> >  					flags | __GFP_NOMEMALLOC | __GFP_NOWARN,
> >  					node);
> >  	if (likely(obj))
> 
> What about kmalloc_pfmemalloc()?

Good point, that looks free as well.

Sidenote: isolating kmem_cache_alloc for possibly-aliasing caches could also
be useful. skb allocation has net_hotdata.skb_small_head_cache. It doesn't merge
with anything for $raisins (odd size, plus I don't think usercopy caches are
getting merged?) but it feels too... accidental?

Maybe passing something like SLAB_NO_MERGE and making the size
standard-looking would be nice. I have a size of 704 bytes per object, and
this probably causes some weird wastage for each slab.


-- 
Pedro
