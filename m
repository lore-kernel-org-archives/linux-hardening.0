Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311278;
	b=d4I2zgVl1SdwlRebt3YYdSWqqteujB9Lxnm01ohZZGmHaQ5CSLBsu3xX5XcfBncJMyvr
	 a+OrescJiwPNEFhqqN8N8GUQCE9uSXlf1TB5aIm7Qpju4fLwZ1CRu/jjmAbUVogZ3opXO
	 aTnC5AKqFcbkJt2tHmxWI6UBhrQb2pprlG9ialEeCVyaXAdnLvRvmjE395lqmlWgec8jA
	 Lu2iFdvB4oL55a7liIRLC20NcvMPLxeuDymjFDohuvXtl8yMfvUJSSp5dsrGvD1SIrp5c
	 saTBrzYA9uV57DMY5rdea7JeWHlYG6m+RfKbqwgMig/eTgsIcqFESuZ1435UZYHzSVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311278;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=qGURqmXpzK2RLNXVuRSk2BdtnPUh0Q968Z0BGF6BGuk=;
	b=CLx/QNs+fzg1cOkJa9hFkDolX2F7tTU8Rn/1OF/yaaAvQ/hKlH1ATjQkSUzThnUEtQUl
	 CeQwfsCO2nNaV3f6AQCA9JnTQGp5u8BYE3zMgTfMSMKO03jZ4WYBJ0OrkJU2lnzNfJyBU
	 4kLX4B0YInSXZpDFMvaoPj0FgJWBi4sWVp6k4my/FjNeFkrLvetxgLjU/oEV5sjbSRYYB
	 7RKEK4+z1g77gcihEzpsfoS1oXRP6oRC/YQS63ZejtSkpwxZSVU4/awJDri9bMDyEvq7p
	 fNeFznvufwWUxWhM0n060Uc3x/Pt+9rGL9ULLy5S62z3V5EEoRnIxkrHJFuThWuZ8gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=U6qQmIOe;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WIwzEQN8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=U6qQmIOe;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WIwzEQN8;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5019A606A32E;
	Tue, 10 Nov 2026 11:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5019A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=U6qQmIOe;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WIwzEQN8;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=U6qQmIOe;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WIwzEQN8
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3C00E21ECD;
	Tue, 10 Nov 2026 11:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794311275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qGURqmXpzK2RLNXVuRSk2BdtnPUh0Q968Z0BGF6BGuk=;
	b=U6qQmIOe4LvIJA+DVbIM/USCgGP3Cvm2/v13Ni2PC8EpzU10lX24ukr0eO9SFWetRwpSBd
	esprniFiFGj+wf3Xk/G4UbA6Lf2T57d4d+XkbCxTKmVUMLfk7rEVyxnFzCgFsdXRbpJ0CS
	JAvVo6oLslQd+JKTA/j0KzsfOvNvp30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794311275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qGURqmXpzK2RLNXVuRSk2BdtnPUh0Q968Z0BGF6BGuk=;
	b=WIwzEQN8OeUdjpJtUl13rh/DMUycjp1FwDjrGfpA8v7bpJTaRmUDjKMG7dEeXGBRYXsfji
	NfmQfnBsPoDaCXAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=U6qQmIOe;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WIwzEQN8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794311275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qGURqmXpzK2RLNXVuRSk2BdtnPUh0Q968Z0BGF6BGuk=;
	b=U6qQmIOe4LvIJA+DVbIM/USCgGP3Cvm2/v13Ni2PC8EpzU10lX24ukr0eO9SFWetRwpSBd
	esprniFiFGj+wf3Xk/G4UbA6Lf2T57d4d+XkbCxTKmVUMLfk7rEVyxnFzCgFsdXRbpJ0CS
	JAvVo6oLslQd+JKTA/j0KzsfOvNvp30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794311275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qGURqmXpzK2RLNXVuRSk2BdtnPUh0Q968Z0BGF6BGuk=;
	b=WIwzEQN8OeUdjpJtUl13rh/DMUycjp1FwDjrGfpA8v7bpJTaRmUDjKMG7dEeXGBRYXsfji
	NfmQfnBsPoDaCXAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3F4E13479;
	Tue, 10 Nov 2026 11:47:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CJDRJWoE82rwewAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 10 Nov 2026 11:47:54 +0000
