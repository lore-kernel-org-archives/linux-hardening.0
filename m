Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773A821129D;
	Wed, 12 Feb 2025 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373173; cv=none; b=HAI6gzxoJiIdUBWUaHtQLOBsz2Rsb0b2FKuxgY9vdgKz4kbm/C41TVIWb8HxAnIr5pFY55ECcJMXxwKzbPdZfmt5ux2TboxaOt/QSDJrDWNVn4azc4IQ/A0Bieiefl64sWBt04YTsgfheboe7avPYjoL7Duva2YycIFGyf7oQAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373173; c=relaxed/simple;
	bh=Og5b7w8vwT2FfAvIOJEzB8X8fr/IO97aPZnx3C1y12Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vdo9zhCuh8e1ugnsbQB5Y0zyjRhkpCtohSJC6x0vFgt61uxrLxdrD0Y1SGQXnzH7UKrYvfZ8GWAkScYWIdG6iEiIUsDfJ4DP+L1HrtljlWp8vPKgjpidzRdOprMYulsrtJsZz35zRXrBs63cQGJ5LKFQI91ajR6bsT8+9UbLOR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NUf4jfeV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gORug0Bn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KwnHRs8z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FwkFeDEs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NUf4jfeV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gORug0Bn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KwnHRs8z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FwkFeDEs"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EDE321FB41;
	Wed, 12 Feb 2025 15:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739373164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KaBr7AUYFXyg5gP7lASMau8rIKyqar+e3APe/nWwAX0=;
	b=NUf4jfeVO3E+2ctI6PhrJ1uJj9Jt9JEy/+VBt08aMhD1uO/0JmNOlte3l/q0Z36fwqHyqF
	7I9lK1v8PmnzIvu4sWzI8HJDa1kgr1IyxbJj1cCxxkUVEmhp2tF8CO1+7ffe+9n0sczPoQ
	3BP43aYEHwCvLeO/UCondd4htBxFzlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739373164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KaBr7AUYFXyg5gP7lASMau8rIKyqar+e3APe/nWwAX0=;
	b=gORug0BnU+b9unsDYLQTEfWHRZq8Lsd/Jt72vLbhaK2PJ2cw180iNGw6NjXIWpQ53Syku+
	5eZvGj5dX3NSCqBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KwnHRs8z;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FwkFeDEs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739373163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KaBr7AUYFXyg5gP7lASMau8rIKyqar+e3APe/nWwAX0=;
	b=KwnHRs8zxD3PSzbP464uf787fnulHT/AKSW2bm1+FEnUOe4u9OjmH6WvPDAMg7V3pcw07g
	yVwQgP+2NUP9W7rM1nESYxWLow73EhLW3H7bD2cKUCw0X9KbJOsZHFoAtdcDX5+SgBZ4Se
	pUkiQeoch0Jl2uIlKj/75NEpmLunQdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739373163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KaBr7AUYFXyg5gP7lASMau8rIKyqar+e3APe/nWwAX0=;
	b=FwkFeDEsQo/y9C1ZtVaReRiO4GIgOnbP8quomN4CIYdYaet4ZM6aQsl3drKANfSO82uMUb
	No2yf3gQggdzpPDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7F0913AEF;
	Wed, 12 Feb 2025 15:12:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /Fd8MGu6rGcZQgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 12 Feb 2025 15:12:43 +0000
