Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E6D5592EC
	for <linux-hardening@vger.kernel.org>; Thu, 15 Oct 2026 18:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087522; cv=pass; b=g2aMP5uBEr9E9Qpl4wkGOcmpWjFMFU7rPauUH8Uem0ScGi8Jwmjro8JJ+YQDCoRZC7v46XPnlnxzBOJLhS6olYM9xXg1t4+6GCeKXhXZsOb1fmrO0RvELma/5/faETR3AVHB2TsxbpCqA03+E9SfmnEOG+QeMHJ/MKB42k6w+YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087522; c=relaxed/simple;
	bh=9qqZFCxNvH9lQuYn8TifWIOPbxzX+/pJtiEqloKnb/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqY2770ETMsnZFLOaB4WKWT0C19FvbAHob68g7g5L76SgT3kn8vT7jliBxM7hKE3TY3r3fhV9Duk3LM1e5rOX0kDna6fwFgh6KP70h4enjgSfvAoyVq5SDfy0s4PleGK3Y3+QQ5GjPGgqLwpucZD0POgTjpucpzuGP3sf4mgOdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N9486xIi; arc=pass smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N9486xIi"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7c33cc572e6so254295137.1
        for <linux-hardening@vger.kernel.org>; Thu, 15 Oct 2026 11:05:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792087516; cv=none;
        d=google.com; s=arc-20260327;
        b=rYZ0kP+r+7F/3dg73fgWhH8XpOcYCBCSstgUb070egXE7xrIp6g82dhRxfGFPQlPu0
         Nz/ADBwFLRQ4uaM2cSC0oXz4XKz5wG7B1itBYIGeQ2DfusNUYFjkp/EsIROnDs06wqD3
         b88kUrEuklFXJN9kssPvT/DCeGHWgb9iuNnpDpedTS0K6FoSzXn4+WDFcD9CiWD5FULn
         DgE7ZgAWnrfGud5HOm48HfGCiLw0CP4jQ6a0EUh7xtkR15Kzhd0ZiBvnX4mDU6p7bT55
         v0EzoW7qjF+V1S8XdyiD+paA+fbVj4i2jSLf+rmhsfMA61bADeVspsT/w4x0jzuw4h7b
         ziLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M5pLMAaw/NhUBZQOOoKqfbkfYTSk+h3K5UqvT2yaGdI=;
        fh=1NWmDNVH85RqY7sUJMsZWhTlLl7mewuPIzi3Z/rwddg=;
        b=d9LZyBjAafjmM9QPbIK2Y81nfXNvAqQauYuWwykzCFHzpFl2sd5AEujtm8l+nq/c6Y
         Ct+dmTCpKYh7lDF6ESqE2dg+Sn8ZfPTQ8rcjwkJqC35XXyI3Y1bgdCawjwIvxXhPIQyd
         L7ZTNFy/HV+3hiCEbo2FyJJv8N6cywQQ5UovDQ97IFglkMAhk2TIt19Ys3qQt549ovjg
         zB2XlO90MISWVYNXjMVAIx/PF3gjL7yEsYKwQZKddahnL4DHDgv3Iix0Oo2PbM9zIBYR
         6FIAvvCRaOBTVv/VqrXz81IqexVSrrMsKwjrfmdIYHkmFOkvzlOwZJAMH1u6CBj0YGuK
         jWNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792087516; x=1792692316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M5pLMAaw/NhUBZQOOoKqfbkfYTSk+h3K5UqvT2yaGdI=;
        b=N9486xIifrrI86RsrrjAYSYTfy1eFv7P93rJouLRDAe9u74QuQsxGhIG1oxXsRwy0u
         Y3s5D5RanuCAYGKsu2fyEeEd6HQoxAzpVlLReWeAZ4mF9pQ4KHuvuIUbLceI7Pj4j1lV
         ydHQmPgRZRBC4s/Q0rVOart6Rwp3LrD07w/+2CtIObbmXFQf+IyAjIfUCF/E+EIuEjq8
         5hWwUx3hZpmbUEAffJ210qJwmTJA85mW97rs2Y/O8owRMTEsfbTjEgvoDRzVPRwo/o3s
         WfQnkljZfs1aVDVZmOwzsQy3jIxCBQ4udgFAOFN+ZqP6JrXdkjTfxyrF5pK2jPvXVZ8S
         vqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792087516; x=1792692316;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M5pLMAaw/NhUBZQOOoKqfbkfYTSk+h3K5UqvT2yaGdI=;
        b=Vi/qseFgwMd590J8VeE9obCeP/r3WUnCrnzUwjzu04+RazwhrCGNMb3/2ZjegMLLFO
         DVFOGZIbi8shV0l+gsAhcpXwtb1s3w8Dq10N1uqoK1mJ3ZVtYj0qMn+kMvloZFFieA7y
         nbfP9s5JrU6WbWBqdZte9xHSIqrb2pb1F7v9z309hUX3472IERzWAWdVqH6mD07mIvVU
         7Y18pZ0CnCDHDxY4W8xwgQ2v2HmWzBcHDGW1dhTptYLmhwmf9UImYmYLR5st59DRk2JZ
         FcZJaDGy+KXZ0Fovypfpkz/lbnXpjzPtHlvUObshMcsyIaKsXP9qYzpzqFq/UOa3eLaC
         XpAw==
