Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C270267B64
	for <linux-hardening@vger.kernel.org>; Tue, 25 Feb 2025 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740486518; cv=none; b=g3udl+DRXsJjW1h1UZBs5IpnI9WbubLchBiuRihbThgemsP/cd/MMXF2oeXk0oPfWYY4LXdqcLmRsYiT3ui/wvtZwHDmNQk7bkaWcO1LBDjv7ksY8Ncrzh/N4og7DSkbBusqxZiCBQEd88B0APwyeAYV1zYKvzj9IFcKeGG3FA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740486518; c=relaxed/simple;
	bh=MuDBLjAZ9U2+vCu5yoNNXavZNRZysUPXPdcP52zUuHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRRfTSCe0zvaCkIdt+143KR9N9NvbI1gyakL4wNyK2vb9hy2UUkbveIn8MsNpadUF0tAcLjrqoS7cAQ/Km8kIylFXuK3RVLMHT2nT84QVVyTdfx38rMfU2OsfPuBrcGR2oYgR8wZHVOEeCcaQBYfPy73bUxv/A7aOVORyR6kNdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sOATRaCr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CfKwfuD2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sOATRaCr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CfKwfuD2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sOATRaCr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CfKwfuD2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sOATRaCr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CfKwfuD2"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C1861F44F;
	Tue, 25 Feb 2025 12:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740486514;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K6Zh0aZsMEjnChLeM8bm+c0liv3N6f210rW3vv1RlWs=;
	b=sOATRaCrDHxgN7SBOeHPyT41M/40zOXg/q6cE6UuXqUy8UnJamNzzhSOOyoR+Ush4CT3Pu
	272LFT1nhXu0p/1KcwgUEU8UmkAvqM0x1YgFngGopmoL51SsK5CWx0yYsP+NLqK8TD512r
	ObaeXogJfeSjBu3XyI35ji80hOHR/1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740486514;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K6Zh0aZsMEjnChLeM8bm+c0liv3N6f210rW3vv1RlWs=;
	b=CfKwfuD2hLBniAvbKdO8TSBxkxsT88qDe55V3hMNeH1XrNJ8N2mYp8w5W58jQQqxQmdUfL
	mWxPrlF7fZI+kZAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740486514;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K6Zh0aZsMEjnChLeM8bm+c0liv3N6f210rW3vv1RlWs=;
	b=sOATRaCrDHxgN7SBOeHPyT41M/40zOXg/q6cE6UuXqUy8UnJamNzzhSOOyoR+Ush4CT3Pu
	272LFT1nhXu0p/1KcwgUEU8UmkAvqM0x1YgFngGopmoL51SsK5CWx0yYsP+NLqK8TD512r
	ObaeXogJfeSjBu3XyI35ji80hOHR/1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740486514;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K6Zh0aZsMEjnChLeM8bm+c0liv3N6f210rW3vv1RlWs=;
	b=CfKwfuD2hLBniAvbKdO8TSBxkxsT88qDe55V3hMNeH1XrNJ8N2mYp8w5W58jQQqxQmdUfL
	mWxPrlF7fZI+kZAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F23F13888;
	Tue, 25 Feb 2025 12:28:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tDjmGnK3vWfyTwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 25 Feb 2025 12:28:34 +0000
Date: Tue, 25 Feb 2025 13:28:28 +0100
From: David Sterba <dsterba@suse.cz>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-hardening@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Replace deprecated strncpy() with strscpy_pad()
Message-ID: <20250225122828.GM5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250225092949.287300-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225092949.287300-2-thorsten.blum@linux.dev>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Feb 25, 2025 at 10:29:49AM +0100, Thorsten Blum wrote:
> strncpy() is deprecated for NUL-terminated destination buffers. Use
> strscpy_pad() instead and don't zero-initialize the param array.
> 
> Compile-tested only.
> 
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  fs/btrfs/sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 53b846d99ece..b941fb37776d 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1330,13 +1330,13 @@ MODULE_PARM_DESC(read_policy,
>  
>  int btrfs_read_policy_to_enum(const char *str, s64 *value_ret)
>  {
> -	char param[32] = { 0 };
> +	char param[32];
>  	char __maybe_unused *value_str;
>  
>  	if (!str || strlen(str) == 0)
>  		return 0;
>  
> -	strncpy(param, str, sizeof(param) - 1);
> +	strscpy_pad(param, str);

I don't think we need the padding, so strscpy is probably ok. We copy
input string to a temporary modifiable buffer and then match it against
a table, so the NUL termination is ok.
