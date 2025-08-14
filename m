Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413341DE2A5;
	Thu, 14 Aug 2025 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755174960; cv=none; b=SxT0pkMOoE/YJAXoPA68LR9mGJyml+uPJDVtnOuITDryq0NOv0KLGrnlJ6Yb9plHeY9egAeiysYCfbvFqywriLboLGNPT2AvoVwurfWUY/POoSkcZYPuteE6Nxf8uKH82N6nLN4o1PzI1rtApTAkPKbT5cVzr64yrWktHV6HjfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755174960; c=relaxed/simple;
	bh=d0chepvMTCh7nRNY6/nneXMPwXlxAZHGQVMwQe1JW7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzzpJOrCL5x+WzeoVJpEGKKTTdiqUZiYDb/GZ+a1uXuTA+jVMm8ce2OwSZbRVGf3NWZH7AEfM7HQNkCHjvIpQcAlv07R8HmvA/O8EBwnX3dAplUaldYRifve7E3HFQZxc2v2PtLpiIPGUeZtYytD4fg3CZ3a/XvREFd6IKzvvvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oqG6vsmT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oqG6vsmT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DD7C4CEED;
	Thu, 14 Aug 2025 12:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755174959;
	bh=d0chepvMTCh7nRNY6/nneXMPwXlxAZHGQVMwQe1JW7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oqG6vsmT6xx5AVJ16aY0bqHueR5rs6uSzjLDF2Z0RynkKkuXd8pWKSp5ET/C63K1X
	 q88qpINM5+WUMfQ5OklViyEWoIyjedXdRJxgrz3OPdF8oQ01icqqAVOwBrGZgwlxQw
	 kep8Lbasji0XU9XbRcWV9A1DUATcw8iM9VFUXupQ=
Date: Thu, 14 Aug 2025 14:35:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Nir Lichtman <nir@lichtman.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-hardening@vger.kernel.org,
	Daniel Thompson <daniel@riscstar.com>,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: Replace deprecated strcpy() with strscpy()
Message-ID: <2025081408-swinging-endorphin-abe2@gregkh>
References: <20250814120338.219585-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814120338.219585-2-thorsten.blum@linux.dev>

On Thu, Aug 14, 2025 at 02:03:37PM +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead and remove several manual
> NUL-terminations.

Manual NULL terminations are good, why get rid of that?

> Since the destination buffers 'cmd_cur' and 'cmd_hist[cmd_head]' have
> the fixed length CMD_BUFLEN, strscpy() automatically determines their
> size using sizeof() when the size argument is omitted. This makes the
> explicit size arguments for the existing strscpy() calls unnecessary,
> remove them.

But now you are dynamically calculating this?

> No functional changes intended.

How did you test this?  Many of these types of changes are wrong, so you
really really need to prove it is correct.

> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/debug/kdb/kdb_main.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 7a4d2d4689a5..ea7dc2540e40 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -727,14 +727,10 @@ static int kdb_defcmd(int argc, const char **argv)
>  	mp->help = kdb_strdup(argv[3], GFP_KDB);
>  	if (!mp->help)
>  		goto fail_help;
> -	if (mp->usage[0] == '"') {
> -		strcpy(mp->usage, argv[2]+1);
> -		mp->usage[strlen(mp->usage)-1] = '\0';
> -	}
> -	if (mp->help[0] == '"') {
> -		strcpy(mp->help, argv[3]+1);
> -		mp->help[strlen(mp->help)-1] = '\0';
> -	}
> +	if (mp->usage[0] == '"')
> +		strscpy(mp->usage, argv[2] + 1, strlen(argv[2]) - 1);

Now you are manually testing the length of argv[2], are you sure that's
ok?

> +	if (mp->help[0] == '"')
> +		strscpy(mp->help, argv[3] + 1, strlen(argv[3]) - 1);
>  
>  	INIT_LIST_HEAD(&kdb_macro->statements);
>  	defcmd_in_progress = true;
> @@ -860,7 +856,7 @@ static void parse_grep(const char *str)
>  		kdb_printf("search string too long\n");
>  		return;
>  	}
> -	strcpy(kdb_grep_string, cp);
> +	strscpy(kdb_grep_string, cp);

If this was just a search/replace, it would have been done already, so
why is this ok?


>  	kdb_grepping_flag++;
>  	return;
>  }
> @@ -1076,12 +1072,12 @@ static int handle_ctrl_cmd(char *cmd)
>  		if (cmdptr != cmd_tail)
>  			cmdptr = (cmdptr + KDB_CMD_HISTORY_COUNT - 1) %
>  				 KDB_CMD_HISTORY_COUNT;
> -		strscpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
> +		strscpy(cmd_cur, cmd_hist[cmdptr]);

Same here.  And other places...

thanks,

greg k-h
