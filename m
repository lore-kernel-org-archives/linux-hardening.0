Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7231E1CD2C;
	Sat, 14 Dec 2024 07:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734162464; cv=none; b=t0LkP0c3QH5unutEIVmf9BIelI4rAlh0fPy6CQkOmgAuSiRkBoUf3YYg/xgHgm90MMfLkRPxBHpLPo0aDDXqfWQMi9BTzoGglpQxeK+T5/zHUELrhkSSpMb+RoZPl8nCRzG3OTpHnTTgP/lWWllnoV8hYFjGT4ImvQyTUOLeOV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734162464; c=relaxed/simple;
	bh=YIbX2MgGl3xGze3jMMeFEJiLRt0XWfpz5HfIdkZ+pIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szkzXHmS11v3DkMRY/7IRyFOB2uDt37U2UECOZh7Jq4F4X0cidu1SYk7Ux5i5tLaGLs6alLbYsvRtB0KS5oelzqX9pTk/NJZj67nHapdXEz6ytwVh52nF5Uh9miuh1vok68hPcmhYAy6hh063T8QCifE7SKEH/qVFnRNXOC/xT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2PG3gvYR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2PG3gvYR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3503EC4CED1;
	Sat, 14 Dec 2024 07:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734162463;
	bh=YIbX2MgGl3xGze3jMMeFEJiLRt0XWfpz5HfIdkZ+pIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2PG3gvYRb5L837h6bmde+6JNYeDyCcawdsc0kBqnKck0ckF+WyJrFxdybO9YRUoHI
	 ZQe4xD3BhacPnAopunOstxKiloQ4T8g6GfqrpxyPHpINwWLUMsihEBEODII2VeC9Mm
	 JmXYXvNqOBH+6bH7zpBCVCg0JBP8W/020A13QX5o=
Date: Sat, 14 Dec 2024 08:47:40 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jared Finder <jared@finder.org>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Jann Horn <jannh@google.com>,
	Hanno =?iso-8859-1?Q?B=F6ck?= <hanno@hboeck.de>,
	Jiri Slaby <jirislaby@kernel.org>, linux-hardening@vger.kernel.org,
	regressions@lists.linux.dev,
	kernel list <linux-kernel@vger.kernel.org>
Subject: Re: GPM & Emacs broken in Linux 6.7 -- ok to relax check?
Message-ID: <2024121418-blazer-valiant-c51a@gregkh>
References: <ee3ec63269b43b34e1c90dd8c9743bf8@finder.org>
 <CAG48ez0vg9W=oatvEqxvTSYNUx7htY23LxPrYCiuLZhZQuaGjg@mail.gmail.com>
 <Z08NV4Z-L0anDxGk@google.com>
 <Z08QvvfLSWGIDfBD@google.com>
 <ca2a101ccf5ae790dd2cac58ff832922@finder.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca2a101ccf5ae790dd2cac58ff832922@finder.org>

On Fri, Dec 13, 2024 at 09:13:54PM -0800, Jared Finder wrote:
> On 2024-12-03 06:07, Günther Noack wrote:
> > On Tue, Dec 03, 2024 at 02:53:27PM +0100, Günther Noack wrote:
> > > Hanno, you are the original author of this patch and you have done a
> > > more
> > > detailed analysis on the TIOCLINUX problems than me -- do you agree
> > > that this
> > > weakened check would still be sufficient to protect against the
> > > TIOCLINUX
> > > problems?  (Or in other words, if we permitted TIOCL_SELPOINTER,
> > > TIOCL_SELCLEAR
> > > and TIOCL_SELMOUSEREPORT for non-CAP_SYS_ADMIN processes, would you
> > > still see a
> > > way to misuse that functionality?)
> > 
> > P.S.: For reference, some more detailed reasoning why I think that that
> > proposal
> > would be OK:
> > 
> > It would protect at least against the "minittyjack.c" example that was
> > attached
> > to https://www.openwall.com/lists/oss-security/2023/03/14/3
> > 
> > The trick used there was:
> > 
> > * ioctl() with TIOCLINUX with TIOCL_SETSEL with TIOCL_SELLINE,
> >   to make a selection (a.k.a. changing the contents of vc_sel)
> > * ioctl() with TIOCLINUX and TIOCL_PASTESEL to paste the selection.
> >   (The implementation for that is in selection.c/paste_selection()
> >   and is just copying from vc_sel.)
> > 
> > So as long as we are protecting the change to vc_sel, that should be OK
> > in my
> > mind.
> 
> It's been silent for about a week and a half here. How long do we wait
> before creating a patch here? This is a regression so I'm assuming we
> shouldn't wait too long.
> 
> I'm happy to create the patch if that's helpful. I'd need help with process
> for submitting it for inclusion in the latest kernel as well as backports to
> earlier impacted versions. I've never submitted code to Linux before.

Sure, make a patch and we will be glad to help you out in getting it
accepted if it looks good.

thanks,

greg k-h
