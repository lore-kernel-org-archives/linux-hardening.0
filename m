Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34425EE14D4
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Sep 2023 18:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241608AbjIFS2B (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Sep 2023 14:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238372AbjIFS2A (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Sep 2023 14:28:00 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2561610C8
        for <linux-hardening@vger.kernel.org>; Wed,  6 Sep 2023 11:27:57 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-414dff0a8ecso46661cf.0
        for <linux-hardening@vger.kernel.org>; Wed, 06 Sep 2023 11:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694024876; x=1694629676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrGg9NVcpdceTuuEZVHwG7gAd6aReinJXpTg+Gi7ctg=;
        b=mzl5Egp6UIY03zsAQ7XPU4ZI5FPG58m6Gfk/4wZC5tFR7wJ+f5GwwyZLxXX3Vmzukz
         wlMcnJL7RUGfD7iU6z43dzflvurgaz7lO9ECneNJohLFQN52o4XQfru1vVg7DmT/00bA
         8sLwayIhBl2YyBPoE28Hm5ll7+p+gdKalVnaTRIm6l+RRYXrRDhtqz3TtS//O7HDcwHk
         GM+3DRlna95vW2LyP5IKvCcCM3BA2WWHmwx0NnFLbbG0+gkZIyCBgGQXYUICSQmF7HYs
         aZFHaK8N4dAvVXA3D3cOBSvnvaFXrsSit6pCOdFt10Hq4qBGrBpm5gchRHMVoaae02Rt
         56hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694024876; x=1694629676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrGg9NVcpdceTuuEZVHwG7gAd6aReinJXpTg+Gi7ctg=;
        b=Art+WcfEXbcCBmUYiurae6IfD+UMkyAWSgrQZbmn6nPhzkOFCtJu+3QxLtdG0Unu2l
         o7V0XiKH/bffxyeWk6BImgGQsg2R3GNzPWJ9q50iQIQ7FwjVvfPRVZHC5fV9NUrrD86s
         a22OYhk83jtoFbYGovilSCr7wtE6Wc3KUVSmVwZVfqKBsWwKuV52ysQaETf/Wewyl2XW
         VMgyVq1mCKBej0FkEkMbWags54kyylGid+bOpgu537s++8yq9HNBnPCZ/hlJUeL32n6c
         Vje/ogtwRRuPudEIFNKntErWqWLVPhEYlEPAKzIkZBqNtjtioQ9PvxQxTBnpOxuJbiVs
         CQWA==
X-Gm-Message-State: AOJu0YzVZAr+nN22TeSAtj4h5FBPXzXRsunOlULaxntkcmTsHuCFsjU2
        1ZzpI5NJquNDHWun9JF/93TJ1mQu931U0Utl4Ab7iG4MAdq9aUKgGfPLtg==
X-Google-Smtp-Source: AGHT+IGfhsqbbGDD5lwj9bjClvIiOtUBeYARpoOKPx35Vis2UUsegJQmDLBEycqg/MKRy/f3hzjjEdT6fkYJQlZShf8=
X-Received: by 2002:a05:622a:4407:b0:403:f5b8:2bd2 with SMTP id
 ka7-20020a05622a440700b00403f5b82bd2mr13558qtb.9.1694024876090; Wed, 06 Sep
 2023 11:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230906175215.2236033-1-song@kernel.org> <202309061102.DB794AD295@keescook>
 <34CC4A68-CE36-4DE5-B1A1-AB7FD075C0EB@fb.com>
In-Reply-To: <34CC4A68-CE36-4DE5-B1A1-AB7FD075C0EB@fb.com>
From:   Fangrui Song <maskray@google.com>
Date:   Wed, 6 Sep 2023 11:27:44 -0700
Message-ID: <CAFP8O3+Rrs7rs5nO3cQbpeayE2vQXTmaaaEfY_weyCGCuBYrFQ@mail.gmail.com>
Subject: Re: [PATCH] x86/vmlinux: Fix linker fill bytes for ld.lld
To:     Song Liu <songliubraving@meta.com>
Cc:     Kees Cook <keescook@chromium.org>, Song Liu <song@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "x86@kernel.org" <x86@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Sep 6, 2023 at 11:16=E2=80=AFAM Song Liu <songliubraving@meta.com> =
wrote:
>
>
>
> > On Sep 6, 2023, at 11:06 AM, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Sep 06, 2023 at 10:52:15AM -0700, Song Liu wrote:
> >> With ":text =3D0xcccc", ld.lld fills unused text area with 0xcccc0000.
> >> Example objdump -D output:
> >>
> >> ffffffff82b04203:       00 00                   add    %al,(%rax)
> >> ffffffff82b04205:       cc                      int3
> >> ffffffff82b04206:       cc                      int3
> >> ffffffff82b04207:       00 00                   add    %al,(%rax)
> >> ffffffff82b04209:       cc                      int3
> >> ffffffff82b0420a:       cc                      int3
> >>
> >> Replace it with ":text =3D0xcccccccc", so we get the following instead=
:
> >>
> >> ffffffff82b04203:       cc                      int3
> >> ffffffff82b04204:       cc                      int3
> >> ffffffff82b04205:       cc                      int3
> >> ffffffff82b04206:       cc                      int3
> >> ffffffff82b04207:       cc                      int3
> >> ffffffff82b04208:       cc                      int3
> >>
> >> gcc/ld doesn't seem to have the same issue. The generated code stays t=
he
> >> same for gcc/ld.
> >>
> >> Cc: Kees Cook <keescook@chromium.org>
> >> Cc: x86@kernel.org
> >> Signed-off-by: Song Liu <song@kernel.org>
> >
> > Ah! Thanks for the catch... I wonder if ld.lld should be fixed too? My
> > understanding was that ":text =3D...." was defined as being explicitly
> > u16?
>
> Per my experiment, gcc/ld gives same output for :text =3D0xcc, :text =3D0=
xcccc,
> and :text =3D0xcccccccc; while ld.lld handles :text =3D as u32, so :text =
=3D0xcc
> with ld.lld gives:
>
> ffffffff82b042a1:       00 cc                   add    %cl,%ah
> ffffffff82b042a3:       00 00                   add    %al,(%rax)
> ffffffff82b042a5:       00 cc                   add    %cl,%ah
> ffffffff82b042a7:       00 00                   add    %al,(%rax)
> ffffffff82b042a9:       00 cc                   add    %cl,%ah
> ffffffff82b042ab:       00 00                   add    %al,(%rax)
>
> I am not sure what the right behavior is per specification.
>
> Thanks,
> Song

AFAIK GNU ld's behavior is not documented here
https://sourceware.org/binutils/docs/ld/Output-Section-Fill.html

The Output Section Fill syntax allows an expression. It seems that if
you use =3D0xcc+0, GNU ld will use a 4-byte filler as well, similar to
gold and ld.lld.

Frankly, I feel that GNU ld behavior should not be relied upon. lld's
comment states that it is a deliberate choice to follow gold instead
of GNU ld here.

I'll elaborate a bit and add this discrepancy to my
https://maskray.me/blog/2020-12-19-lld-and-gnu-linker-incompatibilities
:)



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
