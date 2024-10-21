Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E511E2824
	for <linux-hardening@vger.kernel.org>; Mon, 21 Oct 2024 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503407; cv=none; b=V1vd7ura2fItuxJL8FqNIc/425juFxluy/dB4Fo8gg5o2zeOu+93EqH30QEQ+zadx7uFyrGre06dOCutHC47ebMETSQX9M+8i5RBQHSye0Gxwx75OLyYamxm1i9Zm6Ye2hS84m5RIGOEvOYlz7eCGa9QTv6jL6v0LYbrJCe1LcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503407; c=relaxed/simple;
	bh=DjbT5uld7w6vhzj/KDwtvfauUcaiWhU36u1wDHVvUkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BlqcV+8jbSPWsqP+fkBCUCR0htiWtDcekWPHX0emPs5Uw3Pc9OobBXFtoMJgFfK+VLgv5aeRkyH14zmwlAYGGIEYgPURZwNMXH/wgDGo7smn92aXM168+obWBsdtrGGSOzsGimGme5FF06Gz/4PnrKuh+3nmdKumxQ2BYyd1Wgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=afBpTN5T; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="afBpTN5T"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53a0c160b94so2235355e87.2
        for <linux-hardening@vger.kernel.org>; Mon, 21 Oct 2024 02:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729503404; x=1730108204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaA6MjCnzEXGANWWWWPr9A1xNlE9CLYxfxefrNOCSVU=;
        b=afBpTN5TJTvv/cIqqzzIjEdWhWNNYtioyjE5uzRB2+I7olp+06ZbRsUoR6maFaioMg
         B3o8DQ7Ibsqf8zuhrj6XHZMCSTZO/yMEKQAb9mRmGvyv4Uuy7diIaMNi9eGyu2BPWy7U
         02O2HkO2Vd24Ks/WKgrT/BiwbZ7/6uAgtlVGb2Lc/VmNESdHt4gWPANfCcRimn4skBvA
         npOYBPGivpfDwK5zv40NeyHtWkyMlDMUfYWvGFsjF3HnmQzk+0Rij5R3chMl8ODumT8f
         M/s/cCwpK/bDsy11Y98rR6IFpUO231L2UZr41q5Em2LTZcMv5bGJMqdNviKH1yfpcygk
         Lc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729503404; x=1730108204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaA6MjCnzEXGANWWWWPr9A1xNlE9CLYxfxefrNOCSVU=;
        b=sYDHacGftyGAdrM4mFCAd2GmNMgQPGhU9YUA4iJnfwFHI2u8wBTIqfQPyLetG1YhZW
         XBTpneTPufYnMiEzIJ9YeDbPR4N9oVNaluQUs4TjVmbS0TW+n2kI+tAYFAJSTwlOqn9d
         PLgAHVbHGQRR6qFSbC7WL+1m2hH66JFBFM9YkVUTG2wupbAW9bxEh2TyQqL43SddZ9A4
         ek3avSEckzGgGCxwzbpr11iwshpB5Pxwoz2+V/dyJDZdG3k1xxCed+KfDqiI/K583eB2
         REAxTiFt1hpegeOtZXiYvkdk0KwZXR2iqIVG76Iz/FzyIUH4qQRPKGJ21TH2OIIcCMa/
         heeA==
X-Forwarded-Encrypted: i=1; AJvYcCWqK83Fb/928Z2Ubrf5t1DP6w0RTbVXWiHmMERPyBNSqh0ADH0S+Kt1xD9+jzLvVJQDd8pcArkRb9BEr/7u0zA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6L2jl///6SWGDw5sqNoJtKAXkhNPGTVRO46wn/HGuXxTMWu9R
	p+iFmrO2Yuo9rTdhy4dFjCDFaYu83yXGPxkYnlQcs7dEVQ7bCQMfzLSjncaK3FDlre3wsJ8Rs7Z
	fAwo3ffByeyRzsTLylkDNHDsh2hxvqO4hAXwBng==
X-Google-Smtp-Source: AGHT+IGyxR3KLXD9voqeo0vrfplP7ht0srAq44lPfCneecMz/dqpegZprFIjW8SGAe3Y3LLv9qb/Gh5UmbrPs+b5/wU=
X-Received: by 2002:a05:6512:3a8d:b0:539:e510:d83f with SMTP id
 2adb3069b0e04-53a1520be23mr4815698e87.5.1729503403651; Mon, 21 Oct 2024
 02:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021091417.37796-1-brgl@bgdev.pl> <2024102113-shame-mooned-4f1b@gregkh>
In-Reply-To: <2024102113-shame-mooned-4f1b@gregkh>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 21 Oct 2024 11:36:32 +0200
Message-ID: <CAMRc=Mc0Qg9GkUsU-7QYPPQ-isZniABWYxtGLQ5KW1TAuZSA-A@mail.gmail.com>
Subject: Re: [PATCH] lib: string_helpers: fix potential snprintf() output truncation
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 11:34=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Mon, Oct 21, 2024 at 11:14:17AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The output of ".%03u" with the unsigned int in range [0, 4294966295] ma=
y
> > get truncated if the target buffer is not 12 bytes.
> >
> > Fixes: 3c9f3681d0b4 ("[SCSI] lib: add generic helper to print sizes rou=
nded to the correct SI range")
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  lib/string_helpers.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Hi,
>
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>
> You are receiving this message because of the following common error(s)
> as indicated below:
>
> - You have marked a patch with a "Fixes:" tag for a commit that is in an
>   older released kernel, yet you do not have a cc: stable line in the
>   signed-off-by area at all, which means that the patch will not be
>   applied to any older kernel releases.  To properly fix this, please
>   follow the documented rules in the
>   Documentation/process/stable-kernel-rules.rst file for how to resolve
>   this.
>
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>
> thanks,
>
> greg k-h's patch email bot

Did something change? I typically don't add Cc: stable@vger.kernel.org
to the fixes I send and this is the first time I'm getting this email.

I can resend of course.

Bart
