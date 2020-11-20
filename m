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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24ECC2D0E4
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 22:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 701E42236F
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 22:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3DJ41JX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgKTWpU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 17:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgKTWpU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 17:45:20 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C2BC0613CF;
        Fri, 20 Nov 2020 14:45:19 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id e81so8447133ybc.1;
        Fri, 20 Nov 2020 14:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IGDOWKKq6xCnwWSk70Q1NBr14x+oJN9x0alo3n+41Pg=;
        b=T3DJ41JXNehc3YEEyUuo5UvcD/cQ+JatOO/tdt3eh50lPdetbDtOJYdAPhYJTPdk1t
         +6AFOHIME9KTQe0XLW8au3BnP8i+FCqBSF74pQAD2VJ1Ta+fC0cRMrVdOZKt7VZbGiKF
         WBy0ZyY5/ccNsVar/FG0NF/kE3neLoEA5W/gWyaynqAljCK3P9et7g2Qt3c4np6pZUPW
         6MkwxwgE+N1arvNhqFf6WtXV4qfl0ecoZublkqxLjM3Gbab8ZSYwDgUdg0c+T3WxgMzG
         0KiY6BJEcezFhOtJfuWg09qtqK5EtWKnDEvtV5zB6oBjXTdXJwbBlisPz9Ze5/LMmB8i
         j1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGDOWKKq6xCnwWSk70Q1NBr14x+oJN9x0alo3n+41Pg=;
        b=UFicYTIDBXTUBv5P2f0doS11cuGoe8lAwIErnUakEXonIP7alqLimX14um4a8LUt8D
         r3IXhgJb6p37et0FPEjZv987mJhGIVw4S3zZ9j+N17rXvUrvfSeP5d/+c315BRYzmgwe
         PRBxBdMj4rU/U+XSYz+CyRu5UemOuotu/FR6ceevkI9+nk9uYiSPpkPynsQcbXp8dPcV
         pMBqnPhw4zx0pXDDt9CEuVagslYJkXQeq0IXQOHRzlJFiN0rnqEi6/ziTcsoXHZTYKSR
         WmvZW+xRiG88uu5kDLI8FmIrJbYMtly320cwtcDCRCVf+GKJuRjvpWmV5RXy9q5wqWbn
         H+IA==
X-Gm-Message-State: AOAM532luHABQg7k+RfSCdeG1h7JABX78s43HTjmLIDAesnNxabONmcp
        NfGQpbRicCcoHcLFCmIJC+WTGu+4G0/+kJJR+II=
X-Google-Smtp-Source: ABdhPJy4XXPGwSb5+sjtbSWzHe15A2qwK1ApZqcOU1rinnFDil8g58upNilSYntsp396xqgfbJ7fwyczHoFalkRV8eI=
X-Received: by 2002:a25:397:: with SMTP id 145mr20533812ybd.6.1605912319170;
 Fri, 20 Nov 2020 14:45:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605896059.git.gustavoars@kernel.org> <9ac81a4aab74e0b3317172e66a985fe6d1ae4e1b.1605896059.git.gustavoars@kernel.org>
In-Reply-To: <9ac81a4aab74e0b3317172e66a985fe6d1ae4e1b.1605896059.git.gustavoars@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 20 Nov 2020 17:45:07 -0500
Message-ID: <CADnq5_Ow_b35AuCGO=LncniDDcwSeS9fSpUiJd+vZYfc29TM0g@mail.gmail.com>
Subject: Re: [PATCH 028/141] drm/amd/display: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
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

On Fri, Nov 20, 2020 at 1:28 PM Gustavo A. R. Silva
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
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  | 1 +
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 2 ++
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c      | 1 +
>  3 files changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> index ad394aefa5d9..23a373ca94b5 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> @@ -1198,6 +1198,7 @@ static enum bp_result bios_parser_get_embedded_panel_info(
>                 default:
>                         break;
>                 }
> +               break;
>         default:
>                 break;
>         }
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> index 29d64e7e304f..fd1e64fa8744 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> @@ -903,6 +903,7 @@ static enum bp_result bios_parser_get_soc_bb_info(
>                         break;
>                 case 4:
>                         result = get_soc_bb_info_v4_4(bp, soc_bb_info);
> +                       break;
>                 default:
>                         break;
>                 }
> @@ -1019,6 +1020,7 @@ static enum bp_result bios_parser_get_embedded_panel_info(
>                 default:
>                         break;
>                 }
> +               break;
>         default:
>                 break;
>         }
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index fec87a2e210c..b9254a87ee73 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -1052,6 +1052,7 @@ static bool dc_link_detect_helper(struct dc_link *link,
>
>                                 return false;
>                         }
> +                       break;
>                 default:
>                         break;
>                 }
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
