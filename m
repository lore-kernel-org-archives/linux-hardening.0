Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0199EC3DA4E
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Aug 2023 16:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352255AbjHQQdF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Aug 2023 12:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353686AbjHQQco (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Aug 2023 12:32:44 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9334B272B
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 09:32:43 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a800814122so3496976b6e.0
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 09:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692289963; x=1692894763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+vwsIIkApicUDYFNS7p6Sv0nA8tfIRKAQr/UoaAwtQ=;
        b=0YyixNOhKxpiJUEKfO9Jahp9tCHjQ6Z4lZDOaoQdnQ6jXi66XBq2NQjBi9fKpsNNIu
         ivs60Nom5cM0KemUBz9E23DmOnhsMFLA7C+SpMz4G5xkvstNeFz4ZAyZAsaVrMD8biPq
         E1JKNPt6ZuB8IZ21HVzPzN4LvkuKd8jZgQiJJPUWvwHHuYew3eCBq0aHfA2xrxZLOZtI
         B4uPk3YqT7EDIwVXAh1hyrktWzRLPy5COvpoJEHpV9ClIJ8G44phSUmY5eWjw1/VeCqk
         cgMMyFbdXXawwRj36j0Fma4lVUP8XOL8/34ENz3ftQOZ05L5RXvmnxrj+VuPi5XU9gZ2
         mmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692289963; x=1692894763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+vwsIIkApicUDYFNS7p6Sv0nA8tfIRKAQr/UoaAwtQ=;
        b=ls7YEsSOX3XGt0xXTupIhgvX7DOr3LLl3Cac7GO8Z8NRC/+AmC6FF28tR1hnjTBkY6
         4yTypJ8oIWVKi0AVtG+u8wImIb0aAevKkZjUi5rnsDDgwzbGEnF/dx0fZOPEHcfNhDL2
         klne1KiVI0OH1UZlR3l5QiEr4eLHEpkc4lNXmGDGE3Tj78YNz4TxXx3OTA1gEWwdM7LN
         iOXNxytw4ISH8JtPl1mVjK4hcTGyNOxQi1xO00trGVvFrT4oy14mFGgnyjT7Ix3PObj/
         8yMBwAiCdk0G0jWvfsIW5QJ0olAFAgk0Hgr0YvZ6lSe3+rwLKThPQ5eb8PiO4/CMQhN2
         Y8YQ==
X-Gm-Message-State: AOJu0YziZGxFpOhd8T+ZK9QsckgOHm8ndCg58pXzIOdgZnUoMqIrYIm6
        Yd27eK+Vt/bM8VMNMYr/+mmdw2DG9NU545kx0gpjBA==
X-Google-Smtp-Source: AGHT+IFPKWksr+unyACwxPrN7wNn2ejufDgCpn6okIOqLFHF2UUxRjKicoGsY0oujrUyX1uKwjOQG70DCbI0QT1/t/U=
X-Received: by 2002:a05:6358:9916:b0:129:c50d:6a37 with SMTP id
 w22-20020a056358991600b00129c50d6a37mr6032724rwa.16.1692289962822; Thu, 17
 Aug 2023 09:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <ZN5DvRyq6JNz20l1@work>
In-Reply-To: <ZN5DvRyq6JNz20l1@work>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Thu, 17 Aug 2023 12:32:31 -0400
Message-ID: <CAM0EoMmK0VK1=5SSHVm28zz2CUCamxJPXNukehqY955uP17VPQ@mail.gmail.com>
Subject: Re: [PATCH][next] net: sched: cls_u32: Fix allocation in u32_init()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 17, 2023 at 11:57=E2=80=AFAM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Replace struct_size() with sizeof(), and avoid allocating 8 too many
> bytes.
>
> The following difference in binary output is expected and reflects the
> desired change:
>
> | net/sched/cls_u32.o
> | @@ -6148,7 +6148,7 @@
> | include/linux/slab.h:599
> |     2cf5:      mov    0x0(%rip),%rdi        # 2cfc <u32_init+0xfc>
> |                        2cf8: R_X86_64_PC32     kmalloc_caches+0xc
> |-    2cfc:      mov    $0x98,%edx
> |+    2cfc:      mov    $0x90,%edx
>
> Fixes: d61491a51f7e ("net/sched: cls_u32: Replace one-element array with =
flexible-array member")
> Reported-by: Alejandro Colomar <alx@kernel.org>
> Closes: https://lore.kernel.org/lkml/09b4a2ce-da74-3a19-6961-67883f634d98=
@kernel.org/
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  net/sched/cls_u32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index da4c179a4d41..6663e971a13e 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -366,7 +366,7 @@ static int u32_init(struct tcf_proto *tp)
>         idr_init(&root_ht->handle_idr);
>
>         if (tp_c =3D=3D NULL) {
> -               tp_c =3D kzalloc(struct_size(tp_c, hlist->ht, 1), GFP_KER=
NEL);
> +               tp_c =3D kzalloc(sizeof(*tp_c), GFP_KERNEL);
>                 if (tp_c =3D=3D NULL) {
>                         kfree(root_ht);
>                         return -ENOBUFS;


LGTM.
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> 2.34.1
>
