Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3265CC433E0
	for <linux-hardening@archiver.kernel.org>; Mon, 15 Feb 2021 18:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC6A764DE8
	for <linux-hardening@archiver.kernel.org>; Mon, 15 Feb 2021 18:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhBOS54 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 15 Feb 2021 13:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhBOS5u (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 15 Feb 2021 13:57:50 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93AAC061574;
        Mon, 15 Feb 2021 10:57:09 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id d20so8730754oiw.10;
        Mon, 15 Feb 2021 10:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0af+WuSCKKu/Gkao8Lc4ne4kj0xNUEww6DlbPnUDKhk=;
        b=NMlT+kWg96hgUcvIJOoGgvLjN7FstIeFJZXWH4AdON1ltmrsIvqJtTblNzY+cDXA50
         bMHOG80pUsuXUz/impsrJWKpD45Dpwkx8N5Ki2ecqOVPeZK/+Qw8vwpxKkw1C1DJEpld
         zU85b/WZYSoDlIxkb3gVtx2X1f7VeCmA7t/oeOHjNfOxJ7d+zR8qNpIPsbJVEs0OzS9d
         CQh35RePwBFPiloBxtmXYK0YQA9Dyn4BD9N5jZlDCbsZHsm/OE7oTSjU3p8gN/y9AbMf
         tT5CAmSliQVpsukjSvD5crMVwqUEZUyqCBW6uKVSo4Sx8va53e3QFOiwGyrVvq2SXS9c
         3z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0af+WuSCKKu/Gkao8Lc4ne4kj0xNUEww6DlbPnUDKhk=;
        b=khNyUzNHVnO5tWqNZGOMJl/OnBETBbKZaMo8iyNJ7d1p1mbYUuvptiqKS6ve+gufPj
         Jg+9lDbhD5JmgWatKXl7xDQU8fQB5qv+excVd0hFnmKib3o4SXUC5zFSg1UqBaRFPnAy
         KqrKWXKk6h92RX7+Wx34OJYw/fn+DW0BgmgmapJFcNdxmZx5ycbE/KC9X/JQp09f7//L
         9QdBS/7YL4hiqzC0AAwN8g2wB+h8Os8QUcIEpHVWaxoKLoXbjYURMyqVfbnbnR4cwgPI
         K0d+RasTDNCAbe7WHp93iS3rPIJKt931x234CoZpCpg+sipHCbTRHaLE0kRJWP/8Uu5f
         CveQ==
X-Gm-Message-State: AOAM533mogDMTJDNmkQpMoum9VUliQ1oN/shVY24pliGoKg59wGMnyMU
        GYHJCxzCaJ0I+5fBrOrZkOrbWGwJKGNFWs5VLtKr0CJr
X-Google-Smtp-Source: ABdhPJxL6zZIj+6kyNCLjENdlwv2Lhea/JfbdHl6sy5eSywH4TjKjHKdnOun7wD6LEYknuJ/MBbSTUuCPUJfG61bVN0=
X-Received: by 2002:aca:5404:: with SMTP id i4mr190631oib.123.1613415429195;
 Mon, 15 Feb 2021 10:57:09 -0800 (PST)
MIME-Version: 1.0
References: <20210210232600.GA66488@embeddedor>
In-Reply-To: <20210210232600.GA66488@embeddedor>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 15 Feb 2021 13:56:58 -0500
Message-ID: <CADnq5_MSZJYLRJ-A8jAzUWAaK-7N46wj4BQk=FWxrBkDgbojbg@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/pm: Replace one-element array with
 flexible-array in struct _ATOM_Vega10_GFXCLK_Dependency_Table
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

On Wed, Feb 10, 2021 at 6:36 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use =E2=80=9Cflexible array members=E2=80=9D[1] for these c=
ases. The older
> style of one-element or zero-length arrays should no longer be used[2].
>
> Use flexible-array member in struct _ATOM_Vega10_GFXCLK_Dependency_Table,
> instead of one-element array.
>
> Also, this helps with the ongoing efforts to enable -Warray-bounds and
> fix the following warning:
>
> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c: In funct=
ion =E2=80=98vega10_get_pp_table_entry_callback_func=E2=80=99:
> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:3113:30: =
warning: array subscript 4 is above array bounds of =E2=80=98ATOM_Vega10_GF=
XCLK_Dependency_Record[1]=E2=80=99 {aka =E2=80=98struct _ATOM_Vega10_GFXCLK=
_Dependency_Record[1]=E2=80=99} [-Warray-bounds]
>  3113 |     gfxclk_dep_table->entries[4].ulClk;
>       |     ~~~~~~~~~~~~~~~~~~~~~~~~~^~~
>
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.9/process/deprecated.html#zero-len=
gth-and-one-element-arrays
>
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/109
> Build-tested-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/6023ff3d.WY3sSCkGRQPdPlVo%25lkp@intel.=
com/
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h b/dr=
ivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
> index c934e9612c1b..9c479bd9a786 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
> @@ -161,9 +161,9 @@ typedef struct _ATOM_Vega10_MCLK_Dependency_Record {
>  } ATOM_Vega10_MCLK_Dependency_Record;
>
>  typedef struct _ATOM_Vega10_GFXCLK_Dependency_Table {
> -    UCHAR ucRevId;
> -    UCHAR ucNumEntries;                                         /* Numbe=
r of entries. */
> -    ATOM_Vega10_GFXCLK_Dependency_Record entries[1];            /* Dynam=
ically allocate entries. */
> +       UCHAR ucRevId;
> +       UCHAR ucNumEntries;                                     /* Number=
 of entries. */
> +       ATOM_Vega10_GFXCLK_Dependency_Record entries[];         /* Dynami=
cally allocate entries. */
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
