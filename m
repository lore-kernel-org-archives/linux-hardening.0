Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C630327180B;
	Wed, 12 Feb 2025 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739370744; cv=none; b=otc2reRHEqjxTMZ7EYGqDN31Pbq77FVUbF8xy72CJwZTyu2pQx3j08BPhAqYSz4g1tfX99qdjmuevgD8IE+T67X7sbd40582BFbrOD+hgKGonSOlfAvOdiG9+1ARTcSNfwUQCZ1X093Iwhu3S6C2TKPM0mwk8HRMc/0LRTOiPD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739370744; c=relaxed/simple;
	bh=uttk/8N9bTT/GbyOULHpMzTmqJDYocTv4bs1LU5K9kM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GssxSJOtqjbz6hoqqAMUhn7iF/6Q64FTuGkQlqdA9J5dllibsQXCmxv7CNCaChH9Rn92XPhfBMsClF3P3BvfOby+mIzhuIFrmR8pI7AKrPMWkqu30qy5Cro+/T4OwhbqEYLVIwokEE6uFkRCk6Tg21ZIEuOD+qaKAfSatPIE5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nUvShn1a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ItWYJmnp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nUvShn1a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ItWYJmnp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nUvShn1a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ItWYJmnp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nUvShn1a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ItWYJmnp"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C958C337B4;
	Wed, 12 Feb 2025 14:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739370740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ye8yKCiRFKz8E9Wr/Bto9ANzqQ7EA3W0jKUpD3AWWoM=;
	b=nUvShn1ahh2rK2QbQlkJ/Jxz1wrohrDssNykOM1+g5l8CtQHh41swYgWCfvgLUTPAQ8pt6
	IvbIic3s5Aux3Npwu4OGRe4JLLzmNypgRrax+lCd1OpDehlEZ3xsD3mkCLuVoCXOdyq7sG
	IV6UOW7OesyWUdVzAdBh4VlAG3sCT2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739370740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ye8yKCiRFKz8E9Wr/Bto9ANzqQ7EA3W0jKUpD3AWWoM=;
	b=ItWYJmnp5XYFvrPiqmNB8vwDNfiASyb0jSyYhE8+VQEtnLPoWyW7qhgQRZK+NnwhW0PBqk
	379iC2Xktobw6vBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739370740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ye8yKCiRFKz8E9Wr/Bto9ANzqQ7EA3W0jKUpD3AWWoM=;
	b=nUvShn1ahh2rK2QbQlkJ/Jxz1wrohrDssNykOM1+g5l8CtQHh41swYgWCfvgLUTPAQ8pt6
	IvbIic3s5Aux3Npwu4OGRe4JLLzmNypgRrax+lCd1OpDehlEZ3xsD3mkCLuVoCXOdyq7sG
	IV6UOW7OesyWUdVzAdBh4VlAG3sCT2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739370740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ye8yKCiRFKz8E9Wr/Bto9ANzqQ7EA3W0jKUpD3AWWoM=;
	b=ItWYJmnp5XYFvrPiqmNB8vwDNfiASyb0jSyYhE8+VQEtnLPoWyW7qhgQRZK+NnwhW0PBqk
	379iC2Xktobw6vBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAC1C13874;
	Wed, 12 Feb 2025 14:32:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pQYrKfSwrGfyMgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 12 Feb 2025 14:32:20 +0000
Message-ID: <30b06d39-f1b8-45b3-8c81-5d4dffed30a5@suse.cz>
Date: Wed, 12 Feb 2025 15:32:20 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Refine kmalloc caches randomization in kvmalloc
Content-Language: en-US
To: Harry Yoo <42.hyeyoo@gmail.com>, GONG Ruiqi <gongruiqi1@huawei.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
 Tamas Koczka <poprdi@google.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Xiu Jianfeng <xiujianfeng@huawei.com>, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250212081505.2025320-1-gongruiqi1@huawei.com>
 <Z6yuQEYJbmWi8z23@fedora>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <Z6yuQEYJbmWi8z23@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,huawei.com];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On 2/12/25 15:20, Harry Yoo wrote:
> On Wed, Feb 12, 2025 at 04:15:03PM +0800, GONG Ruiqi wrote:
>> Hi,
>> 
>> v3:
>>   - move all the way from kmalloc_gfp_adjust to kvrealloc_noprof into
>>     mm/slub.c
>>   - some rewording for commit logs
>> v2: https://lore.kernel.org/all/20250208014723.1514049-1-gongruiqi1@huawei.com/
>>   - change the implementation as Vlastimil suggested
>> v1: https://lore.kernel.org/all/20250122074817.991060-1-gongruiqi1@huawei.com/
>> 
>> Tamás reported [1] that kmalloc cache randomization doesn't actually
>> work for those kmalloc invoked via kvmalloc. For more details, see the
>> commit log of patch 2.
>> 
>> The current solution requires a direct call from __kvmalloc_node_noprof
>> to __do_kmalloc_node, a static function in a different .c file. As
>> suggested by Vlastimil [2], it's achieved by simply moving
>> __kvmalloc_node_noprof from mm/util.c to mm/slub.c, together with some
>> other functions of the same family.
> 
> Hi, GONG!
> Sorry for my late review.
> 
> This patch series looks good to me (with a nit),
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> Also, I verified that the problem you described exists on slab/for-next,
> and the patch series fixes the problem. Please feel free to add,
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

> nit: Does it make sense to call __kvmalloc_node_track_caller_noprof()
> instead of __do_kmalloc_node() to avoid bloating the code size?

Hm I think it would be a bit arbitrary to make kvmalloc special like this
here. But we should probably change __do_kmalloc_node() to
__fastpath_inline. Or even check if not making it inline at all results in
other callers (not kvmalloc probably due to its complexity) doing a tail
call there, which should be fast enough.

> My simple build test says it saves 1592 bytes:
>   $ ./scripts/bloat-o-meter slub.o.before slub.o.after
>   add/remove: 0/1 grow/shrink: 0/1 up/down: 0/-1592 (-1592)
>   Function                                     old     new   delta
>   __kvmalloc_node_noprof.cold                   39       -     -39
>   __kvmalloc_node_noprof                      1755     202   -1553
>   Total: Before=79723, After=78131, chg -2.00%
> 
>> Link: https://github.com/google/security-research/blob/908d59b573960dc0b90adda6f16f7017aca08609/pocs/linux/kernelctf/CVE-2024-27397_mitigation/docs/exploit.md?plain=1#L259 [1]
>> Link: https://lore.kernel.org/all/62044279-0c56-4185-97f7-7afac65ff449@suse.cz/ [2]
> 

