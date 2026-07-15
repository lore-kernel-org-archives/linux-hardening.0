Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D812F39B5
	for <linux-hardening@vger.kernel.org>; Wed, 15 Jul 2026 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784102101; cv=none; b=FccnZFaKqlbTG5LkYWdxMGKbAo7Gs6CWsLTkqq3FBbW0TZsBJhwf88X5dv3zSzmOimSoP4H1EOQfzZ/BiETQxr2BEu6KcNkG/UTl67MRjwlfI0nUToHXcHLIxUP23UTfG6a39ZNo6bv3fvO/jmGo5cvLD7BznIAdxG/1qsWZrLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784102101; c=relaxed/simple;
	bh=W+3PNG/rQkb1rXBSDdcPIdifSQue918SU9KPZ6VfCYs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXMILsIXxIBEpY2ssyCUs19YarV1T5bbcUE4UVR5oNNQfNPNXgM71uUyqYvPWFoJY0LfOruFF6WqR8xi6teV28ghxX4/qAFE4i5/r6rmo8z/lXc9E24a+ASdzyGpgLrDLEw8VQm4adWVPTsA7p9+6gK2QRbAy2Awknx06dn1ps0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LQ9BuE72; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZI4M2tq5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IkBb31TO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6I+9Y9xC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LQ9BuE72";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZI4M2tq5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IkBb31TO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6I+9Y9xC"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3868E76073;
	Wed, 15 Jul 2026 07:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784102098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wXJx+ndhr0wzT6Dna5r9N6rTI3YFqffJa78zyokU+SI=;
	b=LQ9BuE72eYdNrei+jtepPFbc6rSzzdD0zxs3gaT73H0q/I4pBEmL8EsRTI6K1sAlUclbKD
	vFGvJ4HFgt1iIz4FSa3evxy6vq87llSbrs2Y8AyVEiBSAG0S+kEUrP/wLexirrRc2NIKFE
	ChBZY6Z4uri0TwzdWQF02K82zHuySAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784102098;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wXJx+ndhr0wzT6Dna5r9N6rTI3YFqffJa78zyokU+SI=;
	b=ZI4M2tq5g5Shy2u0qHYZWqgW6CJ1pHJtm6BRWhNTDtktE3kzAzdaz0GEBF4g6F5LAPyvEn
	cLaLS26sVtdWiiBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784102097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wXJx+ndhr0wzT6Dna5r9N6rTI3YFqffJa78zyokU+SI=;
	b=IkBb31TOe/ojsYlgb3lvrl4/GkmFjZrr8QKSpCWPhkCTv8nOaI+pK+8iiXzxCJ10VPGgCV
	7NDKj2PgQXSALNvq8y166jGqZV6tG1G0/UvnDht0peIp2KrMMC/qxZcL9GIZpF130HOeAK
	xzhV2CMz7CL9MmEsoZECVN7T4wJRclA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784102097;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wXJx+ndhr0wzT6Dna5r9N6rTI3YFqffJa78zyokU+SI=;
	b=6I+9Y9xCygmxjIQceEwvWwdQeFhN/llBO4PUjHfmHFWVZyiX/IchOK7srvuoB+wwrqTpXi
	xuG0I2qQqyWH61AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFD51779AD;
	Wed, 15 Jul 2026 07:54:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ur4QONA8V2pAPAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 15 Jul 2026 07:54:56 +0000
Date: Wed, 15 Jul 2026 09:54:56 +0200
Message-ID: <87o6g8y9f3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ian Bridges <icb@fastmail.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/generic: Replace strlcat() with strscpy()
In-Reply-To: <alaPxW5S5PT_-kZi@dev>
References: <alaPxW5S5PT_-kZi@dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,fastmail.org:email]
X-Spam-Level: 

On Tue, 14 Jul 2026 21:36:37 +0200,
Ian Bridges wrote:
> 
> In preparation for removing the strlcat() API[1], replace its two
> uses in the generic parser.
> 
> Both call sites append one suffix to a string that the function has
> already bounded to the buffer size. A strscpy() anchored at the
> current end of the string writes the same bytes, including when the
> suffix is truncated.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Ian Bridges <icb@fastmail.org>
> ---
> The patch was tested as follows.
> 
> - W=1 build of sound/hda/, zero warnings.
> - A userspace differential harness compiled the old and the new
>   functions side by side. The buffers were byte identical over their
>   full length, including the bytes after the terminator.
> - A QEMU runtime compare. A guest with an emulated HDA codec was
>   booted on the base and on the patched kernel, and the captured
>   /proc/asound state was byte identical. That covers the PCM stream
>   names from fill_pcm_stream_name() live.
> 
>  sound/hda/codecs/generic.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/hda/codecs/generic.c b/sound/hda/codecs/generic.c
> index 660a9f2c0ded..5f373cbf4a53 100644
> --- a/sound/hda/codecs/generic.c
> +++ b/sound/hda/codecs/generic.c
> @@ -2712,10 +2712,12 @@ static void get_jack_mode_name(struct hda_codec *codec, hda_nid_t pin,
>  			       char *name, size_t name_len)
>  {
>  	struct hda_gen_spec *spec = codec->spec;
> +	size_t used;
>  	int idx = 0;
>  
>  	snd_hda_get_pin_label(codec, pin, &spec->autocfg, name, name_len, &idx);
> -	strlcat(name, " Jack Mode", name_len);
> +	used = strnlen(name, name_len);
> +	strscpy(name + used, " Jack Mode", name_len - used);
>  
>  	for (; find_kctl_name(codec, name, idx); idx++)
>  		;
> @@ -5682,6 +5684,7 @@ static const struct hda_pcm_stream dyn_adc_pcm_analog_capture = {
>  static void fill_pcm_stream_name(char *str, size_t len, const char *sfx,
>  				 const char *chip_name)
>  {
> +	size_t used;
>  	char *p;
>  
>  	if (*str)
> @@ -5695,7 +5698,8 @@ static void fill_pcm_stream_name(char *str, size_t len, const char *sfx,
>  			break;
>  		}
>  	}
> -	strlcat(str, sfx, len);
> +	used = strnlen(str, len);
> +	strscpy(str + used, sfx, len - used);
>  }
>  
>  /* copy PCM stream info from @default_str, and override non-NULL entries

Hmm...  IMHO, those changes are *too ugly*.

Is the reason to drop strlcat() is only about the performance, no?
If it were some security hardening, I'd find OK, but if not, this kind
of change is doubtful: the code path is no hot path, hence the effect
is nothing, and yet readability becomes significantly worse.


thanks,

Takashi
