Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC92D2248AF
	for <linux-hardening@vger.kernel.org>; Mon, 10 Mar 2025 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602520; cv=none; b=SoIU3v7aozwmW8CwcE7r0WkyLE7QzcNA1vrr7BNwmthP8uBMMzpyvjHSzPvD9CfmmQkI+WVQm+mk2mcwV7z+UZG/2NgchC8qdqaI4TBnYxuG86x5SDSJmO7v2jhoLw49z1KJh2ZpaRkvoHqX/sUr13XFwrBwOEmTks0E84vinxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602520; c=relaxed/simple;
	bh=9efuJwEyGNsv2zYMHCCO5EDKVRUa26N4xpdeI5PHUcY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8J047DhXM/oPf+ApNROYZCTDehDYRUa9d9h3j2DZhVKPQ3HXdXnDHEcbzl68ZfgH0ait/MXPaMNYVJ9HNlDoHOT7FBDuElSKVxSZNCqWA+ukPtCEWO9ONgq8w/oRs3e4NgN/lGquwQT9eaVGbK7hYoEebm/yO6YTVE6Wbx52Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GgdXEI6e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Gql7v8om; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A1CalgRY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nFv0nSUH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GgdXEI6e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Gql7v8om";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A1CalgRY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nFv0nSUH"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA5BE21162;
	Mon, 10 Mar 2025 10:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741602517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b5vrudqUIRMhct6dpCgJ1DFv6JTwrGfy1tiyzgZ45KI=;
	b=GgdXEI6edUxkgRQZ67B9pcgu7r2l2sb7k0/l7mZIKZHOl1L1Q76JqmkU6p/pJpQ+0NSzi9
	4Ct7y/D41aLHl91UccmOPSEo81sQT+oMQ6kYbT63h5o4SEHqXn7HXaMkXjtAsBHnVQhsW6
	dGdya3PT5dSSaiKqXa0pEt5sLyj25A8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741602517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b5vrudqUIRMhct6dpCgJ1DFv6JTwrGfy1tiyzgZ45KI=;
	b=Gql7v8ommwZH3PSUSVgWlsZ5B2iWAsuwk/veOng/xPD3E3O5m7W1RGApHLOw6e0I6KGFSz
	pJ6Vx+VuFIiJPUAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=A1CalgRY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nFv0nSUH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741602516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b5vrudqUIRMhct6dpCgJ1DFv6JTwrGfy1tiyzgZ45KI=;
	b=A1CalgRY1BvNpVGFojc5Cu1QOH+hUlfJgPp/vMHmSKF5zqtdJS4CqLTXKovCmWAZ5Dm8p1
	Lb35uZNdAv3eNoLAIaBMYFIoKzxoNzxU9MwW5IpU/3Fn6sXB16N/kxDfAvxSOekSSPwlJC
	XgGV01NfmkTBn77AAqiWXx0TrFSLnsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741602516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b5vrudqUIRMhct6dpCgJ1DFv6JTwrGfy1tiyzgZ45KI=;
	b=nFv0nSUHk1IPrhf4bdUETNgdCKxbe0AFHaO/xXMbAYPtddJJ/Ij0AjVzi0jlO3HN/QtkA9
	j3oD4WvIqwMEtxCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABDA0139E7;
	Mon, 10 Mar 2025 10:28:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vMHCKNS+zmdRaQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 10 Mar 2025 10:28:36 +0000
Date: Mon, 10 Mar 2025 11:28:36 +0100
Message-ID: <87plipyyaz.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ALSA: ctxfi: change dao_set_input functions from kzalloc to kcalloc
In-Reply-To: <20250308-ctdaio-kzalloc-v1-1-804a09875b0e@ethancedwards.com>
References: <20250308-ctdaio-kzalloc-v1-1-804a09875b0e@ethancedwards.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: DA5BE21162
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
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 08 Mar 2025 19:52:59 +0100,
Ethan Carter Edwards wrote:
> 
> We are trying to get rid of all multiplications from allocation
> functions to prevent potential integer overflows. Here the
> multiplication is probably safe, but using kcalloc() is more
> appropriate and improves readability. This patch has no effect
> on runtime behavior.
> 
> Link: https://github.com/KSPP/linux/issues/162 [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>

Thanks, applied now.


Takashi
