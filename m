Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C18EE4996
	for <linux-hardening@archiver.kernel.org>; Mon, 21 Aug 2023 14:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbjHUOfn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 21 Aug 2023 10:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbjHUOfn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 21 Aug 2023 10:35:43 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAA2E4
        for <linux-hardening@vger.kernel.org>; Mon, 21 Aug 2023 07:35:41 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-58e6c05f529so38230957b3.3
        for <linux-hardening@vger.kernel.org>; Mon, 21 Aug 2023 07:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692628540; x=1693233340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4b53Dt95uy0fYaSBvKqTMmQI/Jg+tUp+Lr7nWAEjFQ=;
        b=22U+T63rr3IJQB7X/OAN1jX9o1iucJy6N4RiqqE6GUYVZPm2LNMK4jWqnY77X3QFte
         glT7Tgt90rkTK4aH+vYedoLBlACNsC+Wp7eLU800PaBifJSeo9bPBM8jjQRcz6kCnS1u
         Cj5suf/1TzWPA+vKE0lRs+zHLM4OnGaD5DFm2oJIA1wXo5YEogDZLrHVs8wVfHijZPxG
         DCdlprTWYjYk2GpDKKWKrBluTqGk9SFjNKBNQWrnhAH8TSfY8P4zIDAN/N+nS6Xemx74
         y+hhO/3RjX2MLan9o1yVW2QK32BdGsDtsDA1j3pw1zMnneLn/D5i+YWUx8icVeo20tRY
         c9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692628540; x=1693233340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4b53Dt95uy0fYaSBvKqTMmQI/Jg+tUp+Lr7nWAEjFQ=;
        b=luxcpD3wnD8YOyluxxysKEwCkd5lukr9WUmhmlgGIl632Ok4saSxJqLwlD5EJfuRBa
         JIU2ls8I3L5v3UKcOpdUAx/mHNmDel4mwH/ZpeYDlFetil1iR5gZS6F1zhH4x/Pxi2WO
         h1MZfc2L0hathk3hq1P82NqiC0HkKMaidvlri8Bg/W/lESZnCIYDUpWzjDDSTFJAPWAw
         UDiFxlIybjMn2oEzdaUb9JwOb+DZmjkL0sRUCpPIfu25WUAVilnplHtWzvhccBfGrA6x
         +zH2GXDPS4ra6s+raRFmcFqD4KyMkAlFTEA41s9V0QPN7ZkrvW5hGGoNgchGGhgT0uBq
         W8XQ==
X-Gm-Message-State: AOJu0YzFXxO+Hd93egIZ81qDyWnJBybNawGVdbdvuyoI5RDswqAaY2z5
        yNPHE27AKyeR+PCGc40Wgfcv3NvlugzrPRsgOaKHnA==
X-Google-Smtp-Source: AGHT+IGc4t2KXVvvpf/b+ACln5ICMXYLNE8r9zPyYmYSkxHisyF3ZUrdWwvWQW72lw997s97O0AXtDbGgIfpDltOfHM=
X-Received: by 2002:a81:a194:0:b0:585:5fbf:1bf1 with SMTP id
 y142-20020a81a194000000b005855fbf1bf1mr6948644ywg.48.1692628540654; Mon, 21
 Aug 2023 07:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <ZN5DvRyq6JNz20l1@work> <20230818193810.102a2581@kernel.org>
In-Reply-To: <20230818193810.102a2581@kernel.org>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Mon, 21 Aug 2023 10:35:29 -0400
Message-ID: <CAM0EoM=fZVr4ROKZ+tA9A=yxcx6LnNVFzTb+_brFv9c-CiRfdA@mail.gmail.com>
Subject: Re: [PATCH][next] net: sched: cls_u32: Fix allocation in u32_init()
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Aug 18, 2023 at 10:38=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 17 Aug 2023 09:58:53 -0600 Gustavo A. R. Silva wrote:
> > Subject: [PATCH][next] net: sched: cls_u32: Fix allocation in u32_init(=
)
> > Date: Thu, 17 Aug 2023 09:58:53 -0600
> >
> > Replace struct_size() with sizeof(), and avoid allocating 8 too many
> > bytes.
>
> What are you fixing?
>
> > The following difference in binary output is expected and reflects the
> > desired change:
> >
> > | net/sched/cls_u32.o
> > | @@ -6148,7 +6148,7 @@
> > | include/linux/slab.h:599
> > |     2cf5:      mov    0x0(%rip),%rdi        # 2cfc <u32_init+0xfc>
> > |                        2cf8: R_X86_64_PC32     kmalloc_caches+0xc
> > |-    2cfc:      mov    $0x98,%edx
> > |+    2cfc:      mov    $0x90,%edx
>
> Sure, but why are you doing this? And how do you know the change is
> correct?
>
> There are 2 other instances where we allocate 1 entry or +1 entry.
> Are they not all wrong?
>
> Also some walking code seems to walk <=3D divisor, divisor IIUC being
> the array bound - 1?
>
> Jamal acked so changes are this is right, but I'd really like to
> understand what's going on, and I shouldn't have to ask you all
> these questions :S

This is a "bug fix" given that the structure had no zero array
construct as was implied by d61491a51f7e . I didnt want to call it out
as a bug fix (for -net) because existing code was not harmful but
allocated extra memory which this patch gives back.
The other instances have a legit need for "flexible array".

cheers,
jamal
> --
> pw-bot: cr
