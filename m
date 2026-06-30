Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D0943C05D
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830416; cv=none; b=tWR/6LGNxbRhqK16xeaz0lxAPHdIX0xy36jLE25huae57rNiQxN9uknG1Pw3YlS3IOa4UiiQeNwtpzeRW6qIE7SyMLENjTw2LMN/qrRN+uId4z+kX2e0rLmvCDi9ckI2y/aAzx7G8J6Tm1/iUB7Hsppn/rGW6HiAOo24VKUiRGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830416; c=relaxed/simple;
	bh=2OGKBErnifNP3VL7pFlGQnquPYmnUC8k4hHKpvAv/sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcBxvRxXd7ddx+da6XLpy3PrQIu4BP4MfqmkxyvQTMCcjaEGFR396iXYpQmCUWO7RsBvGmzSW12OtQryQrbYndGV0QtVy8simiCN80Zutr1Rc4UwNmtQqByfys0zwyZO8ydS5TrMXw4T/xjCK81spmtOLbGMu4aK+R03SL/rmV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0k0FXMnR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m/+HI1/7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GWNUlwry; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ik9xhJZm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0k0FXMnR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m/+HI1/7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GWNUlwry";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ik9xhJZm"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D85CE710AC;
	Tue, 30 Jun 2026 14:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782830413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RnFr60XaYcmQD9ST85I7XAqhA4M5wK5bIo4FXi9x5zk=;
	b=0k0FXMnRZuZQKPf8AlzFtsH1LCXRXdhx/OEktTiFuW1O+D7tP115J0RNzL7lOcRkP0RVzd
	Th+sca2po7IYFsHggCLVTDoJX2PDfgb2LKCOtNyCi7ZZkzK0zLGmzNkVoAcV59LvbOMCgp
	Dx+gO5T2zGr/fZ1hliA9T60qUxFGlQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782830413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RnFr60XaYcmQD9ST85I7XAqhA4M5wK5bIo4FXi9x5zk=;
	b=m/+HI1/7GMGCNdrhmmTlPQ1hDyyj6yxI/B0skh4iW+rUiFKZt+w+sD7DJ5NWT8cAkbWBps
	KI1Yso3Ab0s4jMDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782830412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RnFr60XaYcmQD9ST85I7XAqhA4M5wK5bIo4FXi9x5zk=;
	b=GWNUlwryy/hcdx2rbHUHS/5UkdYtUkVc6/+ZKTlpL06/73FknUEdl2d5TbOufRvFbg5n7E
	ZwAh1mrRsokFVN0hlAarcdCrK1T649DaG7zUUTcTQNwl/P6EjQy/dSZJlf0vBNUEkR1LJM
	nJDFBvclmEIrp+j5RTJ9mk65GWGwTo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782830412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RnFr60XaYcmQD9ST85I7XAqhA4M5wK5bIo4FXi9x5zk=;
	b=ik9xhJZmxShdFkFpjOeBjcBFyhpTrF39dswSYhtIu+pp8Gw/LsDhvS2GUNI8ds2uMqbrgf
	JztpxbaXoOFHGZDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 793BF779A8;
	Tue, 30 Jun 2026 14:40:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T4qXGUvVQ2o6DAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 30 Jun 2026 14:40:11 +0000
Date: Tue, 30 Jun 2026 15:40:09 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Xiang Mei <xmei5@asu.edu>
Cc: Dave Hansen <dave.hansen@intel.com>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, linux-hardening@vger.kernel.org, 
	Uladzislau Rezki <urezki@gmail.com>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Jennifer Miller <jmill@asu.edu>, Tiffany Bao <tbao@asu.edu>, Ruoyu Wang <fishw@asu.edu>, 
	Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>, 
	Yan Shoshitaishvili <yans@asu.edu>
Subject: Re: [PATCH v2] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
Message-ID: <akPT82jDvPwlaNuo@pedro-suse.lan>
References: <20260629214712.1198680-1-xmei5@asu.edu>
 <d9775951-fe04-4d1f-b205-bd4626590f5e@intel.com>
 <CAPpSM+QTiwgPk3KNmWbjSk_SS8LLL5XDfikWC1A98vetom3yeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPpSM+QTiwgPk3KNmWbjSk_SS8LLL5XDfikWC1A98vetom3yeg@mail.gmail.com>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,linux-foundation.org,redhat.com,alien8.de,linux.intel.com,vger.kernel.org,gmail.com,zytor.com,kvack.org,asu.edu];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 
X-Spam-Score: -4.30

Just as a quick FYI, it's good LKML ettiquette to keep people who engaged with
the previous threads on CC for new versions :)

On Mon, Jun 29, 2026 at 04:28:19PM -0700, Xiang Mei wrote:
> On Mon, Jun 29, 2026 at 3:29 PM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 6/29/26 14:47, Xiang Mei wrote:
> > > With CONFIG_VMAP_STACK, kernel stacks are allocated in the vmalloc area,
> > > which an unprivileged user can surround with attacker-controlled data by
> > > spraying vmap allocations adjacent to a target stack (for example via
> > > XDP_UMEM_REG, though other vmalloc spray paths work too). Today each
> > > guarded vmalloc allocation is followed by a single unmapped guard page.
...snip...
> > To even be considered, this series needs to be refactored properly.
> > Making this VMAP_GUARD_PAGES a separate patch is the bare minimum.
> >
> Good suggestion, I will do it in v3:
> 
>     1/3 - introduce VMAP_GUARD_PAGES
>     2/3 - mark percpu vmap areas VM_NO_GUARD

I would suggest you create a VMAP_STACK flag and condition these guard regions
bsaed on that. Otherwise it's a bit arbitrary as to what callers get 0x11 guard
pages, and which don't.

(you can find the concrete stack allocation functions in kernel/fork.c)

-- 
Pedro
