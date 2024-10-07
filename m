Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994FA1D86CE
	for <linux-hardening@vger.kernel.org>; Mon,  7 Oct 2024 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313416; cv=none; b=qNrYxehbcIX/Y5fF26+uhxthWNM3mJa7XQaCrMFyIJQpenujvD6bZXATVHxNlP0Y3RiLUOAzUvYf+q08glmoq/dpoq4F/m7M5IryAxlaicEQevPUba5ToDAKlekUPjN/lriFc+aF46/ItZYBokq/tiwowWKuliPNJmZJHdUUdBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313416; c=relaxed/simple;
	bh=UoZJgnOU+cpZzaO1kTH0rbuTDby7trtHXlUaN8PNeeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUViM9AfSPhuxg8+P3EgGmUKBjiGLJutxo+3lZ5hNFvaAq3RuP9hKxfKrED22HpOSAccwY3ZHKznZvvroUQLc5Q/6ATv/pbjfjkg0HuxzFTA4KnWLvuXewrNwI214SPA2lbO6t+lf6Jq6tM0TunRcYUfEwmOGcgRvIqyj2pL2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Fe8RzgCv; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fe8RzgCv"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-710e6ea4782so244817a34.0
        for <linux-hardening@vger.kernel.org>; Mon, 07 Oct 2024 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728313413; x=1728918213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnMYpMSi30pRgprxZcWHtApA7E1/LbOK6iJZCnWy7fY=;
        b=Fe8RzgCvKb9YEG/FNP5YtFDQGyGm7iKeq/kXDFCi4ndhGE38v8B7u/Wckt0WUkOC5i
         7AJdoAtpZ7/ruO/vBTTkog4h9IuFHhV9shvvcKpKWCzPdmV2VO7xUb7ifpFaq2U25mtH
         A4Xs83THGfHP5HP5jMt/nbNqPC+ckadE0QOnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728313413; x=1728918213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnMYpMSi30pRgprxZcWHtApA7E1/LbOK6iJZCnWy7fY=;
        b=gUDyHW9XNdYsK8j9NbXWmNJjufuFTuHfxcstok3N0b1YxakOs1nptPrAZSCxUa6P77
         LBJZGxA2QF1HhHTBkiDrY0WY4QgiyBUuJpLlu/D1jAuocVbrkD4khz2Qte3klR3ta17a
         SdkaJAYIwNBwYtXDK0qEH6lcSf5C/oVca5hjVNWUZDOb1+YkbY88BBn2KgTXqIiSJyq9
         BGMWxw+tIgQtDegtyMuYJtxpXfFmFHJhmIrAfQvPoK4xblKKR7HJ11Xej7yEQUzGWl/M
         tWSn7dTDQGXNIGRVSvi/Uh6naEd7Y90iPovYlgI32IOKoyvuJXCnzMJnuKli5Svvxjl4
         SvZA==
X-Forwarded-Encrypted: i=1; AJvYcCWqjHJ8HfL3NpO6U51xXDrVbd5tQKr1E10/TVSrlLROakB+8FvqwP7CK+u939BSipSB2zbwr5H1k2QVdYN/9wA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz58B4vhH6E2PPcS7HlSz0oPnmJqghULBgyYXAMBEgpKH8f3eF8
	3fcxi1ur12Zlzcun0FgN3GnzWfKOpjuWb6T+EdhkmGh+FtpuvQDL/gMcmdDAPxQg5rK2Tn4e/U5
	iVt753GyF1RXNkwJ9yxKDPZKRRTlaCWFF/hnk
X-Google-Smtp-Source: AGHT+IHoAnc3BjGBILjnmbLFo2ofO9yLKDc28NITtzSSbSlwUCHw83CVP6hL/oqAJSRlAtNEV3l5YeF2ABjLV48sw9s=
X-Received: by 2002:a05:6870:8a2a:b0:260:e5e1:2411 with SMTP id
 586e51a60fabf-287c1e57f76mr2249422fac.6.1728313413483; Mon, 07 Oct 2024
 08:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001002628.2239032-1-jeffxu@chromium.org> <20241001002628.2239032-2-jeffxu@chromium.org>
 <4544a4b3-d5b6-4f6b-b3d5-6c309eb8fa9d@infradead.org> <CABi2SkUhcEY7KxuRX3edOHJZbo2kZOZfa0sWrcG2_T0rnvHCWQ@mail.gmail.com>
 <78f05735-cca3-491e-b2d6-c673427efa07@infradead.org> <15868.1728090271@cvs.openbsd.org>
In-Reply-To: <15868.1728090271@cvs.openbsd.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 7 Oct 2024 08:02:00 -0700
Message-ID: <CABi2SkWOz8fX1M6Jx0Xh1y-866Zsn6fweK9-ZB30PRkPPgdgEQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mseal: update mseal.rst
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org, keescook@chromium.org, 
	corbet@lwn.net, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, jannh@google.com, sroettger@google.com, 
	pedro.falcato@gmail.com, linux-hardening@vger.kernel.org, willy@infradead.org, 
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	usama.anjum@collabora.com, surenb@google.com, merimus@google.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, enh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Theo

On Fri, Oct 4, 2024 at 6:04=E2=80=AFPM Theo de Raadt <deraadt@openbsd.org> =
wrote:
>
> Randy Dunlap <rdunlap@infradead.org> wrote:
>
> > On 10/4/24 9:52 AM, Jeff Xu wrote:
> > >> above is not a sentence but I don't know how to fix it.
> > >>
> > > Would below work ?
> > >
> > > Certain destructive madvise behaviors, specifically MADV_DONTNEED,
> > > MADV_FREE, MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK,
> > > MADV_WIPEONFORK, can pose risks when applied to anonymous memory by
> > > threads without write permissions. These behaviors have the potential
> > > to modify region contents by discarding pages, effectively performing
> > > a memset(0) operation on the anonymous memory.
> >
> > Yes, that works.
> > Or at least it explains the problem, like Theo said.
>
> In OpenBSD, mimmutable() solves this problem (in later code iterations).
>
> In Linux, does mseal() solve the problem or not?  The statement doesn't
> answer this question.  It only explains the problem.
>
> If it doesn't solve the problem, that's pretty surprising (weaker than
> mimmutable).
>
> During development I wrote a fake little program which placed an 'int =3D
> 1' resided into a zone of readonly memory (.data), and then imagined "an
> attacker gets enough control to perform an madvise(), but only had
> enough control, and has to return to normal control flow immediately".
> The madvise() operations was able to trash the int, altering the
> program's later behaviour.  So I researched the matter more, and adapted
> mimmutable() to block ALL system-call variations similar to 'write to a
> not-permitted region'.
>
> So the question remains:  Does mseal() block such a (rare) pattern or not=
.

Apology  for delay.
Yes, mseal does block such patterns.

Thanks
-Jeff

> The sentence doesn't indicate that mseal() has a response to the stated
> problem.
>
