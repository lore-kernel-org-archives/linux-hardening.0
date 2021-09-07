Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1430EC433EF
	for <linux-hardening@archiver.kernel.org>; Tue,  7 Sep 2021 17:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E168160EBA
	for <linux-hardening@archiver.kernel.org>; Tue,  7 Sep 2021 17:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345333AbhIGRBh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 7 Sep 2021 13:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbhIGRBh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 7 Sep 2021 13:01:37 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D93C061575;
        Tue,  7 Sep 2021 10:00:30 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so13566735otk.9;
        Tue, 07 Sep 2021 10:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tX3dLY3KjaJdK+boJZc/jDVbrXqd0jZWFd+gRGqD1s0=;
        b=JDQqLN0MwwK5CCpl1DnA4YhnQTWZvr8TH6HVybD0AeeTcxvlEvUwKAO1AVnNz+g5Fl
         F+VYli6qUA/dz6+QZTxAMfsN3DkNBwjnjP4X4YICQi1JZm2ZqZjXje/Zxd6aPlUTkpgb
         xCI9iENlZWLA0VcWtac6VIx8hJXRv3+hmwVbPx+1sodHQRpAQjqDIoTMziGMRvlRpG8/
         QudUgxMk5JoVXuTso95DqKHtS2Aw8+WwY5CSfoSLb7gbNFAIgygP58dAzmBidrDkt7LN
         u4V+EtJEJdwac6M455A+mc3vWCI8YZSv2INqZz8drbbeGoG5CVhKlBWpqt0/rwgxrd5b
         pMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tX3dLY3KjaJdK+boJZc/jDVbrXqd0jZWFd+gRGqD1s0=;
        b=Otv90+FJwAye+7A4CxuPB/GekolIalC7kHm+9Spt9pnVG8xZxdJrfyTFRuSaed2CkL
         nR1Gv/fUdWvTQpmeLY2jA/Ya8rTHMBWiMYNYHhVQ5asfvb6g644D0+G1J6nXboJ9oydi
         3moRTZ1ANHtYtxHM0MgSHtWxuKCGZfQ0Q54hm6rgDHegad/mH2WpaL/XH+jhoknD2R3i
         Q9XV2HQWP4MUE/idR8TRHUeNZdhRI9kto2VXnGv8m6Z6HJXw3epwrhylQB3AQcR0s+FD
         xQHwxU5dwsKeMxHLiR9xNQXRiZVPS6YGV0svMPkuea1QCh2JZHYVjPVqMZ3YIbSwdD+/
         UeXw==
X-Gm-Message-State: AOAM5308I/APPCXkykuSsiiOYu4s+atFDRwbchdJwKYPqzHQahfCaYNt
        ssybvY7j7MyNnFZB5Oa0gawLKKWSARpzu4GImaAzG9b1
X-Google-Smtp-Source: ABdhPJzwSR0tEBZdt+IeLRjOaJvXXaOQn4kPRkpLoZWTSbNFLWCZ+U8QwcBpUgbwb+zy7V3LmUG/aj6K0dQ93vW2HLg=
X-Received: by 2002:a05:6830:25d3:: with SMTP id d19mr16404248otu.357.1631034030040;
 Tue, 07 Sep 2021 10:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210904154106.9550-1-len.baker@gmx.com>
In-Reply-To: <20210904154106.9550-1-len.baker@gmx.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 7 Sep 2021 13:00:19 -0400
Message-ID: <CADnq5_P_Vq9Qw+K4-mOf-VYDq20UQJ3k1PE94f9-nqi36qmE3g@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Prefer kcalloc over open coded arithmetic
To:     Len Baker <len.baker@gmx.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Applied.  Thanks!

Alex

On Sat, Sep 4, 2021 at 11:41 AM Len Baker <len.baker@gmx.com> wrote:
>
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
>
> So, refactor the code a bit to use the purpose specific kcalloc()
> function instead of the calculated size argument in the kzalloc()
> function.
>
> [1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
>
> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---
>  drivers/gpu/drm/radeon/r600_dpm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/r600_dpm.c b/drivers/gpu/drm/radeon/r600_dpm.c
> index 35b77c944701..fd4226b99862 100644
> --- a/drivers/gpu/drm/radeon/r600_dpm.c
> +++ b/drivers/gpu/drm/radeon/r600_dpm.c
> @@ -820,12 +820,12 @@ union fan_info {
>  static int r600_parse_clk_voltage_dep_table(struct radeon_clock_voltage_dependency_table *radeon_table,
>                                             ATOM_PPLIB_Clock_Voltage_Dependency_Table *atom_table)
>  {
> -       u32 size = atom_table->ucNumEntries *
> -               sizeof(struct radeon_clock_voltage_dependency_entry);
>         int i;
>         ATOM_PPLIB_Clock_Voltage_Dependency_Record *entry;
>
> -       radeon_table->entries = kzalloc(size, GFP_KERNEL);
> +       radeon_table->entries = kcalloc(atom_table->ucNumEntries,
> +                                       sizeof(struct radeon_clock_voltage_dependency_entry),
> +                                       GFP_KERNEL);
>         if (!radeon_table->entries)
>                 return -ENOMEM;
>
> --
> 2.25.1
>
