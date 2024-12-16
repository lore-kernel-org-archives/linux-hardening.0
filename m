Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0916F13C690;
	Mon, 16 Dec 2024 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734362085; cv=none; b=Gj3czSSXjiOJv7HVlu/QY1R0W9vDG8ZA1CHswKk/8kScVTzCWUmNB2u3mWEpyIJOyyomZA3vCTzHfXu4zeSooVIJbE+gHosTq3iWPsadlTN6j0P9fOZBebdy6us6IVlT9HFZWFCxhAbi3EjT04Xai33M12IDTYvUUy0JpSyPRyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734362085; c=relaxed/simple;
	bh=TRzJDG8qpNxuOKS+kC6W4LWtn//Sk7pcdff4uLjlKV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyjSIvUsbAhNApamHqYlh/qzm6h/iCXqlqrw/Mo1CpWGFG0nJ0ugjnsn16hdrI9WvH5NHX0ZvtvIteccCjUTahmmhioe7RRaZG9RNPuPffbQBBej1REHKc56LzA4Ld2APd8jXFtiP7VTj7CBDO3TGqVFMCUyhk49qSYxf3vimQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nQvX9kQV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nQvX9kQV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F0BC4CED0;
	Mon, 16 Dec 2024 15:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734362084;
	bh=TRzJDG8qpNxuOKS+kC6W4LWtn//Sk7pcdff4uLjlKV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQvX9kQVXQgdNkYBe1+OI2F9+nyxl3Hxai1zykb43Qmm2uTuAEkGPbgcLXU55KE+S
	 JJhDdcpjGmArH7jJWKLdQHH3a4hIYu4Rbe9Rkd5h8YbwHnm1cRqiEUJBAXGZOrK9Ry
	 v5XOLFq4GdCVYC1kEoOi/MsHksY0Cvuj3lClNLBA=
Date: Mon, 16 Dec 2024 16:14:39 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Cc: Jann Horn <jannh@google.com>,
	Hanno =?iso-8859-1?Q?B=F6ck?= <hanno@hboeck.de>,
	Jiri Slaby <jirislaby@kernel.org>, linux-hardening@vger.kernel.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: Permit some TIOCL_SETSEL modes without CAP_SYS_ADMIN
Message-ID: <2024121628-naturist-unopposed-44a8@gregkh>
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

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch breaks the build.

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
