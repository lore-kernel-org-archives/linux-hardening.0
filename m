Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371E4EB64D9
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Jun 2023 00:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjF1AVS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 27 Jun 2023 20:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjF1AVR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 27 Jun 2023 20:21:17 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88892716
        for <linux-hardening@vger.kernel.org>; Tue, 27 Jun 2023 17:21:15 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5700b15c12fso54347877b3.1
        for <linux-hardening@vger.kernel.org>; Tue, 27 Jun 2023 17:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1687911674; x=1690503674;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcaDa6W6WP89z4qNOjx+aoveTbeKQkmZrfgEbjf/kOw=;
        b=Sjiyt5ZEmgyo0bCjrWHDYw+D5cIKyOyyOTbyJxE6Qu9YOsYz457EfjSW6xBV+ntTa5
         8T1yQ7WqCOkwQJ3INqczJMTAtz6crYA05sk1HqULsRKaV2Sj0buXFXtA9oRZkLkyP1+L
         LZwY2Yh87+d8ZHYnI2buK8M6wczvBEAeK/GUeuV/Cl1hs09MvIE4kyml9l1QrV9ox3nL
         98JbtOY2KUV5HyQUTTela8g20oIIxUkahCaR28xhra65Yg1VOF/Z9dx0b/FKnWmI6l/U
         Q1vtIxTz2ROHfL3SlJ16I2imJduboSBepdOsr4aCBBhFM2hZQacH+hv+yLvPT2NU5Ua9
         wOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687911674; x=1690503674;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcaDa6W6WP89z4qNOjx+aoveTbeKQkmZrfgEbjf/kOw=;
        b=K9tfqyB4o+6H7kesTtASOwIfon2lVn1ElZDFCn2wyVrmv7KUtKpt5AAuh5bSgKNamj
         YDTTV3QXV+hOA0LSxF6SXxyRVMiZS4MooA3rRl5PJftZJUek8UqDuCIkqyH5f2dRdPMK
         21DKiDWIkbr+zZPIZffXBndBB3lyfn+vERTqy15GuHhk+4SVUz41mb0kyQRuSnhuhKlW
         4WOiCpGz3uXWFMnyWg+ze4M740lpWEXTqlXLj2eOR2r8QQcAYN4P4TTa1VE+FXDyjIu3
         XGkw48WylsMs0NKKug0c6Fa5DNT2+oBECBYSiQtwGL1fcLTg7NdTow79daZIutBVTrmN
         Xicg==
X-Gm-Message-State: AC+VfDzk8IFCNJmpj3KLdHW477kTSBgkh3/6ZEe1Y+/BkI9kjPQikKW0
        9ra2IRuC1PGpTLIJEqouyHIp6WbugSMb5XZjSRru
X-Google-Smtp-Source: ACHHUZ7r5LudDYQpLJkHN8R/+TVzZHocys370y7pm5ef5mP5GMOyfydAY2Il848iqMMnU/cUH2l+Q1fXn/YLegWUgtk=
X-Received: by 2002:a81:7204:0:b0:568:be91:c2b1 with SMTP id
 n4-20020a817204000000b00568be91c2b1mr37444410ywc.9.1687911673797; Tue, 27 Jun
 2023 17:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221022182828.give.717-kees@kernel.org> <20221022182949.2684794-2-keescook@chromium.org>
 <20221227234000.jgosvixx7eahqb3z@begin> <C95AF535-7A95-48BA-8921-1932C15A1931@kernel.org>
 <20221228205726.rfevry7ud6gmttg5@begin> <20230625155625.s4kvy7m2vw74ow4i@begin>
 <20230627215021.ajwlckics4ssquit@begin>
In-Reply-To: <20230627215021.ajwlckics4ssquit@begin>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Jun 2023 20:21:03 -0400
Message-ID: <CAHC9VhQzSSV30nDpq2q3pNjLDygu_aAsQWiNWuGBB0bphc9kBA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] tty: Allow TIOCSTI to be disabled
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Kees Cook <kees@kernel.org>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Dave@mielke.cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jun 27, 2023 at 5:50=E2=80=AFPM Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
> Samuel Thibault, le dim. 25 juin 2023 17:56:25 +0200, a ecrit:
> > Samuel Thibault, le mer. 28 d=C3=A9c. 2022 21:57:26 +0100, a ecrit:
> > > Can we perhaps just introduce a CAP_TIOCSTI that the brltty daemon wo=
uld
> > > be able to use? We could even make it only allow TIOCSTI on the linux
> > > console (tty->ops =3D=3D con_ops).
> >
> > *Please* comment on this so we can progress. ATM people are
> > advising each other to set dev.tty.legacy_tiocsti=3D1, which is just
> > counter-productive in terms of security...
>
> People are even discussing adding that configuration to the brltty
> package, which e.g. on ubuntu is installed by default, and thus
> defeating completely the security measure by default...
>
> Please do contribute to the discussion so we can fix this.

Hi Samuel,

I'm sorry to hear that this is impacting Braille terminals, but I do
believe there are solutions in place which would allow affected users
to re-enable TIOCSTI system-wide via the sysctl and then selectively
allow access to the terminal applications.  However, I do believe they
would all require some additional work on the distro/user's part if
the user didn't want to continue to allow system-wide access to
TIOCSTI.

The first thing that comes to mind is an Android-esque filtering that
Kees already mentioned in the commit itself.  I'm not an Android
expert, but based on the linked "ioctl_macros" file in the Android
source, it looks like Android is leveraging the SELinux ioctl extended
permission functionality to limit access to TIOCSTI.  I'm not sure
what experience you have with SELinux, but if you have some
understanding of SELinux policy the documentation below might help you
get started playing with this:

* https://github.com/SELinuxProject/selinux-notebook/blob/main/src/xperm_ru=
les.md

Another option to restrict TIOCSTI once it has been re-enabled
system-wide would be to leverage seccomp to block `ioctl(..., TIOCSTI,
...)`.  Sadly, I don't think one would be able to use systemd's
existing seccomp filtering as it doesn't support syscall parameters,
but I imagine with some work one could add some ioctl smarts to the
systemd seccomp code and/or use an existing seccomp sandboxing tool to
effectively remove TIOCSTI.  Using libseccomp, a simple filter would
look something like this (untested pseudocode, you've been warned):

  ctx =3D seccomp_init(SCMP_ACT_ALLOW);
  seccomp_rule_add(ctx, SCMP_ACT_ERRNO(EIO), SCMP_SYS(ioctl), 1,
SCMP_A1(TIOCSTI));

I'm sure there are some other good ideas that aren't coming to mind
right now, but I tend to think that the solutions to this are going to
be up in userspace.

--=20
paul-moore.com
