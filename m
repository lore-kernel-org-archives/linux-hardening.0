Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623F544DB72
	for <linux-hardening@vger.kernel.org>; Tue, 20 Jan 2026 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932776; cv=pass; b=bIn1mDLgMojTf8UGLnQNK69V5kLdaKTHvohyD5z5etpSFQ0PKMUZdAGHXUy82Buz8HOgjBTYCIuV4hrfpSSLDLU7hrlppIe7kjN81mKCrJoZe4n8L9FIVykp6CYn27j7P4L1TL63G5vCxmeMMao7i/TPRHLn49MsGxKb3SdVPFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932776; c=relaxed/simple;
	bh=G0ot6VfCtfTdK2d9u7Kku4JHYhx/Ooh4GfeogKVkVAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jf6Tf1zCCWIGoWGAgctS/AxU9lUcMni/8zYd5RO/XGLf0D8vy95FmE7c6hNjsktBn+Axi9xEhKGePF4fLLH5NobIV+0DbS/K58vexADr4nSJITa+4Qrjfc90R5Sd5nyTZ4MxJ0z5JKvfGeVkUvN94BTMzR6dzSx1h2obBWNUDB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YHFiYZ9S; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YHFiYZ9S"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8765b80a52so906311366b.2
        for <linux-hardening@vger.kernel.org>; Tue, 20 Jan 2026 10:12:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768932772; cv=none;
        d=google.com; s=arc-20240605;
        b=aCx/98yLYXbO6vWDVawnvhBJCiULHWiX1Ym7CbOZhdT3/4+DBybyRWqJGEYeteNt7H
         WdnFe6DmexwDWImg7xpVyuDGNpxDVIUgjYVYtGwJIVitqCEXqSG0BOIe9fmugo/m+rf1
         G4brBfhf4G5ZCmEYz1wKiny2RpoNY9ew8PoyJ0saGDD6MtcuFvCZb5wKjDFk0q2fImGa
         A7vZOI1JBA4sc6MpsGP/2latGLtCKQ9UOyClt9NPuBA9zX6h7GZ+XFJJ7q7r7HO6nD5A
         geZEls9S1MyGWesmxN6qx1QeRBq6lN5CrhjWp5VGvlkdyMLtchUmZgGgz/l1HQUreKLS
         ewsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e8YNtzr6sL6sTnKQNamIDqVuGsbXWJqsHdWC+WyrhKw=;
        fh=EyywVlM5j7Ip26PdwIT4HtG9SNtDXXn1VhIQBHS34CQ=;
        b=IJJjgkoXp4mVQALbU7Vfxsldou8BRN4sJ3dSQMTOtP5UooDOw9chgD18Mj/MUw4sGU
         lkV8D3vJpWYWBxsGKosdcCuCJhaF3L8f1mNaXjViow7iRLIMXVllWZI14IHOf9N9w8F3
         mkA19RRhYJFMa4P3en6ktCna5BQmHxLnVLJmZk4h7UiHi/w7MIQ1dEdKyeS7iAzMNaoo
         9s293m3o0jcXXZcFDbvOqjZT53+SIoK/MZD6gezTHc4m8x2wlh/1Km8B/KxAEn9CDMTQ
         fn3jxF7F1I5WyPd7lum81c7j5CniUl4GbM7aSE/4n9j4sKJ7QiGcFLRa65Me6k99Sr/l
         gOYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768932772; x=1769537572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8YNtzr6sL6sTnKQNamIDqVuGsbXWJqsHdWC+WyrhKw=;
        b=YHFiYZ9ScdC2spexyQ2ESNoLvRezy+51Hdh5z9cS39+2HCnseJGRUbUc81mLPstnts
         8q6lNw8uAOtXj8ifDZbXKimnZioZpFP2Sc4OMqtDlCH4AuXsSg/KOwCh0E1tm02K9ZwV
         RyQqCSlEcJUaM6LSWZQNIVxX2eUpaKmXpCLFj07FzL3tOoRWaJHh7DRqp+84ZPlzBaXx
         pRZN6XyYMmgBR4ZYw7Xzm9XVCMqSKvPYBiv5cxAqnyqMKKSwMsFkRBhK+lbbiZDKMeZG
         EzsCym8802RPHgvflW+8KP0L/uBC9a+tl1IuQbth+AyC6Bs6uqsQBaRgEY1ABAnFJbd9
         3guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768932772; x=1769537572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e8YNtzr6sL6sTnKQNamIDqVuGsbXWJqsHdWC+WyrhKw=;
        b=SZjHpDfUQKru/ZqwDnRecDr4Iwf8RHc7Qzr5WqKT612YyGkTTJo8fMTrrgeU2hL9FE
         BQffKxOcQhH6Uu2z226M4h1DcA20UDCMpj0dip7ASbP4HBiRzpflRvPER/H/BG2Pb3P8
         rolXdeaVeP78QWprRzpSfWYpA3rcI9jtH4zEmWbYHcoJBy7Br2nzYASV0yOdAniLkZOR
         zJYvJ4Q7o48xZJCor559pzGF78BDXVRaHi8neKy8GVyK9z8OncB4PrtM2UKK0Ez61ciz
         tRCqKxr5N+YYE4hyJdiEBpTKl0OX6iKIOehnpjd1NmRfIfYHKOK4fBELtI8JO/Tn3XhU
         TGxg==
