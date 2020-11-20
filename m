Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B004EC5519F
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 22:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 579A42240C
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 22:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vLazJgTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgKTWni (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 17:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbgKTWni (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 17:43:38 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC0DC0613CF;
        Fri, 20 Nov 2020 14:43:38 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id o144so10018719ybg.7;
        Fri, 20 Nov 2020 14:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nu9Pci9XSkyd2dQdu9gYuDXeZiilDMpuYrk/Rd2PDx0=;
        b=vLazJgTbtfbaGpmbkmH9kjLDe/7YdZSR3IjSdTOC3a7M45J/PvYmtJ/ATBlPLtCXnS
         B9HxkvDhjflDpD9Je6i2J5DMk7XoIAuV+CgpkIE/GgKxvF081o4pPQZ7gGHBtBgIdozW
         a7gdWKUoPTaXlyivSbYHWO3GQFZuSqcPgv/qsmgMLwOAfQKjfjopSamtnb/TXGqobEhq
         cRMY/udYpwC+qW64oD+Kym32KEcD/EhXx/v2i960ZlYjlm+QAPJ1cpWunMuXQJ6H7fox
         m06GBTkn6shJ6Hk8qlWcQoLAGEg7fPky6YI3HaLP1o07U5OWbTUA5YtULqsV0Z71AA+S
         oppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nu9Pci9XSkyd2dQdu9gYuDXeZiilDMpuYrk/Rd2PDx0=;
        b=Qiec+gpid1pLwrKegOezeR4YZyVVLmQ8TG858t4hEIfxSCptoNgEechQ3T5zGdvZPd
         2SbPNPRUwV6JWbNlW7KDMlnuEbf8jYr6qrSqbaBNu+nB2fmOzokXKpiG9XV0KfHpzGXE
         D9cugnOWjpUdOESJ2Lt7dIo//pfe0IANOdNk1vfcIPGvYIQSzKfE4NVOC61ljr9blLtX
         x6aiZchD3u3AZZAuGS02I2sMwAresSTiOOtYPIjMtt52sCYG50iCg/t6i1E9YCCG1AGr
         LkE1fF0PIJcngxnw1Zl12S986Xy/i+AVVeUqg/XPlHv1oen1B3C0HWqNGalzs0waTMd4
         vuZw==
X-Gm-Message-State: AOAM531Iivp6tAKm11FOf+pwDsB0Rfsylou1Z8QUyhIr0IeQ65tMNYgx
        RTPErOQLuy48CwK9lY7Us1+FA+D6CiUSU/XH3Gk=
X-Google-Smtp-Source: ABdhPJwtW2ZdxXKGprnW3kFvpKNwPgrQ+lYf1VfvdBm8kxziqaJ0nTDG9tH90wmo+KGpy9hxejETqZf0R7aZrzO+0cs=
X-Received: by 2002:a05:6902:102a:: with SMTP id x10mr20678016ybt.130.1605912217819;
 Fri, 20 Nov 2020 14:43:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605896059.git.gustavoars@kernel.org> <4737ca598d8548f06e5cae6333c0e100b74ffa65.1605896059.git.gustavoars@kernel.org>
In-Reply-To: <4737ca598d8548f06e5cae6333c0e100b74ffa65.1605896059.git.gustavoars@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 20 Nov 2020 17:43:26 -0500
Message-ID: <CADnq5_OFMOpG8ZDHBGXv4pcmHsm=5FJKPqCzYNyxTAJ28QPu9A@mail.gmail.com>
Subject: Re: [PATCH 005/141] drm/radeon: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-hardening@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Nov 20, 2020 at 1:24 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> warnings by explicitly adding multiple fallthrough pseudo-keyword macros,
> as replacement for /* fall through */ comments.
>
> Notice that Clang doesn't recognize /* fall through */ comments as
> implicit fall-through markings.
>
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/ci_dpm.c | 2 +-
>  drivers/gpu/drm/radeon/r300.c   | 1 +
>  drivers/gpu/drm/radeon/si_dpm.c | 2 +-
>  3 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
> index 886e9959496f..3d0a2e81b2de 100644
> --- a/drivers/gpu/drm/radeon/ci_dpm.c
> +++ b/drivers/gpu/drm/radeon/ci_dpm.c
> @@ -4860,8 +4860,8 @@ static void ci_request_link_speed_change_before_state_change(struct radeon_devic
>                 case RADEON_PCIE_GEN2:
>                         if (radeon_acpi_pcie_performance_request(rdev, PCIE_PERF_REQ_PECI_GEN2, false) == 0)
>                                 break;
> +                       fallthrough;
>  #endif
> -                       /* fall through */
>                 default:
>                         pi->force_pcie_gen = ci_get_current_pcie_speed(rdev);
>                         break;
> diff --git a/drivers/gpu/drm/radeon/r300.c b/drivers/gpu/drm/radeon/r300.c
> index 73f67bf222e1..213dc49b6322 100644
> --- a/drivers/gpu/drm/radeon/r300.c
> +++ b/drivers/gpu/drm/radeon/r300.c
> @@ -1162,6 +1162,7 @@ static int r300_packet0_check(struct radeon_cs_parser *p,
>                 /* valid register only on RV530 */
>                 if (p->rdev->family == CHIP_RV530)
>                         break;
> +               fallthrough;
>                 /* fallthrough do not move */
>         default:
>                 goto fail;
> diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
> index d1c73e9db889..d19c08e0ad5a 100644
> --- a/drivers/gpu/drm/radeon/si_dpm.c
> +++ b/drivers/gpu/drm/radeon/si_dpm.c
> @@ -5748,8 +5748,8 @@ static void si_request_link_speed_change_before_state_change(struct radeon_devic
>                 case RADEON_PCIE_GEN2:
>                         if (radeon_acpi_pcie_performance_request(rdev, PCIE_PERF_REQ_PECI_GEN2, false) == 0)
>                                 break;
> +                       fallthrough;
>  #endif
> -                       /* fall through */
>                 default:
>                         si_pi->force_pcie_gen = si_get_current_pcie_speed(rdev);
>                         break;
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
