Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B681C18CBFA;
	Fri,  9 Aug 2024 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723193997; cv=none; b=K/yIyFKwlU96Nnmq1xJ8owkxDFlq1vASmqvkfMAnZzArd9ZgPCtS3LjbLwgWD43aruQTnpi1RC6eluTyewNAfPhi5JQ4MHLSuvsNqp+GNu6cfHFTgSQLqM4Rf0mc0NuP08vNOIJb3I7pzZbNniIvZoVMl7QdnOvdluLstb8m9mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723193997; c=relaxed/simple;
	bh=3OBlyozUoezflwc1KcpEwHZ4JBQxYtYXHSnoEd0YwwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nnUXUOsTEZxiN443CfokFtft8zYH+U0ADtRiEWLjjKKRQC8NrWTbqfzccI3sh06LJ+kEESAlBirnG10jtQ1H4qGhfhcM5xSL9ZTmDuo1YRcGgqbOV621of1OjOxTuvYo4TcuLoDctsRQ/kQP97deTxlpU/0szrPozeGA7sRUQ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hecFQTnj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KZgbGkEK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hecFQTnj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KZgbGkEK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hecFQTnj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KZgbGkEK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hecFQTnj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KZgbGkEK"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 953271FF2F;
	Fri,  9 Aug 2024 08:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723193993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qJDjhIoxUXDLGf1tiz/qcgoJ9zcTAnQZcgHgMroPuCA=;
	b=hecFQTnj4dlXZQBDKyFkZXK1KHRihuLmHA9kO1nBPTsQgGxn2v872Jus4rlY8wE9g/4Znd
	YrfwzhaObA1h/zOnOy3MCdOpnMtm+oshtlJxyp5uwz9WVV7tdaJjBav+nnbz92hDN2o7sg
	46Ebumhj56azk1lcqsWtQnLkFGeampI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723193993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qJDjhIoxUXDLGf1tiz/qcgoJ9zcTAnQZcgHgMroPuCA=;
	b=KZgbGkEK608Fs+II5f0AjZyee9zRmn437pR7XFn+xvI4flIa3KJ2ZdzeLvl2pjO/rcq5iE
	KPN2wMYGd02IfoBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hecFQTnj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KZgbGkEK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723193993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qJDjhIoxUXDLGf1tiz/qcgoJ9zcTAnQZcgHgMroPuCA=;
	b=hecFQTnj4dlXZQBDKyFkZXK1KHRihuLmHA9kO1nBPTsQgGxn2v872Jus4rlY8wE9g/4Znd
	YrfwzhaObA1h/zOnOy3MCdOpnMtm+oshtlJxyp5uwz9WVV7tdaJjBav+nnbz92hDN2o7sg
	46Ebumhj56azk1lcqsWtQnLkFGeampI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723193993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qJDjhIoxUXDLGf1tiz/qcgoJ9zcTAnQZcgHgMroPuCA=;
	b=KZgbGkEK608Fs+II5f0AjZyee9zRmn437pR7XFn+xvI4flIa3KJ2ZdzeLvl2pjO/rcq5iE
	KPN2wMYGd02IfoBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6ADD413A7D;
	Fri,  9 Aug 2024 08:59:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iEGdGYnatWb0LQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 09 Aug 2024 08:59:53 +0000
Message-ID: <ddf093db-b0a8-4e44-9d81-1e4840967557@suse.cz>
Date: Fri, 9 Aug 2024 10:59:52 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slab: Introduce kmalloc_obj() and family
Content-Language: en-US
To: Kees Cook <kees@kernel.org>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Jann Horn <jannh@google.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Marco Elver <elver@google.com>,
 linux-mm@kvack.org, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20240807235433.work.317-kees@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240807235433.work.317-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.00 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,intel.com,kvack.org,vger.kernel.org,lists.linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 953271FF2F
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: 0.00

On 8/8/24 01:54, Kees Cook wrote:
> Introduce type-aware kmalloc-family helpers to replace the common
> idioms for single, array, and flexible object allocations:
> 
> 	ptr = kmalloc(sizeof(*ptr), gfp);
> 	ptr = kcalloc(count, sizeof(*ptr), gfp);
> 	ptr = kmalloc_array(count, sizeof(*ptr), gfp);
> 	ptr = kcalloc(count, sizeof(*ptr), gfp);
> 	ptr = kmalloc(struct_size(ptr, flex_member, count), gfp);
> 
> These become, respectively:
> 
> 	kmalloc_obj(p, gfp);
> 	kzalloc_obj(p, count, gfp);
> 	kmalloc_obj(p, count, gfp);
> 	kzalloc_obj(p, count, gfp);
> 	kmalloc_obj(p, flex_member, count, gfp);

So I'm not a huge fan in hiding the assignment, but I understand there's
value in having guaranteed the target of the assignment is really the same
thing as the one used for sizeof() etc.

