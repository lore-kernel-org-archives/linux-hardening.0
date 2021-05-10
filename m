Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82252C433B4
	for <linux-hardening@archiver.kernel.org>; Mon, 10 May 2021 21:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4750B6143B
	for <linux-hardening@archiver.kernel.org>; Mon, 10 May 2021 21:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhEJVVs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 10 May 2021 17:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhEJVVs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 10 May 2021 17:21:48 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB0FC061574;
        Mon, 10 May 2021 14:20:42 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id c3so17052226oic.8;
        Mon, 10 May 2021 14:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UeT1yVa8IIxY6hdASi/NqWEsMFgzmGdlvlJ7R9HQwm8=;
        b=RbJt2ajQ868MUEQUzQh0fYgU+oDUU0Eq9AaFR0howBjOvVJaxaCgobsWq/TOfzVxu9
         3jNtKIY/il6EDyV5Le4sHLHh5HUrMVcn7ghYfYIPhvBCzehc/74W0ygawpN0DGCgmkMt
         +XjGuyO3uxG06jJtAy9LmJfcsYt6JmPSJK9k2t9tV/jmBkU21VekRBFwutU0Qa/Hkm1g
         7fMty9dzDu7acWGG0LgVEuvLFu9KdBBOWYdSlLP/vw+Wyt43yO9zXj70ECEAmU6BF5Xz
         e52C24Thst/c7rj7aPaY52OtoGWkHNUKZfRFngZsR10qwrzM33Mun1NVCjKhgH2Z4fJQ
         KClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UeT1yVa8IIxY6hdASi/NqWEsMFgzmGdlvlJ7R9HQwm8=;
        b=QY53SmH1PK6MRWUHckxVPlcIgLUVii+yWFAQyGXo+vA0yiugzB6gzae/jF2bxW/YKp
         l96A36tdkQ54E1Ug4zrZczes1UILBwtyJxlCvzlZ6vredPbuAcGrMmdi7zjXEGNg3BCX
         GDQ7GuXXLCgsm6NY8lvjj1p5rKOVaci7ymPxpqCR99g1rihRNgucc+si8Vwel0cqoMAp
         FGakCTZHBjnLplvaCvO852l4rmy6p4gBD4b8Gz6gitxTF2ojvXLSyZrBp0VxT5TinxdG
         3aQmDK2WbMkcM7U1t2cFjoD13r7vw4xeN6buHrXGNM0FonPJBd9HHG3v8drQlHn5+2pV
         elHg==
X-Gm-Message-State: AOAM533lOBKCnh+/QjzRQWV80zOcgcAj/ju+YFcLIZlITXRuDnUBlC0m
        aicEQDwo1Wted+mSw07XnYmec4CGQiNCo/BnPZU=
X-Google-Smtp-Source: ABdhPJwVVrhMgNcxgHUGoaId/wywToOMzLn/154v1gmpV/hZ8IVBL6deqT+9tYpfmOrhhbbUCYQxmpcx9RHai1YeP1w=
X-Received: by 2002:a05:6808:68a:: with SMTP id k10mr19309258oig.120.1620681642063;
 Mon, 10 May 2021 14:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210510204618.GA135281@embeddedor>
