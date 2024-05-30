Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4856715B542;
	Thu, 30 May 2024 11:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717069007; cv=none; b=XQeEBgOd9NxLDWI5uLpnrQ5VJGZolbSv7Jequo46IL4UMo2H4OYAgGmYVTW3k+JPFIhad3xadyNdWH1zihH0TVN8kMTMQOvTwdPTd9xutw8Eu+qt/9h16mCA21/yDBLcyS7NUpmq/viMrVbowUBmQ4xqOcWaasyPW1mir353O68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717069007; c=relaxed/simple;
	bh=lAyROzAO+jYZ3WcbudQvYxGvD81b3r1StqcJZJ0tal0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t35AnnfXjwTbZjfAFdLPYIMzW6FRd2nzZNVglcHTyUgkhq6ZnBc4iDlEpNpSIgmpxrncz8Ub9s61RYmtfoSW5Id7xDYNPyx9YK1Bum/WLotkynykD+DAmz4Khx8gp72EU+OH1eL10XuQDhYKRlP8DpWslu5knAm1EKorTx5aenQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0AyRuKv1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0lQCY9YY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2BHH0Yb7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=er4IELe+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0AyRuKv1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0lQCY9YY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2BHH0Yb7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="er4IELe+"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EA32B3385A;
	Thu, 30 May 2024 11:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717069003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H1QmM+PZxNZugaPg+B7WVk4t3FLpVQo+v6IALRKoCrc=;
	b=0AyRuKv1vythWcSTdy1g48/592iuwuIdGIYiofYIzvqH/0pVWC2+jUTs1mxHKc2f0LdAFx
	mA81O2lBgEGdUVhuCIoqKXI4uoUAZbiZyLK344dCFRtjwEp1vkHCaDs1UQbWxzjo+482LH
	9CefmwZ+pxy4Np98+sTFvt9UDVOX4N4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717069003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H1QmM+PZxNZugaPg+B7WVk4t3FLpVQo+v6IALRKoCrc=;
	b=0lQCY9YYDPr5qaoH9UYdyeEj+TFgclq7kF9qRqEgYbG9RqXrHbvYjgEBToUwTqxqV6m8Nl
	bzlmVVJ9LsLti8Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2BHH0Yb7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=er4IELe+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717069002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H1QmM+PZxNZugaPg+B7WVk4t3FLpVQo+v6IALRKoCrc=;
	b=2BHH0Yb7z4cWMNV1bVRhRt0P9S8N08DRzgrc3LbzoB/bv9oCoKaK68GvcQQtVfqfVyyTJ4
	EugQ32DGvM+PrHYpc/eLfciZF9MVZfMnp1RdSyL0DmVLuksHH3vkywkxYX/zVUHBG5JrCd
	L9r1nSjpBdp+SckXHheYnKltuXa68kI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717069002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H1QmM+PZxNZugaPg+B7WVk4t3FLpVQo+v6IALRKoCrc=;
	b=er4IELe+o2+gbvJlo1Y1jU4/BbqOBF8JW2ocgEemsvuNLv9HjKTsV8cfxhTrAhRJ1m7jbz
	veA43i6IZSPrmrDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0ECF13A83;
	Thu, 30 May 2024 11:36:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2+nHMspkWGYXPAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 30 May 2024 11:36:42 +0000
Message-ID: <9dd5c65d-036a-4920-bd7a-90e302cf21a8@suse.cz>
Date: Thu, 30 May 2024 13:37:22 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] codetag: avoid race at alloc_slab_obj_exts
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 kernel-dev@igalia.com, Suren Baghdasaryan <surenb@google.com>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20240527183007.1595037-1-cascardo@igalia.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20240527183007.1595037-1-cascardo@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,igalia.com,google.com,linux.com,kernel.org,lge.com,linux-foundation.org,linux.dev,gmail.com,chromium.org];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EA32B3385A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.00

