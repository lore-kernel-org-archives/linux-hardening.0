Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFAA3D69;
	Sat,  1 Jun 2024 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717275943; cv=none; b=rZb4JRMrhA3kEN52hN1S5vlr6P0c6UdVia3RRFLrTNWn4EbgjfPj+jhWlLNurMH1CW3hKkhqBjeWrvpfKni8eDV50Bn2b5rJ1uy6PiPtKfPUH/DW+cJFnMt15AJAcUin7i5xFaCSfYp/Xc+AY+ZF8dRi7u1qNYP9+AiYxLBQOmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717275943; c=relaxed/simple;
	bh=ljldlZuW5R96CDDUsml/oGI7I8C/lXL9K+6aVcKgyaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWBsqcvadJmW90jwDfyItCc94TwqB5AEVvCvh3glASipK5mMDervO9J6HllBazNiPiIRYzzH8f6j31StujYz8H+JANluRMQyqV5EvFF2Mkd9j2Lss3goqGDC1LMoci4q/mHnHTXxm3tUUOIX5tMkjKYiarzUBXFuoLLDGMN5h9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Op6iEKu4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dBvJNwmx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Op6iEKu4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dBvJNwmx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Op6iEKu4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dBvJNwmx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Op6iEKu4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dBvJNwmx"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A054E1FEEC;
	Sat,  1 Jun 2024 21:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717275939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kwPPQFqT3GBMJ/jhWI+Nr3RwsaB4dK6fZEkpDAERYTQ=;
	b=Op6iEKu4yTxsRDrm0d/07HPUnilBG3ZXoBOScKonAsdbpsdm8eG42Qb2u4gd9E458+Ii0q
	OPI50/Ik3a0JmhHkQ4PWipL+esmZc31VHBrpDiXvjhzWvP3OXrNckhvfOrvx8p/6cWHm5U
	lLpyyNM6Lxc/1mYsjXKh/dtqlSa+Kt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717275939;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kwPPQFqT3GBMJ/jhWI+Nr3RwsaB4dK6fZEkpDAERYTQ=;
	b=dBvJNwmxTHGgr7p0bqPedHGk44G5htsVc2XQKZ6S5UbiFHvwpMCe771SfHo1hi8dPSxi5H
	pDRq8raJlRoG1cDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Op6iEKu4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dBvJNwmx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717275939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kwPPQFqT3GBMJ/jhWI+Nr3RwsaB4dK6fZEkpDAERYTQ=;
	b=Op6iEKu4yTxsRDrm0d/07HPUnilBG3ZXoBOScKonAsdbpsdm8eG42Qb2u4gd9E458+Ii0q
	OPI50/Ik3a0JmhHkQ4PWipL+esmZc31VHBrpDiXvjhzWvP3OXrNckhvfOrvx8p/6cWHm5U
	lLpyyNM6Lxc/1mYsjXKh/dtqlSa+Kt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717275939;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kwPPQFqT3GBMJ/jhWI+Nr3RwsaB4dK6fZEkpDAERYTQ=;
	b=dBvJNwmxTHGgr7p0bqPedHGk44G5htsVc2XQKZ6S5UbiFHvwpMCe771SfHo1hi8dPSxi5H
	pDRq8raJlRoG1cDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8685D137C3;
	Sat,  1 Jun 2024 21:05:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k45SICONW2YUUgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Sat, 01 Jun 2024 21:05:39 +0000
Message-ID: <03207187-9e85-412e-98a9-1965f31b0003@suse.cz>
Date: Sat, 1 Jun 2024 23:05:39 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kunit/fortify: Remove __kmalloc_node() test
Content-Language: en-US
To: Kees Cook <kees@kernel.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240531185703.work.588-kees@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240531185703.work.588-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.40 / 50.00];
	BAYES_HAM(-2.90)[99.56%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A054E1FEEC
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.40

On 5/31/24 8:57 PM, Kees Cook wrote:
> __kmalloc_node() is considered an "internal" function to the Slab, so
> drop it from explicit testing.

So is __kmalloc() and so I have the removal of both as part of the cleanup here:

https://lore.kernel.org/all/20240527090127.21979-2-vbabka@suse.cz/

which reminds me I should put it to -next at this point. Review still welcome :)

> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: linux-mm@kvack.org
> Cc: linux-hardening@vger.kernel.org
> ---
>  lib/fortify_kunit.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
> index 39da5b3bc649..f9cc467334ce 100644
> --- a/lib/fortify_kunit.c
> +++ b/lib/fortify_kunit.c
> @@ -235,9 +235,6 @@ static void fortify_test_alloc_size_##allocator##_dynamic(struct kunit *test) \
>  		kmalloc_array_node(alloc_size, 1, gfp, NUMA_NO_NODE),	\
>  		kfree(p));						\
>  	checker(expected_size, __kmalloc(alloc_size, gfp),		\
> -		kfree(p));						\
> -	checker(expected_size,						\
> -		__kmalloc_node(alloc_size, gfp, NUMA_NO_NODE),		\
>  		kfree(p));						\
>  									\
>  	orig = kmalloc(alloc_size, gfp);				\