Message-ID: <ea75290d-5fad-4785-8790-408877d846e2@suse.cz>
Date: Wed, 12 Feb 2025 16:12:43 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Refine kmalloc caches randomization in kvmalloc
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
References: <20250212081505.2025320-1-gongruiqi1@huawei.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJkBREIBQkRadznAAoJECJPp+fMgqZkNxIQ
 ALZRqwdUGzqL2aeSavbum/VF/+td+nZfuH0xeWiO2w8mG0+nPd5j9ujYeHcUP1edE7uQrjOC
 Gs9sm8+W1xYnbClMJTsXiAV88D2btFUdU1mCXURAL9wWZ8Jsmz5ZH2V6AUszvNezsS/VIT87
 AmTtj31TLDGwdxaZTSYLwAOOOtyqafOEq+gJB30RxTRE3h3G1zpO7OM9K6ysLdAlwAGYWgJJ
 V4JqGsQ/lyEtxxFpUCjb5Pztp7cQxhlkil0oBYHkudiG8j1U3DG8iC6rnB4yJaLphKx57NuQ
 PIY0Bccg+r9gIQ4XeSK2PQhdXdy3UWBr913ZQ9AI2usid3s5vabo4iBvpJNFLgUmxFnr73SJ
 KsRh/2OBsg1XXF/wRQGBO9vRuJUAbnaIVcmGOUogdBVS9Sun/Sy4GNA++KtFZK95U7J417/J
 Hub2xV6Ehc7UGW6fIvIQmzJ3zaTEfuriU1P8ayfddrAgZb25JnOW7L1zdYL8rXiezOyYZ8Fm
 ZyXjzWdO0RpxcUEp6GsJr11Bc4F3aae9OZtwtLL/jxc7y6pUugB00PodgnQ6CMcfR/HjXlae
 h2VS3zl9+tQWHu6s1R58t5BuMS2FNA58wU/IazImc/ZQA+slDBfhRDGYlExjg19UXWe/gMcl
 De3P1kxYPgZdGE2eZpRLIbt+rYnqQKy8UxlszsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZAUSmwUJDK5EZgAKCRAiT6fnzIKmZOJGEACOKABgo9wJXsbWhGWYO7mD
 8R8mUyJHqbvaz+yTLnvRwfe/VwafFfDMx5GYVYzMY9TWpA8psFTKTUIIQmx2scYsRBUwm5VI
 EurRWKqENcDRjyo+ol59j0FViYysjQQeobXBDDE31t5SBg++veI6tXfpco/UiKEsDswL1WAr
 tEAZaruo7254TyH+gydURl2wJuzo/aZ7Y7PpqaODbYv727Dvm5eX64HCyyAH0s6sOCyGF5/p
 eIhrOn24oBf67KtdAN3H9JoFNUVTYJc1VJU3R1JtVdgwEdr+NEciEfYl0O19VpLE/PZxP4wX
 PWnhf5WjdoNI1Xec+RcJ5p/pSel0jnvBX8L2cmniYnmI883NhtGZsEWj++wyKiS4NranDFlA
 HdDM3b4lUth1pTtABKQ1YuTvehj7EfoWD3bv9kuGZGPrAeFNiHPdOT7DaXKeHpW9homgtBxj
 8aX/UkSvEGJKUEbFL9cVa5tzyialGkSiZJNkWgeHe+jEcfRT6pJZOJidSCdzvJpbdJmm+eED
 w9XOLH1IIWh7RURU7G1iOfEfmImFeC3cbbS73LQEFGe1urxvIH5K/7vX+FkNcr9ujwWuPE9b
 1C2o4i/yZPLXIVy387EjA6GZMqvQUFuSTs/GeBcv0NjIQi8867H3uLjz+mQy63fAitsDwLmR
 EP+ylKVEKb0Q2A==
In-Reply-To: <20250212081505.2025320-1-gongruiqi1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EDE321FB41
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 2/12/25 09:15, GONG Ruiqi wrote:
> Hi,
> 
> v3:
>   - move all the way from kmalloc_gfp_adjust to kvrealloc_noprof into
>     mm/slub.c
>   - some rewording for commit logs
> v2: https://lore.kernel.org/all/20250208014723.1514049-1-gongruiqi1@huawei.com/
>   - change the implementation as Vlastimil suggested
> v1: https://lore.kernel.org/all/20250122074817.991060-1-gongruiqi1@huawei.com/
> 
> Tamás reported [1] that kmalloc cache randomization doesn't actually
> work for those kmalloc invoked via kvmalloc. For more details, see the
> commit log of patch 2.
> 
> The current solution requires a direct call from __kvmalloc_node_noprof
> to __do_kmalloc_node, a static function in a different .c file. As
> suggested by Vlastimil [2], it's achieved by simply moving
> __kvmalloc_node_noprof from mm/util.c to mm/slub.c, together with some
> other functions of the same family.
> 
> Link: https://github.com/google/security-research/blob/908d59b573960dc0b90adda6f16f7017aca08609/pocs/linux/kernelctf/CVE-2024-27397_mitigation/docs/exploit.md?plain=1#L259 [1]
> Link: https://lore.kernel.org/all/62044279-0c56-4185-97f7-7afac65ff449@suse.cz/ [2]
> 
> GONG Ruiqi (2):
>   slab: Adjust placement of __kvmalloc_node_noprof
>   slab: Achieve better kmalloc caches randomization in kvmalloc

Applied to slab/for-next, thanks!

> 
>  mm/slub.c | 162 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/util.c | 162 ------------------------------------------------------
>  2 files changed, 162 insertions(+), 162 deletions(-)
> 

