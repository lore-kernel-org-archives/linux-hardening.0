Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE276C4320E
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Aug 2021 03:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F55601FE
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Aug 2021 03:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243896AbhH0DKt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 26 Aug 2021 23:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhH0DKq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 26 Aug 2021 23:10:46 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DAFC0613C1
        for <linux-hardening@vger.kernel.org>; Thu, 26 Aug 2021 20:09:58 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x16so1404102pll.2
        for <linux-hardening@vger.kernel.org>; Thu, 26 Aug 2021 20:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=A0T8uTR7GMZqtBCbDn/gFQIDHCnH77G7fVAFcMza5dc=;
        b=RTQNLhPEzWsh2Lauk0HYElABZJ+QsERiqC/cM4gadfwqV3fVLLURSgxMXdzSiz26bS
         IVaFUx0bR6tT2+oWog+ObpVTHcRR4583kYQi1NAdU1KTWzdV5np1thbramOM6615/40v
         TzLoELgsoc1qBqeya7L0yB2ULv0wvSgeF7Qls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=A0T8uTR7GMZqtBCbDn/gFQIDHCnH77G7fVAFcMza5dc=;
        b=g08Z/qUtfBgxLUzTFm37aMKn/McOY68qT636EW7BXCI1r3JLMNwt2l/UzmFh4CATrY
         XWpPQRjlphZ0+FLKNBvGBD6eCLPFpkOfARpdNwF8UT3wbVPmlPIddCjBQru9ciXWwm3F
         AKuvVK7q3Pt6IXPZs7D7WfVYXsOPA4zIA+ZHjPVE0pGSd6VE+5Z0gAcRjVWurRCd9q4u
         1n6uyonQmzokmug5ZZZj8J3NDQEQiQgQsXl5V1X8sZUiPYmPYLArSDSgOSmJ92gnLXWX
         lZdZqV79IopJwoxogVf9QY6woiwFJf6q1AppGG6S8MrL94oDeIHpVpW2i9lGNMreglVd
         I6TA==
X-Gm-Message-State: AOAM531cxhgii90vYfshQn/RE8MlyF7P4DRmU9vt/mbp92j1nBDSE+tB
        h8tlddpWJrck8/X/yKhPIX8j+g==
X-Google-Smtp-Source: ABdhPJwYWdGUce0Ml+jbyi9WOZar6+mJGMxIi2FvO9ZXxBpA2sOq6YXA918EUzgTEb2gkeKFBegHVQ==
X-Received: by 2002:a17:90a:d589:: with SMTP id v9mr20307795pju.61.1630033797527;
        Thu, 26 Aug 2021 20:09:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c124sm4358304pfc.216.2021.08.26.20.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 20:09:56 -0700 (PDT)
Date:   Thu, 26 Aug 2021 20:09:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Feifei Xu <Feifei.Xu@amd.com>, Likun Gao <Likun.Gao@amd.com>,
        Jiawei Gu <Jiawei.Gu@amd.com>, Evan Quan <evan.quan@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Lijo Lazar <lijo.lazar@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Sathishkumar S <sathishkumar.sundararaju@amd.com>,
        Jonathan Kim <jonathan.kim@amd.com>,
        Darren Powell <darren.powell@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Ryan Taylor <Ryan.Taylor@amd.com>,
        Graham Sider <Graham.Sider@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        David M Nieto <David.Nieto@amd.com>,
        Lee Jones <lee.jones@linaro.org>,
        John Clements <john.clements@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] drm/amd/pm: And destination bounds checking to struct
 copy
Message-ID: <202108262009.85E4C2B53@keescook>
References: <20210825161957.3904130-1-keescook@chromium.org>
 <CADnq5_M7cj3o4KbtA937nO_oA6ZS3-ZByLBqif_BzkXuYyV8Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_M7cj3o4KbtA937nO_oA6ZS3-ZByLBqif_BzkXuYyV8Kw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 26, 2021 at 03:51:29PM -0400, Alex Deucher wrote:
