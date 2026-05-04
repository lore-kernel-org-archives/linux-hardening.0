Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759AD354AE3
	for <linux-hardening@vger.kernel.org>; Mon,  4 May 2026 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777893918; cv=none; b=b8a514Sr5yN6dGQBEfJ8wWmrMliJZwvfHy9nNRPxG7tentGIqoskmkXvLo3ALEVf0ZoynAL0fC3wHxfV1ZeniyyrXY7I0UdTzA1SBo2pXCuugzlD9yUvKwTDmVxyqaoFSkxw2NuOKgH/qXaeBlyc46fmk2zQJkYM+LeVOSw1NqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777893918; c=relaxed/simple;
	bh=HscUiJVZ3RmQ3xNaZ4sAweXHRrvtYD8/65kto23AtMc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ensn240VnkVYk7sPZwhjt+4+QlYOlnyCrSSsWvNR4gsdpkvUoDqLbSxsTIhYEFvZrqgYuqL6YI6KTRMjcoLp8TGIrTWhj4SImDdloUBtQi3PilYAk1bx4tkwQ1vl8J0MI/5S4dUeCKsWxbIuJL3tmfO3EQ4iGZdSes0lZWLIZPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G2xHpJgw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JbivaMws; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G2xHpJgw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JbivaMws; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G2xHpJgw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JbivaMws";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G2xHpJgw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JbivaMws"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A1F9B5C58B;
	Mon,  4 May 2026 11:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777893908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oVSRMOhB8TBD9s+hZEyz4dUiL28YrCE9p+dIEatHQCk=;
	b=G2xHpJgw91lfraWUAVcXPoxbGwPRInDN+/MDIlILzG2mLhloPmL2Cos1AAYSv/J7dfl3M7
	AJM36CueA00PeiaPe5tqqASDWHFc/EugKoXXaoOIl0il+wUHAG5rxcln8VKemRk+9Qet2O
	jbjwRaXWrz2FWSPsodbjeMiYHKGCCQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777893908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oVSRMOhB8TBD9s+hZEyz4dUiL28YrCE9p+dIEatHQCk=;
	b=JbivaMwsaxfUpb1kYuG3bE4X5ihMoZs2qJQvensbpd8XfnLv3A4/UNVOARkpYvvLy+97xv
	QhPto8vH4pLdbXAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777893908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oVSRMOhB8TBD9s+hZEyz4dUiL28YrCE9p+dIEatHQCk=;
	b=G2xHpJgw91lfraWUAVcXPoxbGwPRInDN+/MDIlILzG2mLhloPmL2Cos1AAYSv/J7dfl3M7
	AJM36CueA00PeiaPe5tqqASDWHFc/EugKoXXaoOIl0il+wUHAG5rxcln8VKemRk+9Qet2O
	jbjwRaXWrz2FWSPsodbjeMiYHKGCCQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777893908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oVSRMOhB8TBD9s+hZEyz4dUiL28YrCE9p+dIEatHQCk=;
	b=JbivaMwsaxfUpb1kYuG3bE4X5ihMoZs2qJQvensbpd8XfnLv3A4/UNVOARkpYvvLy+97xv
	QhPto8vH4pLdbXAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E5E7593A3;
	Mon,  4 May 2026 11:25:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EIywERSC+Gm3GQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 04 May 2026 11:25:08 +0000
Date: Mon, 04 May 2026 13:25:07 +0200
Message-ID: <87zf2fxvqk.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas)__counted_by:Keyword:b(_le|_be)?b)
Subject: Re: [PATCH] ALSA: seq: oss/rw: allocate evrec with main struct
In-Reply-To: <20260430210413.31185-1-rosenp@gmail.com>
References: <20260430210413.31185-1-rosenp@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO

On Thu, 30 Apr 2026 23:04:13 +0200,
Rosen Penev wrote:
> 
> Use a flexible array member to simplify allocation slightly.
> 
> Add the header as flexible array members require full definitions.
> 
> Remove null check and just kfree. The former is not needed.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied to for-next branch.  Thanks.


Takashi
