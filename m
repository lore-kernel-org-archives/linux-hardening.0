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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57527C5519F
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 22:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B8522470
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 22:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnUi7YuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgKTWmv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 17:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbgKTWmv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 17:42:51 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394D8C0613CF;
        Fri, 20 Nov 2020 14:42:51 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id 2so9982341ybc.12;
        Fri, 20 Nov 2020 14:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E+/p0vsaZaZ5eJ4n4W/6kpMXGlN10lE2LER/KFN9S5s=;
        b=YnUi7YuNuw8mKKyydLvw5QmsWlZh9G7Hpn1spIT8RDTKUXYY13Bdxmk2fyzYfaErqE
         Asbi0nrX6Dkr+ZsTTAmv2yPPxoNN5RBSKqB6jgsNcvaCfd/NyrS79hQRaD+ZjC3hak7i
         neGJNQiXMdMH2t/nVgmdGZV9/ZEPtbs829cRB1laYEDnvivjitpGDwIofQ2fzZroA62j
         5YPYQlzIggcV4spdaMob8NPflrEt4tOAJ9eydFDf162XehoY+LkQmJZyV6enRbfV7zDL
         RuiTSBs7Lrn3O4YvLm6si/JY31SdwPVSGSV7o18NonKTuaze082T1eyGembEoKNEBVsi
         7lFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E+/p0vsaZaZ5eJ4n4W/6kpMXGlN10lE2LER/KFN9S5s=;
        b=NONkbjWLL8NfMFQ10l59KZxvjGk7eJH6zOWdaxFQxp+VL+kkuRqT/j1YJpYS5t+FlS
         /abVIJc2Cs6rxhyIzI1c29FwJ0x5Fd89E8vBgd2cRlrqeoBNaZbvnmrMRPl2rNbUnQP7
         e3sNDsdxoi3ZrOSkzdFlVF4G15b5kjQyne4J4Qy1yb8TAzPCYka1Zwm+kyBpOO3tWklY
         vT3bNAvd/qru8hdypUC4rVRtqqP7WAT6OKvZG6CyzfwKKHYnrYCd6lHYd5+A4xp3sjNA
         mjFHuYafXfMa/wESZaaz0V5TdnWX1IvBbxZJ7sOCSnD4o5le3gSyephLbbXX8TqsTJNa
         11Og==
X-Gm-Message-State: AOAM533oc1sIc1pVk+1OjKw3+4pOhzjomZm1pjDQWVAy1OB35p2PuB22
        ljFHdETTKmB+my6G68onj9x/TELiCQy1AkRZj30=
X-Google-Smtp-Source: ABdhPJznvvvinnh9ZMC/o+FJus/kMLARw94VjcalVRGgnDnpdX/NRwfA7QFMoYTZF4aZs0JOYd/9VAXxpWa9YkmSLkg=
X-Received: by 2002:a25:7614:: with SMTP id r20mr25968047ybc.157.1605912170528;
 Fri, 20 Nov 2020 14:42:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605896059.git.gustavoars@kernel.org> <dc55f2cf59d8d3426bf9b01a6555db6de61c9361.1605896059.git.gustavoars@kernel.org>
In-Reply-To: <dc55f2cf59d8d3426bf9b01a6555db6de61c9361.1605896059.git.gustavoars@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 20 Nov 2020 17:42:38 -0500
Message-ID: <CADnq5_OsDDGcy1EvEOP23pqfF628dGEq=3-hY_G45b_5j4nmtQ@mail.gmail.com>
Subject: Re: [PATCH 004/141] drm/amdgpu: Fix fall-through warnings for Clang
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
> warnings by explicitly adding multiple break statements instead of just
> letting the code fall through to the next case.
>
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 1 +
>  drivers/gpu/drm/amd/amdgpu/vi.c        | 1 +
>  4 files changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 3579565e0eab..98ca6b976b6e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -8398,6 +8398,7 @@ static int gfx_v10_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
>                 WREG32_FIELD15(GC, 0, CP_INT_CNTL_RING0,
>                                PRIV_INSTR_INT_ENABLE,
>                                state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
> +               break;
>         default:
>                 break;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 0d8e203b10ef..e61121629b93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5683,6 +5683,7 @@ static int gfx_v9_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
>                 WREG32_FIELD15(GC, 0, CP_INT_CNTL_RING0,
>                                PRIV_INSTR_INT_ENABLE,
>                                state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
> +               break;
>         default:
>                 break;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 3ebbddb63705..584b99b80c29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -502,6 +502,7 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
>                                 WREG32(reg, tmp);
>                         }
>                 }
> +               break;
>         default:
>                 break;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> index 9bcd0eebc6d7..d56b474b3a21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -1645,6 +1645,7 @@ static int vi_common_set_clockgating_state(void *handle,
>         case CHIP_POLARIS12:
>         case CHIP_VEGAM:
>                 vi_common_set_clockgating_state_by_smu(adev, state);
> +               break;
>         default:
>                 break;
>         }
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
