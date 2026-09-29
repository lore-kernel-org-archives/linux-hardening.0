Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1908729AAEA
	for <linux-hardening@vger.kernel.org>; Tue, 29 Sep 2026 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790690780; cv=pass; b=b0GEA/bmiKblz6z7JBHjA9jQDtIQ8Nn90pscJnX635t04miseq3NOaHClS3pcy39854hTufKu+SRm8f6RLwAeEb+DPC2ZYAtnqSrPluzqpe9eEux1F/R/6OVwB96AoPu1YZ30EqDGbW5sR2UY1PL96/b61+8MRZEE7FJW2R/two=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790690780; c=relaxed/simple;
	bh=fhR9qb/Hb1WbvE1d2mf3NQKyepj3kvNi8JDNlOX8T8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAjbuJyuw1ybUxaw9zxQj/+6Yeor1gLMcPU6vnooEbadirDIRTIfnZGAr01/+5502MK7Y+r5THDeF0Ye4RV07tgDtIveJrpE2u3I9lOprYxOB9YgEpaJ3XPfzS/NuVEiarXgR1EKZT74mORpzktDAIJLKvKBvLAN7tf3SlCbCJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QydAqF5e; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QydAqF5e"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d8facae850so52745ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 29 Sep 2026 07:06:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790690778; cv=none;
        d=google.com; s=arc-20260327;
        b=RdEdhWXKs7uHML9nXd8sMXkIN8CjyNCr2HzWBsP4ha1CEk+QLGR1e99/FgI92jRyT5
         96VejEEl6QDWMCrdxLLvB/jkD9yLVKLulu0YLW3nC78YyrSEntOxw3WjDZI4cVACqmTn
         AS/TaS+XCtc23czbPxsmkAXcjGtGjsa6bgpsfiSxdoL9rLNodeRrpkpzJRL380wE9yw1
         ISEvaRsbAKaJ4Y3UgIMslHZSDWavyZ+avrENK/wHMXXYnFxkUfdsoTwI6r0DWPH6XCgU
         Fz5OAhCo66F7sGDgXID6D4WFVPUlDLP7t4KKvnjJogRuoCeP11MMSDIhK7hz9yeFnvHW
         78Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bjuSCtHrD4hJ6bIOwYxSF2S+dabm2wOYtiRT9In2WKk=;
        fh=dEpMeYUToOXaHqRnn5gZGw0amrRNjgt0K0EYQm1tAGg=;
        b=MarQWSFcNTioUmI8T+tyyS2C1WgmgSuSxvDO8lnmlhwmHJpZ90XJ/HuzU/qAJWuBwC
         cRXIS70yhEmQQUPJ++Tjbd8WLsbVb+9PDtHJgy1x60ywF6SOpI3ncNuBjl0NP0xF0MVd
         BEY7n52GOzZ0RgROTkdBX3EuGzDH228juq4xJo/+8WxPaqRdjfGSjCzilFuwk/qR1jDj
         CNmEKa8pCMdE4Xh6Co+3jXJ+MjSd3D4WvGy+M88h/LLrnMpVw++4o6wJXe7Vyo4qq0eo
         ICtfsdEukx6oiUcgwH9xZ8PzbDtvaXldeIu+o/YkDeBDSxmovncM0MXNwnZAS4O8oa9a
         aaxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790690778; x=1791295578; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bjuSCtHrD4hJ6bIOwYxSF2S+dabm2wOYtiRT9In2WKk=;
        b=QydAqF5eUj6KA5YwOyHVodV8I5FDURpQumR5kyUv/5Z1akvffwH+HqmOzvswRRIhsA
         QiP7zfJQ2e8QR1Pnfm5ZMMcvev1tjcS39GQY7KtSXbYhte06bK9RvGyklikWHsHxVtBS
         hZk5vEnSs1Wj+/qSH0KrhU+qnGNTn92h89UtGpqUy/sz/UgI+SsJLVUxg3a7Du8XLHAg
         AEr4rpHwHan3GDY//PMefThDbX31uymrhWjgg2vKx2ifB6b48EUVC8WnBe34rJE3PURF
         I1bwZcnr2Na50w8c9Wllbp/++A4wXNL0AaB+w7wTBXpsZj3NDyCAUXgtq9ng1aEnoq2d
         e7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790690778; x=1791295578;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bjuSCtHrD4hJ6bIOwYxSF2S+dabm2wOYtiRT9In2WKk=;
        b=EsdVHfZCkkS6Zz9fHKvgNR45d9YsFM6RdgJztXcVHbxDUEoyPvGVkT0O56vU92cyhL
         ITZiKx//oEof0ETheC7F65AAZ+enKFgUyPuiPg3cWQx5CvCN5xN3j0rUT76pO7eI9RGC
         BqPGRkeEPYuT7jVPZ/6CadDenm4+J/r0o/g/M88JHhZ3/OQbDg+8I3rZkPcsWYCdVpwL
         iwY/IDZuxq96avkNs3TL9Pg2L3lNy6vXQU1gWi3B2vYSSxLxsY7eLPoxQnBgXzruIlcO
         4Q8PTE6WGbnoJLOojt6Jrs6EwdYIrgX0L2r9wPNUDBwj2HGOMPgp7Sssy1nPc5GxC50B
         VpYg==
