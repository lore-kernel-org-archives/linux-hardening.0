Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CEDC433F5
	for <linux-hardening@archiver.kernel.org>; Sun, 13 Feb 2022 02:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbiBMCcU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 12 Feb 2022 21:32:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiBMCcT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 12 Feb 2022 21:32:19 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8934A5FF2F
        for <linux-hardening@vger.kernel.org>; Sat, 12 Feb 2022 18:32:13 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id i10so183971plr.2
        for <linux-hardening@vger.kernel.org>; Sat, 12 Feb 2022 18:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=684CqHNwxeeFLDieT+hnImprW0dvEy16HRmo/OqQ8xM=;
        b=2/eyFc1PS/DG76NEKk8T151hYk/zKSztRGlztHd6pc0aK7ITJTn2hnlBYUh4LfTu8N
         NzDHhflNWPpKnwjtmTIem29YuUXO8HGI6pGiua3Ht1aD51mkr0XaB+i7i8B1y+C2wLN4
         Gp0235f94zC/e+/VEY+aBGx7k5zK86/Q+rcv90U55I3yFunbLBqcm0P9PrIuUTs3WvkX
         xyWMflfEMQ89O1RPyHPWwnySFALCgg9m+jmk6128At2dw8WD6TrfQsPHvsXgBmQ2WI9/
         79XVmkOmcqEpAwgWU8r91cFOXXgtjCZPRK+cMrdnbAEp+PQ99Ak114iATUTAyY2sx7Qv
         ELKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=684CqHNwxeeFLDieT+hnImprW0dvEy16HRmo/OqQ8xM=;
        b=0VyAWfQDizrHS3zSETttoOBtngg54ztjbOv3rzr8hFEPVeFC6jz4zc8i3N3s8FxbUh
         rMRRB8sJInX48pZR7SCh+LfFsj4kQQU8keMtD4gNi1NU6Wbg8w9y889QN8QQm19dRkJ3
         nd6zGQGVJm772HHn+QEbqd1I1tFuiHV+vt6FtD8FGPFdQB2Kfut50Ue/WPvIcib/Pv/u
         dF5DV5PBaqHbYz3RjI7eO89k9qfXjCQVEK3w2p+9XLbcV27PxHGBv/ZPoabgeNRBS1DE
         WOIQSoW9rN8m9jpdjBoi5/TjuoGjSRU5esRl3/+fnTQm9NpvT5CYPw1GhUIErkIeng4b
         8vpA==
X-Gm-Message-State: AOAM533ieBDNG0PTU3VlTtCg1Pgq/0ISSm36pdQrH1lk+dQGZ98Hmn2E
        0/jAXlwckPkpWYEMerB2x9JcXbGYlJqaQw==
X-Google-Smtp-Source: ABdhPJyO3PZGcWVStExkJGBmRqNZ3FSI0hCXzWP8s9q//C22gfxpdpkBR42a4pFeBrtu1+7v3NVK6A==
X-Received: by 2002:a17:90a:9704:: with SMTP id x4mr7680500pjo.219.1644719532927;
        Sat, 12 Feb 2022 18:32:12 -0800 (PST)
Received: from smtpclient.apple ([2600:1010:b021:31a8:38de:7526:b98f:ba7b])
        by smtp.gmail.com with ESMTPSA id 16sm20612051pfm.200.2022.02.12.18.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Feb 2022 18:32:12 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC] Get siginfo from unreaped task
Date:   Sat, 12 Feb 2022 18:32:08 -0800
Message-Id: <CF5167CE-FA1C-4CEC-9EA8-5EE8041FE7C4@amacapital.net>
References: <CAP145phC6S6Zda-ZWLH1s4ZfDPh79rtf_7vzs-yvt1vykUCP4A@mail.gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Will Drewry <wad@chromium.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <CAP145phC6S6Zda-ZWLH1s4ZfDPh79rtf_7vzs-yvt1vykUCP4A@mail.gmail.com>
To:     =?utf-8?Q?Robert_=C5=9Awi=C4=99cki?= <robert@swiecki.net>
X-Mailer: iPhone Mail (19C63)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


> On Feb 12, 2022, at 3:24 AM, Robert =C5=9Awi=C4=99cki <robert@swiecki.net>=
 wrote:
>=20
> =EF=BB=BFsob., 12 lut 2022 o 05:28 Kees Cook <keescook@chromium.org> napis=
a=C5=82(a):
>>=20
>> Make siginfo available through PTRACE_GETSIGINFO after process death,
>> without needing to have already used PTRACE_ATTACH. Uses 48 more bytes
>> in task_struct, though I bet there might be somewhere else we could
>> stash a copy of it?
>=20
> An alternative way of accessing this info could be abusing the
> waitid() interface, with some additional, custom to Linux, flag
>=20
> waitid(P_ALL, 0, &si, __WCHILDSIGINFO);
>=20
> which would change what is put into si.
>=20
> But maybe ptrace() is better, because it's mostly incompatible with
> other OSes anyway on the behavior/flag level, while waitd() seems to
> be POSIX/BSD standard, even if Linux specifies some additional flags.
>=20
>=20

I had a kind of opposite thought, which is that it would be very nice to be a=
ble to get all the waitid() data without reaping a process or even necessari=
ly being its parent.  Maybe these can be combined?  A new waitid() option li=
ke you=E2=80=99re suggesting could add siginfo (and might need permissions).=
  And we could have a different waitid() flag that says =E2=80=9Cmaybe not m=
y child, don=E2=80=99t reap=E2=80=9D (and also needs permissions).

Although the =E2=80=9Cdon=E2=80=99t reap=E2=80=9D thing is fundamentally rac=
y. What a sane process manager actually wants is an interface to read all th=
is info from a pidfd, which means it all needs to get stuck in struct pid. A=
nd task_struct needs a completion or wait queue so you can actually wait for=
 a pidfd to exit (unless someone already did this =E2=80=94 I had patches a w=
hile back).  And this would be awesome.=