Date: Tue, 10 Nov 2026 12:47:54 +0100
Message-ID: <87pkwcvrf9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-core: reset rtd->num_components after allocation
In-Reply-To: <87bj7yw9e2.wl-tiwai@suse.de>
References: <20261109102536.357134-1-ghidoliemanuele@gmail.com>
	<87bj7yw9e2.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,toradex.com,kernel.org,perex.cz,suse.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,toradex.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 3C00E21ECD

On Mon, 09 Nov 2026 12:07:33 +0100,
Takashi Iwai wrote:
> 
> On Mon, 09 Nov 2026 11:25:20 +0100,
> Emanuele Ghidoli wrote:
> On Mon, 09 Nov 2026 11:25:20 +0100,
> Emanuele Ghidoli wrote:
> > 
> > From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > 
> > 
> > Commit 4dd10fbbeb9c ("treewide: Convert devm_kmalloc() family to the
> > devm_kmalloc_obj() family") switched the snd_soc_pcm_runtime allocation
> > in soc_new_pcm_runtime() to devm_kzalloc_flex(). components[] is
> > annotated with __counted_by(num_components), so when the compiler
> > provides __builtin_counted_by_ref() the allocation now also sets
> > rtd->num_components to the number of allocated slots.
> > 
> > snd_soc_rtd_add_component() fills components[] one entry at a time and
> > expects num_components to start at zero. Starting from the allocated
> > size, for_each_rtd_components() stops at the first, still NULL, entry,
> > so the runtime has no components: they are not probed, no controls or
> > user-visible PCM devices are created and the card registers empty,
> > without any error message. In addition, each added component is stored
> > past the end of components[]. On the tested board these stores still
> > land in the slack of the kmalloc bucket that devres rounds the
> > allocation up to, so KASAN does not report them.
> > 
> > Reset num_components after the allocation.
> > 
> > Seen on a Colibri iMX7D (simple-audio-card, fsl-sai, sgtl5000): the card
> > is listed in /proc/asound/cards, but /proc/asound/pcm is empty and
> > 
> >   amixer: Unable to find simple control 'Capture Mux',0
> >   aplay: main:850: audio open error: No such file or directory
> > 
> > Tested on that board with v7.4-rc2 built with GCC 15.2 (first seen with
> > GCC 16.2): the failure is there without this change; with it, playback,
> > capture and the codec controls work again.
> > 
> > The root cause analysis, this change and the testing were done with the
> > help of an AI coding assistant (Claude Code, Claude Opus 5.5).
> > 
> > Fixes: 4dd10fbbeb9c ("treewide: Convert devm_kmalloc() family to the devm_kmalloc_obj() family")
> > Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > ---
> > 4dd10fbbeb9c only reached mainline in v7.4-rc2 (not in broonie/sound yet),
> > so this is based on v7.4-rc2.
> > 
> > The other devm_k[mz]alloc_flex() sites added by 4dd10fbbeb9c were checked
> > too: none of them fills a __counted_by() counter one entry at a time, so
> > this one looks like the only user hit by the preset counter.
> 
> I guess a bugzilla entry that was reported recently is also related
> with this problem.
>   https://bugzilla.kernel.org/show_bug.cgi?id=222249
> 
> My first gut feeling was that it might be safer to revert the use of
> devm_kmalloc_flex() in that code, as it has a significant side-effect
> unlike other straight conversions.  But, if this fix covers well, we
> can go with this fix, of course.

And it seems working for the bugzilla issue above, too.

Mark, could you pick this up quickly?  It looks like a severe
regression.

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=222249


thanks,

Takashi
