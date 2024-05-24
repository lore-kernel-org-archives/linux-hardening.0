Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CBE48CCC;
	Fri, 24 May 2024 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716558218; cv=none; b=ufMlSvkY/E9lIX/1sLlxtc1VhOr6SmdrWsk76zoqlboRfmKxsn2XfSPBQ2UBAOBHsQ92Xr2s29eu6smVBdbmY6C3Rkpj17NZdGzzQ+yzsgz5nPCUWeURnS5j9C6GIrydXjoPPFWZLNRuQoidaQtLck+v4vL00f5MkcFNuzcPSUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716558218; c=relaxed/simple;
	bh=cASt5Gq+MzmerFyjDSSbLRLvNUUUGACwoXVV2AZBuCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROETgQzcUel6h22rtPZa5trH6CLT3YC4LPUcUJRDgkGaM33dYUP//ss7f+5KJLAkWiX76cr+dXhUl4MUVVKXMLcasTyI0ag26dL6B0SBEQJ8b+UJcbCr9KTj/kC/nVXBSYG/KIv6dXOKrAmqmLWpJQwgBSrhX9M+54B6GTsfRpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mRmEcha3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GXZoXpNM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mRmEcha3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GXZoXpNM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mRmEcha3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GXZoXpNM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mRmEcha3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GXZoXpNM"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3EBAA20A5D;
	Fri, 24 May 2024 13:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716558214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YJ9ov1ih/Htcxrz4xMcatNZjxTV+V0xnQjiLS2C3JSU=;
	b=mRmEcha3Ltz9RvWXvBHgnAjREnJML1EWvgVKjXYnAc/TC/uUALwWWAkKx4jUxqeCATbhQY
	0TyEqSH8ALvf/SudneTHyGosAunG/R0gsrG0MzN3VNZNf/4LKmIRbnKp5PcgUK+PdKsl+M
	kciguIGkB/zGr5zMHCWyRyoqh9JykL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716558214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YJ9ov1ih/Htcxrz4xMcatNZjxTV+V0xnQjiLS2C3JSU=;
	b=GXZoXpNMzdZhUODaVJ840CfdlwgPp8zoRlDmRoJyoVSMJAL7zMi2Nr5zUk5Dgsz1Wzq4E0
	yFz73dNdAZuPRcDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mRmEcha3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GXZoXpNM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716558214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YJ9ov1ih/Htcxrz4xMcatNZjxTV+V0xnQjiLS2C3JSU=;
	b=mRmEcha3Ltz9RvWXvBHgnAjREnJML1EWvgVKjXYnAc/TC/uUALwWWAkKx4jUxqeCATbhQY
	0TyEqSH8ALvf/SudneTHyGosAunG/R0gsrG0MzN3VNZNf/4LKmIRbnKp5PcgUK+PdKsl+M
	kciguIGkB/zGr5zMHCWyRyoqh9JykL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716558214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YJ9ov1ih/Htcxrz4xMcatNZjxTV+V0xnQjiLS2C3JSU=;
	b=GXZoXpNMzdZhUODaVJ840CfdlwgPp8zoRlDmRoJyoVSMJAL7zMi2Nr5zUk5Dgsz1Wzq4E0
	yFz73dNdAZuPRcDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 163B213A3D;
	Fri, 24 May 2024 13:43:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y2EfBYaZUGa8IQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 24 May 2024 13:43:34 +0000
Message-ID: <eab4f90c-bfb2-4595-9f52-f88146310c6f@suse.cz>
Date: Fri, 24 May 2024 15:43:33 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] mm/slab: Introduce kmem_buckets_create() and
 family
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
 Xiu Jianfeng <xiujianfeng@huawei.com>, Suren Baghdasaryan
 <surenb@google.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>,
 Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>,
 julien.voisin@dustri.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240424213019.make.366-kees@kernel.org>
 <20240424214104.3248214-4-keescook@chromium.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240424214104.3248214-4-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -3.00
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3EBAA20A5D
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,huaweicloud.com,huawei.com,suug.ch,gondor.apana.org.au,dustri.org,vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On 4/24/24 11:41 PM, Kees Cook wrote:
> Dedicated caches are available for fixed size allocations via
> kmem_cache_alloc(), but for dynamically sized allocations there is only
> the global kmalloc API's set of buckets available. This means it isn't
> possible to separate specific sets of dynamically sized allocations into
> a separate collection of caches.
> 
> This leads to a use-after-free exploitation weakness in the Linux
> kernel since many heap memory spraying/grooming attacks depend on using
> userspace-controllable dynamically sized allocations to collide with
> fixed size allocations that end up in same cache.
> 
> While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
> against these kinds of "type confusion" attacks, including for fixed
> same-size heap objects, we can create a complementary deterministic
> defense for dynamically sized allocations that are directly user
> controlled. Addressing these cases is limited in scope, so isolation these
> kinds of interfaces will not become an unbounded game of whack-a-mole. For
> example, pass through memdup_user(), making isolation there very
> effective.
> 
> In order to isolate user-controllable sized allocations from system
> allocations, introduce kmem_buckets_create(), which behaves like
> kmem_cache_create(). Introduce kmem_buckets_alloc(), which behaves like
> kmem_cache_alloc(). Introduce kmem_buckets_alloc_track_caller() for
> where caller tracking is needed. Introduce kmem_buckets_valloc() for
> cases where vmalloc callback is needed.
> 
> Allows for confining allocations to a dedicated set of sized caches
> (which have the same layout as the kmalloc caches).
> 
> This can also be used in the future to extend codetag allocation
> annotations to implement per-caller allocation cache isolation[1] even
> for dynamic allocations.
> 
> Memory allocation pinning[2] is still needed to plug the Use-After-Free
> cross-allocator weakness, but that is an existing and separate issue
> which is complementary to this improvement. Development continues for
> that feature via the SLAB_VIRTUAL[3] series (which could also provide
> guard pages -- another complementary improvement).
> 
> Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [1]
> Link: https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html [2]
> Link: https://lore.kernel.org/lkml/20230915105933.495735-1-matteorizzo@google.com/ [3]
> Signed-off-by: Kees Cook <keescook@chromium.org>

So this seems like it's all unconditional and not depending on a config
option? I'd rather see one, as has been done for all similar functionality
before, as not everyone will want this trade-off.

Also AFAIU every new user (patches 5, 6) will add new bunch of lines to
/proc/slabinfo? And when you integrate alloc tagging, do you expect every
callsite will do that as well? Any idea how many there would be and what
kind of memory overhead it will have in the end?


