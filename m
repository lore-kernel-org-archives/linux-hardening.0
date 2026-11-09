Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794222458;
	b=Ief40aCqvtWqCV9HIiQnZl8WeM7P4Py5dnQCQJHBFesGw1BafN1c3w7BPcjWhb3QnRpF
	 T/Y5WuhfnRsVEDSth/t4ydCcnl0ow8eXavl8rqwO/wysuuljaHSWNzdPXKwsEPvDnEMh1
	 wQUsXYDiflGhOAHqAaRG43VQH11omZZoqLNO7HS/hj2R+BRgZexejMUvWdAwFu/my1Dhy
	 PivGnQFC36xu73yRylPHN1Y5GI3Ozj7zusMXBZ57EhNolOZCB5EXFKxnLYC/enG+TXtpa
	 XAkZoejQSG9qdGwirp0HOdGBeakfZNIB5Vt3Fc3+JR6S/nFjLNhTfi3x7ojp6RjNrVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794222458;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=yJtaga32g0U9vhTGcK00+DLTorW/Gm6WwE87naWfe3A=;
	b=4OJbt55nXXtf677Vb2szA5wt4gnStsZSxiOSNslzxd+JxxlaF/lFH9fUbxB1zCBzaAfk
	 TzCY8StSbSmLjGgLrZUcmSJwZInoQl8c4d/jNEOQYDLDFRirYAV1XBvnGennWYednamVX
	 ASLPNGKUsDft820rU808S79aKo+ngSPKqeaPrrCd6q9N1rVZ4q5RZTKqxzpcfUnXv63ld
	 Umm/tXthrGpGI5Bd6BT3b9ldf16hIvRe/+m7fuAz2kfywbX2MrmPfc0ZAvENWGOHpHzvY
	 8UKLy+zvptmOTcZacGWGETVbpd9K5AyhUqnsd5lsjlZtJjz1i3a1DaGzj625Lv4wyIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=G7ZuuZ7F;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8DZL15mZ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=V2lAfJL9;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dU77csUp;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD51A606A321;
	Mon,  9 Nov 2026 11:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD51A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=G7ZuuZ7F;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8DZL15mZ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=V2lAfJL9;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dU77csUp
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B3CE1F7C2;
	Mon,  9 Nov 2026 11:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794222456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yJtaga32g0U9vhTGcK00+DLTorW/Gm6WwE87naWfe3A=;
	b=G7ZuuZ7Fn1ck/XvjaPXKVk0h/78G8TeEgpDMeWsTDrNvJg6PJWFLL0gIM6Cw9DCPc9o2ih
	5ukyxnI9eGptqsV/rG4vUQkutOIYUkwerb6BTsdP1T7KVcqO1sWP/edZqNRAC5lApyE2Vj
	AmTvrp67Kz0l2a3UqQlsCpPBt599boQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794222456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yJtaga32g0U9vhTGcK00+DLTorW/Gm6WwE87naWfe3A=;
	b=8DZL15mZ04yr3tJ0OLXjP3HXd/IqZbK7AdcBvl7AINSdXEt3uDTyOKrPqByB3ihBZXm7nC
	nyRAHwuREoV0CLCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=V2lAfJL9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dU77csUp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794222454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yJtaga32g0U9vhTGcK00+DLTorW/Gm6WwE87naWfe3A=;
	b=V2lAfJL9VWzQzL+luBdhEbgFQ8l8qNApb9k2VgW/IY1bcjeRILdVEDyrIPal+/Ek2GQKNK
	T/LkY9XwBxwDeD3i0PG5vOX9/aN5cSHOtGhXvKoEvGHYC1F4VUYN7Ucta7f0cOTQggPQlV
	UxMXJJBMFkY0+cq6W/q6XMAtV7SAtvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794222454;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yJtaga32g0U9vhTGcK00+DLTorW/Gm6WwE87naWfe3A=;
	b=dU77csUpfXQW1WnILoKW+a25yqXqX8jX6JbJo8wIDsAN8sycfcfJ4rBcrftmvjAR0ka/jA
	b5vzMJkgE8J0itBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1C6313319;
	Mon,  9 Nov 2026 11:07:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6kSkL3Wp8Wo0EgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 09 Nov 2026 11:07:33 +0000
Date: Mon, 09 Nov 2026 12:07:33 +0100
Message-ID: <87bj7yw9e2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
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
In-Reply-To: <20261109102536.357134-1-ghidoliemanuele@gmail.com>
References: <20261109102536.357134-1-ghidoliemanuele@gmail.com>
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
X-Rspamd-Queue-Id: 9B3CE1F7C2
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,toradex.com,perex.cz,suse.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,toradex.com:email]
X-Spam-Score: -12.51