X-Forwarded-Encrypted: i=1; AKwUvByhcaxaFgAt/KGHV79i0y8TZUcF65em+FF97vcDcCt5S5Ei2AHPt+mzopXpzuMJOyHhRN970CFsPw2E2WSOiDA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbWIQF6b+5+coGvWCTPEvb2v9jtLbqgkNdpBC8osYCY0ORZBIp
	Isb/0U/0EMEIbvtLwQQMWMZ7HCPM/PkKvmw/SBkk8AgaZyLubH6HSTMdOFZTIYL6BRdpPQCVmkS
	FbhG8fzTgcU0CuuyMSF9kmJTG5btc6fCO+YNoDZk=
X-Gm-Gg: AYBFou1ugpeQ9EVqkJX1hKax2J2SYgUx3kpkEPorwD+zJQfyMOY1xrNCjTtxX7xDQeH
	GUHFsSW9Ma294pDNddtx61PHfHDifpe+cJ+k3XhD/oi+PcsRSGC3KNJlHq/mRgnR0E1K2cvrQWb
	PrFMovQpZ5Zard5x5Ejir7YhaEvyHc0OXprNJEdPHTaBYdgetcYBTYkGLb81WeBZSokPciWp9Pu
	ZuRKZ+l7bt9G1ktos6yIOLYtPskHht5pxBT1+epjp6EUmenx5iOhpoSgTW7J+QMk7bB8lLjrEaZ
	Xm1o3if1/WtX7c/N/OGzcqRUFJ19mvtnAlx1nFrrurkAyExCFrPdTwO/f8fNmfywFSo3oMWq0Ij
	CJxUyWkmyv3wYPy0HJwbwLQMIBc89Envz412bDgG03fKQZd2dXKtF
X-Received: by 2002:a05:6102:258a:20b0:7cb:be5a:c62b with SMTP id
 ada2fe7eead31-7cc182ac610mr231069137.43.1792087515155; Thu, 15 Oct 2026
 11:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012205919.4012405-1-morbo@google.com> <20261013203146.387344-1-morbo@google.com>
 <20261014133805.47afdb0b@pumpkin> <CAGG=3QUZna+bi-_nmJh-1aWBBtuURbexQczXCNt0R+jDSb1NMQ@mail.gmail.com>
 <20261015110004.6f77ea67@pumpkin>
