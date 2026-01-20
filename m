Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E78144D683
	for <linux-hardening@vger.kernel.org>; Tue, 20 Jan 2026 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932705; cv=pass; b=LD7a507X9MwjJYqufhoSj4F57S4sTUBIXzVtsGZkF+fxqzKl67eywqPHxQBamcAjL4mdLKyGWTrB3lOZ5/Y2utj1HAEvgmfkwVa8KJdRJVKP+lPyuOLmYpBdgwo7dLvBNl3d4j9rE5Zn1IvD2Be2FBx0fIra71JOmv7Bi7YP2V8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932705; c=relaxed/simple;
	bh=6uJ8uXj14S0D0ONW/lrmUGGFAUg1zVWxSuh2ypdbbKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaSKLSBDTLj/XtsAlGxZMn9DupK1Ilh6mnvG6xwACgMBEcISGSYr6A6wzA2neJM6OJtvnxBId6RoFbRAzNZBE1c+JJtJRnbNwYCUSpYEVoQjRm8WWL0M4lKB+gfjIaosrB3KQyfooximRHwlu/46wMxJuKms/S5nq1tXBaatP7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aFdU520n; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aFdU520n"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8765b80a52so906131466b.2
        for <linux-hardening@vger.kernel.org>; Tue, 20 Jan 2026 10:11:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768932701; cv=none;
        d=google.com; s=arc-20240605;
        b=GzgY23zXT0QV6rWtMbr3iJY6zR20kvsjx8ispt0Q8ByDcl75gI/fg7+vGYYJvHA+UX
         Mh4JEzFi5sPi422yjelOxn8O9R0kDYUg261TteYMev5dLpgZR21/fZCJ1QMQpjkVkrBr
         dLqR38mbRYalmJFC3XOuSQIHcWyrpzOxpuZNxXeddKfrjri486YSiKd8NvMo6qzAGqhu
         Ngphs7qx0kXeaU6DJqIMZAI1BVD0aSYbgfPhNyOYhPsCOS6kv0CpWmbFamtH508hn2sA
         QWF42vGJHbLLvJ+LJObXs4/5T50nICsDoSjbC815Izkp65lKtgmtwRqWVRIaWptJmfD3
         POMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6HNUo8PrhXo91SkMVhjYZd+vwGPnd7oySasSZ/9ylOM=;
        fh=IvrElf1Q7WFarWA2LvvmVY5DdkCrIWCt9baeB92+S1o=;
        b=jO1hBihGkf/ox+eBDlyUUpA//L0urFZJ5FcpiJNiV2HdHj/dbMPrQ+3RTgNAaje1xY
         mVRZsrTgwMVDOOq7wVQKjyRqimH2KLEIvQJmXMTvi5avrm9P+rzMLMDMvfVcRrIXVsuN
         sGxJ6xsf+cuCWtW6RfRG9mjeHszP5JKtIT56T0EBcRMJXUZRSK+r49VHmmc991TzaRSn
         8WdlXdSnnI6PD4qDGdXxqyv6YGwOm8hUTw+RlG2mioyUSO2QWVAAbJo2MTlxL/ZQZuyx
         K9lS3MlFngAo3tX92DnZn/vptXt3M3UshMXU24+XLD7NEULsrYzKCm+GMhsFOSsKfece
         kanA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768932701; x=1769537501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HNUo8PrhXo91SkMVhjYZd+vwGPnd7oySasSZ/9ylOM=;
        b=aFdU520nbVSDQemnPew7IttArDTdI7gpkrAp++7Ej7junQJTzyd2JfWYJjm8JD34ao
         gVIhbyD4jL2ZMKH6dyyhvrWhnb/eS01Z2DkUxuE/4MvB2SkqvSw3nLxwdksuUZQBFNS0
         HjxvxYMxoGruZj5qVWNZAcwPwqtlGG9zTezOsufE99YJKxLw4Kh8dD3tRL+CHZRECcgG
         Z9A7oOmXQAVDGZu9abGW1VALn6RqdEbQ+jkza/yeCSfdonWCpJnFAPS1JnVF4htDYXhU
         FVng51liiQea5to2nHGW6Vziz2t1yDAreHT6wESvCWRcDaIvpR+wR6Y2q81XBF3ftgp4
         +yBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768932701; x=1769537501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6HNUo8PrhXo91SkMVhjYZd+vwGPnd7oySasSZ/9ylOM=;
        b=YG49H0rTbV0dGXXkYzkbeOkKd1zCnGMT9iRdeSszTTWQFzePcpg3iq/RwdH93HqPkE
         05TxO87VBuMs+vKwmRF0fCpyo0eS/qlPgp2sR9gtCRcgxmUg3TLSHe4XmsdyxwGYgf1W
         a236uIL1B3691SZ/TX/yxn75MlN3ZHQItCMQc+ocBmX6Xj6IVP/7AaAmiYJ3HYJiB9uK
         pHnV7arY6/f0JbhA6l5XLVagHvyuSzKqgKvM0yk6YWjDC3HKJXrZyt7OKR7jA+OqCgfG
         JGxNPJhjwbANqoFsit7oqS11Rz2VIVAq6Pm7ZvFKB8Dz3K99OFyOcR7rWU3vQhl56cRl
         zQnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvHqmNZ9KggnOfcnK8fd+IsQlaxAKrMKpHY0vziB20aESLCrCALZGuesWfKaKr0IY5iQDDvAmHWx2gUCTvceE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa9faDq3kb92+0yBXmUNYh8rU/QvtynVSUvQNdX2hv5O5PVx94
	z3IeKvkpnoXG+CP9HJA9btAQSF4KJks/e0QLeDYb1XN9DoWURiSLm21XOa9IgD18LqePqdROhB5
	Hsra10uCjqDq1rGGaVNhEvoBwLMFxMTfDJOeu5Lo=
