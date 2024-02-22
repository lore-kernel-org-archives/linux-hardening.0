Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1FD3DB9A
	for <linux-hardening@vger.kernel.org>; Thu, 22 Feb 2024 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621928; cv=none; b=Sbhr4cDsUBsYq6Y91s++Co1tlN89vV9Mk+LnP0s6d73bBCjVYAkdqSZJ12dZdcKRxv9OpeaX1HFuOkIbCaUqq6RSIcnrxcEqUikIIO+N5Vi8qbJaASTmVohSthc1lfrdG+0SRsdPY2YTPo66xUA7CIvImqifCuCv56BnQeDKPJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621928; c=relaxed/simple;
	bh=wNfsL80mNMC2d2nidGt395UjfsvPLVaIfIZViGCe8r8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7UqHAQOzeGD0oCLdnFTEp0I+9yiP2EluOpkerZW9qBBd1Sy3ln71rLkyDURdGlux+MhXglikwYq6yXKpWZnhDEPm5ODx5N7ceyjYS1M9jVuSvKW2DJdCtKw8IDNsqDMONYm15EGXuYWQKAwDLwyTUgt4c07Mmrp4y3dbDrKbMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=As0Zlzbs; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="As0Zlzbs"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3e7ce7dac9so621953766b.1
        for <linux-hardening@vger.kernel.org>; Thu, 22 Feb 2024 09:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708621925; x=1709226725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R62y3zmfO3vkTBKELkMH6EBSN9Umpuk/UWSNDSUJmRE=;
        b=As0Zlzbsz1b9+PXroP/vAHy8leON9LDThSbHd+LehBkFW/pJIzWpku2qjg/701Y4q8
         KiUVAJqsFDU/OBX9UOcD3XhGdFSjY8hmgiWgDF5gz3Vv8/fai0QM/iULHQuGLqp744h7
         0zT+m+ib/l9SxYQp3BjSjcm/phKn7IZj71npgMdfsCcDdMKE0MC7BTQlNn4SNhFc/hzr
         gWbNNY4bsi73/b8lylSrMEIrZHjRY8KHqXpPb7wensViCqFFCgCQ+850pFR9sMh4srDa
         emfrlQ/oQsN3dPlEgSpfMkz2pp4699xk5m9bc8jw0Wd040rUdB0JlYOAFWaQMsQAVo9C
         1z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708621925; x=1709226725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R62y3zmfO3vkTBKELkMH6EBSN9Umpuk/UWSNDSUJmRE=;
        b=KAwRPdCnoGt2Rk4ZnNQthDfyV5ncFkrTr8m9rpPtJWAsohoeQY1mZzNL+awOuAo73M
         ct7FEGCnxYcKqmw+CigC+VerO1Dq9V9XHdyQrbir5aUlIiAXyXdEFgPvN6uE0ah83Jvo
         50CYIwCuY/rj/f77j4fYIGGDvCexnttjEaGBxkl3l/QUxPpK/pqZOP+fEdHcKUCZ6sGy
         w+IqlnFZpjbEF7hk9AAmtBDgtNVWJ610IcfhHr5xshvhjX0RSReiSs9im4WsHgCeurts
         yI8CaZNt6SXH5X9qW6t8+QZQU4Kw+kX7BVUcyRNQLGuhwUp1mhUzky3D0gj+ixqJsILe
         ImGA==
X-Forwarded-Encrypted: i=1; AJvYcCX60l0GiMCfr9Hf5/xSc8HxxW48HUJviwsmKeHXPi+qCuFKDu4zX4o73QutQ2E8tp9Djt3/y/yb6+dxaOujDpYvpao6W0tgdkiXi7nclsVe
X-Gm-Message-State: AOJu0Yzh/jaTR2EKrgWfRxN7XiWSXcqYomzFsGlF2Snjg2PxQtZF4NmX
	0i9N6mc001iohvzRNzDDVlfS/lbGe6wFu1KtvG0WxrndaKReyefVqR/9Ie/9JOcnCbpjTYie7yZ
	N7i9LNWTw2zH43u3pzTJzNuqr2zA=
X-Google-Smtp-Source: AGHT+IE0sPki7t4TbugmLAgjhSr6glJUOzmra/6Ww/Qw1K5v8TM0qF7dC2R8Xsoh68eYEwXKc40Ck7ci/1qOLBc8qHw=
X-Received: by 2002:a17:906:1cc2:b0:a3e:4d4c:d120 with SMTP id
 i2-20020a1709061cc200b00a3e4d4cd120mr12161358ejh.12.1708621924680; Thu, 22
 Feb 2024 09:12:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230406000212.3442647-6-keescook@chromium.org>
 <202304061930.4Au0PASm-lkp@intel.com> <19930c5a-f1ed-4b04-b69a-d7259966f020@app.fastmail.com>
 <202402220829.10C6C7C@keescook>
In-Reply-To: <202402220829.10C6C7C@keescook>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 22 Feb 2024 19:11:28 +0200
Message-ID: <CAHp75VfDxrTyPCunRbteANRu+-Pt0sMvepxnBAgRbc-Bdb=6nQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] fortify: Split reporting and avoid passing string pointer
To: Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	Andy Shevchenko <andy@kernel.org>, Cezary Rojewski <cezary.rojewski@intel.com>, 
	Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, Nathan Chancellor <nathan@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Zhaoyang Huang <zhaoyang.huang@unisoc.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Miguel Ojeda <ojeda@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	"Liam R. Howlett" <liam.howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Dan Williams <dan.j.williams@intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Yury Norov <yury.norov@gmail.com>, "Jason A . Donenfeld" <Jason@zx2c4.com>, 
	Sander Vanheule <sander@svanheule.net>, Eric Biggers <ebiggers@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 6:30=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
> On Thu, Feb 22, 2024 at 02:00:26PM +0100, Arnd Bergmann wrote:
> > On Thu, Apr 6, 2023, at 13:19, kernel test robot wrote:
> >
> > > If you fix the issue, kindly add following tag where applicable
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Link:
> > > https://lore.kernel.org/oe-kbuild-all/202304061930.4Au0PASm-lkp@intel=
.com/
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >>> ld.lld: error: undefined symbol: __fortify_panic
> > >    >>> referenced by fortify-string.h:208 (include/linux/fortify-stri=
ng.h:208)
> > >    >>>               arch/arm/boot/compressed/fdt_ro.o:(fdt_stringlis=
t_count)
> > >    >>> referenced by fortify-string.h:208 (include/linux/fortify-stri=
ng.h:208)
> > >    >>>               arch/arm/boot/compressed/fdt_ro.o:(fdt_stringlis=
t_search)
> > >    >>> referenced by fortify-string.h:208 (include/linux/fortify-stri=
ng.h:208)
> > >    >>>               arch/arm/boot/compressed/fdt_ro.o:(fdt_stringlis=
t_get)
> >
> > I get a related build failure from the same commit:
> >
> > arch/arm/boot/compressed/misc.c:157:6: error: no previous prototype for=
 '__fortify_panic' [-Werror=3Dmissing-prototypes]
> >   157 | void __fortify_panic(const u8 reason, size_t avail, size_t size=
)
>
> Whoops, thank you! This series got a refresh after you did the
> missing-prototypes work and I missed this one. I've fixed it and
> double-checked for any others. Hopefully this will be clean in the next
> -next. :)

Thank you! (FWIW, I also hit it today)

--=20
With Best Regards,
Andy Shevchenko
