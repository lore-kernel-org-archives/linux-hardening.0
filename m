Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E583488233
	for <linux-hardening@vger.kernel.org>; Wed, 16 Sep 2026 23:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602975; cv=pass; b=K7lVRr+3UibcvhKfLjpft3zU2Y2woaLMAN7uJSs8uow6X0+uNxH9BF7FHRHEW18i9sTSzU1ts9cvspwcBLgRccFPPe1GxZtqbvSZhdiyJK0fW2EWRivWAqD382Fg2aP7Qo32F5JkeTQgah1At/MWuwGdoE+gL9/G7IPH6OBKyHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602975; c=relaxed/simple;
	bh=5tKaWdmu51kDXBBHcn30mMEVoJTfZmICHt+dSfRbXmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pInjhf+9+dPmyqbm9FC95q7TIwkwc0jQfjno/PIQ5pYGZPzpMnq/xDn7UCS2MDHnkCVCEE+U/ypVWkADNPoS1+arqWjg4PAdOejGUixdPJyP1JKamzJdKQUdjZSpYSQcW1tQtVTPOsyKMQdiUDxNbVviliYilFp/IVHa8+0YKUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mqcRcSQN; arc=pass smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mqcRcSQN"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-982e8fa9171so137918241.3
        for <linux-hardening@vger.kernel.org>; Wed, 16 Sep 2026 16:56:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789602973; cv=none;
        d=google.com; s=arc-20260327;
        b=ksjyIEGhs05UYTLT35IXsRe0qqr1ffY6ulIb+/pgXuhWDIM+oRfQaeBa812LaWsfpl
         /VxsTAHw/cO5EB6GuEsGS6o2v9YBgoRIN1TKCcP9JkxZpJAKJiPJ84JuR5kUm2bW3OYo
         8aEQCEfQ9KEp/RFYaJi1232P8v6nf9YQzx8kW3zxLM9PR5n2MPBTmVtqTJlRiJb0UeoT
         4xwhBtoDXiJA8KGmnPEDWcARP5XrC11q+GzMlDqgFvZW98mbBTyL0mttitGkXLORG2qU
         yJs0ZL4/ggbj3Kf/2hDHguCjElfQRv0AX8Ta3YTkkAsaUVoh96ruQrQjd9dbT/oonOha
         k8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LRwA+HQjBliPkd+fmYUUZiunYG12ceL1uUJHyUv3qZk=;
        fh=7bJYlBHmo5tR83S8H7NIIzOWZN5wY1HCuuFwlnW6vZw=;
        b=NpPUjlzc5sobdcN5kz+Fgn+j7P/owRFRf7IDbXWwqW+xprkGSvyHvKsmMgPcumX3kE
         r/VsLAtbNql52Xe4lKwfsCI4PFNxQp9yMF5qt8tkpFb6i6gH8L71kkptiYOGK9qKIgy/
         gBZ7jdbim8jnCVVjNpvNvzmhkgy5lvjpcE1pUwO2KjZLDHaW9+xeDH9MB3yCZd5qZa5i
         Wjd7/d2vgZ9XrYdP2GSwPZgw8J3rBs2lcPKqxyAA3aKspiuDzmmPTvEutmYXS+0fXXtr
         I6yx2t0DNAxY5j91hNLCXmfcSaCD8omDohFbh/vd9imOP0vtCWPJiA8UfhQFcgTOxgIj
         1ldg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789602973; x=1790207773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LRwA+HQjBliPkd+fmYUUZiunYG12ceL1uUJHyUv3qZk=;
        b=mqcRcSQN9xkuxJOcjn1PYlCnePK5Zv6c9NB8AQYLh2+NWPg2RUZPWnU4LepZPyH9NL
         XaWUr55EgE9Z03CylPh77r14jmZitCgp92ajvAaxr3x4xh1ThDPas/lpT5ZHCQfaVzE4
         d3H1FOWDPxSg4GRtSjbKfzjWYYEFz0OazelYmrXBhuRHsb571TXF3ZtTq4+eoPeMTmWb
         whUJ+WQXr0eMIQ6e4gyRuspLODaKuhGrElEbnkgjPsKfQqfl1KN8aX1hwZp/0Lpa9dLf
         uZgTnlZZ1Ufwb/TH96MDY5hR0kcN+m0XwWwYqZqnjMtJ3ailRNanJPXrUUJz71/DRfT1
         j8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602973; x=1790207773;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LRwA+HQjBliPkd+fmYUUZiunYG12ceL1uUJHyUv3qZk=;
        b=x357RZVkFUPORsrdAbaqqVsP+DGMCTJUfYfxvSsZfzzy8zFbtb3UbPJW7dqwtBgKg7
         JFaNR1YhlRr5ga+MbXRdA2jI2JnJW7MQHIiQt7Q5AkUO3tz2HcGb/YNr6mHnngL6cuNL
         oPKQwf3DB2wAaUJKRt3ILm3IckCIXb1L+zvQscT3YJeYnt/vyDlHUrAwFdjr0WEtd7zG
         WI/lUqzvb3r35gKz4aHlax9mVHacqnyoJTTyUAEOfH2YbipL3TGRF//tgitG9HvGJymg
         l7e6VExbCPLZ2HOFU4nHfWrscoEQvLl/ojeBUTQwxwsx5mHitv8YCMSdgyfMi6Bd3FdM
         EhhA==