X-Forwarded-Encrypted: i=1; AJvYcCWv2kgQoTDu6EMCRevU653CRdLtXyJlRMJ9BztYiYzSHaCaQQAGBaGWtEBF/Ue3U+qdoVO9knXn3y5iUhykLZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUfKxjeLM3f1NU83OhzsU6FnsJKZzoxcEZCUeLqQiyI+AAbytc
	TDDpbkPRutzFBTvmpwuFew+BDEddPMJTeHK2tpf44bEJh/BpUhVQCGjeRqCw7ACrzN+bAQOVDq+
	9dxjgXtUWqzHdOiY8d2cAzfbFeynDYDnSIcCgPyQ=
X-Gm-Gg: AY/fxX6ykuf/WgOLympIoBEvaljUCPUugKMdQIKa6D4J0/ZR6sXTQCOW4KzgPN2O3L1
	5jfFMgFgK8RBcAXxuSXmQIzF29Zq2OXxBYnIxiKbDRLc/c19PhJCyH3U/icFKf2uTs5GGTjU6BC
	SR+oDFqO0o5sE9NRfWl4WVBTrYGZ70hu9GBML7O3R7xxq+DV3Gng2bjOkY8t7lFGLm6qedrsgEX
	0hYHJWe/p/OqQECk6plNsJkjuTViCPQSGUurvCF//lV2QgEkGtuv5TUaYmOFtiwwYTRdI+cbvvU
	irWTeNIVFh0cNHpfpFb+Q2GRtw0PE4cSzdrtbFC7jXBvVX5U0Rj5GMIwe9tIy4ZLe5Rt0A5xk5K
	hRnE=
X-Received: by 2002:a17:907:9615:b0:b80:5ae7:5d94 with SMTP id
 a640c23a62f3a-b8792d27519mr1273652266b.7.1768932771343; Tue, 20 Jan 2026
 10:12:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114193716.1740684-1-morbo@google.com> <20260116005838.2419118-1-morbo@google.com>
 <20260116095318.46a149fb@pumpkin> <202601171106.90E508A9D4@keescook>
In-Reply-To: <202601171106.90E508A9D4@keescook>
From: Bill Wendling <morbo@google.com>
Date: Tue, 20 Jan 2026 10:12:34 -0800
X-Gm-Features: AZwV_QhDwTff35V7oRC_lRCHIRr3OUHATuj7NTOuUgdO0F2oWVoaStpeXxTPVes
Message-ID: <CAGG=3QWeYZqLA8FSMYZFRrJ24LtEKJdmRAq3awkMZj0+qy=4_w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] Compiler Attributes: Add __counted_by_ptr macro
To: Kees Cook <kees@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Justin Stitt <justinstitt@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Marc Herbert <Marc.Herbert@linux.intel.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Jeff Xu <jeffxu@chromium.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
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

On Sat, Jan 17, 2026 at 11:07=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Fri, Jan 16, 2026 at 09:53:18AM +0000, David Laight wrote:
> > On Fri, 16 Jan 2026 00:57:57 +0000
> > Bill Wendling <morbo@google.com> wrote:
> >
> > > Introduce __counted_by_ptr(), which works like __counted_by(), but fo=
r
> > > pointer struct members.
> > >
> > > struct foo {
> > >     int a, b, c;
> > >     char *buffer __counted_by_ptr(bytes);
> > >     short nr_bars;
> > >     struct bar *bars __counted_by_ptr(nr_bars);
> > >     size_t bytes;
> > > };
> > >
> > > Because "counted_by" can only be applied to pointer members in very
> > > recent compiler versions, its application ends up needing to be disti=
nct
> > > from flexibe array "counted_by" annotations, hence a separate macro.
> > ...
> > > diff --git a/Makefile b/Makefile
> > > index 9d38125263fb..6b029f694bc2 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -952,6 +952,12 @@ KBUILD_CFLAGS  +=3D $(CC_AUTO_VAR_INIT_ZERO_ENAB=
LER)
> > >  endif
> > >  endif
> > >
> > > +ifdef CONFIG_CC_IS_CLANG
> > > +ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
> > > +KBUILD_CFLAGS      +=3D -fexperimental-late-parse-attributes
> > > +endif
> > > +endif
> >
> > Will that still be needed for clang 22?
>
> AFAIK, yes. AIUI, this flag will remain while -fbounds-safety continues
> to be upstreamed into LLVM.
>
> > Looks a bit like a temporary flag to avoid regressions.
> > Probably ought to at least have a comment that it won't be needed
> > by some future clang version so that it gets tidied up.
>
> Once it's no longer needed, yes, I will want it removed from the
> Makefile.
>
Would it be good to 'fixup' a comment in the Makefile for that?

-bw
