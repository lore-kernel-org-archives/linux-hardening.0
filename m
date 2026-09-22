Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC85C530DEB;
	Tue, 22 Sep 2026 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072460; cv=none; b=Z+HI4NrNDdNYa0wi8i1oT+IhMP9KFyjdSpwy98oqigh7KFeghLmAQudenKE/Bm50lQvOfhfJgi+Tdx82gbh/HfPXmLdqMBIrhRE6XWugZkS9HetQgnBOErNvHGu039AEf4szWcPxVdcKl2YgSwqIod1Qu0XE+aNNpWre9EGNYV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072460; c=relaxed/simple;
	bh=ZaLCi8tedOXUacdNuIHrsRsHRIY0f9Ioz2/NPuEwGlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pH7O/ERwD7jcu3+U3v0rczQsP/HdITuCfBQXkmOWt6jnNX1R6ZmRaqA6ftY8ga46zG1ygJdyKYHjFEVygzZhR8mhchz5xra0auZZ04p5oBx6XvREd1pEyLPuoGLie1M1qNHIuXlYJIOHgIYlJ64ofNCiErpmp/2NeS0zEMcaYUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pH/IjMeu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OvIiBQPU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LVyxfCN0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SmHGB/SI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pH/IjMeu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OvIiBQPU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LVyxfCN0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SmHGB/SI"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AAF7021CE4;
	Tue, 22 Sep 2026 10:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790072452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tq2QDVpBjjYWYAhsxdz+8PGZW/rKjO4PXD0rtR+Sk7E=;
	b=pH/IjMeuGAJ3LQe6XHHZbPMlZpk84c/SjMDd/TOnxDdCSOFROoMvdeYnLT5UqXP+/yevxi
	fvAPcdYIYnSDCk4XE5b7rD5tRx77a3LEjXsxaYOsaUfGo7oo++pC9CZoTM8tlcJafwx/KB
	+MggSO1tBd9K07UsKLn46hXu2hO3ybg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790072452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tq2QDVpBjjYWYAhsxdz+8PGZW/rKjO4PXD0rtR+Sk7E=;
	b=OvIiBQPUnBhJktefDYsIHOdJs4oJ7XXgV9/pjWdpYYl5Nrsp0bblnHw4bZNmb0eefLe0z2
	0eW1w3Z1AQXZYCBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790072448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tq2QDVpBjjYWYAhsxdz+8PGZW/rKjO4PXD0rtR+Sk7E=;
	b=LVyxfCN0dT3V/fWCa+D7ubIyjCziP1KpZaBraLyP6vmbwzbkwbgc0zqD19igGtvTzer9V5
	s34/9cn9h4gb8BkDQZmyouIKkA9fzazIvcqWsXLaG95GwHnnP4cEHYpk0AfsOU2FJXOjKq
	lL+AmEXL5Wgskan5o2LhhbgcBZRPRjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790072448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tq2QDVpBjjYWYAhsxdz+8PGZW/rKjO4PXD0rtR+Sk7E=;
	b=SmHGB/SIgoix+o6WIHsJQwJbpG3IlM383k2yj1MUdF/MD4xU0J3BimrF5maYlprlVkos6X
	noyw2ZTiZQHZ6JBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D89D9132D3;
	Tue, 22 Sep 2026 10:20:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3mGhIn5WsmqaIAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 22 Sep 2026 10:20:46 +0000
Date: Tue, 22 Sep 2026 11:20:40 +0100
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
Subject: Re: [PATCH v4 6/7] mm/slab: Let a bucket set handle __GFP_ACCOUNT
Message-ID: <arJVktqS-CL7zNX0@pedro-suse.tail5790ac.ts.net>
References: <20260921075811.too.775-kees@kernel.org>
 <20260921075820.1718334-6-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921075820.1718334-6-kees@kernel.org>
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[pedro-suse.tail5790ac.ts.net:mid,imap1.dmz-prg2.suse.org:helo]

On Mon, Sep 21, 2026 at 12:58:17AM -0700, Kees Cook wrote:
> A bucket set holds one row of caches, cloned from KMALLOC_NORMAL, and an
> allocation of any other kmalloc type falls back to the general caches.
> Extend this to handle __GFP_ACCOUNT, so that a single bucket user can
> isolate either GFP_KERNEL or GFP_KERNEL_ACCOUNT allocations, as is
> needed for skb data, where AF_UNIX uses:
> 
> 	sk->sk_allocation = GFP_KERNEL_ACCOUNT;
> 
> The coverage is selected at bucket creation time:
> 
> 	b = kmem_buckets_create_types(name, flags, 0, INT_MAX, NULL,
> 				      BIT(KMEM_BUCKET_NORMAL) |
> 				      BIT(KMEM_BUCKET_CGROUP));
> 
> The prior kmem_buckets_create() function keeps its name and defaults
> to only KMEM_BUCKET_NORMAL, leaving existing users as-is.
> 
> Only the accounted type is offered. Nothing wants a reclaimable or
> no-obj-ext row, and of the twelve places passing GFP_DMA to an skb
> allocator, all rare hardware: b44, b43legacy, prestera and s390 ctcm.

Well, yes, BUT I don't think silently falling back is a great option.
I would rather things be done Properly(tm) and kmem_buckets allowing
instantiation of most/all kmalloc cache types. Given it's security stuff,
I would prefer being quite explicit over silent.

Perhaps, to save on memory, users could choose to fall back to the default
caches. But at kmem_buckets_create time.


-- 
Pedro
