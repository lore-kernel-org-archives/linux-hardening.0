Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34E5C5519F
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 22:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 970A02236F
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 22:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJlQIvCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgKTWqZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 17:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgKTWqZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 17:46:25 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A94C0613CF;
        Fri, 20 Nov 2020 14:46:24 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id v92so10033597ybi.4;
        Fri, 20 Nov 2020 14:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2et3t7V/KMkTytiG/e4D11gYul4TV6gTCzuYs+F2ZTA=;
        b=DJlQIvCJkf4+1dPh8TYw/kq+VciO+Nu8p0l00YuVUY9jScVcMNkjJrM9QrGA0UaAWo
         vR1QAMpWzfdHrJutnVWx/iyN6mkkntDbJ+TDwyj96irCZVg32WjHaS9cvci2j/VXeOu8
         nb6f4V/bfTKkg/jp1G1VMsDsvproKdBmjTJ5xh6SMvPjmi9ZqlMy1k/ATKosh2BIvdel
         93prsAl37ZGGkXKXWE2Z3blMLMznWhGGosb1ZXUnkMHWhvs5sZRLWY50q10QXhIhiaIh
         KuiAx3tkdXFXbw8I4+Ae64AnkcHfrOG1SXlNvnzUydInBV0NDE7ER0xtaACS4quhbHPd
         S+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2et3t7V/KMkTytiG/e4D11gYul4TV6gTCzuYs+F2ZTA=;
        b=o8WYmrPrtdEmor/0Fu0s62kDbgcQQCulSV9GaBC0u8ow9kyrtl31h5Olmeahnyk5rO
         gr0M6kkwM9ihadbfdwjX8vgOF0kxXNxAeEuZxslGk6OkMsB6ZWy3Od0NoYLkA/sIqVuA
         SE4psVw+6DUB9TghXyB7phbkdaNYPAmjitI+RjqeHUGdMgJ+zc2JtVjU0QCyrcu1yFae
         XFE8XdvZ5fJgsNZPIJ7xC3eBd2HXZSbZUJEBmkNvHbe2fM2RPODMdfNLusjbgHtKVgDU
         +S13nBuZXN0r1nP1UksYopdb0LMLmwdrOt3kgvMsYcF6zmODfqV2FVK8IHYVG2wGbsl4
         Zq6g==
X-Gm-Message-State: AOAM533jCveFD2YV9EuWTdRMg+8UvDNDCijRXtw5PTIxv3LeVF14OfAa
        8t3coAWbip8iKZSzq0eTzvUXjD++gKkLvLBUp/w=
X-Google-Smtp-Source: ABdhPJzSQjUz8dvYfSiTH1U32APPsuQRJVBLBjH9CH5oFPS39C/kkiOMuJbRHdykj3+wPaMWsDr+x2P3/HvDpgo75s4=
X-Received: by 2002:a25:b803:: with SMTP id v3mr30277370ybj.326.1605912384156;
 Fri, 20 Nov 2020 14:46:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605896059.git.gustavoars@kernel.org> <b73d98f74902b495689069177ffde953e1a061fb.1605896059.git.gustavoars@kernel.org>
In-Reply-To: <b73d98f74902b495689069177ffde953e1a061fb.1605896059.git.gustavoars@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 20 Nov 2020 17:46:12 -0500
Message-ID: <CADnq5_Ozd0bGq6CpkmjHaZH+D8dwpnMNmCzPQxh7pNh0hwNykg@mail.gmail.com>
Subject: Re: [PATCH 078/141] drm/amd/pm: Fix fall-through warnings for Clang
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

On Fri, Nov 20, 2020 at 1:35 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a couple
> of warnings by explicitly adding a break statement instead of letting
> the code fall through to the next case, and a fallthrough pseudo-keyword
> as a replacement for a /* fall through */ comment,
>
> Notice that Clang doesn't recognize /* fall through */ comments as
> implicit fall-through markings.
>
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/pm/powerplay/si_dpm.c                  | 2 +-
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> index b5986d19dc08..afa1711c9620 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> @@ -6200,8 +6200,8 @@ static void si_request_link_speed_change_before_state_change(struct amdgpu_devic
>                 case AMDGPU_PCIE_GEN2:
>                         if (amdgpu_acpi_pcie_performance_request(adev, PCIE_PERF_REQ_PECI_GEN2, false) == 0)
>                                 break;
> +                       fallthrough;
>  #endif
> -                       /* fall through */
>                 default:
>                         si_pi->force_pcie_gen = si_get_current_pcie_speed(adev);
>                         break;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
> index c3d2e6dcf62a..7d7d698c7976 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
> @@ -2272,6 +2272,7 @@ static int polaris10_update_smc_table(struct pp_hwmgr *hwmgr, uint32_t type)
>                 break;
>         case SMU_BIF_TABLE:
>                 polaris10_update_bif_smc_table(hwmgr);
> +               break;
>         default:
>                 break;
>         }
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
