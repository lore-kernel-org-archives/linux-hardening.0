Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tRlIzDb4"
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C571D181
	for <linux-hardening@vger.kernel.org>; Tue,  5 Dec 2023 14:21:08 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40838915cecso64126275e9.2
        for <linux-hardening@vger.kernel.org>; Tue, 05 Dec 2023 14:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701814867; x=1702419667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtdgYO2/5wzcNxCn3VtqicgQzIviRp5CjfOT6b/JWQ0=;
        b=tRlIzDb4uNTyUDRQFsBCDd/+gfoE++6balB9VVWBmuUjCJgBqdWGvBCYS2WmJHZVNH
         6Lf2Tpb03aCOEZLQwf5C7xy5VE0OAmKr4P3jRWRhJT8DSOh3fne6oM9sXjrB0QE4Sf1m
         kbIpvzl4OSyU31MSYwWPilXOdCaX3uLu/PMtFw4994vdLmaQt7fE1DK7s6//1oRNfzng
         p4z+9vR0uVQ5+2QIXGAuW08MGoTo3WTqGQvczcP100NO0tHfChR5dFWMDQzYBvwsDfK1
         5SXFf4AVcBRMeuAaMTXoz/6aOUImGXoMRFukQIIIhpZR76LjB4bHwYCwuqd63kXhakmS
         L3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701814867; x=1702419667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtdgYO2/5wzcNxCn3VtqicgQzIviRp5CjfOT6b/JWQ0=;
        b=WWf2Li8iWYvPR/F5tXxk+auXnr9FsFV+mhBLOiwY0oDyxz9jjZ5z5+d0raQEu3Zhif
         IuUzyGwlowQPo6y94hvqTwcgWouiIB6iEIGJvOLl5AoHl03y52d6JUyxza6BG91Aj8tj
         NHjyY7o93rBRhbFTx+TSk3x+OxCtYJ3DxO5njwmzm+qFag/WpH11H0Xsh8oEfNSQwmwN
         DHv+9QdAv1Ki5Eto76XvvSFelj/H9KuBQH3P0PLlT1j9bXQyKlPkPQFwY8k7H+VKHeub
         vWZT0RvOxbc+/edoqFKxiKRYsPK7O/NSYC2rc7JDPkrJEafdWcKc4a4sPmLeehJFPzcI
         9Yqw==
X-Gm-Message-State: AOJu0YxFIijzFrDp7hYhBEqGGUOB5swFsrcOWRFzi2ptr4ROK31C5Dd3
	GveTU69zHWnEzzJ1aM/+N0CxNuSgY1rC52eKM94B9w==
X-Google-Smtp-Source: AGHT+IEHRLg/u4MDQUXn2Q3Vi3FcZx0NgtWPXTCyQiVCGa7EFiClCbQEpu59QZ9PdQyHgzUKzF5X+LKaQB/fPM6CEJg=
X-Received: by 2002:a05:600c:4f81:b0:40c:67a:b3bc with SMTP id
 n1-20020a05600c4f8100b0040c067ab3bcmr14832wmq.71.1701814867131; Tue, 05 Dec
 2023 14:21:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205213807.GE1674809@ZenIV> <CAKwvOd=2VASkaLvjU+7kkbvhu2CimYn5KUGJBDRePyUhtrNK2Q@mail.gmail.com>
 <ZW-d1NZRIvmJlfcW@smile.fi.intel.com> <20231205221521.GH1674809@ZenIV>
In-Reply-To: <20231205221521.GH1674809@ZenIV>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 5 Dec 2023 14:20:55 -0800
Message-ID: <CAKwvOdm3PrKhGi9DuQvaYN6O-R-EtGQ=BhFm7D4ZPDqU_ZzUkA@mail.gmail.com>
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
To: Al Viro <viro@zeniv.linux.org.uk>, Andy Shevchenko <andy@kernel.org>
Cc: tanzirh@google.com, Kees Cook <keescook@chromium.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nick DeSaulniers <nnn@google.com>, Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 2:15=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Wed, Dec 06, 2023 at 12:01:56AM +0200, Andy Shevchenko wrote:
> > On Tue, Dec 05, 2023 at 01:51:10PM -0800, Nick Desaulniers wrote:
> > > On Tue, Dec 5, 2023 at 1:38=E2=80=AFPM Al Viro <viro@zeniv.linux.org.=
uk> wrote:
> > > > On Tue, Dec 05, 2023 at 08:58:53PM +0000, tanzirh@google.com wrote:
> >
> > ...
> >
> > > > > IWYU is implemented using the IWYUScripts github repository which=
 is a tool that is
> > > > > currently undergoing development. These changes seek to improve b=
uild times.
> > > > >
> > > > > This change to lib/string.c resulted in a preprocessed size of
> > > > > lib/string.i from 26371 lines to 5232 lines (-80%).
> > > >
> > > > It also breeds includes of asm/*.h, by the look of the output, whic=
h is
> > > > not a good thing in general ;-/  E.g. #include <asm/uaccess.h> *any=
where*
> > > > outside of linux/uaccess.h is a bad idea.
> > >
> > > It's not clear to me when it's ok to #include <asm/*.h>.  Is there a
> > > convention here that I'm missing?
> >
> > The mandatory ones can be used, but not all of them.
> > In some cases you even must include asm and not linux
> > (unaligned.h, byteorder.h, maybe others...).
> >
> > As I told, it comes with experience, we lack of the
> > respective documentation (or file which is good for
> > automation checks, like with IWYU).
>
> It would certainly be nice to have such information in the tree;
> "where should I pick $SYMBOL from?" is something one needs to
> find out often enough.  To a large extent it's covered by "where
> in include/*.h do we have it defined?", but that's not all there
> is to it.  E.g. "get_user() =3D> use linux/uaccess.h".
>
> There's also stuff like "$SYMBOL should not be used outside of arch/*
> and include/*, better use $OTHER_SYMBOL", etc.

That's basically one of the tables we maintain.
https://github.com/ClangBuiltLinux/IWYUScripts/blob/main/symbol.imp

Of course, such a table is a living document; whether it resides in
tree or out of tree eventually I don't particularly care either way.
There are outstanding questions like "is it even possible to
autogenerate such a table (vs manual curation)" and "are the ones
we've coded so far correct?"  I don't expect to have all of the
answers with the initial implementation, but instead to collect
feedback from kernel devs and iterate from there.  Very helpful
responses in this thread so far; we appreciate it.

I suspect that folks that have played with IWYU in the past
encountered great difficulty since these override tables are poorly
documented, and the out of the box defaults assume more of a userspace
layout for common definitions (which our script which wraps IWYU
disables).
--=20
Thanks,
~Nick Desaulniers
