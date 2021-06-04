Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A78C4743D
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Jun 2021 16:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7945613B4
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Jun 2021 16:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhFDQ7B (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Jun 2021 12:59:01 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:44628 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhFDQ7B (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Jun 2021 12:59:01 -0400
Received: by mail-ot1-f54.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so9674758otp.11;
        Fri, 04 Jun 2021 09:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H6LHbgNy52Ugn9xE6Njw7OtLaeKXGWqrKMiHAaaNoo0=;
        b=JXNWAZ4V09YmbaqN7UJyI+miEtdFviDNduqUgu9epQACEKhdjBEYV9BuUli2dWxu6u
         eU3Umhh7yJnJ2o/wcxptR4f8aCKf5ptn/TIkIIAPMINohtNz73Rkn6l1POAkkRjeHpGe
         tzb+0N4w0H3vOeUUhSO4yvrJ8aAatO7y1TW2htElfCBm51eCMS8bkklIS9jliA5QSWFm
         W8SUT9yMDN0g6Q6dkIB7TYOFO7gT8JklD+sanqi//4w+uV819tS52JyH15TbuANqfNli
         UM4pQBrp5f9s3wtOJLE5nIJ0Sklgdo+Y1HClAlZIi87SxW7XNeso8kbRElKKUbbuIU+i
         GZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H6LHbgNy52Ugn9xE6Njw7OtLaeKXGWqrKMiHAaaNoo0=;
        b=sZgZNCmycF7pLUZ7uRws/PrlfMRebQb4tL/Mz6VYbm4DimFW60vgGiQO/RhaA8Yr98
         q5F9WR5EmM9KrSEIFg5HL6otkQ6HTKUkNUvTV2uQBfPJSFm5jxkbs4RqXZ1l7h5A4Ty7
         /MU10jeukVZIIsLKCy4z3fYWelbzEYU7+8NCX4t7XCfpl86h2nOf75B64iCjOdf1rbfG
         JBT1K/dlPtPAMiMgfLviDanMHF9JhGxVgOHEAE/sw8SrkDLkrdQxsil8+hhLGup0AD3P
         vACETLgN2eMDANpomCs+TDlPGJH/Tr1toJYoAsj8QIQ/pANnwLshF7bgsNOmZZDiplqS
         sgHg==
X-Gm-Message-State: AOAM53287QdWoLqnxVkD0ABaQoj2gduz2iS/hVbzN4NeiYBoMWYaZUmB
        pcDuWcwNSf05IaP2UBlWYFdafBrNZhdmFNdx6xA=
X-Google-Smtp-Source: ABdhPJxuhdyOzEz5VW5nfgY1B5KIZXGb8L5KvrRMXRaPrm7Tg2bsRzBEb2J03ByBd9xw6YU3u0CirA9m+xvudrrNy3o=
X-Received: by 2002:a05:6830:1e64:: with SMTP id m4mr1913092otr.23.1622825774401;
 Fri, 04 Jun 2021 09:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210604050613.GA240889@embeddedor>
In-Reply-To: <20210604050613.GA240889@embeddedor>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 4 Jun 2021 12:56:03 -0400
Message-ID: <CADnq5_OSFqq9KxZ17B7abeUfdUOR1ix4OFHjxkgzWdm7FzPfgA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/pm: Fix fall-through warning for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Kees Cook <keescook@chromium.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Jun 4, 2021 at 1:05 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
>
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> JFYI: We had thousands of these sorts of warnings and now we are down
>       to just 22 in linux-next. This is one of those last remaining
>       warnings. :)
>
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index 8f71f6a4bb49..43c3f6e755e7 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -831,6 +831,7 @@ static int smu10_dpm_force_dpm_level(struct pp_hwmgr *hwmgr,
>                 break;
>         case AMD_DPM_FORCED_LEVEL_MANUAL:
>                 data->fine_grain_enabled = 1;
> +               break;
>         case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
>         default:
>                 break;
> --
> 2.27.0
>
