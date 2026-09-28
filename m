Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D18C4CB8A1
	for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602760; cv=pass; b=Bo42v47id3/j+JdsyTVR/Jdym8yYEbyf7mWgZZloSNCHcHjyGMJHt3+suNfWVqJUjTVvyZUocnatOF3gZP3WCHbai6PMjavE/jrZ+xt9vQvzhWa0OSzA/H8QIBQESpGJ755fYoraBDnIN1r/xxciOEBudvzYpKvtZk8jfEW8RuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602760; c=relaxed/simple;
	bh=kkoVXtyBSbX/hlAjoM5EXYeotLKKyXHsImySYu3kOBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2s6MFBScElaoLC1YamCK0Anq86iUw4zPLWHDvl3pDGIFYuLv9Xl0zi1d41h9K95yXZO7l6SfHOU1VB9xxpXTiesJ4Xh0WM2aanHNxAQlchPlNdqPHwqHx5W2FGyn4Wqemclo1tBE7GVSxB4tx7ll1iH4u+DTx2MU/fWmmFMu48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4a7I3Nw; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4a7I3Nw"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a4fbc5586so463404466b.2
        for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 06:39:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790602757; cv=none;
        d=google.com; s=arc-20260327;
        b=G39dYkWI1UWAwG0euIJymaRLwOMNDGEMp/+OjYRGxJNyUX5BF736gT4fj9L/+OA53i
         hYvtSQDf3u+ykXv+UY8iiADlzUozeoe1/q3ljNTOP0s+UiDynPpLyLNTx28Wgp/3R4kt
         H1a8hYbtT2xyoe+lfI1zd9x2xro3EETgXskIliEI8tPQ/T0R5JyU+EhjK4HE0B3sKv8/
         18c4lUMbYxXWA4fRhxNWFIYdCfdDq8fZf23G452Ycc4iCabFUE60vKTBmv1xsdfOb8Oa
         yDGpvV6ffFnpybJJObw8rrFauh1RXTS5WCl9H8RkV9mWLFwcEHajtItO+QeFzznpZqD9
         zLEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kkoVXtyBSbX/hlAjoM5EXYeotLKKyXHsImySYu3kOBI=;
        fh=nzlI5PB+FXMOwmjR57BAzJlk6283yHzANdRgqNsWE0k=;
        b=TjnDP6+vSCMS0RLWPVTBAcml7Kp9+GRiGvKhPv5evEuZctIYFVMw4eZCDZiE9tD5MB
         T4S0tovJ7MwFScnjV15KfxWhQfQ4NwWLqxJy8Jo+idgtwTLS/sv8j+Eq/Sih+cMPkQ18
         tp0f70Wsf9eqCnIpA2zIMG0kcd/mDs4fF/SfI0RIsuzoH2jhwdQU6JwRVKZJnSvNNivl
         MPRXJ3nh6tr5m2EvEnK1PLdQMvzZwMP49duhfu3bpxitZhcxGisX/ifw1EijMWIB46Z5
         Sn5jZlqaMPhA6W+oyz1HMbc4N9DntdtRgEtWTnw/W8ZqrXxFeVX+/2JVD20r2UVGSlSm
         2jaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602757; x=1791207557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kkoVXtyBSbX/hlAjoM5EXYeotLKKyXHsImySYu3kOBI=;
        b=b4a7I3NwDQFNBCVAgiuFBdB8iqEB/ceqqZU7HZgl4Ui9HCN7vyf464/O2tDbS1tM+V
         wYTPLVfmT69ave9jcWzKXMqpJCcXiClzHvs2WHwDLkpBdu0xR6MqqHKARH9tVhZfZREK
         XwpzfqVX/CWpe3ukPYxpJtin15QCDBenvUcLtCiN//iWL5uea4Zh8FpA6czm8cRi8vDF
         LJSjlJYnjHxBDWz/FEW+qngUVNIifdervUPxzjb25wqwYyyOZVu0dghWXCFOKkjIS5BT
         5Q7ffuxv31zLnvI6ldNWcSBBEDCOEmlZpRvPrradtlBDsHtsrjyd+C3oc2K6S4/ZEqpc
         XabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602757; x=1791207557;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kkoVXtyBSbX/hlAjoM5EXYeotLKKyXHsImySYu3kOBI=;
        b=GzjIMwtC8yT4gfagJVK3+wGNFd9Fh0LURSuu38k9WwFKK9gGqhR/qY9Fr5n5KTqikD
         l3VQ+jBFxq1u1jHFXo+bwDYf4KtSL3j8JML8qqPk6CrSss+u6uHkNu4ztdjS2erGKss+
         NqECO5AGFpU3+HW78XKBk9oXvPo30v2LOIakClcbJMmX25HUGy27JRbx84c3ETui3jK+
         lKNZ3sFsdlwaioyLPT3BRmQ/mPnhBxGIh2vf1sTboVz4kSSuPRhKznUFQ5xW49rnNOKF
         ih093PMjx6DncPRgo3PDP82BEDMiZQzx/maowsnOESEXGACUxyqmJEP7kTUO+6nr3HxK
         4Shw==