But returning size seems awkward, it would be IMHO less confusing if it
still returned the object pointer, that could be then also assigned
elsewhere if needed, tested for NULL and ZERO_SIZE_PTR (now it's both 0?).

I'm also not sure that having it all called kmalloc_obj() with 3 variants of
how many parameters it takes is such a win? e.g. kmalloc_obj(),
kcalloc_obj() and kcalloc_obj_flex() would be more obvious?

> These each return the size of the allocation, so that other common
> idioms can be converted easily as well. For example:
> 
> 	info->size = struct_size(ptr, flex_member, count);
> 	ptr = kmalloc(info->size, gfp);
> 
> becomes:
> 
> 	info->size = kmalloc_obj(ptr, flex_member, count, gfp);

How about instead taking an &info->size parameter that assigns size to it,
so the ptr can be still returned but we also can record the size?

Also the last time David asked for documentation, you say you would try, but
there's nothing new here? Dunno if the kerneldocs are feasible but there's
at least Documentation/core-api/memory-allocation.rst ...

Thanks,
Vlastimil

> Internal introspection of allocated type also becomes possible, allowing
> for alignment-aware choices and future hardening work. For example,
> adding __alignof(*ptr) as an argument to the internal allocators so that
> appropriate/efficient alignment choices can be made, or being able to
> correctly choose per-allocation offset randomization within a bucket
> that does not break alignment requirements.
> 
> Additionally, once __builtin_get_counted_by() is added by GCC[1] and
> Clang[2], it will be possible to automatically set the counted member of
> a struct with a counted_by FAM, further eliminating open-coded redundant
> initializations, and can internally check for "too large" allocations
> based on the type size of the counter variable:
> 
> 	if (count > type_max(ptr->flex_count))
> 		fail...;
> 	info->size = struct_size(ptr, flex_member, count);
> 	ptr = kmalloc(info->size, gfp);
> 	ptr->flex_count = count;
> 
> becomes (i.e. unchanged from earlier example):
> 
> 	info->size = kmalloc_obj(ptr, flex_member, count, gfp);
> 
> Replacing all existing simple code patterns found via Coccinelle[3]
> shows what could be replaced immediately (saving roughly 1,500 lines):
> 
>  7040 files changed, 14128 insertions(+), 15557 deletions(-)
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=116016 [1]
> Link: https://github.com/llvm/llvm-project/issues/99774 [2]
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/kmalloc_obj-assign-size.cocci [3]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: Marco Elver <elver@google.com>
> Cc: linux-mm@kvack.org
> ---
>  include/linux/slab.h | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index eb2bf4629157..46801c28908e 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -686,6 +686,44 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
>  }
>  #define kmalloc(...)				alloc_hooks(kmalloc_noprof(__VA_ARGS__))
>  
> +#define __alloc_obj3(ALLOC, P, COUNT, FLAGS)			\
> +({								\
> +	size_t __obj_size = size_mul(sizeof(*P), COUNT);	\
> +	void *__obj_ptr;					\
> +	(P) = __obj_ptr = ALLOC(__obj_size, FLAGS);		\
> +	if (!__obj_ptr)						\
> +		__obj_size = 0;					\
> +	__obj_size;						\
> +})
> +
> +#define __alloc_obj2(ALLOC, P, FLAGS)	__alloc_obj3(ALLOC, P, 1, FLAGS)
> +
> +#define __alloc_obj4(ALLOC, P, FAM, COUNT, FLAGS)		\
> +({								\
> +	size_t __obj_size = struct_size(P, FAM, COUNT);		\
> +	void *__obj_ptr;					\
> +	(P) = __obj_ptr = ALLOC(__obj_size, FLAGS);		\
> +	if (!__obj_ptr)						\
> +		__obj_size = 0;					\
> +	__obj_size;						\
> +})
> +
> +#define kmalloc_obj(...)					\
> +	CONCATENATE(__alloc_obj,				\
> +		    COUNT_ARGS(__VA_ARGS__))(kmalloc, __VA_ARGS__)
> +
> +#define kzalloc_obj(...)					\
> +	CONCATENATE(__alloc_obj,				\
> +		    COUNT_ARGS(__VA_ARGS__))(kzalloc, __VA_ARGS__)
> +
> +#define kvmalloc_obj(...)					\
> +	CONCATENATE(__alloc_obj,				\
> +		    COUNT_ARGS(__VA_ARGS__))(kvmalloc, __VA_ARGS__)
> +
> +#define kvzalloc_obj(...)					\
> +	CONCATENATE(__alloc_obj,				\
> +		    COUNT_ARGS(__VA_ARGS__))(kvzalloc, __VA_ARGS__)
> +
>  #define kmem_buckets_alloc(_b, _size, _flags)	\
>  	alloc_hooks(__kmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), _flags, NUMA_NO_NODE))
>  

