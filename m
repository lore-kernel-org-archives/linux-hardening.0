Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE68E3C2785
	for <linux-hardening@vger.kernel.org>; Fri, 15 May 2026 07:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778828788; cv=none; b=BsTPHxldFfOXtLR8ynSon0rkstOwkMrApJS0eGhqAcXExjdry9Ls3ZrO+Yl0kA6PCq5qz7TKntqa54V8Kdt1y+EQpCT+xxa+t+TMdF8jAd7N0D7r6TWHubyrXs8/hY06WqGs5mGIEDLnMBokhNFmlMmzOybUqFfDdBi7EcRKu28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778828788; c=relaxed/simple;
	bh=hsBv10U9ASyMD3woSVDQ3ujCzyQ3fqqnQVMDp/Icia4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fT9XOhqL7+xwXv+UOpY25xk7KncKenZHwBF1rllK7ZKKLe1YCJtFpe3PtrEZtmUKQAe2Zkb1H0SU2ezI8rBhw6oYqQqvlFHhEg1gyu7IRXM+I9l836sMuox7LU0ONjxB6Lg0XI0aYzwJLfFpcqaVmNk7wk7DG2lyKTOKm4GgNYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1/+8J9HE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5BOPi6e6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SI+garXG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j3bxLcS3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1/+8J9HE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5BOPi6e6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SI+garXG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j3bxLcS3"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1FA766B64C;
	Fri, 15 May 2026 07:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778828785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P/mfJ9R0E7QADeQssJnnzehk4FkMJ3YWVXn3FdbglVA=;
	b=1/+8J9HEaG24AsgeXlCQrjrnF2F1KE9c4R9J2qQfNAylWDjcTIGfV9nqgJ2DeI+pDQcJt9
	wi/WOPHdeaqbDfw3nm3kMqfz1FTtWkcEYoDdf3h+ubkyVwbmXpZcMiTPoWV4qMzVBg+CMZ
	rRglGoWs2+DONOMcPkSQYXr11Qn63Ms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778828785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P/mfJ9R0E7QADeQssJnnzehk4FkMJ3YWVXn3FdbglVA=;
	b=5BOPi6e6GQRSFKqJUpb6W8EmcOoYJ5jg0/vvePvWK7UhNkn79sj8NcsVrvLXIAy8EWw/ad
	eMN8J6NeYoJJD1AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SI+garXG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=j3bxLcS3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778828784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P/mfJ9R0E7QADeQssJnnzehk4FkMJ3YWVXn3FdbglVA=;
	b=SI+garXGzhdwBY8S48uHzAkz7m/ucN+1mmuQUyM/ZbIjumJJe6IngmoFAe3WrsoZq3KurG
	gFG38jkpfqFzsV4zOuo7pfEuf9OOk64Flddxh4EyHNrkgvsynjb113Ko6ljMNVH7jccCbT
	QkdbdWBhUc5EKUIA584gKsFqxRQmI9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778828784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P/mfJ9R0E7QADeQssJnnzehk4FkMJ3YWVXn3FdbglVA=;
	b=j3bxLcS33mIjnq8YOYSCxFs0WfO8Cwnp+r21C5JR3GKECYCz3Sf8lJNkbvShL43ND+QG9F
	FuetMnZhnrIr7PBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAA59593A9;
	Fri, 15 May 2026 07:06:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z/cqNO/FBmppXQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 15 May 2026 07:06:23 +0000
Date: Fri, 15 May 2026 09:06:23 +0200
Message-ID: <875x4pup74.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas)__counted_by:Keyword:b(_le|_be)?b)
Subject: Re: [PATCH] ALSA: asihpi: Use flexible array for control cache
In-Reply-To: <20260511230121.28606-1-rosenp@gmail.com>
References: <20260511230121.28606-1-rosenp@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 1FA766B64C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.51

On Tue, 12 May 2026 01:01:21 +0200,
Rosen Penev wrote:
> 
> Store the ASIHPI control-cache lookup table in the control-cache
> allocation instead of allocating it separately.
> 
> This keeps the lookup table tied to the cache object lifetime and
> removes the extra allocation and free path.
> 
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Thanks, applied to for-next branch.


Takashi
