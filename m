Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ldrO/XOw"
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50321B1
	for <linux-hardening@vger.kernel.org>; Tue,  5 Dec 2023 14:15:07 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-33350fcb2c7so103519f8f.2
        for <linux-hardening@vger.kernel.org>; Tue, 05 Dec 2023 14:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701814506; x=1702419306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DD0DNj25uBQ/C17oozD5v/SE0XLXNTxkbhUNY2hqqrE=;
        b=ldrO/XOwjHG4NlObybD1T3211udZtIX/tDNFD/piT/AP0GDM1xWEGR0fa/dHGc8aM5
         JVDo6gwVV08L8Lr7x3ZAogx3GCdZO9WKx+viltHtZeoC83twY1YdyuBXzJbsLYPPb3wi
         ss4uAibjvdpjfj2WMCR7/ZfqIPoHSfyinM6Dej8SZ4daIfadWQ0oefYHDokFSiHylgRv
         qHr/UgQYR+Zy7EcKlcf/TbmttJKHj0RVZZV/a3s7H0s69JFO6IbrTsx/ajZudQ0+EbNx
         dkhBCD0ViB5JNduxBU+Hw8xjBliYME728gTgNdlma/6qiZEwMiuxTD3DeQbA8KxtZeAN
         As3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701814506; x=1702419306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DD0DNj25uBQ/C17oozD5v/SE0XLXNTxkbhUNY2hqqrE=;
        b=GVk8XKPPpzQ2g+FrI6R3sJsnV04P+BqBlMKznOOzheW5pXeMTegpTtp+ANaZhuuxPY
         X/xJSDaOkqCzDhXo2OGQTKkq8LpH8XDEvcsc9wYXL0aWSfSggOi4gNpPueLMQUhWIFHY
         WUYf3rxHC2vPjpMEhB+TkX9uRAquDmOzcrQFHLEeBvWwMsMqD2tN4ptukbGSkkKCmuWs
         4dzZO6HbU2v6qfIJyk9QDSLGlh5v3rRLIEYn5Qes6bQph+j/7fKK3btOKWUC3dRRqaeZ
         w0ehki81vE285IMaFZ/Z3+ajE5UuHVXaAi1OXUmsP4j5fNMvhz6wI1M7PeF0STsUwj2z
         Ndww==
X-Gm-Message-State: AOJu0YzTaj73Ke4aGf4Z92hosHvwKP8kY3xUfF0UD3gOfnhnPX5+O1OJ
	Ni0CBQq/lC+5un/Rlw93Pcx6jA+Qj0FCKLX9M/mGaw==
X-Google-Smtp-Source: AGHT+IEIuFKrkoFvYNzPlxheppKvhm+ftQtjTc7AwFMq9skdDpEb1ZX2PjA9ALQOqeclZUUHHQS+hx4qWH0scPlWAGg=
X-Received: by 2002:adf:f18f:0:b0:32f:7c6c:aa14 with SMTP id
 h15-20020adff18f000000b0032f7c6caa14mr6218857wro.37.1701814506175; Tue, 05
 Dec 2023 14:15:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205213807.GE1674809@ZenIV> <CAKwvOd=2VASkaLvjU+7kkbvhu2CimYn5KUGJBDRePyUhtrNK2Q@mail.gmail.com>
 <2023120608-ivy-snowdrop-890d@gregkh>
In-Reply-To: <2023120608-ivy-snowdrop-890d@gregkh>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 5 Dec 2023 14:14:55 -0800
Message-ID: <CAKwvOdmFJ=ZGN8ZScS5oQpXnAL0wwtTDCeNNGpBKZXzQ4kRAVA@mail.gmail.com>
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
To: Greg KH <greg@kroah.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, tanzirh@google.com, 
	Kees Cook <keescook@chromium.org>, Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick DeSaulniers <nnn@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 1:59=E2=80=AFPM Greg KH <greg@kroah.com> wrote:
>
> On Tue, Dec 05, 2023 at 01:51:10PM -0800, Nick Desaulniers wrote:
> > On Tue, Dec 5, 2023 at 1:38=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk=
> wrote:
> > >
> > > It also breeds includes of asm/*.h, by the look of the output, which =
is
> > > not a good thing in general ;-/  E.g. #include <asm/uaccess.h> *anywh=
ere*
> > > outside of linux/uaccess.h is a bad idea.
> >
> > It's not clear to me when it's ok to #include <asm/*.h>.  Is there a
> > convention here that I'm missing?
>
> General rule, NEVER include asm/*.h, there should be a include/*.h
> instead that works.  So much so that checkpatch.pl should catch this,
> right?

ah, shoot, I was showing Tanzir how to use `b4` for patch development,
and forgot to check this.  Indeed it does.

I can see how the check works (scripts/checkpatch.pl L5881).  Decoding
that will probably help us improve the tooling.

>
> But of course, it doesn't always hold true, there are a few minor
> exceptions, but they are rare.

$ grep -r \\#include lib | grep asm

shows quite a few exceptions, and just in lib/.

For example, lib/math/int_log.c includes asm/bug.h.  Is that a case
where lib/math/int_log.c should be #include 'ing linux/bug.h rather
than asm/bug.h?
--=20
Thanks,
~Nick Desaulniers
