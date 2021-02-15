Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F08C433DB
	for <linux-hardening@archiver.kernel.org>; Mon, 15 Feb 2021 19:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D57964DE8
	for <linux-hardening@archiver.kernel.org>; Mon, 15 Feb 2021 19:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhBOTAc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 15 Feb 2021 14:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhBOTAa (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 15 Feb 2021 14:00:30 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881DCC0613D6;
        Mon, 15 Feb 2021 10:59:49 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id s107so6935199otb.8;
        Mon, 15 Feb 2021 10:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3X1XsNstRQL1WuFYlu8xsGr7F4oO4915n9l7ICDbNJc=;
        b=ijbDE8T+6hMwQkB7YtZfsrwTUXMkA40VHqTtLgkX+SpejZr2FXaiSWKcEZFQ+Q7ZAb
         m5YIn1Piclp1rFKqj/5QqUnUJS/U5AwqlnWd6MYMj/ywAqE/u1/6llFicvdsLtxpAFD0
         uIKYUmHQGyni4fKHZKX8HwZvKORfZGj/XIVTFUyF4zXbhHHfs+rm8S70RbHYJaddcZpn
         waVPbRVmAtMDDOxWWyMos+rNJvCyObHTG3bzx6uLhC9ETQnUxaKGHvu+wG158mORL+gJ
         uHut6PZ97L6Pqcj0bup7zC650WvlLNmI9F/xnP1Ax08VynkJEvkMJakUayuH8+2sL3bG
         aTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3X1XsNstRQL1WuFYlu8xsGr7F4oO4915n9l7ICDbNJc=;
        b=UfeC4JMWmtyP0GTiSu6Ka4M/DPeJb3kfKUEPyFRZREvH6fveSNOzrBNg2U4kysIxT4
         +L4BNdexI5XaidqwfSu35YNgTBhGPiZ3BbYKzvwNHR/F2IT5D6Wk4IAKWb8zWRfD2i0F
         XOwmeIDG1dPDtqSJHjmFcn/fOxqYXpD6zDFGYwr1CRO/xLA39augWkm3QX12omwygWeC
         ARnSYON6dleaXNhxBkWh+cX1F+ODFjK8AzSILHkQqmYBKyBUgC6FfXdmK1N9JJi9amj+
         A9ihLVgesN9XLZ1CC/5zQkOSwfR6dio5z48fI+zsNoga9CAJzTMX9dwkKK2AZ+/sd6gz
         /lYQ==
X-Gm-Message-State: AOAM530XL+q+r5+q6ssSbRjETKPYQ2kD6YDx79pI6tWHl1TPjPmimvAN
        jHZR1R9VWhcvntSE6GBxDXY/4z2X2k0dO4MYloF1m3Lo
X-Google-Smtp-Source: ABdhPJxZ/l9Glmq2B/ll9Rne/71EAAOPsrnC19WDBNhkBmmZM+3dkyVXeylQO4TogazhV72/FnMuquUuIvVF3iui9ak=
X-Received: by 2002:a9d:ec7:: with SMTP id 65mr12345634otj.311.1613415588997;
 Mon, 15 Feb 2021 10:59:48 -0800 (PST)
MIME-Version: 1.0
References: <20210210234927.GA68137@embeddedor>
In-Reply-To: <20210210234927.GA68137@embeddedor>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 15 Feb 2021 13:59:38 -0500
Message-ID: <CADnq5_NjBspgusW73UNXb2sLiOtsKiAvXTby0zg+OiL1DuEXFA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/radeon/nislands_smc.h: Replace one-element
 array with flexible-array member in struct NISLANDS_SMC_SWSTATE
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 10, 2021 at 6:49 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use =E2=80=9Cflexible array members=E2=80=9D[1] for these c=
ases. The older
> style of one-element or zero-length arrays should no longer be used[2].
>
> Use flexible-array member in struct NISLANDS_SMC_SWSTATE, instead of
> one-element array.
>
> Also, this helps with the ongoing efforts to enable -Warray-bounds by
> fixing the following warnings:
>
> drivers/gpu/drm/radeon/ni_dpm.c: In function =E2=80=98ni_convert_power_st=
ate_to_smc=E2=80=99:
> drivers/gpu/drm/radeon/ni_dpm.c:2521:20: warning: array subscript 1 is ab=
ove array bounds of =E2=80=98NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99 =
{aka =E2=80=98struct NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99} [-Warra=
y-bounds]
>  2521 |   smc_state->levels[i].dpm2.MaxPS =3D
>       |   ~~~~~~~~~~~~~~~~~^~~
> drivers/gpu/drm/radeon/ni_dpm.c:2523:20: warning: array subscript 1 is ab=
ove array bounds of =E2=80=98NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99 =
{aka =E2=80=98struct NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99} [-Warra=
y-bounds]
>  2523 |   smc_state->levels[i].dpm2.NearTDPDec =3D NISLANDS_DPM2_NEAR_TDP=
_DEC;
>       |   ~~~~~~~~~~~~~~~~~^~~
> drivers/gpu/drm/radeon/ni_dpm.c:2524:20: warning: array subscript 1 is ab=
ove array bounds of =E2=80=98NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99 =
{aka =E2=80=98struct NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99} [-Warra=
y-bounds]
>  2524 |   smc_state->levels[i].dpm2.AboveSafeInc =3D NISLANDS_DPM2_ABOVE_=
SAFE_INC;
>       |   ~~~~~~~~~~~~~~~~~^~~
> drivers/gpu/drm/radeon/ni_dpm.c:2525:20: warning: array subscript 1 is ab=
ove array bounds of =E2=80=98NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99 =
{aka =E2=80=98struct NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99} [-Warra=
y-bounds]
>  2525 |   smc_state->levels[i].dpm2.BelowSafeInc =3D NISLANDS_DPM2_BELOW_=
SAFE_INC;
>       |   ~~~~~~~~~~~~~~~~~^~~
> drivers/gpu/drm/radeon/ni_dpm.c:2526:35: warning: array subscript 1 is ab=
ove array bounds of =E2=80=98NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99 =
{aka =E2=80=98struct NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99} [-Warra=
y-bounds]
>  2526 |   smc_state->levels[i].stateFlags |=3D
>       |                                   ^~
> drivers/gpu/drm/radeon/ni_dpm.c:2526:35: warning: array subscript 1 is ab=
ove array bounds of =E2=80=98NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99 =
{aka =E2=80=98struct NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99} [-Warra=
y-bounds]
>  2526 |   smc_state->levels[i].stateFlags |=3D
>       |   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~
>  2527 |    ((i !=3D (state->performance_level_count - 1)) && power_boost_=
limit) ?
>       |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
>  2528 |    PPSMC_STATEFLAG_POWERBOOST : 0;
>       |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/radeon/ni_dpm.c:2442:20: warning: array subscript 1 is ab=
ove array bounds of =E2=80=98NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99 =
{aka =E2=80=98struct NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99} [-Warra=
y-bounds]
>  2442 |   smc_state->levels[i + 1].aT =3D cpu_to_be32(a_t);
>
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.9/process/deprecated.html#zero-len=
gth-and-one-element-arrays
>
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/109
> Build-tested-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/6023ed54.BfIY+9Uz81I6nq19%25lkp@intel.=
com/
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/nislands_smc.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/nislands_smc.h b/drivers/gpu/drm/rade=
on/nislands_smc.h
> index 3cf8fc0d83f4..7395cb6b3cac 100644
> --- a/drivers/gpu/drm/radeon/nislands_smc.h
> +++ b/drivers/gpu/drm/radeon/nislands_smc.h
> @@ -134,11 +134,11 @@ typedef struct NISLANDS_SMC_HW_PERFORMANCE_LEVEL NI=
SLANDS_SMC_HW_PERFORMANCE_LEV
>
>  struct NISLANDS_SMC_SWSTATE
>  {
> -    uint8_t                             flags;
> -    uint8_t                             levelCount;
> -    uint8_t                             padding2;
> -    uint8_t                             padding3;
> -    NISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[1];
> +       uint8_t                             flags;
> +       uint8_t                             levelCount;
> +       uint8_t                             padding2;
> +       uint8_t                             padding3;
> +       NISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[];
>  };
>
>  typedef struct NISLANDS_SMC_SWSTATE NISLANDS_SMC_SWSTATE;
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
