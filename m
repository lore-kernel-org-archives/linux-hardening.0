Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90103EC83C
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785402468; cv=none; b=CoQDoHm6RcSS5sblbExN49TMya3glrglgF8tk/OvZ6RwmuplnAVLUQWKsLaNVfuLtDgd5MtkoduT4LU5lbd3ZnTMdxRNHiGBDn22D3+e6Qj5cBELa0o+lFZyN/9dwSpctZAlqlsJuCUSDUY1k/cLgKTsg23dZYvWzj+rB4HBeQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785402468; c=relaxed/simple;
	bh=NcOKm/6FAgnlyW/Si0oZ9Z8lDLDhI5vXGTAfaxZi1ng=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqT6zKf6S+f3JJlO37NvFTDByLHNg2MPr28Zy2dJmKN2lg9Of5Md3GaQwVD7aWd81ElWkCJJfWBFXZXQzzJ/V2FGswl+G3DAliXhBgN2V5L88NqcT/He36drvJ8m74rtQz9GgJ5T1aW+PT9o3YiFD/7phTSqKmq5saMYeuF9XW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GJ0baDcP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T4fEIBPA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1V/+P+ey; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Bb+JD+J4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GJ0baDcP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T4fEIBPA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1V/+P+ey";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bb+JD+J4"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A7DC67D52E;
	Thu, 30 Jul 2026 09:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785402460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/2I7GqjsrjT29uowpQk6NFdDyIeivUiqsWiwXXEqgLs=;
	b=GJ0baDcP6dsTI4xzkzv72WS9c64rNL1urCo1Ix2o6s4as6RBI5ikszLfXSUeLFwbUUj8HP
	Dhz6ofOICMwWq+r3LQD8HChVsRfAPFb8z3GzuPDEsw8z3ygaG7RGtd2neUhSmz+rxfW0kA
	CmcT1hie+wVL8keGSYJAe5r1jeEw0jk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785402460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/2I7GqjsrjT29uowpQk6NFdDyIeivUiqsWiwXXEqgLs=;
	b=T4fEIBPATb2niJE5z30aBBYoPe+cAvCTlbNctnV4nLbYHx5WxxbTpJQWaEBbF0Pw5ih4ay
	cMLv4C5YPWHaBVCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785402456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/2I7GqjsrjT29uowpQk6NFdDyIeivUiqsWiwXXEqgLs=;
	b=1V/+P+eyi3YFM7vG3qDIVEbL16AjbeIlPMkboN0dlJ4daVmFQWNSwJjnZvF9bceik4Y9O+
	/WFPtVV9kZ42bxH0IM8V2dXuG0jtpDMCZt4BDRqvzgfdiKnVRlNhs4XXF2AZV3fHnFkzEp
	FUtHy5KGnA6rd5Ql6f7iHxZzAqbhtcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785402456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/2I7GqjsrjT29uowpQk6NFdDyIeivUiqsWiwXXEqgLs=;
	b=Bb+JD+J4UsHrZLJHPKiwOUAVcmD88eUpKPQJuMX7Uv4zmxBiNDAVOQpz43PEwLr0LTBAUf
	h0bGUJqxphRx3NCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7422A779CC;
	Thu, 30 Jul 2026 09:07:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q+ciG1gUa2qgXwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 30 Jul 2026 09:07:36 +0000
Date: Thu, 30 Jul 2026 11:07:36 +0200
Message-ID: <87tspg3kx3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ian Bridges <icb@fastmail.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2] ALSA: hda/generic: Replace strlcat() with strscpy()
In-Reply-To: <amolHJpiluNmBsDU@dev>
References: <amolHJpiluNmBsDU@dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.29
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.954];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]

On Wed, 29 Jul 2026 18:06:52 +0200,
Ian Bridges wrote:
> 
> In preparation for removing the strlcat() API[1], replace its uses in
> fill_pcm_stream_name() and get_jack_mode_name(). Both appends become
> bounded strscpy() calls at a known position.
> 
> In fill_pcm_stream_name() the trim walk itself lands on the append
> position. It stops at the trim point when the name has a decoration
> to drop, and at the terminating NUL otherwise, so the suffix
> overwrites from there and no length bookkeeping is needed.
> 
> get_jack_mode_name() measures the label once with strnlen() because
> snd_hda_get_pin_label() does not return a length.
> 
> The produced strings are unchanged.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Ian Bridges <icb@fastmail.org>
> ---
> v2: land on the append position instead of measuring before every
> append. In fill_pcm_stream_name() the trim walk already finishes at
> the append position, so the suffix goes down with one bounded
> strscpy() and no length bookkeeping, matching the pattern of commit
> 86dc52c5c96e ("ALSA: usb-audio: simplify mixer control name
> handling"). get_jack_mode_name() keeps one strnlen() because
> snd_hda_get_pin_label() returns no length. Other shapes were built
> and measured for this respin, including the seq_buf form suggested
> in the thread. That one moves the fill-only-when-empty guard of
> fill_pcm_stream_name() into all three callers, because
> seq_buf_init() clears the first byte, and every call site grew.
> 
> v1: https://lore.kernel.org/all/alaPxW5S5PT_-kZi@dev/

Honestly speaking, I still don't like those changes, sorry.

My argument is about neither code correctness nor efficiency.
Instead, it's about that such a open code makes harder to understand
the intention of the code.

The meaning of strlcat() is clear: append a suffix string in a safe
way.  Meanwhile, when you open-code it:

	size_t used;
	....
 	snd_hda_get_pin_label(codec, pin, &spec->autocfg, name, name_len, &idx);
	used = strnlen(name, name_len);
	strscpy(name + used, " Jack Mode", name_len - used);

it's no longer obvious at a first glance, and you'd need to think of
it much longer -- what does this and whether it's really safe.

So, if we must inevitably drop strlcat() function, it's better to
rearrange the caller side beforehand, e.g. replace strlcat() call to
a local function like append_suffix(), in order to make the meaning
of the code clearer.  Then we can replace the code in append_suffix().

// append a suffix string safely; equivalent with strlcat()
static void append_suffix(char *str, const char *suffix, size_t size)
{
	size_t used = strnlen(str, size);
	strscpy(str + used, suffix, size - used);
}

....
	snd_hda_get_pin_label(codec, pin, &spec->autocfg, name, name_len, &idx);
	append_suffix(name, " Jack Mode", name_len);

Since I've been already working on a cleanup of the relevant code, I'm
going to change strlcat() to append_suffix() (but with strlcat()) as a
preparation, too.  Once when we decide to drop strlcat() actually, we
can change the code in that function.


thanks,

Takashi
