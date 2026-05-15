Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2F73939BD
	for <linux-hardening@vger.kernel.org>; Fri, 15 May 2026 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827996; cv=none; b=I+167ZHKswZxPDn8gQ/+Hfg0z2+gYLh5Hz4sUO1hXxXJoFadRP+qBNfNMu1YqsQ47vIZKqQLWcIJEYNvLLScRQaFcFmRKamsIEgFT5sGwmJ6r0/9Z0Br3+xrjmn9R8RI9+QfzC1dYYsG/KXm7lERBKSiUsgt8sRWJljlg4/3WoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827996; c=relaxed/simple;
	bh=SAtLaS5OkZk41rEEnb3IkTS7qxhAVRbXJ+/3Pe3xK3k=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUkr9El9oz7b04pICEOHBYpkN40OU0vd4Cz1IAKrzHxEVkfmL3nkdRUGxEwlOohUI+JvHjZfWrRPpPRhCwKl8UNzppO7E9RzXoD8wKKGj03fKC+Dt2SNducLeYoD1pRwBS9eKFGJec9nXn+4DCSnYfAtg8q/xSvcpbpXVgtNL58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XBSbyEWS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ukGhSXAw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XBSbyEWS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ukGhSXAw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XBSbyEWS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ukGhSXAw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XBSbyEWS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ukGhSXAw"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 857096B4E6;
	Fri, 15 May 2026 06:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778827993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mKrqBM86x5Px5MXq3CH82jVO/G238G414Gv7n9p1Z44=;
	b=XBSbyEWSF2p3N9JQqW7JyyivlUolGgZvjBidqWPtPeOhA5VhjKKC1bw6Q7+XdjQCB4Mtuv
	XsCzZytBALccbjMIkmt7glhsJPeq0Dklm7TpFnBCspO7yo34hMdhKWBesg7OPLpHa/fWwg
	8Ps9vHzd7zxe1vIYSwoSv7xYXprcyH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778827993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mKrqBM86x5Px5MXq3CH82jVO/G238G414Gv7n9p1Z44=;
	b=ukGhSXAwaHD3hxLqf71B4NNPGvDP01HvfzQPqzDVHzmR5YKOSocLsAs4dtd3rotnTbxwOk
	JUKuFbv3IW9Aw7AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778827993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mKrqBM86x5Px5MXq3CH82jVO/G238G414Gv7n9p1Z44=;
	b=XBSbyEWSF2p3N9JQqW7JyyivlUolGgZvjBidqWPtPeOhA5VhjKKC1bw6Q7+XdjQCB4Mtuv
	XsCzZytBALccbjMIkmt7glhsJPeq0Dklm7TpFnBCspO7yo34hMdhKWBesg7OPLpHa/fWwg
	8Ps9vHzd7zxe1vIYSwoSv7xYXprcyH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778827993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mKrqBM86x5Px5MXq3CH82jVO/G238G414Gv7n9p1Z44=;
	b=ukGhSXAwaHD3hxLqf71B4NNPGvDP01HvfzQPqzDVHzmR5YKOSocLsAs4dtd3rotnTbxwOk
	JUKuFbv3IW9Aw7AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47807593A9;
	Fri, 15 May 2026 06:53:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CxsQENnCBmqjUAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 15 May 2026 06:53:13 +0000
Date: Fri, 15 May 2026 08:53:12 +0200
Message-ID: <87cxyxupt3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas)__counted_by:Keyword:b(_le|_be)?b)
Subject: Re: [PATCH] ALSA: seq: Use flexible array for MIDI channels
In-Reply-To: <20260511075447.445350-1-rosenp@gmail.com>
References: <20260511075447.445350-1-rosenp@gmail.com>
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
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Mon, 11 May 2026 09:54:47 +0200,
Rosen Penev wrote:
> 
> Store MIDI channel entries in the MIDI channel set allocation instead
> of allocating them separately.
> 
> This ties the channel array lifetime directly to the channel set, removes
> a separate allocation failure path, and lets __counted_by() describe the
> array bounds. Move the embedded emux channel set to the end of its
> containing structure so it can carry the flexible array.
> 
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied to for-next branch.  Thanks.


Takashi
