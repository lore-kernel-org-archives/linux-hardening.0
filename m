Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B45D2951A0
	for <linux-hardening@vger.kernel.org>; Tue, 15 Apr 2025 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744718839; cv=none; b=naBeq/BL3U9xsM8Rt/rb4y0dxW9sdhwXFd8e4B87cdQRpHOR6fO/xoX7QyWqUazx7cTJSwjrQ7qEyLvHz5AFlHxSWzQltbplX109XikfanAgMJOKosqlsO2PRiKcdb8nPujCW9Es32iOA1Hvy8NirJFt3O4l3khDv79Gr9pmUg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744718839; c=relaxed/simple;
	bh=q+j/4ED7OV5YAKIOQeHEFisQ36G2XCfFbi7Gj0qZPAU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8IojmIw78QF+Q7iEhNNvTwXuOgHJiQVH3hRigb38+tz1s57ZWPKbbmOImIcK6RADq4JFeAlbiK012DcA07jWG+BMh8vJjaAlvMrYgirQoBDgs7yFo/QZGwwj598uyaoCRKOxcZM4ZjfOxYgC9+DreF5yzZygqFkVvqqpadt1K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HscZcIib; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jKfp2OMp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HscZcIib; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jKfp2OMp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HscZcIib";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jKfp2OMp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HscZcIib";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jKfp2OMp"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F51921162;
	Tue, 15 Apr 2025 12:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744718836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tdU2b0wx3AY/sGHKBtE9YJt3OEIlLfZdeKx71zBsLgo=;
	b=HscZcIibrchgL54J7kjebM5aQYOkiIwcEeGo+LJJSUcfUvYff/q4l+M0s0Ny6ynyagnr4Y
	+VV/XcrpWUo2zDUlqI2AaElfbh/XDDmhBkdvt42hG+Ev9cd92i2A+dIf8uG27cYLD8QbjX
	QnhNHO/09Ktecu0WMLqnsoq7LJP4KYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744718836;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tdU2b0wx3AY/sGHKBtE9YJt3OEIlLfZdeKx71zBsLgo=;
	b=jKfp2OMpJnyVN/PajLHi24Vmc/uvwHKp8Plut4YQlV82wdOiFkrpKZQBLT7JJ+pCFI6FKW
	B79dKQQwjuKRZbDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HscZcIib;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jKfp2OMp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744718836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tdU2b0wx3AY/sGHKBtE9YJt3OEIlLfZdeKx71zBsLgo=;
	b=HscZcIibrchgL54J7kjebM5aQYOkiIwcEeGo+LJJSUcfUvYff/q4l+M0s0Ny6ynyagnr4Y
	+VV/XcrpWUo2zDUlqI2AaElfbh/XDDmhBkdvt42hG+Ev9cd92i2A+dIf8uG27cYLD8QbjX
	QnhNHO/09Ktecu0WMLqnsoq7LJP4KYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744718836;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tdU2b0wx3AY/sGHKBtE9YJt3OEIlLfZdeKx71zBsLgo=;
	b=jKfp2OMpJnyVN/PajLHi24Vmc/uvwHKp8Plut4YQlV82wdOiFkrpKZQBLT7JJ+pCFI6FKW
	B79dKQQwjuKRZbDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CD37139A1;
	Tue, 15 Apr 2025 12:07:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u1maCfRL/mdZDAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 15 Apr 2025 12:07:16 +0000
Date: Tue, 15 Apr 2025 14:07:15 +0200
Message-ID: <87ecxtzkzw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Mark Brown <broonie@kernel.org>,
	David Rhodes <david.rhodes@cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ASoC: cs-amp-lib: Annotate struct cirrus_amp_efi_data with __counted_by()
In-Reply-To: <c344e6bd-1a95-4982-927d-f679410c444b@opensource.cirrus.com>
References: <20250415090354.92211-2-thorsten.blum@linux.dev>
	<9a0595a3-00c0-4006-bd54-99b938ee95bd@sirena.org.uk>
	<C0A89B4A-14BC-48F3-9D0F-31C8C0AF7ECE@linux.dev>
	<c344e6bd-1a95-4982-927d-f679410c444b@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 7F51921162
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 15 Apr 2025 14:03:18 +0200,
Richard Fitzgerald wrote:
> 
> On 15/04/2025 12:51 pm, Thorsten Blum wrote:
> > On 15. Apr 2025, at 12:56, Mark Brown wrote:
> >> On Tue, Apr 15, 2025 at 11:03:55AM +0200, Thorsten Blum wrote:
> >>> Add the __counted_by() compiler attribute to the flexible array member
> >>> 'data' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> >>> CONFIG_FORTIFY_SOURCE.
> >> 
> >> As documented in submitting-patches.rst please send patches to the
> >> maintainers for the code you would like to change.  The normal kernel
> >> workflow is that people apply patches from their inboxes, if they aren't
> >> copied they are likely to not see the patch at all and it is much more
> >> difficult to apply patches.
> > 
> > I just use whatever scripts/get_maintainer.pl outputs. Maybe the
> > MAINTAINERS file should be updated?
> > 
> > Best,
> > Thorsten
> > 
> 
> MAINTAINERS only lists Takashi and Jaroslav as maintainers of
> include/sound/*.
> 
> A separate section lists Mark as maintainer of a specific set of files
> within include/sound/
> 
> I guess any files we put in include/sound that are for an ASoC driver
> have to also be added to Mark's ASoC section of MAINTAINERS?

Yes, it makes sense.


Takashi