On Mon, 09 Nov 2026 11:25:20 +0100,
Emanuele Ghidoli wrote:
On Mon, 09 Nov 2026 11:25:20 +0100,
Emanuele Ghidoli wrote:
> 
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> 
> Commit 4dd10fbbeb9c ("treewide: Convert devm_kmalloc() family to the
> devm_kmalloc_obj() family") switched the snd_soc_pcm_runtime allocation
> in soc_new_pcm_runtime() to devm_kzalloc_flex(). components[] is
> annotated with __counted_by(num_components), so when the compiler
> provides __builtin_counted_by_ref() the allocation now also sets
> rtd->num_components to the number of allocated slots.
> 
> snd_soc_rtd_add_component() fills components[] one entry at a time and
> expects num_components to start at zero. Starting from the allocated
> size, for_each_rtd_components() stops at the first, still NULL, entry,
> so the runtime has no components: they are not probed, no controls or
> user-visible PCM devices are created and the card registers empty,
> without any error message. In addition, each added component is stored
> past the end of components[]. On the tested board these stores still
> land in the slack of the kmalloc bucket that devres rounds the
> allocation up to, so KASAN does not report them.
> 
> Reset num_components after the allocation.
> 
> Seen on a Colibri iMX7D (simple-audio-card, fsl-sai, sgtl5000): the card
> is listed in /proc/asound/cards, but /proc/asound/pcm is empty and
> 
>   amixer: Unable to find simple control 'Capture Mux',0
>   aplay: main:850: audio open error: No such file or directory
> 
> Tested on that board with v7.4-rc2 built with GCC 15.2 (first seen with
> GCC 16.2): the failure is there without this change; with it, playback,
> capture and the codec controls work again.
> 
> The root cause analysis, this change and the testing were done with the
> help of an AI coding assistant (Claude Code, Claude Opus 5.5).
> 
> Fixes: 4dd10fbbeb9c ("treewide: Convert devm_kmalloc() family to the devm_kmalloc_obj() family")
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> ---
> 4dd10fbbeb9c only reached mainline in v7.4-rc2 (not in broonie/sound yet),
> so this is based on v7.4-rc2.
> 
> The other devm_k[mz]alloc_flex() sites added by 4dd10fbbeb9c were checked
> too: none of them fills a __counted_by() counter one entry at a time, so
> this one looks like the only user hit by the preset counter.

I guess a bugzilla entry that was reported recently is also related
with this problem.
  https://bugzilla.kernel.org/show_bug.cgi?id=222249

My first gut feeling was that it might be safer to revert the use of
devm_kmalloc_flex() in that code, as it has a significant side-effect
unlike other straight conversions.  But, if this fix covers well, we
can go with this fix, of course.


thanks,

Takashi


> 
>  sound/soc/soc-core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 68b54e509b65..06a1d5718997 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -387,6 +387,12 @@ static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
>  		device_unregister(dev);
>  		return NULL;
>  	}
> +	/*
> +	 * devm_kzalloc_flex() presets the __counted_by() counter to the
> +	 * allocated size when the compiler has __builtin_counted_by_ref(),
> +	 * but snd_soc_rtd_add_component() expects it to start from zero.
> +	 */
> +	rtd->num_components = 0;
>  
>  	rtd->dev = dev;
>  	INIT_LIST_HEAD(&rtd->list);
> 
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> -- 
> 2.53.0
> 
> 
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> 
> Commit 4dd10fbbeb9c ("treewide: Convert devm_kmalloc() family to the
> devm_kmalloc_obj() family") switched the snd_soc_pcm_runtime allocation
> in soc_new_pcm_runtime() to devm_kzalloc_flex(). components[] is
> annotated with __counted_by(num_components), so when the compiler
> provides __builtin_counted_by_ref() the allocation now also sets
> rtd->num_components to the number of allocated slots.
> 
> snd_soc_rtd_add_component() fills components[] one entry at a time and
> expects num_components to start at zero. Starting from the allocated
> size, for_each_rtd_components() stops at the first, still NULL, entry,
> so the runtime has no components: they are not probed, no controls or
> user-visible PCM devices are created and the card registers empty,
> without any error message. In addition, each added component is stored
> past the end of components[]. On the tested board these stores still
> land in the slack of the kmalloc bucket that devres rounds the
> allocation up to, so KASAN does not report them.
> 
> Reset num_components after the allocation.
> 
> Seen on a Colibri iMX7D (simple-audio-card, fsl-sai, sgtl5000): the card
> is listed in /proc/asound/cards, but /proc/asound/pcm is empty and
> 
>   amixer: Unable to find simple control 'Capture Mux',0
>   aplay: main:850: audio open error: No such file or directory
> 
> Tested on that board with v7.4-rc2 built with GCC 15.2 (first seen with
> GCC 16.2): the failure is there without this change; with it, playback,
> capture and the codec controls work again.
> 
> The root cause analysis, this change and the testing were done with the
> help of an AI coding assistant (Claude Code, Claude Opus 5.5).
> 
> Fixes: 4dd10fbbeb9c ("treewide: Convert devm_kmalloc() family to the devm_kmalloc_obj() family")
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> ---
> 4dd10fbbeb9c only reached mainline in v7.4-rc2 (not in broonie/sound yet),
> so this is based on v7.4-rc2.
> 
> The other devm_k[mz]alloc_flex() sites added by 4dd10fbbeb9c were checked
> too: none of them fills a __counted_by() counter one entry at a time, so
> this one looks like the only user hit by the preset counter.
> 
>  sound/soc/soc-core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 68b54e509b65..06a1d5718997 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -387,6 +387,12 @@ static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
>  		device_unregister(dev);
>  		return NULL;
>  	}
> +	/*
> +	 * devm_kzalloc_flex() presets the __counted_by() counter to the
> +	 * allocated size when the compiler has __builtin_counted_by_ref(),
> +	 * but snd_soc_rtd_add_component() expects it to start from zero.
> +	 */
> +	rtd->num_components = 0;
>  
>  	rtd->dev = dev;
>  	INIT_LIST_HEAD(&rtd->list);
> 
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> -- 
> 2.53.0
> 
