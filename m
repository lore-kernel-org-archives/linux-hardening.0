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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3997C4363C
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 15:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74580217BA
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 15:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZldCsic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgJHPqf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Oct 2020 11:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgJHPqf (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Oct 2020 11:46:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E03C061755;
        Thu,  8 Oct 2020 08:46:33 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i1so1033465wro.1;
        Thu, 08 Oct 2020 08:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZQaMEajHyUF05ChIcIT2Hr92neMZMi5cbrWN6sbkg5k=;
        b=XZldCsicbz+aKtGedOYbJPbFRVcikpIYetMkNutU64Xq5LzOm751pgZMj541VHyHMV
         dni2ARbVTgsf9+GhThAYmEQNtjk752QWWN3WrpVdXC8djlbx2SAxcnZ7Bnvik/f9zoiT
         7nuT7zdSWNm4lbd52lBX6vf4jya0EpP4a+O3Os0n4KiEIxFXm6NBGd6Pyu50MIF/dmcm
         loJUl3sCVyS/JglA7KRDbjy6WlkM9cUtnBdzLXmn1nowlbDAgB/1yow7O59ykO8Ruqbn
         ImGTgS05xUxIuVXaoVPyy9e5hr9NtPO/KplM91IbOWi5rfJVuwTm1k+JjqKpgYBQ20wD
         tt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZQaMEajHyUF05ChIcIT2Hr92neMZMi5cbrWN6sbkg5k=;
        b=pxhTwAKJrCcOzZLJhLPI6JdVRdRvQD5bA9xUBKS0Dt8Pb5YS53LFnvlOuD0DdRBP6o
         kiR2sfAhgWbWq51YvlexgTSREoKj5nyalvywsmEA+T4bQxA2TLJL4yd4QykeqDzvV58T
         urtAjVWM7Iz1fM8URPGeYP3vMoIRGw8HUQRokjf6YXTRAEKDuS2lJCKmEkWhsg1eJP8B
         1GLEih4dGmvLOBQwZ9OpyttvJPyKNG7IhM/hfOZMARcM5JX0S1csVaeK8LfWIuw6v0Lk
         4aGQGLZ+zf7KExtKKhbmtlXaUBd143kPJYuUgh4uyjbzDPD5S8KmkpC5yilOqnlosWnW
         gXKQ==
X-Gm-Message-State: AOAM531VJTPBrdPnF7c54B97WXb4KFdoH0V2obP3EJEc0mFy9jdD2MkV
        EBbas9AnIfqS4JnSiEdEs+qPPUaVCh34BqWU8jA=
X-Google-Smtp-Source: ABdhPJwJVR465d2vJNtPiG0LfE9lDMbFj9J45MtW1i6G8uw6lJF3FYOoDFS9nwvtHCVOBdJjEFcVL8DU1vinUmS4kuc=
X-Received: by 2002:adf:aa0a:: with SMTP id p10mr9863785wrd.362.1602171992051;
 Thu, 08 Oct 2020 08:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602020074.git.gustavoars@kernel.org> <00a464a7e2141dc3117720784d76048e7e3dbed6.1602020074.git.gustavoars@kernel.org>
In-Reply-To: <00a464a7e2141dc3117720784d76048e7e3dbed6.1602020074.git.gustavoars@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 8 Oct 2020 11:46:20 -0400
Message-ID: <CADnq5_PX2LokA0VgC-NLZfCa=k8vc9PWYX5WWVH5RCsEzZc+BQ@mail.gmail.com>
Subject: Re: [PATCH 14/14] drm/amd/pm: Replace one-element array with
 flexible-array in struct ATOM_Vega10_GFXCLK_Dependency_Table
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        linux-hardening@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 7, 2020 at 12:05 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use =E2=80=9Cflexible array members=E2=80=9D[1] for these c=
ases. The older
> style of one-element or zero-length arrays should no longer be used[2].
>
> Use a flexible-array member in struct ATOM_Vega10_GFXCLK_Dependency_Table
> instead of a one-element array.
>
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.9-rc1/process/deprecated.html#zero=
-length-and-one-element-arrays
>
> Build-tested-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/5f7d61dd.O8jxxI5C6P9FOb%2Fd%25lkp@inte=
l.com/
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

This header is shared with firmware, so I'm leaving it as is for consistenc=
y.

Alex


> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h b/dr=
ivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
> index c934e9612c1b..a6968009acc4 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
> @@ -163,7 +163,7 @@ typedef struct _ATOM_Vega10_MCLK_Dependency_Record {
>  typedef struct _ATOM_Vega10_GFXCLK_Dependency_Table {
>      UCHAR ucRevId;
>      UCHAR ucNumEntries;                                         /* Numbe=
r of entries. */
> -    ATOM_Vega10_GFXCLK_Dependency_Record entries[1];            /* Dynam=
ically allocate entries. */
> +    ATOM_Vega10_GFXCLK_Dependency_Record entries[];             /* Dynam=
ically allocate entries. */
>  } ATOM_Vega10_GFXCLK_Dependency_Table;
>
>  typedef struct _ATOM_Vega10_MCLK_Dependency_Table {
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