X-Gm-Gg: AZuq6aIrCLNj9q9HfCOWquJ7rsodcqlrpTPbd9rB1N0l6efWDssfS8UmXboc0wIPmAL
	BhJAB4BA2rwP5QbYF2Tuuj/DBa8cKjwKCSlwhW699T+lv+7YPwLfJtT/+Mnv41ghZf30/DYOoCn
	4J4Guau1UMdAP3Q32VmHWzcC7KWtJxMJEBkRnUfCpmSTtZB45qZi2AKBINiLURSJcQhKnYc87sY
	XyCxMgcquQeRNiryQA7deSRg2H++wmhGLKlwdGLtS3OB3+Ioja0wNrZIGI97kE2QapHrmUG1DjJ
	Zchdhf8cj1f6Xi/pGUjn1CC1IoTS03+OWdFbdb6f9HHYVETFa0U40k/lsNxao3rAsIec3viDzOm
	4KCw=
X-Received: by 2002:a17:907:d92:b0:b87:1d30:7ec with SMTP id
 a640c23a62f3a-b8792f7985dmr1331959866b.37.1768932700986; Tue, 20 Jan 2026
 10:11:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114193716.1740684-1-morbo@google.com> <20260116005838.2419118-1-morbo@google.com>
 <20260116095318.46a149fb@pumpkin>
In-Reply-To: <20260116095318.46a149fb@pumpkin>
From: Bill Wendling <morbo@google.com>
Date: Tue, 20 Jan 2026 10:11:24 -0800
X-Gm-Features: AZwV_Qg0Q8H8gkTfPD29xQRQkPN2S6byR4RDcVQeMnbq12oeSFaTrTP_sX4-TZQ
Message-ID: <CAGG=3QWLn1uRih-F0mVfEjXNjw47Tb=-RWsoqBJUHH=7e_qwPQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] Compiler Attributes: Add __counted_by_ptr macro
To: David Laight <david.laight.linux@gmail.com>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Justin Stitt <justinstitt@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Tejun Heo <tj@kernel.org>, Jeff Xu <jeffxu@chromium.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	John Stultz <jstultz@google.com>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Brian Gerst <brgerst@gmail.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev, 
	Nicolas Schier <nsc@kernel.org>, Tamir Duberstein <tamird@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Naman Jain <namjain@linux.microsoft.com>, Simon Horman <horms@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Douglas Anderson <dianders@chromium.org>, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 1:53=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Fri, 16 Jan 2026 00:57:57 +0000
> Bill Wendling <morbo@google.com> wrote:
>
> > Introduce __counted_by_ptr(), which works like __counted_by(), but for
> > pointer struct members.
> >
> > struct foo {
> >       int a, b, c;
> >       char *buffer __counted_by_ptr(bytes);
> >       short nr_bars;
> >       struct bar *bars __counted_by_ptr(nr_bars);
> >       size_t bytes;
> > };
> >
> > Because "counted_by" can only be applied to pointer members in very
> > recent compiler versions, its application ends up needing to be distinc=
t
> > from flexibe array "counted_by" annotations, hence a separate macro.
> ...
> > diff --git a/Makefile b/Makefile
> > index 9d38125263fb..6b029f694bc2 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -952,6 +952,12 @@ KBUILD_CFLAGS    +=3D $(CC_AUTO_VAR_INIT_ZERO_ENAB=
LER)
> >  endif
> >  endif
> >
> > +ifdef CONFIG_CC_IS_CLANG
> > +ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
> > +KBUILD_CFLAGS        +=3D -fexperimental-late-parse-attributes
> > +endif
> > +endif
>
> Will that still be needed for clang 22?
> Looks a bit like a temporary flag to avoid regressions.
> Probably ought to at least have a comment that it won't be needed
> by some future clang version so that it gets tidied up.

I don't believe that there's a timeline for removing this flag, but I
agree that it should go at some point.

-bw