On 5/27/24 8:30 PM, Thadeu Lima de Souza Cascardo wrote:
> When CONFIG_MEM_ALLOC_PROFILING_DEBUG is enabled, the following warning may
> be noticed:
> 
> [   48.299584] ------------[ cut here ]------------
> [   48.300092] alloc_tag was not set
> [   48.300528] WARNING: CPU: 2 PID: 1361 at include/linux/alloc_tag.h:130 alloc_tagging_slab_free_hook+0x84/0xc7
> [   48.301305] Modules linked in:
> [   48.301553] CPU: 2 PID: 1361 Comm: systemd-udevd Not tainted 6.10.0-rc1-00003-gac8755535862 #176
> [   48.302196] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [   48.302752] RIP: 0010:alloc_tagging_slab_free_hook+0x84/0xc7
> [   48.303169] Code: 8d 1c c4 48 85 db 74 4d 48 83 3b 00 75 1e 80 3d 65 02 86 04 00 75 15 48 c7 c7 11 48 1d 85 c6 05 55 02 86 04 01 e8 64 44 a5 ff <0f> 0b 48 8b 03 48 85 c0 74 21 48 83 f8 01 74 14 48 8b 50 20 48 f7
> [   48.304411] RSP: 0018:ffff8880111b7d40 EFLAGS: 00010282
> [   48.304916] RAX: 0000000000000000 RBX: ffff88800fcc9008 RCX: 0000000000000000
> [   48.305455] RDX: 0000000080000000 RSI: ffff888014060000 RDI: ffffed1002236f97
> [   48.305979] RBP: 0000000000001100 R08: fffffbfff0aa73a1 R09: 0000000000000000
> [   48.306473] R10: ffffffff814515e5 R11: 0000000000000003 R12: ffff88800fcc9000
> [   48.306943] R13: ffff88800b2e5cc0 R14: ffff8880111b7d90 R15: 0000000000000000
> [   48.307529] FS:  00007faf5d1908c0(0000) GS:ffff88806cf00000(0000) knlGS:0000000000000000
> [   48.308223] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   48.308710] CR2: 000058fb220c9118 CR3: 00000000110cc000 CR4: 0000000000750ef0
> [   48.309274] PKRU: 55555554
> [   48.309804] Call Trace:
> [   48.310029]  <TASK>
> [   48.310290]  ? show_regs+0x84/0x8d
> [   48.310722]  ? alloc_tagging_slab_free_hook+0x84/0xc7
> [   48.311298]  ? __warn+0x13b/0x2ff
> [   48.311580]  ? alloc_tagging_slab_free_hook+0x84/0xc7
> [   48.311987]  ? report_bug+0x2ce/0x3ab
> [   48.312292]  ? handle_bug+0x8c/0x107
> [   48.312563]  ? exc_invalid_op+0x34/0x6f
> [   48.312842]  ? asm_exc_invalid_op+0x1a/0x20
> [   48.313173]  ? this_cpu_in_panic+0x1c/0x72
> [   48.313503]  ? alloc_tagging_slab_free_hook+0x84/0xc7
> [   48.313880]  ? putname+0x143/0x14e
> [   48.314152]  kmem_cache_free+0xe9/0x214
> [   48.314454]  putname+0x143/0x14e
> [   48.314712]  do_unlinkat+0x413/0x45e
> [   48.315001]  ? __pfx_do_unlinkat+0x10/0x10
> [   48.315388]  ? __check_object_size+0x4d7/0x525
> [   48.315744]  ? __sanitizer_cov_trace_pc+0x20/0x4a
> [   48.316167]  ? __sanitizer_cov_trace_pc+0x20/0x4a
> [   48.316757]  ? getname_flags+0x4ed/0x500
> [   48.317261]  __x64_sys_unlink+0x42/0x4a
> [   48.317741]  do_syscall_64+0xe2/0x149
> [   48.318171]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   48.318602] RIP: 0033:0x7faf5d8850ab
> [   48.318891] Code: fd ff ff e8 27 dd 01 00 0f 1f 80 00 00 00 00 f3 0f 1e fa b8 5f 00 00 00 0f 05 c3 0f 1f 40 00 f3 0f 1e fa b8 57 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 41 2d 0e 00 f7 d8
> [   48.320649] RSP: 002b:00007ffc44982b38 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
> [   48.321182] RAX: ffffffffffffffda RBX: 00005ba344a44680 RCX: 00007faf5d8850ab
> [   48.321667] RDX: 0000000000000000 RSI: 00005ba344a44430 RDI: 00007ffc44982b40
> [   48.322139] RBP: 00007ffc44982c00 R08: 0000000000000000 R09: 0000000000000007
> [   48.322598] R10: 00005ba344a44430 R11: 0000000000000246 R12: 0000000000000000
> [   48.323071] R13: 00007ffc44982b40 R14: 0000000000000000 R15: 0000000000000000
> [   48.323596]  </TASK>
> 
> This is due to a race when two objects are allocated from the same slab,
> which did not have an obj_exts allocated for.
> 
> In such a case, the two threads will notice the NULL obj_exts and after one
> assigns slab->obj_exts, the second one will happily do the exchange if it
> reads this new assigned value.
> 
> In order to avoid that, verify that the read obj_exts does not point to an
> allocated obj_exts before doing the exchange.
> 
> Fixes: 09c46563ff6d ("codetag: debug: introduce OBJEXTS_ALLOC_FAIL to mark failed slab_ext allocations")
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> Cc: Suren Baghdasaryan <surenb@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Thanks!

> ---
>  mm/slub.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 0809760cf789..1373ac365a46 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1952,7 +1952,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  #ifdef CONFIG_MEMCG
>  	new_exts |= MEMCG_DATA_OBJEXTS;
>  #endif
> -	old_exts = slab->obj_exts;
> +	old_exts = READ_ONCE(slab->obj_exts);
>  	handle_failed_objexts_alloc(old_exts, vec, objects);
>  	if (new_slab) {
>  		/*
> @@ -1961,7 +1961,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  		 * be simply assigned.
>  		 */
>  		slab->obj_exts = new_exts;
> -	} else if (cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
> +	} else if ((old_exts & ~OBJEXTS_FLAGS_MASK) ||
> +		   cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
>  		/*
>  		 * If the slab is already in use, somebody can allocate and
>  		 * assign slabobj_exts in parallel. In this case the existing
