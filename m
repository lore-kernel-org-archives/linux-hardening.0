Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEA1C001B0
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Aug 2023 19:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjHJT6I (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Aug 2023 15:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjHJT6I (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Aug 2023 15:58:08 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF29CE7F
        for <linux-hardening@vger.kernel.org>; Thu, 10 Aug 2023 12:58:07 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bba48b0bd2so9943255ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 10 Aug 2023 12:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691697487; x=1692302287;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GrzpUIYsNReqF6Vjt7YeuyI+AzdvZwRKw+lBcbw3/VE=;
        b=AIGXxuzPsRszEV5Gyhfusxvte6pg5BONip5dTyc5hhzjXpSNO57GWCQT96ebiABjYS
         8/90fFkIVa2FauB47bAOXuu10ZTR9hxBnVQranwCf2+5kEWBpjY2oSyb6xRiXaeGQZ18
         GgxdUjnPTWhQzCQjPexgwl6fmEz94SHJUcsVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691697487; x=1692302287;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GrzpUIYsNReqF6Vjt7YeuyI+AzdvZwRKw+lBcbw3/VE=;
        b=cP0ES7h/IZUgabgGXm3dmXFa8UUVZu3lNsGUSYqdc4IjgleSxVaIkA2DBF0rGFg0dN
         83NjH52JqgL5njv1687DeFY1BN5d8aHAaG/JJz1C2u5LCM0/caViJfHtkeJ1NQhhZk9s
         pAv70mkdmEI3FqF+41ySY/Xg30hZ0fF0VKQcXofQ8BTVOEZhK65LLn+8btKyUtaXVnm6
         rouqySDmnDkuKd7pIDwh64wJTFcTFUE/7edE6l4PzSTvTIeg5bIvTJrv2N1ZGVOLPAmJ
         JWeX2iMaeSpiCEWHUiw35xSm9qH543jSNF9NdcF8V6mPF7uLrpVZIKykUw+moKyUU7PI
         8dgQ==
X-Gm-Message-State: AOJu0Yz2kbk7OHt5GYWitHwj31MT2fM4CK8LhN6VvDGogrdnKcfLs476
        R7BIlJw3RFTNZ4Us15PjyGyVwQ==
X-Google-Smtp-Source: AGHT+IFrQQ+KCWzwjasCjLqDeaFB7YOqF1dDdtbZZXKcKKDFCgxX4Wc6XAZFk5pk13f92S/nfnkDvQ==
X-Received: by 2002:a17:903:247:b0:1bb:b86e:8d60 with SMTP id j7-20020a170903024700b001bbb86e8d60mr4103679plh.46.1691697487304;
        Thu, 10 Aug 2023 12:58:07 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902f54500b001a1b66af22fsm2166866plf.62.2023.08.10.12.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:58:06 -0700 (PDT)
Date:   Thu, 10 Aug 2023 12:58:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] arm64/sysreg: refactor deprecated strncpy
Message-ID: <202308101257.47E6ACBD5@keescook>
References: <20230810-strncpy-arch-arm64-v1-1-f67f3685cd64@google.com>
 <202308101155.81497C5B@keescook>
 <CAFhGd8rfKLY5KujEdvSnqv2MZFhTbEBo_bi7xVacY1pcBC1jRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8rfKLY5KujEdvSnqv2MZFhTbEBo_bi7xVacY1pcBC1jRg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 10, 2023 at 12:25:37PM -0700, Justin Stitt wrote:
> On Thu, Aug 10, 2023 at 12:00 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Aug 10, 2023 at 06:39:03PM +0000, Justin Stitt wrote:
> > > `strncpy` is deprecated for use on NUL-terminated destination strings
> > > [1]. Which seems to be the case here due to the forceful setting of `buf`'s
> > > tail to 0.
> >
> > Another note to include in these evaluations would be "does the
> > destination expect to be %NUL padded?". Here, it looks like no, as all
> > the routines "buf" is passed to expect a regular C string (padding
> > doesn't matter).
> >
> > >
> > > A suitable replacement is `strscpy` [2] due to the fact that it
> > > guarantees NUL-termination on its destination buffer argument which is
> > > _not_ the case for `strncpy`!
> > >
> > > In this case, there is some behavior being used in conjunction with
> > > `strncpy` that `strscpy` already implements. This means we can drop some
> > > of the extra stuff like `... -1` and `buf[len] = 0`
> > >
> > > This should have no functional change and yet uses a more robust and
> > > less ambiguous interface whilst reducing code complexity.
> > >
> > > Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> > > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> > > Link: https://github.com/KSPP/linux/issues/90
> > > Cc: linux-hardening@vger.kernel.org
> > >
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > > ---
> > > For reference, see a part of `strscpy`'s implementation here:
> > >
> > > |     /* Hit buffer length without finding a NUL; force NUL-termination. */
> > > |     if (res)
> > > |             dest[res-1] = '\0';
> > >
> > > Note: compile tested
> > > ---
> > >  arch/arm64/kernel/idreg-override.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
> > > index 2fe2491b692c..482dc5c71e90 100644
> > > --- a/arch/arm64/kernel/idreg-override.c
> > > +++ b/arch/arm64/kernel/idreg-override.c
> > > @@ -262,9 +262,8 @@ static __init void __parse_cmdline(const char *cmdline, bool parse_aliases)
> > >               if (!len)
> > >                       return;
> > >
> > > -             len = min(len, ARRAY_SIZE(buf) - 1);
> > > -             strncpy(buf, cmdline, len);
> > > -             buf[len] = 0;
> > > +             len = min(len, ARRAY_SIZE(buf));
> > > +             strscpy(buf, cmdline, len);
> >
> > This, however, isn't correct: "cmdline" will be incremented by "leN"
> > later, and we want a count of the characters copied into "buf", even if
> > they're truncated. I think this should be:
> >
> >                 strscpy(buf, cmdline, ARRAY_SIZE(buf));
> >                 len = strlen(buf);
> >
> Thoughts on using the return value from `strscpy` here?

This code seems to silently accept truncation, so -E2BIG will cause a
problem if it only looks at the return value.

-Kees

-- 
Kees Cook
