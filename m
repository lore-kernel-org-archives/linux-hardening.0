Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C6A201258
	for <linux-hardening@vger.kernel.org>; Mon,  7 Apr 2025 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744040516; cv=none; b=BMQ65ctY8mqygc38oNERWZarivjR8eI3angFG9IHJIJTVd9Yrcs6Nq/oJaZYXh1+2UMaXWMaoAnXaUiMSiHBzRrlbo4qSu8N6CK8E/hsWdB0RPkz6zcvrhj3ckGZwIMdgZMfgWTI5hGJNBSBYpje3R5pSxwzj2q8lRXJeMohfA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744040516; c=relaxed/simple;
	bh=c+r3gZcw9sRz7g/dxPPMH5rBFO2oV0s/05FUVQt1ycw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AgSvRruGzEiu2+ytV9uW1hJ8STE48GyVyolT1IayRyu4abIxytkk8YFvuBp1MS1dbbORzxzO7Klp+8zbVU2BbqvqGg2nptlDAhQQDbw/dE3jI32GK8xhFJIbisnIQW+qYc8/tCdopPFhS2l+IGOxg9X7nfCtWkh2h6cd5+v/oio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C18FyNCo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vup9tjxh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C18FyNCo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vup9tjxh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C18FyNCo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vup9tjxh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C18FyNCo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vup9tjxh"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B4561F769;
	Mon,  7 Apr 2025 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744040513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iTvPtaU4waFCJGiSOKXC4jb0EXXLdWq6voKpUkzh9h0=;
	b=C18FyNCoh+5ACbUk5PODUxCvuM1VlL5jCcmdo3DZSwXWuz1R7RsGmu7M9jl3TByLMwn/+x
	FQ38Dt3PrIlhgH+VeQZ7qitNxcS8CYWancdEZ00Mv4ZikDsY8AQHOjpMs2ANYvLc/+egH+
	COAA4TDzmG2obVVCO4bAsgj7Y+YOyT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744040513;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iTvPtaU4waFCJGiSOKXC4jb0EXXLdWq6voKpUkzh9h0=;
	b=vup9tjxhOk3P9qiY9ZZRovp/fc2sYRYrUNxvNqL4c7W7XPy4iKFzEWczTVuNNG+6EetT7o
	WQsw///tFxk1QsBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=C18FyNCo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vup9tjxh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744040513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iTvPtaU4waFCJGiSOKXC4jb0EXXLdWq6voKpUkzh9h0=;
	b=C18FyNCoh+5ACbUk5PODUxCvuM1VlL5jCcmdo3DZSwXWuz1R7RsGmu7M9jl3TByLMwn/+x
	FQ38Dt3PrIlhgH+VeQZ7qitNxcS8CYWancdEZ00Mv4ZikDsY8AQHOjpMs2ANYvLc/+egH+
	COAA4TDzmG2obVVCO4bAsgj7Y+YOyT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744040513;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iTvPtaU4waFCJGiSOKXC4jb0EXXLdWq6voKpUkzh9h0=;
	b=vup9tjxhOk3P9qiY9ZZRovp/fc2sYRYrUNxvNqL4c7W7XPy4iKFzEWczTVuNNG+6EetT7o
	WQsw///tFxk1QsBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB03213A4B;
	Mon,  7 Apr 2025 15:41:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id acH9M0Dy82cyQgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 07 Apr 2025 15:41:52 +0000
Date: Mon, 07 Apr 2025 17:41:52 +0200
Message-ID: <87zfgsashr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-hardening@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: azt2320: Replace deprecated strcpy() with strscpy()
In-Reply-To: <20250407090832.743255-1-thorsten.blum@linux.dev>
References: <20250407090832.743255-1-thorsten.blum@linux.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 2B4561F769
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,linux.dev:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 07 Apr 2025 11:08:29 +0200,
Thorsten Blum wrote:
> 
> strcpy() is deprecated, use strscpy() instead.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Applied now.  Thanks.


Takashi
