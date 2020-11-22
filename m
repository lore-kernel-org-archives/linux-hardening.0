Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DB9C56201
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Nov 2020 07:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67E14208C3
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Nov 2020 07:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="ED9ZI38G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgKVHyo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 22 Nov 2020 02:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgKVHyn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 22 Nov 2020 02:54:43 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD5BC0613D2
        for <linux-hardening@vger.kernel.org>; Sat, 21 Nov 2020 23:54:41 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id o144so12940785ybg.7
        for <linux-hardening@vger.kernel.org>; Sat, 21 Nov 2020 23:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cmv8Raua+1tSKqWDryWdApjoa82BkHH+3G4jECAsXHY=;
        b=ED9ZI38GM/y7HDpqvSCnHe7tcnjJBEwtQEWHzA1E4fmp26kYAJuZCcY5loygQ0Vw2b
         I9Rx1LfdG6Xzs/BUmw4dSQzNYuZyCyHbTb80hVACjZAIjlggQ33hjjYme4u/mFppXG/S
         GLNGkZDk+VFlOnxLNi4l3NDKnrclj5eqhRD4z0GUs5dbLY136oaoVN4SKSdn4XD/zA7k
         rMH44mXzrKDZboFuiwQHfpoeQEQe1jHsuNTXkJ3DJ+ArfjB5DA5TaPFzsPKhbI9G3d8s
         Uyfs0bN2fbLADGO7/dV5W5rO/KMdyLcq6tuexmFsmTnyG7Ci2xHGPe1+o6A20d8jWB9X
         q2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cmv8Raua+1tSKqWDryWdApjoa82BkHH+3G4jECAsXHY=;
        b=RCfNyOnzPJN5Uo7zd5optglaqgSZVvAy+2o8/HI5vibCYXRsfvmYKMFLT1fQ9FbZS0
         Mll82SM5i9so32F9ZtloI0GpN8vGuktzf+IMa7baKMZVNA7OAJAam+l/9vGsIFEP4dch
         0Q/NMRZ6i9tXz4AeoEj+renZCyuMjr7LS6pWtjSIzxGpkPEKC31SRWJ1x5A483IxIp1t
         E5PJXvYYBFAqI3zr0NJabRpXokjqXSpFuNKHMilAaj8Eeqx05M2b8u4o/5UJagoNnW/J
         vgyGFa+6+lu6+T+f4tts6BkvneEFeUeGyYtfxhKBeZYp/POxBi8e+0Hv+JxrIdUM0Wsp
         MO6Q==
X-Gm-Message-State: AOAM532Bojm1Bfydom4r8QH03jzz87FManph6db7Rm+uSXo/wPTVST6D
        496tgoV//7qAb8gX0dmOcGeUtjsRR94Ym+GhO03G2g==
X-Google-Smtp-Source: ABdhPJyTrwkMPtEGxDAoEJwLclEl0SxjaSUTnkOaZ1BxWHJtYAl5yWfKV62ygcu2t61UEO4J7OTAcGncmare4c9rjuU=
X-Received: by 2002:a25:2f51:: with SMTP id v78mr36598790ybv.235.1606031680454;
 Sat, 21 Nov 2020 23:54:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605896059.git.gustavoars@kernel.org> <7c424191001cafdc7abd060790ecfcccdf3dd3ae.1605896059.git.gustavoars@kernel.org>
In-Reply-To: <7c424191001cafdc7abd060790ecfcccdf3dd3ae.1605896059.git.gustavoars@kernel.org>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Sun, 22 Nov 2020 09:54:29 +0200
Message-ID: <CAOtvUMeLZXChtoEUNyy=hwHQDqqncUX5V_=JSH3YaiVNLyTcHw@mail.gmail.com>
Subject: Re: [PATCH 075/141] crypto: ccree - Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Nov 20, 2020 at 8:34 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> warnings by explicitly adding multiple break statements instead of
> letting the code fall through to the next case.
>
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/crypto/ccree/cc_cipher.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_c=
ipher.c
> index dafa6577a845..cdfee501fbd9 100644
> --- a/drivers/crypto/ccree/cc_cipher.c
> +++ b/drivers/crypto/ccree/cc_cipher.c
> @@ -97,6 +97,7 @@ static int validate_keys_sizes(struct cc_cipher_ctx *ct=
x_p, u32 size)
>         case S_DIN_to_SM4:
>                 if (size =3D=3D SM4_KEY_SIZE)
>                         return 0;
> +               break;
>         default:
>                 break;
>         }
> @@ -139,9 +140,11 @@ static int validate_data_size(struct cc_cipher_ctx *=
ctx_p,
>                 case DRV_CIPHER_CBC:
>                         if (IS_ALIGNED(size, SM4_BLOCK_SIZE))
>                                 return 0;
> +                       break;
>                 default:
>                         break;
>                 }
> +               break;
>         default:
>                 break;
>         }
> --
> 2.27.0
>

Acked-by: Gilad Ben-Yossef <gilad@benyossef.com>

Thanks,
Gilad

--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
