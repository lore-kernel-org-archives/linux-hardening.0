Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370844D2EE0;
	Tue, 22 Sep 2026 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071125; cv=none; b=XlA5os/ZCHXMF6/8NMGt3I4LFCu6zAz1i3P1fr8wy3XlsgwjS6vhS0oJUA51TE9T4/1k2VdjipWLMt3CBlYjJADUUfsbBTqYhF5mtq/LXvY65MEiOTMHG7OhcB3DazEeNcz2bOzfPXspynglV3P40luWgZMDI72krE8NLkDnktI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071125; c=relaxed/simple;
	bh=HK+yU08m52K64K0cBVvpLuj+tM/+NPiar/AAhtTvtv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdGN4yM9kQScQhi4HhGl2EE3v5DFOg87AXQ8JHZPY7PsJxFy6cwxe8NS/NrcllDXlP+XWbUK/+dK5qB7GAkPqPbKuK8b+LrvnbAc0+3q1IQlJdf6L01ysW4t5aEQ0MQz2mJ6o7z1iwegCkFOTSvGq1FZFbGN2YlB5Ol/H8XT33w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LiZEolQL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YTCIb160; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dse2xfk9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5ej2gdRk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LiZEolQL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YTCIb160";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Dse2xfk9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5ej2gdRk"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E23F41F8B9;
	Tue, 22 Sep 2026 09:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790071118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4URFwrM0sI0j5Ml44Xiz56jlMa8XLSjTXuYmxFnBgOw=;
	b=LiZEolQLtrOcnCpKNhtTGFVrWufQc0pBzKwAnq8xgsyHtt7FOTAXPaGMzM2B/JNZSCQTkP
	5qfTeqjvY5gtkYNBndsHUXbuVY2JO236TnFlQWs55eJ8IEw1eYvcqTq1xjKJBCZ4UX+YTA
	sJuczxH3Rovjnb6cpJGa0ZwWvfJOJxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790071118;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4URFwrM0sI0j5Ml44Xiz56jlMa8XLSjTXuYmxFnBgOw=;
	b=YTCIb160AgoMyuaZDpwuiYTv1e3GB6uMNI3lb6iPSY56aTD87HB360Q467sPor9jhfSTSP
	XAq/xJqeWkRW0WAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790071113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4URFwrM0sI0j5Ml44Xiz56jlMa8XLSjTXuYmxFnBgOw=;
	b=Dse2xfk9rYhsNzWipCoS1JcIReryX19OOYSEO/y6U6h2/Th6M27X1kd3BZhUtd0bGx7baP
	UP9EmCy/KL78BGJ5wf2ePGumoYg4w5Paa0AiWxasn1OWy8L39PUyEjwIptrg2VB5Vlwdh/
	xL4WP2Fe5+ktc2rbQdg+CmKsKBELHGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790071113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4URFwrM0sI0j5Ml44Xiz56jlMa8XLSjTXuYmxFnBgOw=;
	b=5ej2gdRkyDcZftLUT6SaJNLl6a+lu/u772HFMDHv4wdhUy35JgSfKA/2YzV4rMORb7JPRE
	NuaXw1RHmy24dMCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0640E136D9;
	Tue, 22 Sep 2026 09:58:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id knt0I0dRsmrVBwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 22 Sep 2026 09:58:31 +0000
Date: Tue, 22 Sep 2026 10:58:25 +0100
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
Subject: Re: [PATCH v4 1/7] mm/slab: Mark the kmem_buckets_create() context
 as a Context: section
Message-ID: <arJRHFs-r8hkTLhx@pedro-suse.tail5790ac.ts.net>
References: <20260921075811.too.775-kees@kernel.org>
 <20260921075820.1718334-1-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921075820.1718334-1-kees@kernel.org>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,linux.dev,gentwo.org,google.com,kvack.org,vger.kernel.org,davemloft.net,redhat.com,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,pedro-suse.tail5790ac.ts.net:mid]
X-Spam-Flag: NO

On Mon, Sep 21, 2026 at 12:58:12AM -0700, Kees Cook wrote:
> kmem_buckets_create() had the same sentence about calling context as
> kmem_cache_create(), but lacked the "Context:" prefix, so kernel-doc
> rendered in the body instead of as a "context" section.
> 
> Give it the missing prefix. Additionally fix the "a interrupt" typo
> __kmem_cache_create_args() had.
> 
> Fixes: b32801d1255be ("mm/slab: Introduce kmem_buckets_create() and family")
> Assisted-by: LLM
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Pedro Falcato <pfalcato@suse.de> 

-- 
Pedro
