Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3551474BC;
	Mon, 16 Dec 2024 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734362238; cv=none; b=tl1MooauJEVIzQhTQMK8OMZEAG1FwEm/nHH7aEfKOfrkYWMpKnzdK4ZxagXXb5rJj9/8Z04/DDHivuCZ/SXArXUrPUE9n5NQFm7grgf4w5uctgXxzwSkgalZmhLGeAPG3iOZJuRl8/eb7cpARA1El5k9KCZ4CtXr6JPPJ45hjis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734362238; c=relaxed/simple;
	bh=2J6q7DT6SA1J7apxj/V7KyOjH8Q6PnQ2ZcAN6brgkkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VC3+UAKKnrGihAJRtPSBdofcNnEyHnDPFxA3Tj4p/N8FAzr4EK5rdNlgItX6L7ztmFzU6Nevt+yWl8sxyOSqaal0RIve5ZLIWyM0tH0D0VZMXDXa+W7BMZoJHHfzUlgWXmkHW3wI2rhIpM1Yqm/g1cGyGiaRkbikIJwLDi304M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2F8JPt7f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2F8JPt7f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AB3C4CEDE;
	Mon, 16 Dec 2024 15:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734362237;
	bh=2J6q7DT6SA1J7apxj/V7KyOjH8Q6PnQ2ZcAN6brgkkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2F8JPt7fEKeUW1+09qCIpdU6+KQ86X+l0KWxnGRlvnQSA5wzNAx1zDpG4DzFGQjWW
	 sNBygwV17d12641QG2xXtW6kjBSd3B4hMvkhvkmpggHH2XmOtBEQzEYhII835oOQv0
	 A9UL+bpd0C84DzAcOscCUNuF8IHagmhRW2KuP1w0=
Date: Mon, 16 Dec 2024 16:17:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Cc: Jann Horn <jannh@google.com>,
	Hanno =?iso-8859-1?Q?B=F6ck?= <hanno@hboeck.de>,
	Jiri Slaby <jirislaby@kernel.org>, linux-hardening@vger.kernel.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: Permit some TIOCL_SETSEL modes without CAP_SYS_ADMIN
Message-ID: <2024121653-unblessed-mummified-c630@gregkh>
References: <2024121418-blazer-valiant-c51a@gregkh>
 <20241216150722.4079213-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241216150722.4079213-2-gnoack@google.com>

On Mon, Dec 16, 2024 at 03:07:23PM +0000, Günther Noack wrote:
> With this, processes without CAP_SYS_ADMIN are able to use TIOCLINUX with
> subcode TIOCL_SETSEL, in the selection modes TIOCL_SETPOINTER,
> TIOCL_SELCLEAR and TIOCL_SELMOUSEREPORT.
> 
> TIOCL_SETSEL was previously changed to require CAP_SYS_ADMIN, as this IOCTL
> let callers change the selection buffer and could be used to simulate
> keypresses.  These three TIOCL_SETSEL selection modes, however, are safe to
> use, as they do not modify the selection buffer.
> 
> This fixes a mouse support regression that affected Emacs (invisible mouse
> cursor).
> 
> Link: https://lore.kernel.org/r/ee3ec63269b43b34e1c90dd8c9743bf8@finder.org
> Fixes: 8d1b43f6a6df ("tty: Restrict access to TIOCLINUX' copy-and-paste subcommands")
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  drivers/tty/vt/selection.c | 14 ++++++++++++++
>  drivers/tty/vt/vt.c        |  3 +--
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
> index 564341f1a74f..0bd6544e30a6 100644
> --- a/drivers/tty/vt/selection.c
> +++ b/drivers/tty/vt/selection.c
> @@ -192,6 +192,20 @@ int set_selection_user(const struct tiocl_selection __user *sel,
>  	if (copy_from_user(&v, sel, sizeof(*sel)))
>  		return -EFAULT;
>  
> +	/*
> +	 * TIOCL_SELCLEAR, TIOCL_SELPOINTER and TIOCL_SELMOUSEREPORT are OK to
> +	 * use without CAP_SYS_ADMIN as they do not modify the selection.
> +	 */
> +	switch (v.sel_mode) {
> +	case TIOCL_SELCLEAR:
> +	case TIOCL_SELPOINTER:
> +	case TIOCL_SELMOUSEREPORT:
> +		break;
> +	default:
> +		if (!capable(CAP_SYS_ADMIN))
> +			return -EPERM;
> +	}

Shouldn't you check this _before_ doing the copy_from_user() to emulate
the previous logic properly?

> +
>  	return set_selection_kernel(&v, tty);
>  }
>  
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 96842ce817af..ed65b3b80fbd 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3345,8 +3345,7 @@ int tioclinux(struct tty_struct *tty, unsigned long arg)
>  
>  	switch (type) {
>  	case TIOCL_SETSEL:
> -		if (!capable(CAP_SYS_ADMIN))
> -			return -EPERM;
> +		/* CAP_SYS_ADMIN check happens in set_selection_user(). */

No need to mention this here, it's obvious in the function itself.

thanks,

greg k-h
