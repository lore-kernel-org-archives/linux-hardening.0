Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC093C27C40
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Aug 2023 22:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238710AbjHWWjS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 23 Aug 2023 18:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238770AbjHWWjM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 23 Aug 2023 18:39:12 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEA510D7
        for <linux-hardening@vger.kernel.org>; Wed, 23 Aug 2023 15:39:09 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso2919202a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 23 Aug 2023 15:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692830348; x=1693435148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBCD3Z9gv9j7fQceMji1iomuK1C4+DWVfwEAFkYH9Dk=;
        b=J0aBawUtLOC9tkSRByqUtPVkV2ap5zYJZCO+SNBI30zCR8m+dkbs9/PIEBNQRdxeEy
         r65sZ7UbVDX9tBvre/+pQHgL9troneSmiH1CM5mwCEa9Y6eDHyFwhIHrT9t5t7XcR7Bu
         hnklXLqx3WQU/seEP3W1DnveKuK3qF/AkS/nJ/AEHd3YnRa8osbNoz2LVrwXvNHDaWCh
         xlDxx7kdhFPrV7dYphOlh1hMUNUFmgE+b8wf8JIIWiVKxPqqXYLguOjwLHGjoELujv6j
         OFjzVI53bsGPOq60i3m4Eld6fnF/9PLdxYWfdbebbA9rPq0cmnyHj6n7YS9osD44e8gs
         9A9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692830348; x=1693435148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBCD3Z9gv9j7fQceMji1iomuK1C4+DWVfwEAFkYH9Dk=;
        b=gh10NrU1BusaOx6cZh4fMVC+v1L57oNXaBmRtcYVvE4c8yWOSs/cvT7udj1Hwz7Mvc
         To0la7vDaitmGLyQ8wJ8DUWL+WoVu8yKmTF75w3MvTy0JlL+wFIvtomz3sreLo2wXree
         p82pnx6oai2udWPE0delEo40B4nExnQJhboe+FVpgKo2gQwl66HhVkXvVenJS08qF7gp
         6iQ6kAb7E7bew7TiGK6gTwiLb1kM8xkGnQY05hsyoH7pjmH7sZXL5cty2Cw/gkpcKm6e
         pcsRzvO1K+Md2RxFJEogfd2SGcTNbwX6Wa31Vtl9d1/7Vv/jsnYryqlE+qwPh1KmEDqp
         uUUQ==
X-Gm-Message-State: AOJu0Yx45sGNPKerqkZPycshmK/lfxzxCEKGe11/t9IQ+hgTbfoTFU1d
        Aqok5X1S4YRnymE8Cqgrk5Jx5XkxPFckw7XpWbGX9XtWIOJwB1wQ3yo=
X-Google-Smtp-Source: AGHT+IGhIdM7DxxTPWUcpTjfC7HxpBU8P5A6TVZnr7L1ACD7ax9SJgXA3JCRYnyvaxhl5hGpsOpEGebPzbj1p6bel9o=
X-Received: by 2002:aa7:d5ce:0:b0:523:69bf:2bd3 with SMTP id
 d14-20020aa7d5ce000000b0052369bf2bd3mr10915442eds.13.1692830348222; Wed, 23
 Aug 2023 15:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692829410.git.gustavoars@kernel.org> <587423b0737108effe82aefed4407daca39e9a51.1692829410.git.gustavoars@kernel.org>
In-Reply-To: <587423b0737108effe82aefed4407daca39e9a51.1692829410.git.gustavoars@kernel.org>
From:   Justin Stitt <justinstitt@google.com>
Date:   Wed, 23 Aug 2023 15:38:57 -0700
Message-ID: <CAFhGd8rcOPk3RHGhhvFu7=qRTY-hRrdWriwY3h_tiAyL+YnvGg@mail.gmail.com>
Subject: Re: [PATCH 3/3] wifi: mwifiex: Sanity check tlv_len and tlv_bitmap_len
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Dan Williams <dcbw@redhat.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 23, 2023 at 3:33=E2=80=AFPM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Add sanity checks for both `tlv_len` and `tlv_bitmap_len` before
> decoding data from `event_buf`.
>
> This prevents any malicious or buggy firmware from overflowing
> `event_buf` through large values for `tlv_len` or `tlv_bitmap_len`.
>
> Suggested-by: Dan Williams <dcbw@redhat.com>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  .../net/wireless/marvell/mwifiex/11n_rxreorder.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drive=
rs/net/wireless/marvell/mwifiex/11n_rxreorder.c
> index 735aac52bdc4..9ee3b9f1e9ce 100644
> --- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
> +++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
> @@ -921,6 +921,14 @@ void mwifiex_11n_rxba_sync_event(struct mwifiex_priv=
ate *priv,
>         while (tlv_buf_left > sizeof(*tlv_rxba)) {
>                 tlv_type =3D le16_to_cpu(tlv_rxba->header.type);
>                 tlv_len  =3D le16_to_cpu(tlv_rxba->header.len);
> +               if (size_add(sizeof(tlv_rxba->header), tlv_len) > tlv_buf=
_left) {
> +                       mwifiex_dbg(priv->adapter, WARN,
> +                                   "TLV size (%ld) overflows event_buf (=
%d)\n",
> +                                   size_add(sizeof(tlv_rxba->header), tl=
v_len),
> +                                   tlv_buf_left);
> +                       return;
> +               }
> +
>                 if (tlv_type !=3D TLV_TYPE_RXBA_SYNC) {
>                         mwifiex_dbg(priv->adapter, ERROR,
>                                     "Wrong TLV id=3D0x%x\n", tlv_type);
> @@ -929,6 +937,14 @@ void mwifiex_11n_rxba_sync_event(struct mwifiex_priv=
ate *priv,
>
>                 tlv_seq_num =3D le16_to_cpu(tlv_rxba->seq_num);
>                 tlv_bitmap_len =3D le16_to_cpu(tlv_rxba->bitmap_len);
> +               if (size_add(sizeof(*tlv_rxba), tlv_bitmap_len) > tlv_buf=
_left) {
> +                       mwifiex_dbg(priv->adapter, WARN,
> +                                   "TLV size (%ld) overflows event_buf (=
%d)\n",
> +                                   size_add(sizeof(*tlv_rxba), tlv_bitma=
p_len),
> +                                   tlv_buf_left);
> +                       return;
> +               }
> +
>                 mwifiex_dbg(priv->adapter, INFO,
>                             "%pM tid=3D%d seq_num=3D%d bitmap_len=3D%d\n"=
,
>                             tlv_rxba->mac, tlv_rxba->tid, tlv_seq_num,
> --
> 2.34.1
>
