Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9933B7B6E
	for <linux-hardening@vger.kernel.org>; Wed, 15 Jul 2026 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113675; cv=none; b=Btixsd/EXyJn4gNUs3D63W3wB4TtOx4/1p9j2GX+FdpFvU1o2OJ9UdNNs2f70DJdjE3/v9PIxUNc/axPN9ONHCrOO/h8RTh0E1v1WxVEFBwFJh5FwNG8hEuwvqXgLh1MsCz0hwlvI4F48T//83TQth9u2pJbx6wvm9ZSuu++ZCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113675; c=relaxed/simple;
	bh=Hc514JNshgqWceOMm9U2mfrHvFSvhhnQoBZQ351+jAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkoIKcuWiwaeFbFMfQtBM0SQpldbErtXKGCt0BILqEtfk1uKUJjmqB944KRchuEBWezXVr6eUD7vvaNT6E+4Izo4NghDnDzL1U38D3C+Wob7BktFjyh/1nmq18DKNfWiD+7VZc3V/oKRrjITNnTIdGHbXQcAbK1sp3T4TK80tK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ai83GQU1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mAvO173l; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ai83GQU1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mAvO173l; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ai83GQU1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mAvO173l";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ai83GQU1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mAvO173l"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07A567837A;
	Wed, 15 Jul 2026 11:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784113672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nioUefq1xbXjtodWxvKxZTWQPlbxpqryGWIKwDtgw9w=;
	b=ai83GQU1QSLW4HMqQLHqkTNNKJcdnVJeYTkcJczwLEkaWbE4HH08Sgzz4Zi3FfHHLXKF0w
	BUqWf9xtp+Poz7MSTvJxVILX1rJ1fg0J0/12EhNSXj8Ts27FocAgBdZZtHRJP2E0SYcjVW
	dRLsXyhi36zD9Vi640oinf7YuU/RvAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784113672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nioUefq1xbXjtodWxvKxZTWQPlbxpqryGWIKwDtgw9w=;
	b=mAvO173lFLygJBfvjytDRj9llSE+d8jC3KzkTwirCPAfOhdFiZxPmaq14VxHUPIQnWNtTe
	BMuK6oUQqZjAcqAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784113672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nioUefq1xbXjtodWxvKxZTWQPlbxpqryGWIKwDtgw9w=;
	b=ai83GQU1QSLW4HMqQLHqkTNNKJcdnVJeYTkcJczwLEkaWbE4HH08Sgzz4Zi3FfHHLXKF0w
	BUqWf9xtp+Poz7MSTvJxVILX1rJ1fg0J0/12EhNSXj8Ts27FocAgBdZZtHRJP2E0SYcjVW
	dRLsXyhi36zD9Vi640oinf7YuU/RvAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784113672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nioUefq1xbXjtodWxvKxZTWQPlbxpqryGWIKwDtgw9w=;
	b=mAvO173lFLygJBfvjytDRj9llSE+d8jC3KzkTwirCPAfOhdFiZxPmaq14VxHUPIQnWNtTe
	BMuK6oUQqZjAcqAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E927779AE;
	Wed, 15 Jul 2026 11:07:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iqBNAAdqV2ooAwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 15 Jul 2026 11:07:51 +0000
Date: Wed, 15 Jul 2026 12:07:49 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Harry Yoo <harry@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	linux-mm@kvack.org, Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH net-next v3] net: skb: isolate skb data area allocations
 into a separate bucket
Message-ID: <aldpAY6nXwgayHL0@pedro-suse.lan>
References: <20260702170728.168755-1-pfalcato@suse.de>
 <04debe19-bbe8-4b5f-9668-753d1f97832d@redhat.com>
 <ak4w2k4Woj55E0On@pedro-suse>
 <529e3997-d26f-4d8e-ad90-3329fe90e555@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <529e3997-d26f-4d8e-ad90-3329fe90e555@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,pedro-suse.lan:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Wed, Jul 08, 2026 at 10:27:54PM +0900, Harry Yoo wrote:
> 
> 
> On 7/8/26 8:16 PM, Pedro Falcato wrote:
> > On Wed, Jul 08, 2026 at 10:30:50AM +0200, Paolo Abeni wrote:
> >> On 7/2/26 7:07 PM, Pedro Falcato wrote:> @@ -586,6 +586,8 @@ struct
> >> sk_buff *napi_build_skb(void *data, unsigned int frag_size)
> >>>  }
> >>>  EXPORT_SYMBOL(napi_build_skb);
> >>>  
> >>> +static kmem_buckets *skb_data_buckets __ro_after_init;
> >>> +
> >>>  static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int node)
> >>>  {
> >>>  	if (!gfp_pfmemalloc_allowed(flags))
> >>> @@ -593,7 +595,8 @@ static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int node)
> >>>  	if (!obj_size)
> >>>  		return kmem_cache_alloc_node(net_hotdata.skb_small_head_cache,
> >>>  					     flags, node);
> >>> -	return kmalloc_node_track_caller(obj_size, flags, node);
> >>> +	return kmem_buckets_alloc_node_track_caller(skb_data_buckets, obj_size,
> >>> +						    flags, node);
> >>
> >> Sashiko noted that some drivers may require GFP_DMA buckets, and the
> >> above may break them:
> >>
> >> https://sashiko.dev/#/patchset/20260702170728.168755-1-pfalcato%40suse.de
> > 
> > Oh, this is really awkward. Adding linux-mm and slab maintainers for input here.
> > 
> > Considering the current slab bucketing does not seem to duplicate DMA or
> > CGROUP caches, could it make sense to duplicate those as well?
> 
> Could we specify what kmalloc types the user needs when creating
> kmem_buckets and duplicate caches for the requested kmalloc types only?

Perhaps. But do the users themselves know? alloc_skb() allows users to specify
random __GFP flags. We're bound to see some random caller do
alloc_skb(__GFP_ACCOUNT) ;)

In all honesty, I'm not quite sure what the best way forward here is. The most
transparent way is to bucket those other kmalloc types as well, but that might
very trivially result in a lot more caches (and possibly memory usage) for no
great reason. So perhaps specifying caches might do.

-- 
Pedro
