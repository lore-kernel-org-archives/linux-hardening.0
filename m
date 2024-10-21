Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA8C1E3DE5;
	Mon, 21 Oct 2024 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504219; cv=none; b=sqs/tVV69BZ1CHS1wFGslzE7U43JoaAtImdGsU1tA5OzToclD0bGY2INx1Wo9lG8kXsDXNdgoJLMUFhEWrHOhib8kvF3/ueyLe7/ko+0DSozIo4swOfuwUBnb+MaS3DTjHfs3bljdFbqZN08imrhBWHFZHe/ECCgSJVOj7AIVv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504219; c=relaxed/simple;
	bh=ufZj5KJ8xe6+IodZV9ZmqRwQrB+3AGHdNlOA+5RhqFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hffU8CqyGSLczN1/H1r1h7FJb+kxjHFBB5OvV+s2HwbGauNuT1m/bHMAZtc9wTf39htCIuOuuAleYzdg4V0R3ZjLMp2OOkee6G2KJRX1gvrZ+gLYFGcwFGTV9LFgRzDrYpwgmx+gO9JFiqcQ91PdHnhub4VVRW2pGOMs+2STBH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FCIdtY3u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FCIdtY3u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422F8C4CEC3;
	Mon, 21 Oct 2024 09:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729504218;
	bh=ufZj5KJ8xe6+IodZV9ZmqRwQrB+3AGHdNlOA+5RhqFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FCIdtY3uwcc3JYZWK01pnISQaKH2uSVHEDhWh6puv/2TxktpfcKFzbWhJX659Q+lL
	 Gc1FNz5tOUbWn0GWBEOdp9UJP4AU5/Prd4cNbtvnxCJYtLoTX2EJyzLp53nknXLTP5
	 YNDIDkPc1KOGRB7dF9WD1+UDB35IbloqL4Z0ISmE=
Date: Mon, 21 Oct 2024 11:50:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] lib: string_helpers: fix potential snprintf() output
 truncation
Message-ID: <2024102125-sneezing-strive-d5c1@gregkh>
References: <20241021091417.37796-1-brgl@bgdev.pl>
 <2024102113-shame-mooned-4f1b@gregkh>
 <CAMRc=Mc0Qg9GkUsU-7QYPPQ-isZniABWYxtGLQ5KW1TAuZSA-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mc0Qg9GkUsU-7QYPPQ-isZniABWYxtGLQ5KW1TAuZSA-A@mail.gmail.com>

On Mon, Oct 21, 2024 at 11:36:32AM +0200, Bartosz Golaszewski wrote:
> On Mon, Oct 21, 2024 at 11:34 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Oct 21, 2024 at 11:14:17AM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > The output of ".%03u" with the unsigned int in range [0, 4294966295] may
> > > get truncated if the target buffer is not 12 bytes.
> > >
> > > Fixes: 3c9f3681d0b4 ("[SCSI] lib: add generic helper to print sizes rounded to the correct SI range")
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> > >  lib/string_helpers.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Hi,
> >
> > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > a patch that has triggered this response.  He used to manually respond
> > to these common problems, but in order to save his sanity (he kept
> > writing the same thing over and over, yet to different people), I was
> > created.  Hopefully you will not take offence and will fix the problem
> > in your patch and resubmit it so that it can be accepted into the Linux
> > kernel tree.
> >
> > You are receiving this message because of the following common error(s)
> > as indicated below:
> >
> > - You have marked a patch with a "Fixes:" tag for a commit that is in an
> >   older released kernel, yet you do not have a cc: stable line in the
> >   signed-off-by area at all, which means that the patch will not be
> >   applied to any older kernel releases.  To properly fix this, please
> >   follow the documented rules in the
> >   Documentation/process/stable-kernel-rules.rst file for how to resolve
> >   this.
> >
> > If you wish to discuss this problem further, or you have questions about
> > how to resolve this issue, please feel free to respond to this email and
> > Greg will reply once he has dug out from the pending patches received
> > from other developers.
> >
> > thanks,
> >
> > greg k-h's patch email bot
> 
> Did something change? I typically don't add Cc: stable@vger.kernel.org
> to the fixes I send and this is the first time I'm getting this email.

The bot doesn't catch everyone.

> I can resend of course.

If you want it added to the stable trees, you MUST put the proper tags
in it.  Otherwise you are at the mercy of us sweeping the tree when we
get bored to find patches where developers/maintainers didn't tag things
properly :)

thanks,

greg k-h