X-Forwarded-Encrypted: i=1; AKwUvBzXmf/O7fHGXeNOqscacWSu4mIM1pCKZ+Od8B8fZezpyN3ukVoMOwOPc+CRLvNR+LBpSJppgE0QqzfkfzjJHwA=@vger.kernel.org
X-Gm-Message-State: AFq9FYI54hr0hYCQ7YaA7CnNnj9HDL4ez3r9gt+pK4vXhQPGEzhFAi2a
	bNiciQp6kiZg5mqAMx7EtvdxzLA6VqblpynqJnZ7x/R7f4F9i4NAxnJhqLAcK/NRikjeVbNGjKO
	CZDrE/qDRXNg+veK7Uc4PRKp0hG34FQs7UCGJfppf
X-Gm-Gg: AYBFou3tWX1vvOKrv6gx987WKEPIuPVk7IlwINiSueOXJhCPQNCV63nf5BkXQP1it6A
	3vOEhtj+bxSodQun86egDT9HRLaycmjZXylWi44k2WOSkv2hBqWpOe80EdnORRKdY37mreX+FNZ
	wwnbLqD5sCBFmK6OPGjydK/coNk6V8N9iQSD/AuODEjoeVJIVKqCqQeLqRKl0IZtluIuq5bwnrp
	i2ttvg14X5TyyzQr8Il95KwjILGKgwUlpbyvqS3JIrjXKlMvlPzdUxqdnRIdy5dmdq8Ut6z2J3T
	lH5zYbvoslPhrX0OeQVKG8SLtDyy3jU4aH4dbpRA9iRYbItZLc+dzeOWUhE7uPz93Eq0dx04PkA
	B2p7XcLIdVqmHNzPsOTH+b8F8lIaWcgb4tykkt/p8i8DAaQaz2NyV
X-Received: by 2002:a17:902:ecc7:b0:2c9:b404:b55 with SMTP id
 d9443c01a7336-2e2c6355633mr3888815ad.6.1790690777520; Tue, 29 Sep 2026
 07:06:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812-refcount-bug-on-data-corruption-v1-1-c6da63566101@google.com>
 <aru5lCCF50puV8GM@willie-the-truck>
In-Reply-To: <aru5lCCF50puV8GM@willie-the-truck>
From: Jann Horn <jannh@google.com>
Date: Tue, 29 Sep 2026 16:05:40 +0200
X-Gm-Features: AclHuK-fOXsoweB1C7GwlqeBps4yNhb8dBqPbcZDfr5o7KnCnMropqZvBr1B7_8
Message-ID: <CAG48ez3v9uKzoNTj0xz+ec1qV6sAerkmqi8orJE4ghdPfJxz2Q@mail.gmail.com>
Subject: Re: [PATCH] refcount: Use CONFIG_BUG_ON_DATA_CORRUPTION for
 UAF-related errors
To: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Gary Guo <gary@garyguo.net>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 3:14=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
> On Wed, Aug 12, 2026 at 08:56:38PM +0200, Jann Horn wrote:
> > Some refcount issues are not necessarily associated with memory corrupt=
ion,
> > but REFCOUNT_ADD_UAF suggests that a UAF either just happened or is abo=
ut
> > to happen.
> >
> > REFCOUNT_SUB_UAF is also an indicator that reference counting is wrong,=
 and
> > suggests (less strongly) that a UAF access might have happened recently=
.
> >
> > In these cases, BUG() is appropriate if CONFIG_BUG_ON_DATA_CORRUPTION i=
s
> > set.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > MAINTAINERS specifies no specific maintainer for lib/refcount.c, but it
> > does have an entry for include/linux/refcount.h, so I guess I should
> > route this patch based on that.
> >
> > I decided to send this patch after wondering how exploitable it would b=
e
> > to have a refcount_inc() call on an object which has reached refcount 0=
,
> > but is not yet freed because of something like an RCU grace period.
> > ---
> >  lib/refcount.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/refcount.c b/lib/refcount.c
> > index a207a8f22b3c..c0f0dc5296eb 100644
> > --- a/lib/refcount.c
> > +++ b/lib/refcount.c
> > @@ -10,6 +10,15 @@
> >
> >  #define REFCOUNT_WARN(str)   WARN_ONCE(1, "refcount_t: " str ".\n")
> >
> > +#ifdef CONFIG_BUG_ON_DATA_CORRUPTION
> > +#define REFCOUNT_CORRUPTION(str) ({          \
> > +     pr_err("refcount_t: " str ".\n");       \
> > +     BUG();                                  \
> > +})
> > +#else
> > +#define REFCOUNT_CORRUPTION(str) REFCOUNT_WARN(str)
> > +#endif
>
> Can you use CHECK_DATA_CORRUPTION() here instead of open-coding the BUG()=
?

I was considering that, but decided not to for two reasons:

1. CHECK_DATA_CORRUPTION() uses WARN(), while the refcounting code
uses WARN_ONCE() so that a saturated refcount doesn't WARN() every
time it is touched.
2. CHECK_DATA_CORRUPTION() is currently marked with __must_check
(which can't reliably be suppressed on all compilers by casting the
result to void), see
https://lore.kernel.org/all/20260812-data-corruption-mustcheck-v1-1-5f59bd3=
bc2b8@google.com/
.

> Either way:
>
> Acked-by: Will Deacon <will@kernel.org>

Thanks!