X-Forwarded-Encrypted: i=1; AKwUvByqrDags1pe3P11MpFcqrgoGEbw3eq2R+b7lzJRF5pPWY3/jeJQGwLBdiJK2SzJjJ+RyK1yYsRY7Ny6LMkcWOw=@vger.kernel.org
X-Gm-Message-State: AFuF++k819qLxtJhHail4aGyMz4vtRNTB3vC2ggIDaQOCIKhGVE0lK3W
	GVJqnclEy7s7urIApnW4d4cUBhE3n/QqOFZq6t++ncAQx9Mo2k4VL5hyltiRIs2yN0k3Gn+yg+b
	Zqn48NMxsrt/CJnZI/ZRXVrrg4GmtX4Q=
X-Gm-Gg: AYBFou1A+401L42XBrdG0iVm6JdoxsfNI7f2F5r5ja0FsrKl2pIfQHe3JHBnl3hNr57
	jdx9MLwfwrjI/bSc3KKFyAwEUXG2qyvZTIJjNnC+gKEye5q/+h6tuRfh5kmbbpN2ezVibie7s9e
	qLQgMDraSc9WWWtMglqKyhZ6fIN8T5i+bWbXfbJedoK38OlKMEMqJMrbKa6T3rV0NnoCF03LZMV
	8tKjEJfnpPsl16LGHfYCEyYRsW17B5OQ8UrNUi2Lp6NEDk18YdDJFb5NJSnlemxWRAVHqvI6wbW
	p5pNthv15+JDzqFGpVVkDQRPuvnQRqxy2KimT4pN9H3avo2Oozfb6LuTb8PJAj2scEvVLXgplYC
	8QML8KwnoXwEpYJHXRb2X0dHrofMzwsBjcZnBYMcxoJAkGoaHdgsn7VV14qDX39SWLQTuIbaXgs
	pU/TVGaKWbEhP7U6iJ6O8ey2Ao2HQBl5ieJv/9GxoX
X-Received: by 2002:a17:907:7b8d:b0:c2d:c800:d797 with SMTP id
 a640c23a62f3a-c2dc800ea64mr422085366b.6.1790602756657; Mon, 28 Sep 2026
 06:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926205708.384308-1-meatuni001@gmail.com> <CAHp75Vdj8qVY-hCoCxxd1Pg2JaaDjc+QgAK-G=w+Cb=FTYYJEQ@mail.gmail.com>
 <a2687bd9-8cf7-1d08-41fc-9d6e69b5ca17@linux.intel.com>
In-Reply-To: <a2687bd9-8cf7-1d08-41fc-9d6e69b5ca17@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 28 Sep 2026 16:38:40 +0300
X-Gm-Features: AclHuK_yar-ZYML8PKehmtqFyK3Su6decS3wuti4NDLvEmj_PsHR7tuGCThvPLs
Message-ID: <CAHp75VffMOx6q1JKHFz6-_rByiC=1xTqn8Aw47i1KvWPBLCPkw@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib/string_helpers: add ESCAPE_BACKSLASH flag to string_escape_mem()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Muhammad Bilal <meatuni001@gmail.com>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 3:59=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> On Mon, 28 Sep 2026, Andy Shevchenko wrote:
> > On Sat, Sep 26, 2026 at 11:57=E2=80=AFPM Muhammad Bilal <meatuni001@gma=
il.com> wrote:

...

> > > Add ESCAPE_BACKSLASH, which escapes only '\\'. It can be combined wit=
h
> > > ESCAPE_SPACE, or used on its own, without pulling in ESCAPE_SPECIAL's
> > > quote and control-character handling.
> >
> > But why? I believe it can be done in the current implementation using
> > the last argument @only (id est use the list of the characters you
> > want to escape).
>
> Ah, that's my fault for suggesting this and not noticing there was way to
> negatively filter them.

No problem, not a big issue :-)

I think here is the list of those 4 characters that we want to escape
should be passed along with ESCAPE_SPACE | ESCAPE_SPECIAL. This will
get exact code behaviour as of today. In current patch 2/2 AFAICS the
additional SPACE-class characters might have also been escaped which
was not in the original implementation (not sure if it's desired
change or not).

--=20
With Best Regards,
Andy Shevchenko
