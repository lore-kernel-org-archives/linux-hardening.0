Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B071C433DB
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Mar 2021 09:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07AAB64E81
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Mar 2021 09:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhCRJIj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 18 Mar 2021 05:08:39 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:42062 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhCRJIa (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 18 Mar 2021 05:08:30 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 12I985xV022630;
        Thu, 18 Mar 2021 18:08:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 12I985xV022630
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1616058486;
        bh=DMeyXHmm9SwBy+TWjB+RHjym33sbRva0yUXx5ZZSrNA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wr55UlROohtEYkPVNv66reXFMYmlAGsxY+mM0TSJqeplwE2aUxHwiJCGj8ePKQyUH
         SNgAV2jp9f+/Yezsc6uBPoVVXJXxO1UysKdDt0tUqSV7GUNwU3cQ/1425o8ed2Cszg
         x8R5+otBhlC6DatIJ4wqWf1vNNV1oU8T6lwtfMw9EmYauQinBtQQz6JlYwOL6fQgyk
         hFzKxfbpgHxwR67Sh4n/IDKKuZJey+Nv0M11KGMzo4iVjWm7Ubgo80I7xp4Z184LEt
         j/psHBNNffutpFY4fHUXIfbJ7f1BGtFlyxLzahUk6ufJGred8YwkPc0p1x9zOWnIuO
         qCeu5m1sDH4nA==
X-Nifty-SrcIP: [209.85.216.44]
Received: by mail-pj1-f44.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so2391351pjb.4;
        Thu, 18 Mar 2021 02:08:05 -0700 (PDT)
X-Gm-Message-State: AOAM530nncarkHreAqipQkQgnhRCq4Reny7b2wMek0egWyTuTaqSqLQM
        wmZJvQEZgppz0bhLyHiYLteQb57KSuX8mFFcEps=
X-Google-Smtp-Source: ABdhPJxmd/havMv4p1hMyKAmb2uXCRxKdpPHyNkl56QXLWzIZG7cyLqcqtIH4OVxU9nfaTQnvC4NYLWYALiPIK1kxhU=
X-Received: by 2002:a17:90a:3b0e:: with SMTP id d14mr3355489pjc.198.1616058484971;
 Thu, 18 Mar 2021 02:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <279558.1615192821@turing-police> <202103172251.F9D770D@keescook>
 <282490.1616047333@turing-police> <CANiq72nyNSgrM6bhmM7ymdtYYKoDLfUXfwgTwLOmhLFc=c0U-w@mail.gmail.com>
In-Reply-To: <CANiq72nyNSgrM6bhmM7ymdtYYKoDLfUXfwgTwLOmhLFc=c0U-w@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 18 Mar 2021 18:07:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT_hp0PmhWpb2=fScw6Q9DQsBztykis=xN0QCH==AVY6g@mail.gmail.com>
Message-ID: <CAK7LNAT_hp0PmhWpb2=fScw6Q9DQsBztykis=xN0QCH==AVY6g@mail.gmail.com>
Subject: Re: [PATCH RESEND] gcc-plugins: avoid errors with -std=gnu++11 on old gcc
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Mar 18, 2021 at 3:26 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Mar 18, 2021 at 7:03 AM Valdis Kl=C4=93tnieks
> <valdis.kletnieks@vt.edu> wrote:
> >
> > Or declare that gcc6 is the minimum for building the kernel.
>
> Cc'ing some interested people in raising GCC's version for one reason
> or another, so that we put this as another one in the pile of reasons
> :-)
>
> https://lore.kernel.org/lkml/CAHk-=3Dwjgvt1Ei72BTrEH5fgfqykVH-AYt56-7yBT8=
Lcprj7bEg@mail.gmail.com/
>
> Cheers,
> Miguel


Previously we were discussing raising the min GCC
version 5.x,  but not further at this point of time.


We can require GCC 6+ for building GCC plugins.


--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@ -8,7 +8,7 @@ config HAVE_GCC_PLUGINS
 menuconfig GCC_PLUGINS
        bool "GCC plugins"
        depends on HAVE_GCC_PLUGINS
-       depends on CC_IS_GCC
+       depends on CC_IS_GCC && GCC_VERSION >=3D 60000
        depends on $(success,test -e $(shell,$(CC)
-print-file-name=3Dplugin)/include/plugin-version.h)
        default y
        help





BTW, the commit message mentions that
the issues only happen on GCC 4 and 5,
but the added code was:

GCC_FLAVOR =3D $(call cc-ifversion, -ge, 1100, 11, 98)

  instead of

GCC_FLAVOR =3D $(call cc-ifversion, -ge, 600, 11, 98)



So, this patch is also requiring to cover two standards:

GCC_VERSION >=3D 11  :  -std=3Dgnu++11
GCC_VERSION <  11  : -std=3Dgnu++98




--=20
Best Regards
Masahiro Yamada