> On Wed, Aug 25, 2021 at 12:20 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > field bounds checking for memcpy(), memmove(), and memset(), avoid
> > intentionally writing across neighboring fields.
> >
> > The "Board Parameters" members of the structs:
> >         struct atom_smc_dpm_info_v4_5
> >         struct atom_smc_dpm_info_v4_6
> >         struct atom_smc_dpm_info_v4_7
> >         struct atom_smc_dpm_info_v4_10
> > are written to the corresponding members of the corresponding PPTable_t
> > variables, but they lack destination size bounds checking, which means
> > the compiler cannot verify at compile time that this is an intended and
> > safe memcpy().
> >
> > Since the header files are effectively immutable[1] and a struct_group()
> > cannot be used, nor a common struct referenced by both sides of the
> > memcpy() arguments, add a new helper, amdgpu_memcpy_trailing(), to
> > perform the bounds checking at compile time. Replace the open-coded
> > memcpy()s with amdgpu_memcpy_trailing() which includes enough context
> > for the bounds checking.
> >
> > "objdump -d" shows no object code changes.
> >
> > [1] https://lore.kernel.org/lkml/e56aad3c-a06f-da07-f491-a894a570d78f@amd.com
> >
> > Cc: "Christian König" <christian.koenig@amd.com>
> > Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> > Cc: Feifei Xu <Feifei.Xu@amd.com>
> > Cc: Likun Gao <Likun.Gao@amd.com>
> > Cc: Jiawei Gu <Jiawei.Gu@amd.com>
> > Cc: Evan Quan <evan.quan@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v2:
> > - rename and move helper to drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > - add reviews/acks
> > v1: https://lore.kernel.org/lkml/20210819201441.3545027-1-keescook@chromium.org/
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
> >  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       | 24 +++++++++++++++++++
> >  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  6 ++---
> >  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  8 +++----
> >  .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  5 ++--
> >  5 files changed, 33 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index dc3c6b3a00e5..c911387045e2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -1452,4 +1452,5 @@ static inline int amdgpu_in_reset(struct amdgpu_device *adev)
> >  {
> >         return atomic_read(&adev->in_gpu_reset);
> >  }
> > +
> >  #endif
> > diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > index 715b4225f5ee..29031eb11d39 100644
> > --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > @@ -1335,6 +1335,30 @@ enum smu_cmn2asic_mapping_type {
> >  #define WORKLOAD_MAP(profile, workload) \
> >         [profile] = {1, (workload)}
> >
> > +/**
> > + * amdgpu_memcpy_trailing - Copy the end of one structure into the middle of another
> > + *
> > + * @dst: Pointer to destination struct
> > + * @first_dst_member: The member name in @dst where the overwrite begins
> > + * @last_dst_member: The member name in @dst where the overwrite ends after
> > + * @src: Pointer to the source struct
> > + * @first_src_member: The member name in @src where the copy begins
> > + *
> > + */
> > +#define amdgpu_memcpy_trailing(dst, first_dst_member, last_dst_member,    \
> 
> I would change this to smu_memcpy_trailing() for consistency.  Other

Sure; I will send a v3.

> than that, it the patch looks good to me.  Did you want me to pick
> this up or do you want to keep this with the other patches in your
> series?

Since this has no external dependencies, it's probably best to go via
your tree.

Thanks!

-Kees

> 
> Thanks!
> 
> Alex
> 
> > +                              src, first_src_member)                      \
> > +({                                                                        \
> > +       size_t __src_offset = offsetof(typeof(*(src)), first_src_member);  \
> > +       size_t __src_size = sizeof(*(src)) - __src_offset;                 \
> > +       size_t __dst_offset = offsetof(typeof(*(dst)), first_dst_member);  \
> > +       size_t __dst_size = offsetofend(typeof(*(dst)), last_dst_member) - \
> > +                           __dst_offset;                                  \
> > +       BUILD_BUG_ON(__src_size != __dst_size);                            \
> > +       __builtin_memcpy((u8 *)(dst) + __dst_offset,                       \
> > +                        (u8 *)(src) + __src_offset,                       \
> > +                        __dst_size);                                      \
> > +})
> > +
> >  #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYER_L4)
> >  int smu_get_power_limit(void *handle,
> >                         uint32_t *limit,
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > index 273df66cac14..bda8fc12c91f 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > @@ -483,10 +483,8 @@ static int arcturus_append_powerplay_table(struct smu_context *smu)
> >
> >         if ((smc_dpm_table->table_header.format_revision == 4) &&
> >             (smc_dpm_table->table_header.content_revision == 6))
> > -               memcpy(&smc_pptable->MaxVoltageStepGfx,
> > -                      &smc_dpm_table->maxvoltagestepgfx,
> > -                      sizeof(*smc_dpm_table) - offsetof(struct atom_smc_dpm_info_v4_6, maxvoltagestepgfx));
> > -
> > +               amdgpu_memcpy_trailing(smc_pptable, MaxVoltageStepGfx, BoardReserved,
> > +                                      smc_dpm_table, maxvoltagestepgfx);
> >         return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > index f96681700c41..88a4a2aed48e 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > @@ -431,16 +431,16 @@ static int navi10_append_powerplay_table(struct smu_context *smu)
> >
> >         switch (smc_dpm_table->table_header.content_revision) {
> >         case 5: /* nv10 and nv14 */
> > -               memcpy(smc_pptable->I2cControllers, smc_dpm_table->I2cControllers,
> > -                       sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
> > +               amdgpu_memcpy_trailing(smc_pptable, I2cControllers, BoardReserved,
> > +                                      smc_dpm_table, I2cControllers);
> >                 break;
> >         case 7: /* nv12 */
> >                 ret = amdgpu_atombios_get_data_table(adev, index, NULL, NULL, NULL,
> >                                               (uint8_t **)&smc_dpm_table_v4_7);
> >                 if (ret)
> >                         return ret;
> > -               memcpy(smc_pptable->I2cControllers, smc_dpm_table_v4_7->I2cControllers,
> > -                       sizeof(*smc_dpm_table_v4_7) - sizeof(smc_dpm_table_v4_7->table_header));
> > +               amdgpu_memcpy_trailing(smc_pptable, I2cControllers, BoardReserved,
> > +                                      smc_dpm_table_v4_7, I2cControllers);
> >                 break;
> >         default:
> >                 dev_err(smu->adev->dev, "smc_dpm_info with unsupported content revision %d!\n",
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> > index ec8c30daf31c..d46b892846f6 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> > @@ -409,9 +409,8 @@ static int aldebaran_append_powerplay_table(struct smu_context *smu)
> >
> >         if ((smc_dpm_table->table_header.format_revision == 4) &&
> >             (smc_dpm_table->table_header.content_revision == 10))
> > -               memcpy(&smc_pptable->GfxMaxCurrent,
> > -                      &smc_dpm_table->GfxMaxCurrent,
> > -                      sizeof(*smc_dpm_table) - offsetof(struct atom_smc_dpm_info_v4_10, GfxMaxCurrent));
> > +               amdgpu_memcpy_trailing(smc_pptable, GfxMaxCurrent, reserved,
> > +                                      smc_dpm_table, GfxMaxCurrent);
> >         return 0;
> >  }
> >
> > --
> > 2.30.2
> >

-- 
Kees Cook