In-Reply-To: <20261015110004.6f77ea67@pumpkin>
From: Bill Wendling <morbo@google.com>
Date: Thu, 15 Oct 2026 11:04:59 -0700
X-Gm-Features: AclHuK83OVpzmxSg0Z9qbNHGxanTGTt-eP7LKmMT42qkw4H_LA4iLcps9DKtQbA
Message-ID: <CAGG=3QXiykQb+BWtegfe=NDy8e+VsgbY0uRf=Hc=LMuwFxi_-A@mail.gmail.com>
Subject: Re: [PATCH v2] overflow: Match arithmetic in both parts of __builtin_choose_expr
To: David Laight <david.laight.linux@gmail.com>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 3:00=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
> On Wed, 14 Oct 2026 13:39:03 -0700
> Bill Wendling <morbo@google.com> wrote:
>
> > On Wed, Oct 14, 2026 at 5:38=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > > On Tue, 13 Oct 2026 20:31:46 +0000
> > > Bill Wendling <morbo@google.com> wrote:
> > >
> > > > The two parts of '__builtin_choose_expr()' had different arithmetic
> > > > expressions. This patch corrects it so that both parts calculate:
> > > >
> > > >   COUNT * sizeof(*MEMBER) + __must_be_array(MEMBER)
> > > >
> > > > In practice, '__must_be_array' is meant to assert if 'MEMBER' isn't=
 an
> > > > array and return '0' otherwise. However, symmetry is less prone to
> > > > subtle errors (and far more satisfying).
> > > >
> > > > Signed-off-by: Bill Wendling <morbo@google.com>
> > > > ---
> > > > v2: Don't use 'size_add', which just adds more complicated macro cr=
uft to the
> > > >     expression. Instead, just adjust the parentheses.
> > > > ---
> > > >  include/linux/overflow.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > > > index a8cb6319b4fb..d0f04436343e 100644
> > > > --- a/include/linux/overflow.h
> > > > +++ b/include/linux/overflow.h
> > > > @@ -418,7 +418,7 @@ static __always_inline size_t __must_check size=
_sub(size_t minuend, size_t subtr
> > > >  #define flex_array_size(p, member, count)                         =
   \
> > > >       __builtin_choose_expr(__is_constexpr(count),                 =
   \
> > > >               (count) * sizeof(*(p)->member) + __must_be_array((p)-=
>member),  \
> > > > -             size_mul(count, sizeof(*(p)->member) + __must_be_arra=
y((p)->member)))
> > > > +             size_mul(count, sizeof(*(p)->member)) + __must_be_arr=
ay((p)->member))
> > >
> > > Why does this use __builtin_choose_expr().
> > > The types of the two expressions are the same so it might as well use=
 ?:
> > >
> > It's to emit only one of the expressions rather than both. If the
> > 'count' is a constant expression, then it's possible for the compiler
> > to perform the calculation without having to hold onto the "false"
> > path of the ternary operator. So much more efficient in the long-run.
>
> I doubt it.
> Even with __builtin_choose_expr() the compile has to do most of the work
> for compiling the 'false' path.
> If you use ?: then you can also use the much simpler __builtin_constant_p=
()
> and possibly pick up cases where it is only known to be constant later.

In both scenarios the compiler is meant to do the majority of the
work, so I don't care about the compiler doing more work, only that
the work it does results in better code. First,
__builtin_constant_p(n) won't catch as many uses as __is_constexpr(n).
With the ternary operator, the compiler will generate code for both
sides and the predicate, which adds a needless if-then branch to the
CFG. Yes, that will get simplified, but again it's not a benefit over
__builtin_choose_expr(). In the simplest cases, the compilers (both
GCC and Clang) can decide which branch to take in the front-end.
That's possible with the ternary operator, but care needs to be taken
due to possible side-effects. Also, Clang performs far fewer of these
kinds of code transformations in the front-end. For instance, GCC will
perform some inlining in the front-end, making it easier for it to
catch __builtin_constant_p() uses that Clang has to delay.

All of this to say, there is no benefit to using the ternary operator,
even if you want to claim that the compiler is doing more work (which
we don't care about), and potentially worse code being generated, due
to processing that has to occur later on.

> > > Also doesn't this optimisation apply to all uses of size_mul() (aka s=
aturating_mul()).
> > > Presumably relying on the compiler to report the compilation time num=
eric overflow.
> >
> > I'm not familiar with saturating_mul(). I'm sure others on here can tal=
k to it.
>
> That is me giving is a better name.
> The same is true for size_add().
> IMHO saturation size_t calculations is really broken because it allows
> through 'bigger than sensible' sizes that still might cause problems
> (eg kmalloc() of sizes just below the limit.)
>
Patches welcome. :-)

-bw
