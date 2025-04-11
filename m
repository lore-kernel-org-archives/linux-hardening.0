Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A5727D785
	for <linux-hardening@vger.kernel.org>; Fri, 11 Apr 2025 07:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357645; cv=none; b=intJcWT5YyVmr1tTJpkIKOiUhavmIWDu/Jv8QwtcZd1mXjiHvGXW7yhiLObzTbIUSNXYcaADnMnHVN7by+e3d1dQuZnMzK/LbC6v94D6wNsEbuEHuRhBOU5b2Lj6a/Mt+BG0gOxhwb7bmiBsuF89BPPBWSraSM1x3BYWGGHegeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357645; c=relaxed/simple;
	bh=EAz6BYyegX9HsUVlO2LvtyL+bKqfENHOMQini843ORE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BoDF2mvePHnjlS9OCT1T/5s861hE6YOq4pJk2eyWX8Q4WooTSWOlmiP6AUzurVbtKxw39KaJCJyjdhZTG8iJW8nY3yAgFHNyfbgXD1/SMf0G2rr3phHFKAfTtwObwAK9oZNr6kJdY2ERb2uSnvANAz7hYpTniiCAXzg+zUGIfQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3AzJ3xPt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y3PEkJOF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3AzJ3xPt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y3PEkJOF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3AzJ3xPt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y3PEkJOF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3AzJ3xPt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y3PEkJOF"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3C0A821125;
	Fri, 11 Apr 2025 07:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744357641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6aNx8roFs3brDqtJz4qS5Ktvp9IrPY2jgp3xIHvb3U=;
	b=3AzJ3xPtXM9xl6A9NBybWV0Z+mdnzcsHM3ymLxCOl0O1rFgI1boQ3Vfk3y81515olX/b9Z
	GJBdnvEpB3+a3m0kDO3vuJdQE5DA2jzsbgtkvpVGdiDc4PlhNPKpsMAtYWbMeOov+guYmH
	f5rcCkufQ00ZcUrV+uQwWihxKDm1axY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744357641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6aNx8roFs3brDqtJz4qS5Ktvp9IrPY2jgp3xIHvb3U=;
	b=Y3PEkJOFMDbn2b/M6sYqxko+XqKRr4dhrdZkciCJqVDGy7i2TKbC4ulkk5BifBd82OpI+G
	WYDY7knV6nr0p2Dg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3AzJ3xPt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Y3PEkJOF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744357641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6aNx8roFs3brDqtJz4qS5Ktvp9IrPY2jgp3xIHvb3U=;
	b=3AzJ3xPtXM9xl6A9NBybWV0Z+mdnzcsHM3ymLxCOl0O1rFgI1boQ3Vfk3y81515olX/b9Z
	GJBdnvEpB3+a3m0kDO3vuJdQE5DA2jzsbgtkvpVGdiDc4PlhNPKpsMAtYWbMeOov+guYmH
	f5rcCkufQ00ZcUrV+uQwWihxKDm1axY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744357641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6aNx8roFs3brDqtJz4qS5Ktvp9IrPY2jgp3xIHvb3U=;
	b=Y3PEkJOFMDbn2b/M6sYqxko+XqKRr4dhrdZkciCJqVDGy7i2TKbC4ulkk5BifBd82OpI+G
	WYDY7knV6nr0p2Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 013AB13886;
	Fri, 11 Apr 2025 07:47:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vax0OwjJ+GcJCAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 11 Apr 2025 07:47:20 +0000
Message-ID: <472508e5-2b96-403b-9284-274c5bf587c9@suse.cz>
Date: Fri, 11 Apr 2025 09:47:16 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slab: Decouple slab_debug and no_hash_pointers
Content-Language: en-US
To: Kees Cook <kees@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Sergio Perez Gonzalez <sperezglz@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Tamir Duberstein <tamird@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, Thomas Huth
 <thuth@redhat.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Ard Biesheuvel <ardb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Stephen Boyd
 <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250410174428.work.488-kees@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250410174428.work.488-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3C0A821125
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lwn.net,linux.intel.com,rasmusvillemoes.dk,chromium.org,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,linux.dev,oracle.com,infradead.org,vger.kernel.org,kvack.org,redhat.com,alien8.de,linuxfoundation.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLisu716frudqkg98kczdd9eac)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/10/25 19:44, Kees Cook wrote:
> Some system owners use slab_debug=FPZ (or similar) as a hardening option,
> but do not want to be forced into having kernel addresses exposed due
> to the implicit "no_hash_pointers" boot param setting.[1]
> 
> Introduce the "hash_pointers" boot param, which defaults to "auto"
> (the current behavior), but also includes "always" (forcing on hashing
> even when "slab_debug=..." is defined), and "never". The existing
> "no_hash_pointers" boot param becomes an alias for "hash_pointers=never".
> 
> This makes it possible to boot with "slab_debug=FPZ hash_pointers=always".
> 
> Link: https://github.com/KSPP/linux/issues/368 [1]
> Fixes: 792702911f58 ("slub: force on no_hash_pointers when slub_debug is enabled")
> Co-developed-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
> Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
> Signed-off-by: Kees Cook <kees@kernel.org>

I like how this makes things more generic. Perhaps there are more debug
boot/config options that could tie into the hash_pointers=auto and are even
more obvious than slab_debug in the sense that you would really only enable
them in debugging/CI runs when you do not care about the info leaks but want
as much useful debug info as possible (KASAN etc?).

Given how this changes mostly printk code and is in fact only a small change
to slab, I'll wait first if printk maintainers want to take this patch. In
that case please add

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

