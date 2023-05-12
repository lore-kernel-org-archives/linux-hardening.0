Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3E6C77B7C
	for <linux-hardening@archiver.kernel.org>; Fri, 12 May 2023 06:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjELGQp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 12 May 2023 02:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjELGQo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 12 May 2023 02:16:44 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32FF125
        for <linux-hardening@vger.kernel.org>; Thu, 11 May 2023 23:16:42 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ad714536cfso73758341fa.0
        for <linux-hardening@vger.kernel.org>; Thu, 11 May 2023 23:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683872201; x=1686464201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQ77bbYOBWbR7855TOK9Zt3KrUSpo4NHUCHmgDZJ62g=;
        b=bgpGGfeumObtoP7a/yB2giMOv9pHEzoAkvIbr/h8DJKZp4A37byiGtjyf8SmVR5ZgI
         5KBM+r/oiJQDUgrXZfg6mWGiqVZgBwkJPdXowy3dGTjk03/mIR7KtQEFo6j4S90Ygn20
         p/BWUPicfqIMynVsqfTcHoYmXJ/yaNnLiLJnPhyxtFY/PqXKHjPwkTR+EKzQObHElcaa
         9o0XeE3cO8m6ECwl8VEXma/uFQ+3Zug7n2kS/g1SrA5sOAjHpDhcYD4zT8603ZqpX+4w
         XW1HLA79sQVhqhnJEfcy1/9+Pl5QdCmMyElnPU/Lwa3zAm21k69KYFbWSc+TlADaZBqc
         ZW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683872201; x=1686464201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQ77bbYOBWbR7855TOK9Zt3KrUSpo4NHUCHmgDZJ62g=;
        b=gUXMo96ho6rVk1oLWD4AwPjUQno+mhb/MJ5wd/u7FecV17xI5sFEcgMa0T0MkSYvnU
         mOCuT/EuCahaR4z2lIe8N4REm9A8XGk4pWmq0bghRjF6F+JSJsPvho7KcuoKkVeXAkOs
         aeehHytHMO0Ry3qOsHw28p7PQFjcAdjrXznXxzYjTVytse/E9hXhaM7yvqJyXBpUeyCf
         ybfXplsdo3KdcfeIbvsKhwQiEa/70Sa2edIrlb8EwGZRPMh9X3U817MRSFtmSBOzGzu0
         hbDjcxa3JrXVEDfr4Oj76eXMtyCFWo+ANa3DZUrEcwzZuY+mWmvdleLfr1XqriJxvKOh
         IeEA==
X-Gm-Message-State: AC+VfDw/ZMcwFAlGukDZCkPF5psrPfcdq7XvjfJt0fxV0vY8i1rZxPW4
        oeBpC9i/qlK7M03BR7/AcX5FXe8V4rK9zz0Rh4g=
X-Google-Smtp-Source: ACHHUZ5plYpWjO+/pyDX4RwMVfN3iwmYFpQptQPC23Uer5jM/pVdRAQPSCrtf/r5JHqVL3kPDNSxlPFfsuPX+PMLV/E=
X-Received: by 2002:a05:651c:82:b0:2a8:ba49:a811 with SMTP id
 2-20020a05651c008200b002a8ba49a811mr3547726ljq.25.1683872200850; Thu, 11 May
 2023 23:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <ac2550e0-2f5c-3680-08e6-0c224d043036@gmail.com>
 <44940599-7b43-99f6-5b09-4f050d645c7b@gmail.com> <202305111158.C78642624@keescook>
 <74ee73d2-04e-ea8-9430-93929446e925@codesourcery.com> <202305111410.CFE0875F@keescook>
In-Reply-To: <202305111410.CFE0875F@keescook>
From:   Richard Biener <richard.guenther@gmail.com>
Date:   Fri, 12 May 2023 08:16:28 +0200
Message-ID: <CAFiYyc1JRm6gm8aw2ZQmcycN3AF3hu5wjwGeUgDCN6gRN7UbbA@mail.gmail.com>
Subject: Re: [wish] Flexible array members in unions
To:     Kees Cook <keescook@chromium.org>
Cc:     Joseph Myers <joseph@codesourcery.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        GCC <gcc@gcc.gnu.org>, Alejandro Colomar <alx@nginx.com>,
        Andrew Clayton <a.clayton@nginx.com>,
        Andrew Clayton <andrew@digital-domain.net>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, May 11, 2023 at 11:14=E2=80=AFPM Kees Cook via Gcc <gcc@gcc.gnu.org=
> wrote:
>
> On Thu, May 11, 2023 at 08:53:52PM +0000, Joseph Myers wrote:
> > On Thu, 11 May 2023, Kees Cook via Gcc wrote:
> >
> > > On Thu, May 11, 2023 at 06:29:10PM +0200, Alejandro Colomar wrote:
> > > > On 5/11/23 18:07, Alejandro Colomar wrote:
> > > > [...]
> > > > > Would you allow flexible array members in unions?  Is there any
> > > > > strong reason to disallow them?
> > >
> > > Yes please!! And alone in a struct, too.
> > >
> > > AFAICT, there is no mechanical/architectural reason to disallow them
> > > (especially since they _can_ be constructed with some fancy tricks,
> > > and they behave as expected.) My understanding is that it's disallowe=
d
> > > due to an overly strict reading of the very terse language that creat=
ed
> > > flexible arrays in C99.
> >
> > Standard C has no such thing as a zero-size object or type, which would
> > lead to problems with a struct or union that only contains a flexible
> > array member there.
>
> Ah-ha, okay. That root cause makes sense now.

Hmm. but then the workaround

struct X {
  int n;
  union u {
      char at_least_size_one;
      int iarr[];
      short sarr[];
  };
};

doesn't work either.  We could make that a GNU extension without
adverse effects?

Richard.

> Why are zero-sized objects missing in Standard C? Or, perhaps, the better
> question is: what's needed to support the idea of a zero-sized object?
>
> --
> Kees Cook
