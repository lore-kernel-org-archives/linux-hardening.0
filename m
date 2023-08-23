Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F13C3DA6F
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Aug 2023 22:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbjHWWiq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 23 Aug 2023 18:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238744AbjHWWia (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 23 Aug 2023 18:38:30 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2756F10EF
        for <linux-hardening@vger.kernel.org>; Wed, 23 Aug 2023 15:38:14 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52683b68c2fso7623193a12.0
        for <linux-hardening@vger.kernel.org>; Wed, 23 Aug 2023 15:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692830292; x=1693435092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyGN9+zD7zPLZKhTQnParhbWv7+hi6AW4TCo+HHwTrs=;
        b=inISYB0JpQm43URH7Bt2TMvS9i3ee5FdzQPN4XnDKOx2WssyzGb+E04Fj2goJwNVHx
         O+SZDW8YvebN2o14/X4xD+xxkp2859/HmZqtSU1QutDwusHEXU1wLGr9/DDecwKUuxQH
         gDlMKA3nO3mKbeDUSKAwaV+fEIagRPDol78vyrViXIuq8SV6Q+f/06l7szwSacpUT5mh
         J3ivbDJYdfommysTFh87pizqke8fH7BbCHQwKyIxuuioYXfgojHYLUJPcaI2NN9GCwUE
         FuM+Fc2A8qBE80SH9/Z/ECzdkSA1fkJAAeHc380zG3k59rTpGg/Zlixl4xP5K/Yyt/Ho
         D+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692830292; x=1693435092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyGN9+zD7zPLZKhTQnParhbWv7+hi6AW4TCo+HHwTrs=;
        b=UahB1a4Awzzkgl5EKftCFaUaz4carq8WesskbKkLXjiGCwHYV2i2RghOOQfujBzPHk
         ufeK+cF4BqgrrqcGeSSKP3bhnHcBfasEuWvsCOhnS5tQc9/ZGAg0G01w6FkjEUPC9dT+
         uxhy+vw2LU+qKxS74gdmzUveVoZdkmHAQTXtg3DB7aE1JhdPbYpxZYRf9QaoUi6lzVqZ
         wh/ZCm0cpE0aeeY4NHLzdNY3o8T+j04PXXMrhrApUB0z3+bOEAClSp4IJFruI7l4CdHg
         s9D+MbrWIBMYrMSv6UAmy3sllpPDfSNoYP7tVaa+sBWLpK2sz51jndpQOktA2QhL5r8y
         107A==
X-Gm-Message-State: AOJu0YwvH2Eo6aA2V6xKThKP28QydFupYWVtM+PP21kWtRYnsk71RJuY
        bOjcrDZkFlXPswdgwQVtSNzN20jX7MAV1SAwSry1Rw==
X-Google-Smtp-Source: AGHT+IFP9MxJdmuPviuAlED75YimN3tj0vIoX8ellwQP1gB5h5JlWZzElS+hF2pVuu433hWu6xmGZ3r3IXAXnrmCvRE=
X-Received: by 2002:a05:6402:398:b0:523:2e30:aaee with SMTP id
 o24-20020a056402039800b005232e30aaeemr9860373edv.32.1692830292593; Wed, 23
 Aug 2023 15:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692829410.git.gustavoars@kernel.org> <774ab3c21e1f2ee9c95909e5779216d83d05fd9f.1692829410.git.gustavoars@kernel.org>
In-Reply-To: <774ab3c21e1f2ee9c95909e5779216d83d05fd9f.1692829410.git.gustavoars@kernel.org>
From:   Justin Stitt <justinstitt@google.com>
Date:   Wed, 23 Aug 2023 15:38:01 -0700
Message-ID: <CAFhGd8oFbay4bLH=uou=h5QuM6-WwKwYHDfFDgsiNENVrUEQWQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] wifi: mwifiex: Replace one-element array with
 flexible-array member in struct mwifiex_ie_types_rxba_sync
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

On Wed, Aug 23, 2023 at 3:32=E2=80=AFPM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> One-element and zero-length arrays are deprecated. So, replace
> one-element array in struct mwifiex_ie_types_rxba_sync with
> flexible-array member, and refactor the rest of the code, accordingly.
>
> This results in no differences in binary output.
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c | 2 +-
>  drivers/net/wireless/marvell/mwifiex/fw.h            | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drive=
rs/net/wireless/marvell/mwifiex/11n_rxreorder.c
> index d1d3632a3ed7..735aac52bdc4 100644
> --- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
> +++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
> @@ -918,7 +918,7 @@ void mwifiex_11n_rxba_sync_event(struct mwifiex_priva=
te *priv,
>
>         mwifiex_dbg_dump(priv->adapter, EVT_D, "RXBA_SYNC event:",
>                          event_buf, len);
> -       while (tlv_buf_left >=3D sizeof(*tlv_rxba)) {
> +       while (tlv_buf_left > sizeof(*tlv_rxba)) {
>                 tlv_type =3D le16_to_cpu(tlv_rxba->header.type);
>                 tlv_len  =3D le16_to_cpu(tlv_rxba->header.len);
>                 if (tlv_type !=3D TLV_TYPE_RXBA_SYNC) {
> diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wire=
less/marvell/mwifiex/fw.h
> index f2168fac95ed..8e6db904e5b2 100644
> --- a/drivers/net/wireless/marvell/mwifiex/fw.h
> +++ b/drivers/net/wireless/marvell/mwifiex/fw.h
> @@ -779,7 +779,7 @@ struct mwifiex_ie_types_rxba_sync {
>         u8 reserved;
>         __le16 seq_num;
>         __le16 bitmap_len;
> -       u8 bitmap[1];
> +       u8 bitmap[];
>  } __packed;
>
>  struct chan_band_param_set {
> --
> 2.34.1
>
