Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8F631A072
	for <linux-hardening@vger.kernel.org>; Tue, 25 Nov 2025 12:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764072016; cv=none; b=lek2F3iJEd0/5WEKTYjeJY+atw/ncTK+zdJ4X3bYZqmDXpqe81nJoM4nlgLQJlKYBqziSci6Epw7Z3PEQCTsg9psQq9D3+KMx9fxatYcMi2yF9uBhqkTztPexEsJ+2Cf8KAi6Eha89Z8w0BsIbIgowboOMJWAc5OEbzQjNvafYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764072016; c=relaxed/simple;
	bh=p8UZczuW5U880uUAq6qd32HJJG+VIGE4KYPBCPoH0dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLf25IQGPt3NQsN+JXx5HDpewn1GM/+suht80eXV/8J+JtjyAV9Lcw62xrmsy2zvYM5uTMpQW1T3mBxSQc6t4rV5PIPY1v40Iv5JMKHL5Y29H2NeMGCIW1ENhzKHxqPQDD0uauV5LsJz/iJKuOIvmrVYQRg2MrHhM1rJxa2XNEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ge7YN7Nz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yx8KrTiZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ge7YN7Nz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yx8KrTiZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ge7YN7Nz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yx8KrTiZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ge7YN7Nz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yx8KrTiZ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1393F5BD82;
	Tue, 25 Nov 2025 12:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764072007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jEMwke+m3x/9v19D70cmMXhyg5jBS/Jv3gOzKCqqz0w=;
	b=Ge7YN7NzcMavo12i6tY0gdpIBjNlitTqhKygZxXcfhY96+KZE7tZ7DeK0bNdpF5HGExoWu
	H3xJJj4pjoaGPZ87uKqujX8VqRKTSevCmFYtWl0YpogscUZa4GVDadfdZEzaYcxL4uCXLc
	RuGipK2ccoothiYmf1iKKxWs3os12Bs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764072007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jEMwke+m3x/9v19D70cmMXhyg5jBS/Jv3gOzKCqqz0w=;
	b=yx8KrTiZVAJWlodYJv++TkwrJQZj5zdGF77WtYnZkl+d/PSi+TTj3nIjK1WnIM2WDbqzN4
	jAGOq8o4gd4CFjDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ge7YN7Nz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yx8KrTiZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764072007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jEMwke+m3x/9v19D70cmMXhyg5jBS/Jv3gOzKCqqz0w=;
	b=Ge7YN7NzcMavo12i6tY0gdpIBjNlitTqhKygZxXcfhY96+KZE7tZ7DeK0bNdpF5HGExoWu
	H3xJJj4pjoaGPZ87uKqujX8VqRKTSevCmFYtWl0YpogscUZa4GVDadfdZEzaYcxL4uCXLc
	RuGipK2ccoothiYmf1iKKxWs3os12Bs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764072007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jEMwke+m3x/9v19D70cmMXhyg5jBS/Jv3gOzKCqqz0w=;
	b=yx8KrTiZVAJWlodYJv++TkwrJQZj5zdGF77WtYnZkl+d/PSi+TTj3nIjK1WnIM2WDbqzN4
	jAGOq8o4gd4CFjDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 079AD3EA63;
	Tue, 25 Nov 2025 12:00:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0hHWAUeaJWm9UgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Nov 2025 12:00:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8E972A0C7D; Tue, 25 Nov 2025 13:00:06 +0100 (CET)
Date: Tue, 25 Nov 2025 13:00:06 +0100
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH RESEND] fs/xattr: Annotate struct simple_xattr with
 __counted_by
Message-ID: <uxsmzymguamc7bvhtgn2w7z43kxrpq5nuf74m2n6avvsk3efes@g47qjljxanqs>
References: <20251122120028.448504-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122120028.448504-1-thorsten.blum@linux.dev>
X-Rspamd-Queue-Id: 1393F5BD82
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Sat 22-11-25 13:00:22, Thorsten Blum wrote:
> Add the __counted_by() compiler attribute to the flexible array member
> 'value' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/xattr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/xattr.h b/include/linux/xattr.h
> index 64e9afe7d647..296b5ee5c979 100644
> --- a/include/linux/xattr.h
> +++ b/include/linux/xattr.h
> @@ -114,7 +114,7 @@ struct simple_xattr {
>  	struct rb_node rb_node;
>  	char *name;
>  	size_t size;
> -	char value[];
> +	char value[] __counted_by(size);
>  };
>  
>  void simple_xattrs_init(struct simple_xattrs *xattrs);
> -- 
> 2.51.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