X-Forwarded-Encrypted: i=1; AKwUvBw6WvIxr95ZA3MyhQKY6grWTMiQaSi0i3Y4PzYqYxKuq3wCglR68K1iiVcgf2d259cQ9I1QSaik/X3RiFYdtAo=@vger.kernel.org
X-Gm-Message-State: AFuF++lTkqm/sukcv+xQl5+Th9KGicnCpcj47Acojlu8jKPtX9dhqn5A
	boubYl6a0/RTxPTAXHKo6w22sgPriqXiGN5CvfoxmW8+FOCgPzaUBiXozMv/emSwmPsM5vMdeto
	jCW9tMhO97X35+7qT19SGtNthmVzX18GtyV1LyGw=
X-Gm-Gg: AYBFou168kPg+7XfuhMFt+2wBtoDtPX9dWh8JF2lECQcvmScUvrAWXTm25topFokqpc
	fNPKMb1muqNKIeT+N+b/lAv0AwJyMb5QH2RfDVVN+mbepyW8lZYEfX9FypF7AcQcawvDgnekHHh
	006DcgHdC/CI8w2lIqnRo2oW+SXWTvC2gorCAzHw2wrwfR/uYwUPPZWG2k9yDCPb7pLbrgiaQxS
	hGXzRE/RCh6wWO3a+UDS/rLgimi3cbBNQuKJv1thft6iytkDYMJeJ8/gmvfs8PJFiLykRuI3lT9
	jX5StIU4qY2Hj8TO1B9WhPSW192rnjevlDn5ISyTIpLHtf22twG2IOPshFOuxOBxrSnY9RDAqmt
	jAUnpK+NN24Jq3NcHtTcX
X-Received: by 2002:a05:6102:1624:b0:7a1:f7e2:aae3 with SMTP id
 ada2fe7eead31-7a1f7e2f578mr1223176137.21.1789602972255; Wed, 16 Sep 2026
 16:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916221528.1256283-1-morbo@google.com> <20260916222125.1259631-1-morbo@google.com>
 <20260916164711.1cf51b0c3f085639dac5d690@linux-foundation.org>
In-Reply-To: <20260916164711.1cf51b0c3f085639dac5d690@linux-foundation.org>
From: Bill Wendling <morbo@google.com>
Date: Wed, 16 Sep 2026 16:55:55 -0700
X-Gm-Features: AcwNN1V6pZlAsSvT8PHa-4kEYXErDLD2dlhlA1kYs4I7L9QvkcLNRYmodw5KG84
Message-ID: <CAGG=3QWmJZP72d12B1T5o56YbmVFRbyWFg0j_mFOyZUnBtVGrQ@mail.gmail.com>
Subject: Re: [PATCH v2] seq_buf: add seq_buf_strlen(), seq_buf_init_append(), seq_buf_puts_trunc()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 4:47=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 16 Sep 2026 22:21:25 +0000 Bill Wendling <morbo@google.com> wrote=
:
>
> > Converting some strlcat() call sites seq_buf need behavior seq_buf does=
n't
> > currently provide, either directly or without introducing subtle bugs:
> >
> >  - seq_buf_strlen(): seq_buf_used() reports the full buffer size when t=
he
> >    buffer is completely filled, even though seq_buf_str() then overwrit=
es the
> >    final byte with a NUL terminator, leaving only size - 1 bytes of
> >    actual content. Callers that need the true length of the
> >    NUL-terminated string have to fall back to strlen(seq_buf_str(s)).
> >    seq_buf_strlen() mirrors seq_buf_str()'s NUL-termination logic but r=
eturns
> >    the resulting string's length directly.
> >
> >  - seq_buf_init_append(): seq_buf_init() always clears the buffer it's =
given
> >    via seq_buf_clear(). Code migrating from strlcat(buf, ...), which
> >    appends to whatever @buf already contains, can't use seq_buf_init()
> >    without silently discarding that existing content. seq_buf_init_appe=
nd()
> >    preserves it and positions the seq_buf to append after it.
> >
> >  - seq_buf_puts_trunc(): seq_buf_puts() (like seq_buf_printf() and frie=
nds)
> >    writes nothing at all if the string doesn't fully fit, whereas strlc=
at()
> >    always copies as much of the source as there is room for. Converting=
 a
> >    strlcat() call site that relied on that partial-copy behavior to
> >    plain seq_buf_puts() can silently drop content that used to survive
> >    truncated. seq_buf_puts_trunc() keeps the leading bytes of the strin=
g
> >    that fit.
> >
> > ...
> >
> >  include/linux/seq_buf.h | 60 +++++++++++++++++++++++++++++++++++++++++
> >  lib/seq_buf.c           | 35 ++++++++++++++++++++++++
> >  2 files changed, 95 insertions(+)
>
> This seems a lot of code for enabling some strlcat removals.  How many
> is "some"?  If "3" then perhaps do something different at those
> callsites?
>
In the series of patches I have in the wings (I sent one version, but
it was a bit scattered and need to be resent), there are roughly 7
patches which use them, some more than once. While the impetus for
these new functions are to help streamline the removal of the
remaining strlcat, I believe Kees suggested these in order to keep the
mathematics involved in keeping the seq_bufs correct was behind the
API, rather than relying upon each user to get the math "correct".
(Kees, please correct me if I'm wrong.)

> Sashiko had a couple of comments:
>         https://sashiko.dev/#/patchset/20260916222125.1259631-1-morbo@goo=
gle.com
>
I'll look into them.

> Should these new functions be added to lib/tests/seq_buf_kunit.c?

Yes. I'll send a followup with the Sashiko comments addressed and the
KUnit tests added.

Share and enjoy!
-bw
