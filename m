Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47774423A87
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831527; cv=none; b=TrhaAnClZgRdfUkX+ZVEvxDKd6mxDYILk8LYfBOe42ZxmzJqcHwyuKmNpYWO/+Djuu6DApRMuneXcqmxCImH1uB4TYui2k/fII0lUfhat6savevpryDHZ0z5zn4tqr71SB5tkOU0ZtA1wrK44M5+RMEfZAArjpy3V/Xlj6g13JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831527; c=relaxed/simple;
	bh=XITnDls5am55TNYObauzGmPIU+pb+ejjdJKmD/qHLfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEMST1f6cYn2wVokKF9np2+u1WRnl8P+QerB2qxSFRdL7Uy8fHXHou0okIxoD5CBiaoDUWJcd6jeM/WiIMVbtMRanzT1xDkC+6J2A+52zaSX94kDCem0/9hpuIsqUiCMRp7gGZhapYjDm8xi8kQe4SDRMdjXNQFeaiQizCayyDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i1vYbsIY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MfBd6CxZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i1vYbsIY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MfBd6CxZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i1vYbsIY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MfBd6CxZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i1vYbsIY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MfBd6CxZ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 48B8B75DE7;
	Tue, 30 Jun 2026 14:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782831524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fp1dLT9aMiZvLKrxaip+Sq91NThQkBLHSya57MdqiZ0=;
	b=i1vYbsIYl7TLTaXt3i7RVi+UEP7OqLfLPJ4SmLGlE6UpLVLLcIwfPh4bNaMsVwl54h4AyR
	ta2NHYbLeEgNfWi+HoVNxtnpvbtl4Sr+Ba0JZy4w/8G61xAjQIFAZku66kaRguzDlw8o11
	Ul1e8EM+JGI4aSkeacw8qblnYPgWa8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782831524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fp1dLT9aMiZvLKrxaip+Sq91NThQkBLHSya57MdqiZ0=;
	b=MfBd6CxZdG/kZci2Lo7SLl/9MFFvNSPaqGCze0WwU7PIpbjukyOQVhLelOdImvCIeryCQ0
	6AlOkmF+94KZZuDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=i1vYbsIY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MfBd6CxZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782831524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fp1dLT9aMiZvLKrxaip+Sq91NThQkBLHSya57MdqiZ0=;
	b=i1vYbsIYl7TLTaXt3i7RVi+UEP7OqLfLPJ4SmLGlE6UpLVLLcIwfPh4bNaMsVwl54h4AyR
	ta2NHYbLeEgNfWi+HoVNxtnpvbtl4Sr+Ba0JZy4w/8G61xAjQIFAZku66kaRguzDlw8o11
	Ul1e8EM+JGI4aSkeacw8qblnYPgWa8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782831524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fp1dLT9aMiZvLKrxaip+Sq91NThQkBLHSya57MdqiZ0=;
	b=MfBd6CxZdG/kZci2Lo7SLl/9MFFvNSPaqGCze0WwU7PIpbjukyOQVhLelOdImvCIeryCQ0
	6AlOkmF+94KZZuDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E554D779A8;
	Tue, 30 Jun 2026 14:58:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k/+RNKLZQ2poHgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 30 Jun 2026 14:58:42 +0000
Date: Tue, 30 Jun 2026 15:58:41 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Dave Hansen <dave.hansen@intel.com>, Xiang Mei <xmei5@asu.edu>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, linux-hardening@vger.kernel.org, 
	Uladzislau Rezki <urezki@gmail.com>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Jennifer Miller <jmill@asu.edu>, Tiffany Bao <tbao@asu.edu>, Ruoyu Wang <fishw@asu.edu>, 
	Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>, 
	Yan Shoshitaishvili <yans@asu.edu>
Subject: Re: [PATCH v2] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
Message-ID: <akPYNv37BCJXUg8-@pedro-suse.lan>
References: <20260629214712.1198680-1-xmei5@asu.edu>
 <d9775951-fe04-4d1f-b205-bd4626590f5e@intel.com>
 <CAPpSM+QTiwgPk3KNmWbjSk_SS8LLL5XDfikWC1A98vetom3yeg@mail.gmail.com>
 <4e96acf4-25e7-4f30-8455-f9b3f49062be@intel.com>
 <CAPpSM+RhcW=xciX50W3G+2mUVNkmLfL1-BScPN_2TekMbzYVcg@mail.gmail.com>
 <c7c5d2c7-db83-404f-b40f-ee01ae8b9299@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7c5d2c7-db83-404f-b40f-ee01ae8b9299@intel.com>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,redhat.com,alien8.de,linux.intel.com,vger.kernel.org,gmail.com,zytor.com,kvack.org,asu.edu];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,pedro-suse.lan:mid,suse.de:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 48B8B75DE7
X-Spam-Score: -4.51

On Tue, Jun 30, 2026 at 07:01:48AM -0700, Dave Hansen wrote:
> On 6/29/26 18:22, Xiang Mei wrote:
> >> Please don't even try to send a v3 without addressing this.
> > This is a demo exploiting CVE-2026-31419 with this technique:
> > https://github.com/google/security-research/pull/397
> 
> Thanks for sharing that. That's really good info.
> 
> But what I want to hear a bit more about is why this new guard region is
> a good, generic mitigation. Does it help mitigate a whole class of
> vulnerabilities?

I guess, to add to the questions (to Xiang and/or x86 people):
1) Aren't initiatives like kCFI/CET/shadow stack supposed to mitigate these
issues? Is this mitigation supposed to be applied in spite of these features?
2) Aren't you screwed by the time the attacker gets kernel remote code
execution anyway?

> 
> I think you're making the claim that this ENTER technique takes what
> would normally just be a DoS and makes it fully exploitable. Does this
> happen for a lot of DoS bugs? Or is CVE-2026-31419 very unusual and this
> stack guard gunk won't ever be useful again?

I suspect it's just the typical UAF with a function pointer table, that leads
into remote code execution. I know that for our (SUSE) CVE scoring, we tend
to treat these kinds of UAFs a lot more seriously than others. But I didn't
look closely.

-- 
Pedro
