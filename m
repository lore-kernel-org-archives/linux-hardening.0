Return-Path: <SRS0=DAdQ=DP=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD388C433E7
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 17:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C96222200
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 17:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gL5DIxHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731930AbgJHRWw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Oct 2020 13:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbgJHRWv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Oct 2020 13:22:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20AAC061755;
        Thu,  8 Oct 2020 10:22:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n18so7492513wrs.5;
        Thu, 08 Oct 2020 10:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0XCAglP6YywwJUqM/bv9Go8J3wVKQf8G1ogKm9q5Gzw=;
        b=gL5DIxHuRCK9zS157yydNrjM50jVisfQRkHntJVR+dmxm1SRh0sYQpiqcF8gSvxlXj
         Ou61xly9XbENNpEY3e2ZQqLnyPlWma1yYni8Bmq3Rd0XakK+O2FPlFluti5v+w7NVjlW
         9uyO5xHLfyIn/BJNXqaKC7f0Vipqv/sbSMFUzbvEdcz90kEhgal+iWEnR0Ni8TwZtJWo
         LN5ENPrDBDIGHIT2mXnpnjvLFr58txgo0wkiViyPPOT6RQl0fsm4bq/Hd0p2m9BTSmlp
         mG8P15pqui1170eY3yxdIzxvQEZrNgBvcMcjNIbxpQ3jtlNwJsuCb3kMRzGLSD3DtaJo
         Bq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0XCAglP6YywwJUqM/bv9Go8J3wVKQf8G1ogKm9q5Gzw=;
        b=tXYfThHOlgw74XlAzaRlSYxAB+62cQ40/8VdaT8c2JprhHsWoY8R1AsJGBQN0Sp6qY
         v9DnAk4oFza3CGy/54T79iQtb9CGhUu30IoWbk+/XBeVQfuQ+g0PYVL5J7dr4LuYS7ZH
         8E9hatMPK1gKGuBxkZ78EsVAxLO8toPJTpE6iFE//X55wd0iqYZ2eiGD3i+FliZGzZKF
         phKSbDAVszPPQAu9MeS+J3RgTk1/Em9NW93HX5y40q5WrMqj3CnpsG+GioWaXUS+PgOF
         APV4akPWf741zrabQbCHTFCJnAy+5tBr8aO2nev+tF75frTTVADKeHIDoOJD7XXvJk81
         L/DQ==
X-Gm-Message-State: AOAM533KFDF/zTsXjZlkhk8DMJUianSKu4AbV461wWD3sSdgGe4LPvnQ
        HcCTvv4UMiJo4KPQiC58eFBdmYrZQjSEe1yjtMY=
X-Google-Smtp-Source: ABdhPJxKNLFsnTv9OdQfqfvkt+lO2RGpK6EuS+70Pe6YGeonhYinlnofq3OOyLbeNaKzcKYUOE8q03LgA0UxPsjMokE=
X-Received: by 2002:adf:aa0a:: with SMTP id p10mr10309056wrd.362.1602177770395;
 Thu, 08 Oct 2020 10:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201008143450.GA23077@embeddedor>
In-Reply-To: <20201008143450.GA23077@embeddedor>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 8 Oct 2020 13:22:39 -0400
Message-ID: <CADnq5_MHvnkWtEUOG2WTBMaMKJMied3aPDg4ZLy0w+9Vyce_AQ@mail.gmail.com>
Subject: Re: [PATCH][next] amd/amdgpu_ctx: Use struct_size() helper and kmalloc()
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

Applied.  Thanks!

Alex

On Thu, Oct 8, 2020 at 10:29 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Make use of the new struct_size() helper instead of the offsetof() idiom.
> Also, use kmalloc() instead of kcalloc().
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index c80d8339f58c..5be125f3b92a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -100,7 +100,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>         enum drm_sched_priority priority;
>         int r;
>
> -       entity = kcalloc(1, offsetof(typeof(*entity), fences[amdgpu_sched_jobs]),
> +       entity = kmalloc(struct_size(entity, fences, amdgpu_sched_jobs),
>                          GFP_KERNEL);
>         if (!entity)
>                 return  -ENOMEM;
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
