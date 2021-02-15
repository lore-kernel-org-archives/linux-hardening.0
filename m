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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4DFC433E6
	for <linux-hardening@archiver.kernel.org>; Mon, 15 Feb 2021 18:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62CC864E30
	for <linux-hardening@archiver.kernel.org>; Mon, 15 Feb 2021 18:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhBOS5D (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 15 Feb 2021 13:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhBOS5C (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 15 Feb 2021 13:57:02 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3AFC061756;
        Mon, 15 Feb 2021 10:56:21 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id y199so8759034oia.4;
        Mon, 15 Feb 2021 10:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fXBT4xpZ44BWopiCzA5BdkSekv48SAWYnj4iW61mQF0=;
        b=eJgS51jUdUles8PvvEPpAYZzFmm/tLLusqrLPgnqRR727XPOAnyZ25rbFljT37+k+Y
         +opKtAStkmGcOEosBRVvZzmSvwyvemfAQKfML4f6nkxk2Jr96gxGMDCZSmraPyotkvzL
         wP3DDtt2lqMEnbn6A5OxJU9+UlR0vQ80SdXhlgdf9JCTWbEyRqClHQRXPLlEocqKsx+O
         s7Jakamssj57+2F88MTAg3o5KZ/faw8Y2uZLuhlszC3IvCpNclSIVckrqv3xu2gzgSBg
         FZjWDEcaikSN4IAkOJrJfCJ5mB06lrUi/5sma/WFO9Ns46IMtygHDuZbraqxj4mCSlMI
         UAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fXBT4xpZ44BWopiCzA5BdkSekv48SAWYnj4iW61mQF0=;
        b=CtYrtyoYQ3HUnV7BesiGGKedmWHJeG9tjtTmBraTNmDzyXXsfyQMlJ/+8x+yTsCYNo
         clOzzojOuKW+9tyrgFNO0r4ZST9h4VL7stbhgp1hOzUX7pi08kmO3azrnYQi8v7QvOTQ
         +5hw6zxyKCAbw7ByhOYgmqdEEG1YBNqhZBLGLnsuwgeaUTqFasQNR8a98aNWzSDuPSd8
         uGK16SovtEzfX3C3MuKnMKx+CJaeimvcEGc4odF7lbwDhX7F+1abLQymBtp+oo0Cwfpq
         UV64U+LU37txsffo86Cl2Ns+JXq+zi4Mp/3PFQjHjJ3L2XGqmlRIoPtN68LXtZE5PP0w
         efow==
X-Gm-Message-State: AOAM531yQ5ke30rGc14MV9rdgWeQhI1qBGrwi/CSZwLsXvUooKzgxyAe
        ZcvnyhKq1qN0fVr4JmFPyHkaMr5/3PFIx8/DauFydhFP
X-Google-Smtp-Source: ABdhPJwAcslDrIFamFjOx2UkgaG9PKUaghk0g+H6lzKFW3oWgJWZlWyGZ+fN+3cARHbKKz8K5MIAReI1IfDg8Jc/S7Y=
X-Received: by 2002:aca:fc0c:: with SMTP id a12mr200788oii.5.1613415381226;
 Mon, 15 Feb 2021 10:56:21 -0800 (PST)
MIME-Version: 1.0
References: <20210210224031.GA8795@embeddedor>
In-Reply-To: <20210210224031.GA8795@embeddedor>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 15 Feb 2021 13:56:10 -0500
Message-ID: <CADnq5_M+dCHFDoOS3dSTMCTsk7mH=dFSss=u91VwwVuFA=9t6g@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/pm: Replace one-element array with
 flexible-array in struct SISLANDS_SMC_SWSTATE
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
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

On Wed, Feb 10, 2021 at 5:40 PM Gustavo A. R. Silva
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
> Also, this helps with the ongoing efforts to enable -Warray-bounds and
> fix the following warnings:
>
> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/si_dpm.c:2448:20: warning: arr=
ay
> subscript 1 is above array bounds of =E2=80=98SISLANDS_SMC_HW_PERFORMANCE=
_LEVEL[1]=E2=80=99
> {aka =E2=80=98struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99} [-War=
ray-bounds]
> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/si_dpm.c:2449:20: warning: arr=
ay
> subscript 1 is above array bounds of =E2=80=98SISLANDS_SMC_HW_PERFORMANCE=
_LEVEL[1]=E2=80=99
> {aka =E2=80=98struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99} [-War=
ray-bounds]
> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/si_dpm.c:2450:20: warning: arr=
ay
> subscript 1 is above array bounds of =E2=80=98SISLANDS_SMC_HW_PERFORMANCE=
_LEVEL[1]=E2=80=99
> {aka =E2=80=98struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99} [-War=
ray-bounds]
> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/si_dpm.c:2451:20: warning: arr=
ay
> subscript 1 is above array bounds of =E2=80=98SISLANDS_SMC_HW_PERFORMANCE=
_LEVEL[1]=E2=80=99
> {aka =E2=80=98struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99} [-War=
ray-bounds]
> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/si_dpm.c:2452:20: warning: arr=
ay
> subscript 1 is above array bounds of =E2=80=98SISLANDS_SMC_HW_PERFORMANCE=
_LEVEL[1]=E2=80=99
> {aka =E2=80=98struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99} [-War=
ray-bounds]
> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/si_dpm.c:5570:20: warning: arr=
ay
> subscript 1 is above array bounds of =E2=80=98SISLANDS_SMC_HW_PERFORMANCE=
_LEVEL[1]=E2=80=99
> {aka =E2=80=98struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]=E2=80=99} [-War=
ray-bounds]
>
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.9/process/deprecated.html#zero-len=
gth-and-one-element-arrays
>
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/109
> Build-tested-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/6023be58.sk66L%2FV4vuSJI5mI%25lkp@inte=
l.com/
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/pm/powerplay/si_dpm.c       |  6 ++----
>  drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h | 10 +++++-----
>  2 files changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/=
amd/pm/powerplay/si_dpm.c
> index afa1711c9620..62291358fb1c 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> @@ -5715,11 +5715,9 @@ static int si_upload_sw_state(struct amdgpu_device=
 *adev,
>         int ret;
>         u32 address =3D si_pi->state_table_start +
>                 offsetof(SISLANDS_SMC_STATETABLE, driverState);
> -       u32 state_size =3D sizeof(SISLANDS_SMC_SWSTATE) +
> -               ((new_state->performance_level_count - 1) *
> -                sizeof(SISLANDS_SMC_HW_PERFORMANCE_LEVEL));
>         SISLANDS_SMC_SWSTATE *smc_state =3D &si_pi->smc_statetable.driver=
State;
> -
> +       size_t state_size =3D struct_size(smc_state, levels,
> +                                       new_state->performance_level_coun=
t);
>         memset(smc_state, 0, state_size);
>
>         ret =3D si_convert_power_state_to_smc(adev, amdgpu_new_state, smc=
_state);
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h b/drivers/gp=
u/drm/amd/pm/powerplay/sislands_smc.h
> index d2930eceaf3c..0f7554052c90 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h
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
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
