Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D523537F5
	for <linux-hardening@vger.kernel.org>; Thu,  4 Jun 2026 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600360; cv=none; b=Oj6CsQC0/2hQ6omdZuu3gLQu4lom+WcLL7kI1pAKm7UNzP/Chipx2l5ro/mW1SeaFoC/I95iE1Mgc0EN6qC3mo6nHbODIwjYQQE0InVcvY3z5mY2WGZCGUdH6ISrkzEIOZLcaNf76WmYz24yAmkZbqRNVt/MgImHsqXxOlOPru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600360; c=relaxed/simple;
	bh=fj8ubZHRmMFKNsqYq9mUlXMLbL+nrDhZSSkGrPU7usk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAJnFVtn0aUb81IwRmjF3QM0nNoX0EHQD3c11hTFsFQuPAzsGFgeKe2/tTtC2A47LE9ctNZgh3x7uD70l5BEEYvKUjGW+qXyHlr6ML+rwPZ3t7pYVcqAoVQhaC7Dn3Bq9usNUIn5Xv2nFUhOk/dlqQlxzzXRURpYjzAmCYhzEvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l0J0D4oR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+oyJtAd3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l0J0D4oR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+oyJtAd3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l0J0D4oR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+oyJtAd3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l0J0D4oR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+oyJtAd3"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C1270683AB;
	Thu,  4 Jun 2026 19:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780600356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVccA4ceReq1NsSUiW4BvISRJkHdxqfqmTVLliJp0pA=;
	b=l0J0D4oRlwzvwXiFyeQgd7lUB2NIqPON3UN9nyqyuKJRVUwcQ5y8Ex74IWYO8Oa9B5/ZoH
	FFwZpCO72xfZqgFKZurNNMPR1/rzPM9Q5EzVfxWXt3bXp3aKTfdn4k0Yoz222HhjD5ASIC
	liazCw6uqwUjJ5BSFXxkxAZNHpoz+zU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780600356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVccA4ceReq1NsSUiW4BvISRJkHdxqfqmTVLliJp0pA=;
	b=+oyJtAd3Qb2ZMrrAhMaZyEyPWADlPH8EdOy8o/3C7B+euZY4GgIje0HDPQwu3yk10s5yml
	j1lRlfg68lTEhNAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780600356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVccA4ceReq1NsSUiW4BvISRJkHdxqfqmTVLliJp0pA=;
	b=l0J0D4oRlwzvwXiFyeQgd7lUB2NIqPON3UN9nyqyuKJRVUwcQ5y8Ex74IWYO8Oa9B5/ZoH
	FFwZpCO72xfZqgFKZurNNMPR1/rzPM9Q5EzVfxWXt3bXp3aKTfdn4k0Yoz222HhjD5ASIC
	liazCw6uqwUjJ5BSFXxkxAZNHpoz+zU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780600356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVccA4ceReq1NsSUiW4BvISRJkHdxqfqmTVLliJp0pA=;
	b=+oyJtAd3Qb2ZMrrAhMaZyEyPWADlPH8EdOy8o/3C7B+euZY4GgIje0HDPQwu3yk10s5yml
	j1lRlfg68lTEhNAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18C8F779A8;
	Thu,  4 Jun 2026 19:12:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id drW3ASPOIWpQfgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 04 Jun 2026 19:12:35 +0000
Date: Thu, 4 Jun 2026 20:12:25 +0100
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
Subject: Re: [PATCH 1/2] mm/slab: add a node-track-caller variant for kmem
 buckets allocation
Message-ID: <aiHODMbciRELKGbR@pedro-suse>
References: <20260602183122.747759-1-pfalcato@suse.de>
 <20260602183122.747759-2-pfalcato@suse.de>
 <ed9e834d-e3a0-40c2-9407-252f7ac7f00b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed9e834d-e3a0-40c2-9407-252f7ac7f00b@kernel.org>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,davemloft.net,google.com,redhat.com,vger.kernel.org,kvack.org,linux.dev,gentwo.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -3.80

On Thu, Jun 04, 2026 at 02:19:30PM +0900, Harry Yoo wrote:
> 
> 
> On 6/3/26 3:31 AM, Pedro Falcato wrote:
> > This is required by users that want to use kmem buckets, but still
> > desire specifying the NUMA node.
> > 
> > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> > ---
> 
> Acked-by: Harry Yoo (Oracle) <harry@kernel.org>

Thanks for the review!

-- 
Pedro
