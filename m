Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ACEC61DA4
	for <linux-hardening@archiver.kernel.org>; Sat, 18 Mar 2023 18:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjCRSUr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 18 Mar 2023 14:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCRSUq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 18 Mar 2023 14:20:46 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291352658F
        for <linux-hardening@vger.kernel.org>; Sat, 18 Mar 2023 11:20:44 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ek18so32213267edb.6
        for <linux-hardening@vger.kernel.org>; Sat, 18 Mar 2023 11:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679163642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mx8RcyjGbjYoysYjRF/7k04CTiu60fPMXIq+lfuhvoc=;
        b=GSVq3SAexOdrfRpr8pgBOVOY1K+cQz+mYk43CQNULEEJm/1Wkhzv9y6HgJHafUWmoA
         s6LlaMZA3N/JBMhIi2+cakEz1grpwYV6k05OkkKXOqy0eRjrdUzh1otqrXWtMYSK7Tpb
         2ZQOp0EjSCXLZJFKDd+gEXzRIM74oSERxyAFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679163642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mx8RcyjGbjYoysYjRF/7k04CTiu60fPMXIq+lfuhvoc=;
        b=64lewtDHXyLmo6Q/4/k42LNEhN7Jd73gv1NY8/W4WpCZ3ADBXtGm1gl6V0floyFUmz
         8qMEWRty9WItxsmlX5mV/Od4tSssftHwbcbSlIxU/lwmv3SMrKa6SGFvFBs/4ZmxHRow
         41k42qplUcKna6pBRP79aT+W2Kwk8QKiISu01GztAC9IJQrXFPSAA00Oo5yuIz/JHzc+
         OupqbdFMGk9AwgzDrEybWvsA1a+2RgJkB5xFspuvPf79ZeMKhRod9Nul6eI5E3O62taM
         E5B4TGhV6RgdqRIqaqWKkQkyfqPmARiSY6tOQ+c4Z+/WETKbgD3EQKxN9mGrhBPCFVNy
         k09g==
X-Gm-Message-State: AO0yUKW6frw24SOFTyHpddae9ne7d66hMBSRpQoL8WpHN3S+bwkdOwgD
        gigI3Z/M08RKIwWUt/ZyBiFnLqC/5e7vqfNZCtu6Cg==
X-Google-Smtp-Source: AK7set/GoPrVX+s2fX9dA5VdIq5P/LNuEBX3QuXoRTha7ZF+d0iDfdFoTCF65TZ70Ty2dF/OGJs5bQ==
X-Received: by 2002:a17:907:2113:b0:878:72f7:bd99 with SMTP id qn19-20020a170907211300b0087872f7bd99mr3416919ejb.6.1679163642491;
        Sat, 18 Mar 2023 11:20:42 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id w11-20020a1709067c8b00b009231714b3d4sm2372656ejo.151.2023.03.18.11.20.39
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Mar 2023 11:20:40 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id r11so32229910edd.5
        for <linux-hardening@vger.kernel.org>; Sat, 18 Mar 2023 11:20:39 -0700 (PDT)
X-Received: by 2002:a50:ce54:0:b0:4fa:794a:c0cc with SMTP id
 k20-20020a50ce54000000b004fa794ac0ccmr3796617edj.2.1679163639042; Sat, 18 Mar
 2023 11:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <9d0ef355-f430-e8e2-c844-b34cfcf60d88@kernel.dk>
 <CAHk-=wgcYvgJ5YWJPy6PA-B_yRtPfpw01fmCqtvqGN9jouc_8w@mail.gmail.com>
 <CAKwvOdmJkQUe6bhvQXHo0XOncdso0Kk26n8vdJZufm4Ku72tng@mail.gmail.com>
 <6414c470.a70a0220.6b62f.3f02@mx.google.com> <CAHk-=wi5yk0+NeqB34fRC-Zvt+8QZVPTiny9MvCxxjg+ZqDhKg@mail.gmail.com>
 <CANiq72m46OzQPtZbS_VaQGgGknFV-hKvhBw8sVZx9ef=AzupTQ@mail.gmail.com> <CAHk-=wgTSdKYbmB1JYM5vmHMcD9J9UZr0mn7BOYM_LudrP+Xvw@mail.gmail.com>
In-Reply-To: <CAHk-=wgTSdKYbmB1JYM5vmHMcD9J9UZr0mn7BOYM_LudrP+Xvw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Mar 2023 11:20:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiYUWaa676WN5hoyarKeKFDq3nfPg0haRRXeirtHyMg=A@mail.gmail.com>
Message-ID: <CAHk-=wiYUWaa676WN5hoyarKeKFDq3nfPg0haRRXeirtHyMg=A@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 6.3-rc3
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "HeungJun, Kim" <riverful.kim@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mauro Carvalho Chehab <mchehab@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Mar 17, 2023 at 1:51=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I do think that on the kernel side, the fix is to just change
>
>         } while (type++ !=3D SIZE_DEFAULT_FFMT);
>
> to
>
>         } while (++type !=3D SIZE_DEFAULT_FFMT);

Ok, I ended up deciding to just commit that minimal change, even
though it might have been better to just make it a normal for-loop
(and use M5MOLS_RESTYPE_MAX instead as the end condition).

So maybe it would be more legible (and less likely to have had that
off-by-one) if the loop had been

        for (type =3D 0; type < M5MOLS_RESTYPE_MAX; type++)

instead. But I'll leave that decision to the driver authors (now cc'd).

For people brought in late, this is now commit efbcbb12ee99 ("media:
m5mols: fix off-by-one loop termination error") with link to the
discussion here

    https://lore.kernel.org/linux-block/CAHk-=3DwgTSdKYbmB1JYM5vmHMcD9J9UZr=
0mn7BOYM_LudrP+Xvw@mail.gmail.com/

so you can see the history of it (me having initially blamed UBSAN,
but the problem can be triggered at least in theory without it).

                  Linus
