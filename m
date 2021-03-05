Return-Path: <SRS0=3XZ1=ID=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7FDC433DB
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 19:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30D2065074
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 19:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhCETLQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 14:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhCETK4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 14:10:56 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEA4C061574;
        Fri,  5 Mar 2021 11:10:56 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id y131so763844oia.8;
        Fri, 05 Mar 2021 11:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dDSLWCE55+Pw5C88tg6MoG/73HO+jB9/1ATUH2h3DFo=;
        b=b/wnMNlg1kE1kTe6xtjkHGQc0wv4tg0R218ZnK/r2gZZCKqY86Zw0R94BEJIG7GIgB
         EIGy8I2p9hWblWHShW5X+IFhZccqZq9u38PC548vgUBg4nIn9i2CNjE9igYCISTXmdy3
         UXk4QlQlXN4CxvPH+yGwUz92us3i/1zwxkzfc5bEkgMGXitWD53fFPBVqtbEpZlP49xh
         XQ33e0hI+20nBuC6n2Rxx5FJm+Q1pflPS6lnxHrH3SHc/cYbj6pqZs0u2qRW6Ka/RTsu
         4iCXmnYEQkkpbGNArHpXAY1ol+9fwbo9avN8DsbaliNG8vmru6a4WL9GRYRAk0ayarK/
         BfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dDSLWCE55+Pw5C88tg6MoG/73HO+jB9/1ATUH2h3DFo=;
        b=pi0RQu83E4UE4sZ7srQfk/GOGc2K39GdcYURI8+EybhuuJYW7pNS3DPGSRYROyskda
         U8BWpPHZnLncte0zncUckuDmCcqobI3nY3UTFkUCi7u7pac5Rb9nvrGzF5k1lIHNiQLW
         F+Pt18UkqsphLqaQi0oCi3Nj0nLGjFQRnZ0D8o1bvm0EyjTioFVE28SIdxG+ZSS2L+Or
         Cp2e+OeE29s0gq74ZURm4rrs/i7UbUSc1RtTEB6ildXFsvnH/8ZDcKLiOgBfmEztoC4X
         cluQqFYS8wgHi7WaARExNhuI1yU46fue3eXbdg1XV9oaFK2jig94NRLZ/jGFDFd4FwVk
         mtWQ==
X-Gm-Message-State: AOAM531xp+d4OTeXwB8Fab7WcYXoY946tuFpG31jnv3AXTxhA/dt5lCL
        139+LEIFsngN52NJ7p1o1wsYPxnLs2AAjvVlsck=
X-Google-Smtp-Source: ABdhPJxoP+oZnKsJUYZweRX5p0kIhz2DJw+2DIhPP8K8OKqRjR6cEux/6BbiSBjQJf2I6YSJsECrvJXlIFGwehAae2c=
X-Received: by 2002:aca:fccb:: with SMTP id a194mr7895902oii.5.1614971455748;
 Fri, 05 Mar 2021 11:10:55 -0800 (PST)
MIME-Version: 1.0
References: <20210303190458.GA16321@embeddedor>
In-Reply-To: <20210303190458.GA16321@embeddedor>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 5 Mar 2021 14:10:44 -0500
Message-ID: <CADnq5_M3dSMnKQMRv3SVaK6-w5ebJxX6w2-oy8v7+2muw3S3vg@mail.gmail.com>
Subject: Re: [PATCH][next] drm/radeon/si_dpm: Replace one-element array with
 flexible-array in struct SISLANDS_SMC_SWSTATE
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

Applied.  Thanks!

Alex