In-Reply-To: <20210510204618.GA135281@embeddedor>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 10 May 2021 17:20:31 -0400
Message-ID: <CADnq5_Mxu4SitZPJYPgw4X8zFo+wdT2_ZXP4fum4Xr=pt-icZw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Fix out-of-bounds bug
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
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 10, 2021 at 4:45 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Create new structure SISLANDS_SMC_SWSTATE_SINGLE, as initialState.levels
> and ACPIState.levels are never actually used as flexible arrays. Those
> arrays can be used as simple objects of type
> SISLANDS_SMC_HW_PERFORMANCE_LEVEL, instead.
>
> Currently, the code fails because flexible array _levels_ in
> struct SISLANDS_SMC_SWSTATE doesn't allow for code that accesses
> the first element of initialState.levels and ACPIState.levels
> arrays:
>
> drivers/gpu/drm/amd/pm/powerplay/si_dpm.c:
> 4820: table->initialState.levels[0].mclk.vDLL_CNTL =
> 4821:         cpu_to_be32(si_pi->clock_registers.dll_cntl);
> ...
> 5021: table->ACPIState.levels[0].mclk.vDLL_CNTL =
> 5022:         cpu_to_be32(dll_cntl);
>
> because such element cannot be accessed without previously allocating
> enough dynamic memory for it to exist (which never actually happens).
> So, there is an out-of-bounds bug in this case.
>
> That's why struct SISLANDS_SMC_SWSTATE should only be used as type
> for object driverState and new struct SISLANDS_SMC_SWSTATE_SINGLE is
> created as type for objects initialState, ACPIState and ULVState.
>
> Also, with the change from one-element array to flexible-array member
> in commit 0e1aa13ca3ff ("drm/amd/pm: Replace one-element array with
> flexible-array in struct SISLANDS_SMC_SWSTATE"), the size of
> dpmLevels in struct SISLANDS_SMC_STATETABLE should be fixed to be
> SISLANDS_MAX_SMC_PERFORMANCE_LEVELS_PER_SWSTATE instead of
> SISLANDS_MAX_SMC_PERFORMANCE_LEVELS_PER_SWSTATE - 1.
>
> Fixes: 0e1aa13ca3ff ("drm/amd/pm: Replace one-element array with flexible-array in struct SISLANDS_SMC_SWSTATE")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/pm/powerplay/si_dpm.c     | 174 +++++++++---------
>  .../gpu/drm/amd/pm/powerplay/sislands_smc.h   |  34 ++--
>  2 files changed, 109 insertions(+), 99 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> index 26a5321e621b..15c0b8af376f 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> @@ -4817,70 +4817,70 @@ static int si_populate_smc_initial_state(struct amdgpu_device *adev,
>         u32 reg;
>         int ret;
>
> -       table->initialState.levels[0].mclk.vDLL_CNTL =
> +       table->initialState.level.mclk.vDLL_CNTL =
>                 cpu_to_be32(si_pi->clock_registers.dll_cntl);
> -       table->initialState.levels[0].mclk.vMCLK_PWRMGT_CNTL =
> +       table->initialState.level.mclk.vMCLK_PWRMGT_CNTL =
>                 cpu_to_be32(si_pi->clock_registers.mclk_pwrmgt_cntl);
> -       table->initialState.levels[0].mclk.vMPLL_AD_FUNC_CNTL =
> +       table->initialState.level.mclk.vMPLL_AD_FUNC_CNTL =
>                 cpu_to_be32(si_pi->clock_registers.mpll_ad_func_cntl);
> -       table->initialState.levels[0].mclk.vMPLL_DQ_FUNC_CNTL =
> +       table->initialState.level.mclk.vMPLL_DQ_FUNC_CNTL =
>                 cpu_to_be32(si_pi->clock_registers.mpll_dq_func_cntl);
> -       table->initialState.levels[0].mclk.vMPLL_FUNC_CNTL =
> +       table->initialState.level.mclk.vMPLL_FUNC_CNTL =
>                 cpu_to_be32(si_pi->clock_registers.mpll_func_cntl);
> -       table->initialState.levels[0].mclk.vMPLL_FUNC_CNTL_1 =
> +       table->initialState.level.mclk.vMPLL_FUNC_CNTL_1 =
>                 cpu_to_be32(si_pi->clock_registers.mpll_func_cntl_1);
> -       table->initialState.levels[0].mclk.vMPLL_FUNC_CNTL_2 =
> +       table->initialState.level.mclk.vMPLL_FUNC_CNTL_2 =
>                 cpu_to_be32(si_pi->clock_registers.mpll_func_cntl_2);
> -       table->initialState.levels[0].mclk.vMPLL_SS =
> +       table->initialState.level.mclk.vMPLL_SS =
>                 cpu_to_be32(si_pi->clock_registers.mpll_ss1);
> -       table->initialState.levels[0].mclk.vMPLL_SS2 =
> +       table->initialState.level.mclk.vMPLL_SS2 =
>                 cpu_to_be32(si_pi->clock_registers.mpll_ss2);
>
> -       table->initialState.levels[0].mclk.mclk_value =
> +       table->initialState.level.mclk.mclk_value =
>                 cpu_to_be32(initial_state->performance_levels[0].mclk);
>
> -       table->initialState.levels[0].sclk.vCG_SPLL_FUNC_CNTL =
> +       table->initialState.level.sclk.vCG_SPLL_FUNC_CNTL =
>                 cpu_to_be32(si_pi->clock_registers.cg_spll_func_cntl);
> -       table->initialState.levels[0].sclk.vCG_SPLL_FUNC_CNTL_2 =
> +       table->initialState.level.sclk.vCG_SPLL_FUNC_CNTL_2 =
>                 cpu_to_be32(si_pi->clock_registers.cg_spll_func_cntl_2);
> -       table->initialState.levels[0].sclk.vCG_SPLL_FUNC_CNTL_3 =
> +       table->initialState.level.sclk.vCG_SPLL_FUNC_CNTL_3 =
>                 cpu_to_be32(si_pi->clock_registers.cg_spll_func_cntl_3);
> -       table->initialState.levels[0].sclk.vCG_SPLL_FUNC_CNTL_4 =
> +       table->initialState.level.sclk.vCG_SPLL_FUNC_CNTL_4 =
>                 cpu_to_be32(si_pi->clock_registers.cg_spll_func_cntl_4);
> -       table->initialState.levels[0].sclk.vCG_SPLL_SPREAD_SPECTRUM =
> +       table->initialState.level.sclk.vCG_SPLL_SPREAD_SPECTRUM =
>                 cpu_to_be32(si_pi->clock_registers.cg_spll_spread_spectrum);
> -       table->initialState.levels[0].sclk.vCG_SPLL_SPREAD_SPECTRUM_2  =
> +       table->initialState.level.sclk.vCG_SPLL_SPREAD_SPECTRUM_2  =
>                 cpu_to_be32(si_pi->clock_registers.cg_spll_spread_spectrum_2);
>
> -       table->initialState.levels[0].sclk.sclk_value =
> +       table->initialState.level.sclk.sclk_value =
>                 cpu_to_be32(initial_state->performance_levels[0].sclk);
>
> -       table->initialState.levels[0].arbRefreshState =
> +       table->initialState.level.arbRefreshState =
>                 SISLANDS_INITIAL_STATE_ARB_INDEX;
>
> -       table->initialState.levels[0].ACIndex = 0;
> +       table->initialState.level.ACIndex = 0;
>
>         ret = si_populate_voltage_value(adev, &eg_pi->vddc_voltage_table,
>                                         initial_state->performance_levels[0].vddc,
> -                                       &table->initialState.levels[0].vddc);
> +                                       &table->initialState.level.vddc);
>
>         if (!ret) {
>                 u16 std_vddc;
>
>                 ret = si_get_std_voltage_value(adev,
> -                                              &table->initialState.levels[0].vddc,
> +                                              &table->initialState.level.vddc,
>                                                &std_vddc);
>                 if (!ret)
>                         si_populate_std_voltage_value(adev, std_vddc,
> -                                                     table->initialState.levels[0].vddc.index,
> -                                                     &table->initialState.levels[0].std_vddc);
> +                                                     table->initialState.level.vddc.index,
> +                                                     &table->initialState.level.std_vddc);
>         }
>
>         if (eg_pi->vddci_control)
>                 si_populate_voltage_value(adev,
>                                           &eg_pi->vddci_voltage_table,
>                                           initial_state->performance_levels[0].vddci,
> -                                         &table->initialState.levels[0].vddci);
> +                                         &table->initialState.level.vddci);
>
>         if (si_pi->vddc_phase_shed_control)
>                 si_populate_phase_shedding_value(adev,
> @@ -4888,41 +4888,41 @@ static int si_populate_smc_initial_state(struct amdgpu_device *adev,
>                                                  initial_state->performance_levels[0].vddc,
>                                                  initial_state->performance_levels[0].sclk,
>                                                  initial_state->performance_levels[0].mclk,
> -                                                &table->initialState.levels[0].vddc);
> +                                                &table->initialState.level.vddc);
>
> -       si_populate_initial_mvdd_value(adev, &table->initialState.levels[0].mvdd);
> +       si_populate_initial_mvdd_value(adev, &table->initialState.level.mvdd);
>
>         reg = CG_R(0xffff) | CG_L(0);
> -       table->initialState.levels[0].aT = cpu_to_be32(reg);
> -       table->initialState.levels[0].bSP = cpu_to_be32(pi->dsp);
> -       table->initialState.levels[0].gen2PCIE = (u8)si_pi->boot_pcie_gen;
> +       table->initialState.level.aT = cpu_to_be32(reg);
> +       table->initialState.level.bSP = cpu_to_be32(pi->dsp);
> +       table->initialState.level.gen2PCIE = (u8)si_pi->boot_pcie_gen;
>
>         if (adev->gmc.vram_type == AMDGPU_VRAM_TYPE_GDDR5) {
> -               table->initialState.levels[0].strobeMode =
> +               table->initialState.level.strobeMode =
>                         si_get_strobe_mode_settings(adev,
>                                                     initial_state->performance_levels[0].mclk);
>
>                 if (initial_state->performance_levels[0].mclk > pi->mclk_edc_enable_threshold)
> -                       table->initialState.levels[0].mcFlags = SISLANDS_SMC_MC_EDC_RD_FLAG | SISLANDS_SMC_MC_EDC_WR_FLAG;
> +                       table->initialState.level.mcFlags = SISLANDS_SMC_MC_EDC_RD_FLAG | SISLANDS_SMC_MC_EDC_WR_FLAG;
>                 else
> -                       table->initialState.levels[0].mcFlags =  0;
> +                       table->initialState.level.mcFlags =  0;
>         }
>
>         table->initialState.levelCount = 1;
>
>         table->initialState.flags |= PPSMC_SWSTATE_FLAG_DC;
>
> -       table->initialState.levels[0].dpm2.MaxPS = 0;
> -       table->initialState.levels[0].dpm2.NearTDPDec = 0;
> -       table->initialState.levels[0].dpm2.AboveSafeInc = 0;
> -       table->initialState.levels[0].dpm2.BelowSafeInc = 0;
> -       table->initialState.levels[0].dpm2.PwrEfficiencyRatio = 0;
> +       table->initialState.level.dpm2.MaxPS = 0;
> +       table->initialState.level.dpm2.NearTDPDec = 0;
> +       table->initialState.level.dpm2.AboveSafeInc = 0;
> +       table->initialState.level.dpm2.BelowSafeInc = 0;
> +       table->initialState.level.dpm2.PwrEfficiencyRatio = 0;
>
>         reg = MIN_POWER_MASK | MAX_POWER_MASK;
> -       table->initialState.levels[0].SQPowerThrottle = cpu_to_be32(reg);
> +       table->initialState.level.SQPowerThrottle = cpu_to_be32(reg);
>
>         reg = MAX_POWER_DELTA_MASK | STI_SIZE_MASK | LTI_RATIO_MASK;
> -       table->initialState.levels[0].SQPowerThrottle_2 = cpu_to_be32(reg);
> +       table->initialState.level.SQPowerThrottle_2 = cpu_to_be32(reg);
>
>         return 0;
>  }
> @@ -4953,18 +4953,18 @@ static int si_populate_smc_acpi_state(struct amdgpu_device *adev,
>
>         if (pi->acpi_vddc) {
>                 ret = si_populate_voltage_value(adev, &eg_pi->vddc_voltage_table,
> -                                               pi->acpi_vddc, &table->ACPIState.levels[0].vddc);
> +                                               pi->acpi_vddc, &table->ACPIState.level.vddc);
>                 if (!ret) {
>                         u16 std_vddc;
>
>                         ret = si_get_std_voltage_value(adev,
> -                                                      &table->ACPIState.levels[0].vddc, &std_vddc);
> +                                                      &table->ACPIState.level.vddc, &std_vddc);
>                         if (!ret)
>                                 si_populate_std_voltage_value(adev, std_vddc,
> -                                                             table->ACPIState.levels[0].vddc.index,
> -                                                             &table->ACPIState.levels[0].std_vddc);
> +                                                             table->ACPIState.level.vddc.index,
> +                                                             &table->ACPIState.level.std_vddc);
>                 }
> -               table->ACPIState.levels[0].gen2PCIE = si_pi->acpi_pcie_gen;
> +               table->ACPIState.level.gen2PCIE = si_pi->acpi_pcie_gen;
>
>                 if (si_pi->vddc_phase_shed_control) {
>                         si_populate_phase_shedding_value(adev,
> @@ -4972,23 +4972,23 @@ static int si_populate_smc_acpi_state(struct amdgpu_device *adev,
>                                                          pi->acpi_vddc,
>                                                          0,
>                                                          0,
> -                                                        &table->ACPIState.levels[0].vddc);
> +                                                        &table->ACPIState.level.vddc);
>                 }
>         } else {
>                 ret = si_populate_voltage_value(adev, &eg_pi->vddc_voltage_table,
> -                                               pi->min_vddc_in_table, &table->ACPIState.levels[0].vddc);
> +                                               pi->min_vddc_in_table, &table->ACPIState.level.vddc);
>                 if (!ret) {
>                         u16 std_vddc;
>
>                         ret = si_get_std_voltage_value(adev,
> -                                                      &table->ACPIState.levels[0].vddc, &std_vddc);
> +                                                      &table->ACPIState.level.vddc, &std_vddc);
>
>                         if (!ret)
>                                 si_populate_std_voltage_value(adev, std_vddc,
> -                                                             table->ACPIState.levels[0].vddc.index,
> -                                                             &table->ACPIState.levels[0].std_vddc);
> +                                                             table->ACPIState.level.vddc.index,
> +                                                             &table->ACPIState.level.std_vddc);
>                 }
> -               table->ACPIState.levels[0].gen2PCIE =
> +               table->ACPIState.level.gen2PCIE =
>                         (u8)amdgpu_get_pcie_gen_support(adev,
>                                                         si_pi->sys_pcie_mask,
>                                                         si_pi->boot_pcie_gen,
> @@ -5000,14 +5000,14 @@ static int si_populate_smc_acpi_state(struct amdgpu_device *adev,
>                                                          pi->min_vddc_in_table,
>                                                          0,
>                                                          0,
> -                                                        &table->ACPIState.levels[0].vddc);
> +                                                        &table->ACPIState.level.vddc);
>         }
>
>         if (pi->acpi_vddc) {
>                 if (eg_pi->acpi_vddci)
>                         si_populate_voltage_value(adev, &eg_pi->vddci_voltage_table,
>                                                   eg_pi->acpi_vddci,
> -                                                 &table->ACPIState.levels[0].vddci);
> +                                                 &table->ACPIState.level.vddci);
>         }
>
>         mclk_pwrmgt_cntl |= MRDCK0_RESET | MRDCK1_RESET;
> @@ -5018,59 +5018,59 @@ static int si_populate_smc_acpi_state(struct amdgpu_device *adev,
>         spll_func_cntl_2 &= ~SCLK_MUX_SEL_MASK;
>         spll_func_cntl_2 |= SCLK_MUX_SEL(4);
>
> -       table->ACPIState.levels[0].mclk.vDLL_CNTL =
> +       table->ACPIState.level.mclk.vDLL_CNTL =
>                 cpu_to_be32(dll_cntl);
> -       table->ACPIState.levels[0].mclk.vMCLK_PWRMGT_CNTL =
> +       table->ACPIState.level.mclk.vMCLK_PWRMGT_CNTL =
>                 cpu_to_be32(mclk_pwrmgt_cntl);
> -       table->ACPIState.levels[0].mclk.vMPLL_AD_FUNC_CNTL =
> +       table->ACPIState.level.mclk.vMPLL_AD_FUNC_CNTL =
>                 cpu_to_be32(mpll_ad_func_cntl);
> -       table->ACPIState.levels[0].mclk.vMPLL_DQ_FUNC_CNTL =
> +       table->ACPIState.level.mclk.vMPLL_DQ_FUNC_CNTL =
>                 cpu_to_be32(mpll_dq_func_cntl);
> -       table->ACPIState.levels[0].mclk.vMPLL_FUNC_CNTL =
> +       table->ACPIState.level.mclk.vMPLL_FUNC_CNTL =
>                 cpu_to_be32(mpll_func_cntl);
> -       table->ACPIState.levels[0].mclk.vMPLL_FUNC_CNTL_1 =
> +       table->ACPIState.level.mclk.vMPLL_FUNC_CNTL_1 =
>                 cpu_to_be32(mpll_func_cntl_1);
> -       table->ACPIState.levels[0].mclk.vMPLL_FUNC_CNTL_2 =
> +       table->ACPIState.level.mclk.vMPLL_FUNC_CNTL_2 =
>                 cpu_to_be32(mpll_func_cntl_2);
> -       table->ACPIState.levels[0].mclk.vMPLL_SS =
> +       table->ACPIState.level.mclk.vMPLL_SS =
>                 cpu_to_be32(si_pi->clock_registers.mpll_ss1);
> -       table->ACPIState.levels[0].mclk.vMPLL_SS2 =
> +       table->ACPIState.level.mclk.vMPLL_SS2 =
>                 cpu_to_be32(si_pi->clock_registers.mpll_ss2);
>
> -       table->ACPIState.levels[0].sclk.vCG_SPLL_FUNC_CNTL =
> +       table->ACPIState.level.sclk.vCG_SPLL_FUNC_CNTL =
>                 cpu_to_be32(spll_func_cntl);
> -       table->ACPIState.levels[0].sclk.vCG_SPLL_FUNC_CNTL_2 =
> +       table->ACPIState.level.sclk.vCG_SPLL_FUNC_CNTL_2 =
>                 cpu_to_be32(spll_func_cntl_2);
> -       table->ACPIState.levels[0].sclk.vCG_SPLL_FUNC_CNTL_3 =
> +       table->ACPIState.level.sclk.vCG_SPLL_FUNC_CNTL_3 =
>                 cpu_to_be32(spll_func_cntl_3);
> -       table->ACPIState.levels[0].sclk.vCG_SPLL_FUNC_CNTL_4 =
> +       table->ACPIState.level.sclk.vCG_SPLL_FUNC_CNTL_4 =
>                 cpu_to_be32(spll_func_cntl_4);
>
> -       table->ACPIState.levels[0].mclk.mclk_value = 0;
> -       table->ACPIState.levels[0].sclk.sclk_value = 0;
> +       table->ACPIState.level.mclk.mclk_value = 0;
> +       table->ACPIState.level.sclk.sclk_value = 0;
>
> -       si_populate_mvdd_value(adev, 0, &table->ACPIState.levels[0].mvdd);
> +       si_populate_mvdd_value(adev, 0, &table->ACPIState.level.mvdd);
>
>         if (eg_pi->dynamic_ac_timing)
> -               table->ACPIState.levels[0].ACIndex = 0;
> +               table->ACPIState.level.ACIndex = 0;
>
> -       table->ACPIState.levels[0].dpm2.MaxPS = 0;
> -       table->ACPIState.levels[0].dpm2.NearTDPDec = 0;
> -       table->ACPIState.levels[0].dpm2.AboveSafeInc = 0;
> -       table->ACPIState.levels[0].dpm2.BelowSafeInc = 0;
> -       table->ACPIState.levels[0].dpm2.PwrEfficiencyRatio = 0;
> +       table->ACPIState.level.dpm2.MaxPS = 0;
> +       table->ACPIState.level.dpm2.NearTDPDec = 0;
> +       table->ACPIState.level.dpm2.AboveSafeInc = 0;
> +       table->ACPIState.level.dpm2.BelowSafeInc = 0;
> +       table->ACPIState.level.dpm2.PwrEfficiencyRatio = 0;
>
>         reg = MIN_POWER_MASK | MAX_POWER_MASK;
> -       table->ACPIState.levels[0].SQPowerThrottle = cpu_to_be32(reg);
> +       table->ACPIState.level.SQPowerThrottle = cpu_to_be32(reg);
>
>         reg = MAX_POWER_DELTA_MASK | STI_SIZE_MASK | LTI_RATIO_MASK;
> -       table->ACPIState.levels[0].SQPowerThrottle_2 = cpu_to_be32(reg);
> +       table->ACPIState.level.SQPowerThrottle_2 = cpu_to_be32(reg);
>
>         return 0;
>  }
>
>  static int si_populate_ulv_state(struct amdgpu_device *adev,
> -                                SISLANDS_SMC_SWSTATE *state)
> +                                struct SISLANDS_SMC_SWSTATE_SINGLE *state)
>  {
>         struct evergreen_power_info *eg_pi = evergreen_get_pi(adev);
>         struct si_power_info *si_pi = si_get_pi(adev);
> @@ -5079,19 +5079,19 @@ static int si_populate_ulv_state(struct amdgpu_device *adev,
>         int ret;
>
>         ret = si_convert_power_level_to_smc(adev, &ulv->pl,
> -                                           &state->levels[0]);
> +                                           &state->level);
>         if (!ret) {
>                 if (eg_pi->sclk_deep_sleep) {
>                         if (sclk_in_sr <= SCLK_MIN_DEEPSLEEP_FREQ)
> -                               state->levels[0].stateFlags |= PPSMC_STATEFLAG_DEEPSLEEP_BYPASS;
> +                               state->level.stateFlags |= PPSMC_STATEFLAG_DEEPSLEEP_BYPASS;
>                         else
> -                               state->levels[0].stateFlags |= PPSMC_STATEFLAG_DEEPSLEEP_THROTTLE;
> +                               state->level.stateFlags |= PPSMC_STATEFLAG_DEEPSLEEP_THROTTLE;
>                 }
>                 if (ulv->one_pcie_lane_in_ulv)
>                         state->flags |= PPSMC_SWSTATE_FLAG_PCIE_X1;
> -               state->levels[0].arbRefreshState = (u8)(SISLANDS_ULV_STATE_ARB_INDEX);
> -               state->levels[0].ACIndex = 1;
> -               state->levels[0].std_vddc = state->levels[0].vddc;
> +               state->level.arbRefreshState = (u8)(SISLANDS_ULV_STATE_ARB_INDEX);
> +               state->level.ACIndex = 1;
> +               state->level.std_vddc = state->level.vddc;
>                 state->levelCount = 1;
>
>                 state->flags |= PPSMC_SWSTATE_FLAG_DC;
> @@ -5190,7 +5190,9 @@ static int si_init_smc_table(struct amdgpu_device *adev)
>         if (ret)
>                 return ret;
>
> -       table->driverState = table->initialState;
> +       table->driverState.flags = table->initialState.flags;
> +       table->driverState.levelCount = table->initialState.levelCount;
> +       table->driverState.levels[0] = table->initialState.level;
>
>         ret = si_do_program_memory_timing_parameters(adev, amdgpu_boot_state,
>                                                      SISLANDS_INITIAL_STATE_ARB_INDEX);
> @@ -5737,8 +5739,8 @@ static int si_upload_ulv_state(struct amdgpu_device *adev)
>         if (ulv->supported && ulv->pl.vddc) {
>                 u32 address = si_pi->state_table_start +
>                         offsetof(SISLANDS_SMC_STATETABLE, ULVState);
> -               SISLANDS_SMC_SWSTATE *smc_state = &si_pi->smc_statetable.ULVState;
> -               u32 state_size = sizeof(SISLANDS_SMC_SWSTATE);
> +               struct SISLANDS_SMC_SWSTATE_SINGLE *smc_state = &si_pi->smc_statetable.ULVState;
> +               u32 state_size = sizeof(struct SISLANDS_SMC_SWSTATE_SINGLE);
>
>                 memset(smc_state, 0, state_size);
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h b/drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h
> index 0f7554052c90..c7dc117a688c 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h
> @@ -191,6 +191,14 @@ struct SISLANDS_SMC_SWSTATE
>
>  typedef struct SISLANDS_SMC_SWSTATE SISLANDS_SMC_SWSTATE;
>
> +struct SISLANDS_SMC_SWSTATE_SINGLE {
> +       uint8_t                             flags;
> +       uint8_t                             levelCount;
> +       uint8_t                             padding2;
> +       uint8_t                             padding3;
> +       SISLANDS_SMC_HW_PERFORMANCE_LEVEL   level;
> +};
> +
>  #define SISLANDS_SMC_VOLTAGEMASK_VDDC  0
>  #define SISLANDS_SMC_VOLTAGEMASK_MVDD  1
>  #define SISLANDS_SMC_VOLTAGEMASK_VDDCI 2
> @@ -208,19 +216,19 @@ typedef struct SISLANDS_SMC_VOLTAGEMASKTABLE SISLANDS_SMC_VOLTAGEMASKTABLE;
>
>  struct SISLANDS_SMC_STATETABLE
>  {
> -    uint8_t                             thermalProtectType;
> -    uint8_t                             systemFlags;
> -    uint8_t                             maxVDDCIndexInPPTable;
> -    uint8_t                             extraFlags;
> -    uint32_t                            lowSMIO[SISLANDS_MAX_NO_VREG_STEPS];
> -    SISLANDS_SMC_VOLTAGEMASKTABLE       voltageMaskTable;
> -    SISLANDS_SMC_VOLTAGEMASKTABLE       phaseMaskTable;
> -    PP_SIslands_DPM2Parameters          dpm2Params;
> -    SISLANDS_SMC_SWSTATE                initialState;
> -    SISLANDS_SMC_SWSTATE                ACPIState;
> -    SISLANDS_SMC_SWSTATE                ULVState;
> -    SISLANDS_SMC_SWSTATE                driverState;
> -    SISLANDS_SMC_HW_PERFORMANCE_LEVEL   dpmLevels[SISLANDS_MAX_SMC_PERFORMANCE_LEVELS_PER_SWSTATE - 1];
> +       uint8_t                                 thermalProtectType;
> +       uint8_t                                 systemFlags;
> +       uint8_t                                 maxVDDCIndexInPPTable;
> +       uint8_t                                 extraFlags;
> +       uint32_t                                lowSMIO[SISLANDS_MAX_NO_VREG_STEPS];
> +       SISLANDS_SMC_VOLTAGEMASKTABLE           voltageMaskTable;
> +       SISLANDS_SMC_VOLTAGEMASKTABLE           phaseMaskTable;
> +       PP_SIslands_DPM2Parameters              dpm2Params;
> +       struct SISLANDS_SMC_SWSTATE_SINGLE      initialState;
> +       struct SISLANDS_SMC_SWSTATE_SINGLE      ACPIState;
> +       struct SISLANDS_SMC_SWSTATE_SINGLE      ULVState;
> +       SISLANDS_SMC_SWSTATE                    driverState;
> +       SISLANDS_SMC_HW_PERFORMANCE_LEVEL       dpmLevels[SISLANDS_MAX_SMC_PERFORMANCE_LEVELS_PER_SWSTATE];
>  };
>
>  typedef struct SISLANDS_SMC_STATETABLE SISLANDS_SMC_STATETABLE;
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
