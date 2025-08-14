Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85DB31985A;
	Thu, 14 Aug 2025 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755196155; cv=none; b=iG0FLAR1gEiziIe9BmkVCc42qMNwpUMRF+2RoiDaRIrlDBj+ZcR8YHA6nKGjGrN7cv7/7T0W6hiH+m3QllxvP+1aljFrm9gsywc4QpYUAxgtqzDoeAnzFxcstCbkMRe23EWvjJ7EMCOTCIRHVWGELYQKoxUs9BzGvOcFSTXcxDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755196155; c=relaxed/simple;
	bh=H/7cxgG58tWqR4Nrwl+Uq7YGXzUlJdaBMhPlhJ1BJD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBuyFWXVNcIoEZAWnmDQCJxUWKgpLkB3+6+Wlgu9sp0KE+vmfX8UG+UUbPXmNbu5YxhPXyPDZ4Zsobp/pMUeQWJYlq/Sf0cxk9vMXSMOtjinmjsTsI7HyaMS8PHS9kUwn7+zhLeysUmugSHXp20t6bVcBm4aYtnr8i/tfVK3p98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yoHaKrbc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yoHaKrbc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C90C4CEED;
	Thu, 14 Aug 2025 18:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755196154;
	bh=H/7cxgG58tWqR4Nrwl+Uq7YGXzUlJdaBMhPlhJ1BJD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yoHaKrbc7hk54aha/UoZ8wC+34GeR+MY6b7PkJY+7npyEhDHs7vrOhq0Fb33dKBJX
	 t4nDu3O/uSlOw+nDwE98UYI0FjCItPaUENBggTQXgd0uPLOYVQD4DUA1hFMrgk46SP
	 HiDLZCYCz6VRu48OZI3g7L7jy45dWhtjnAFHbx+4=
Date: Thu, 14 Aug 2025 20:29:11 +0200
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
Subject: Re: [PATCH v2] kdb: Replace deprecated strcpy() with strscpy() and
 memcpy()
Message-ID: <2025081451-amigo-joylessly-8b8d@gregkh>
References: <20250814163237.229544-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814163237.229544-2-thorsten.blum@linux.dev>

On Thu, Aug 14, 2025 at 06:32:34PM +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() and memcpy() instead and remove
> several manual NUL-terminations.
> 
> In parse_grep(), we can safely use memcpy() because we already know the
> length of the source string 'cp' and that it is guaranteed to be
> NUL-terminated within the first KDB_GREP_STRLEN bytes.
> 
> Since the destination buffers 'cmd_cur' and 'cmd_hist[cmd_head]' have
> the fixed length CMD_BUFLEN, strscpy() automatically determines their
> size using sizeof() when the size argument is omitted. This makes the
> explicit size arguments for the existing strscpy() calls unnecessary,
> remove them.
> 
> No functional changes intended.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Use memcpy() instead of strscpy() in parse_grep() as suggested by Greg
> - Compile-tested only so far
> - Link to v1: https://lore.kernel.org/lkml/20250814120338.219585-2-thorsten.blum@linux.dev/
> ---
>  kernel/debug/kdb/kdb_main.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 7a4d2d4689a5..048dbbcd91a4 100644
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
> +	memcpy(kdb_grep_string, cp, len + 1);
>  	kdb_grepping_flag++;
>  	return;
>  }
> @@ -1076,12 +1072,12 @@ static int handle_ctrl_cmd(char *cmd)
>  		if (cmdptr != cmd_tail)
>  			cmdptr = (cmdptr + KDB_CMD_HISTORY_COUNT - 1) %
>  				 KDB_CMD_HISTORY_COUNT;
> -		strscpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
> +		strscpy(cmd_cur, cmd_hist[cmdptr]);

Again, you are doing two different things in this patch, it should be 2
different patches.

thanks,

greg k-h
