Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A481A9FBD
	for <linux-hardening@vger.kernel.org>; Fri, 26 Jun 2026 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782502791; cv=none; b=ih0euD5adUvGkAjTnDe8ROy2sztlUtUYQnS1q4q3vO9CaftLenKlcVxrU6HysXUGSaUy2CWro2uBJMl+3rLsZF4yj2XaNQ4MkOB4BwW9MFtxyLYRk3PHGhXf8Y3zUdxiRO5pdTj8GLTWoWEsrYAJrm9OqgWQfCcFRA9wSkwEQfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782502791; c=relaxed/simple;
	bh=5dCL2/n5lGkCdhxVmraE3jPRxKa4VuBi3yP1ITKIIsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRnVYR0lz5FXzIFSDmH9dv3eqyQnpaSGh9jyQiUtyWuxZy18+Tnra4koKNcIQa9p3nZAVJv/BmKZXFYiKITvKTav2Njt1Rzx5IfiqFK513n085g3l88xjT8az11ftWIYJKG56JeUO5K+Sj5AWgY03hWNX3z4sRpXU1JBHrObTXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wmdH4Ude; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=crCDm4qH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wmdH4Ude; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=crCDm4qH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wmdH4Ude";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="crCDm4qH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wmdH4Ude";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="crCDm4qH"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AEA4872359;
	Fri, 26 Jun 2026 19:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782502788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rzMGN6lar8EVCdJmNLl2FZFycB2tmO5d97XbhZn13tk=;
	b=wmdH4Ude7kEJnm0s+K5NOS5y5+rboGYe1FsdDffm7qAAq3BAtAdN9tM5BFdFG2hFDwgsBx
	jUg15o7/aVhuzxD0BwfLCKU6bKg6yiU7RWPgrEoseGQaGRCgIwnoOMPrYxl6aJ6gVUydod
	5kridDb2cwfJoIJnWikIaKDmOndx4Ac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782502788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rzMGN6lar8EVCdJmNLl2FZFycB2tmO5d97XbhZn13tk=;
	b=crCDm4qHjv3HbldHz0umHWyGjLR48IYnhbI4uZzyxzWXwFDT7azZQZ2Jg9YVFL9XvJnExs
	9RRBVKz6zuZmocAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782502788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rzMGN6lar8EVCdJmNLl2FZFycB2tmO5d97XbhZn13tk=;
	b=wmdH4Ude7kEJnm0s+K5NOS5y5+rboGYe1FsdDffm7qAAq3BAtAdN9tM5BFdFG2hFDwgsBx
	jUg15o7/aVhuzxD0BwfLCKU6bKg6yiU7RWPgrEoseGQaGRCgIwnoOMPrYxl6aJ6gVUydod
	5kridDb2cwfJoIJnWikIaKDmOndx4Ac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782502788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rzMGN6lar8EVCdJmNLl2FZFycB2tmO5d97XbhZn13tk=;
	b=crCDm4qHjv3HbldHz0umHWyGjLR48IYnhbI4uZzyxzWXwFDT7azZQZ2Jg9YVFL9XvJnExs
	9RRBVKz6zuZmocAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5643B779A8;
	Fri, 26 Jun 2026 19:39:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wjIqEYPVPmpmEQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 26 Jun 2026 19:39:47 +0000
Date: Fri, 26 Jun 2026 20:39:45 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Xiang Mei <xmei5@asu.edu>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, linux-hardening@vger.kernel.org, 
	Uladzislau Rezki <urezki@gmail.com>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Jennifer Miller <jmill@asu.edu>, Tiffany Bao <tbao@asu.edu>, Ruoyu Wang <fishw@asu.edu>, 
	Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>, 
	Yan Shoshitaishvili <yans@asu.edu>
Subject: Re: [PATCH] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
Message-ID: <aj7UNceukU9zYeGH@pedro-suse.lan>
References: <20260626173444.2252041-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626173444.2252041-1-xmei5@asu.edu>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,redhat.com,alien8.de,linux.intel.com,vger.kernel.org,gmail.com,zytor.com,kvack.org,asu.edu];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -4.30

On Fri, Jun 26, 2026 at 10:34:44AM -0700, Xiang Mei wrote:
> With CONFIG_VMAP_STACK, kernel stacks are allocated in the vmalloc area,
> which an unprivileged user can surround with attacker-controlled data by
> spraying vmap allocations adjacent to a target stack (for example via
> XDP_UMEM_REG, though other vmalloc spray paths work too). Today each
> guarded vmalloc allocation is followed by a single unmapped guard page.
> 
> A single guard page is not enough to contain the x86_64 ENTER
> instruction used as a one-instruction stack pivot. ENTER imm16, imm8
> builds a stack frame and lowers RSP by:
> 
> 	imm16 + 8 * (L + 1),  L = imm8 & 0x1f
> 
> imm16 is an unsigned 16-bit operand (ENTER never raises RSP), and L is
> in [0, 31], so the maximum displacement of a single ENTER is:
> 
> 	0xffff + 8 * 0x20 = 0x100ff bytes
> 
> That is more than enough to step off the current stack, across the
> one-page guard, and into the adjacent sprayed pages. When those pages
> contain a return sled feeding a ROP chain, reaching any ENTER gadget
> (opcode 0xc8, abundant as both intended and unintended gadgets) turns a
> control-flow hijack into full ROP execution without any register control
> at the hijack site, making it a one-gadget-style primitive that
> significantly eases exploitation. The pivot happens after the control
> transfer, so it is not constrained by CFI (kCFI/FineIBT).
> 
> Widen the guard region from one page to VMAP_GUARD_PAGES (0x11 pages,
> 0x11000 bytes), which is the smallest whole-page span exceeding the
> 0x100ff-byte maximum single-ENTER pivot. A pivot off the top of the
> stack now lands in the unmapped guard and faults, instead of in mapped,
> attacker-controlled memory. RANDOMIZE_KSTACK_OFFSET only perturbs RSP by
> a sub-page amount, so it does not change the required width.

What's so special about enter? Why do we need to design our guard pages
around it? FWIW, I can't find enter instructions in any of my kernel builds,
nor can I convince gcc (on godbolt) to generate an enter instruction.

If it's just "this is a single instruction that adjusts RSP", why is e.g.
sub imm32, %rsp ok?

FTR, I think it's fine that you're proposing more guard pages; virtual address
space is virtually free on 64-bit architectures (apart from lower page table
density, which may take a little toll on memory usage and/or page table
caching). I'm just wondering why enter is being used as the concrete target
for this.

-- 
Pedro