On Wed, Mar 3, 2021 at 2:05 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use =E2=80=9Cflexible array members=E2=80=9D[1] for these c=
ases. The older
> style of one-element or zero-length arrays should no longer be used[2].
>
> Refactor the code according to the use of a flexible-array member in
> struct SISLANDS_SMC_SWSTATE, instead of a one-element array, and use
> the struct_size() helper to calculate the size for the allocation.
>
> Also, this helps with the ongoing efforts to enable -Warray-bounds by
> fixing the following warnings:
>
> drivers/gpu/drm/radeon/si_dpm.c: In function =E2=80=98si_convert_power_st=
ate_to_smc=E2=80=99:
> drivers/gpu/drm/radeon/si_dpm.c:2350:20: warning: array subscript 1 is ab=
ove array bounds of =E2=80=98SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99 =
{aka =E2=80=98struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99} [-Warra=
y-bounds]
>  2350 |   smc_state->levels[i].dpm2.MaxPS =3D (u8)((SISLANDS_DPM2_MAX_PUL=
SE_SKIP * (max_sclk - min_sclk)) / max_sclk);
>       |   ~~~~~~~~~~~~~~~~~^~~
> drivers/gpu/drm/radeon/si_dpm.c:2351:20: warning: array subscript 1 is ab=
ove array bounds of =E2=80=98SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99 =
{aka =E2=80=98struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99} [-Warra=
y-bounds]
>  2351 |   smc_state->levels[i].dpm2.NearTDPDec =3D SISLANDS_DPM2_NEAR_TDP=
_DEC;
>       |   ~~~~~~~~~~~~~~~~~^~~
> drivers/gpu/drm/radeon/si_dpm.c:2352:20: warning: array subscript 1 is ab=
ove array bounds of =E2=80=98SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99 =
{aka =E2=80=98struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99} [-Warra=
y-bounds]
>  2352 |   smc_state->levels[i].dpm2.AboveSafeInc =3D SISLANDS_DPM2_ABOVE_=
SAFE_INC;
>       |   ~~~~~~~~~~~~~~~~~^~~
> drivers/gpu/drm/radeon/si_dpm.c:2353:20: warning: array subscript 1 is ab=
ove array bounds of =E2=80=98SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99 =
{aka =E2=80=98struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99} [-Warra=
y-bounds]
>  2353 |   smc_state->levels[i].dpm2.BelowSafeInc =3D SISLANDS_DPM2_BELOW_=
SAFE_INC;
>       |   ~~~~~~~~~~~~~~~~~^~~
> drivers/gpu/drm/radeon/si_dpm.c:2354:20: warning: array subscript 1 is ab=
ove array bounds of =E2=80=98SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99 =
{aka =E2=80=98struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99} [-Warra=
y-bounds]
>  2354 |   smc_state->levels[i].dpm2.PwrEfficiencyRatio =3D cpu_to_be16(pw=
r_efficiency_ratio);
>       |   ~~~~~~~~~~~~~~~~~^~~
> drivers/gpu/drm/radeon/si_dpm.c:5105:20: warning: array subscript 1 is ab=
ove array bounds of =E2=80=98SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99 =
{aka =E2=80=98struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99} [-Warra=
y-bounds]
>  5105 |   smc_state->levels[i + 1].aT =3D cpu_to_be32(a_t);
>       |   ~~~~~~~~~~~~~~~~~^~~~~~~
>
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.9/process/deprecated.html#zero-len=
gth-and-one-element-arrays
>
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/109
> Build-tested-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/603f9a8f.aDLrpMFzzSApzVYQ%25lkp@intel.=
com/
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/gpu/drm/radeon/si_dpm.c       |  5 ++---
>  drivers/gpu/drm/radeon/sislands_smc.h | 10 +++++-----
>  2 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_=
dpm.c
> index 91bfc4762767..918609551804 100644
> --- a/drivers/gpu/drm/radeon/si_dpm.c
> +++ b/drivers/gpu/drm/radeon/si_dpm.c
> @@ -5250,10 +5250,9 @@ static int si_upload_sw_state(struct radeon_device=
 *rdev,
>         int ret;
>         u32 address =3D si_pi->state_table_start +
>                 offsetof(SISLANDS_SMC_STATETABLE, driverState);
> -       u32 state_size =3D sizeof(SISLANDS_SMC_SWSTATE) +
> -               ((new_state->performance_level_count - 1) *
> -                sizeof(SISLANDS_SMC_HW_PERFORMANCE_LEVEL));
>         SISLANDS_SMC_SWSTATE *smc_state =3D &si_pi->smc_statetable.driver=
State;
> +       size_t state_size =3D struct_size(smc_state, levels,
> +                                       new_state->performance_level_coun=
t);
>
>         memset(smc_state, 0, state_size);
>
> diff --git a/drivers/gpu/drm/radeon/sislands_smc.h b/drivers/gpu/drm/rade=
on/sislands_smc.h
> index 966e3a556011..fbd6589bdab9 100644
> --- a/drivers/gpu/drm/radeon/sislands_smc.h
> +++ b/drivers/gpu/drm/radeon/sislands_smc.h
> @@ -182,11 +182,11 @@ typedef struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL SI=
SLANDS_SMC_HW_PERFORMANCE_LEV
>
>  struct SISLANDS_SMC_SWSTATE
>  {
> -    uint8_t                             flags;
> -    uint8_t                             levelCount;
> -    uint8_t                             padding2;
> -    uint8_t                             padding3;
> -    SISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[1];
> +       uint8_t                             flags;
> +       uint8_t                             levelCount;
> +       uint8_t                             padding2;
> +       uint8_t                             padding3;
> +       SISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[];
>  };
>
>  typedef struct SISLANDS_SMC_SWSTATE SISLANDS_SMC_SWSTATE;
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
