Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A6EC3DA7A
	for <linux-hardening@archiver.kernel.org>; Fri,  6 Jan 2023 11:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjAFLoA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 6 Jan 2023 06:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjAFLn7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 6 Jan 2023 06:43:59 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCF06A0D6
        for <linux-hardening@vger.kernel.org>; Fri,  6 Jan 2023 03:43:59 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id b2so1418156pld.7
        for <linux-hardening@vger.kernel.org>; Fri, 06 Jan 2023 03:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=04eEBcfPF9rPWJ6oe8vSrIbuReCNM+F3t+uhS5IgjAI=;
        b=eTbHhoFLjQJuPbwPLx+3u4gPgft2Pc5mtQeE0YFtzDmI1Ffve96+xCYRtzTIcYRbie
         z08AL6l6eADTEDx42za6p3tIDuC+kO6hzPIxxF2h/FlDkJrbrrYxyHb6Akm2bw4S5zUL
         zRyxdg74QrapIdR150Zp6h2SRd1jot0uGWzrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04eEBcfPF9rPWJ6oe8vSrIbuReCNM+F3t+uhS5IgjAI=;
        b=Pi0ng335HV6w9qrW8XT9uDC6t2tFo0hJ2lgaamIqlE+ieZFGJ80BjCkd/BTDxhhgZL
         oORmMnFRhBaxidzUI2gW2PukBEsp7FQf71KwR7vmJH4avUd5fkSUzu3XsLuSf75+pGBX
         T8QraKy83Zz6nRFNES7arOuNMcXNi4beskCWDhH0h6DhkDn7d/BFZnY6ZFnRamr2ZUwr
         3y+f59fnJT7cWOhpwP1N1+yqx2Bz95FB81uLh43Q6tnVYB8WIcjH2wzurebO6XHU+EG8
         qpADHm/vxzyIjpTjkRpEKoot4dUzYIGKWvJuHAIJKZhWb5MToYJXk7eb4fKyHmkY9qA/
         rRZw==
X-Gm-Message-State: AFqh2kphclLlOO2nzXOw2p+As1dkyQKANPVHFsXLMsyW3Q4Tif280Gg7
        O3HBB2g6vsb1wqo72aArRD+o5mWdbtmviH3Li1o=
X-Google-Smtp-Source: AMrXdXsxSLR7hN32nwj5H2QWcPg/ukVSMaIgK8f2exWwzHrSmX1LeiaX4NM8I/Cf7dApXJwBpuI9HA==
X-Received: by 2002:a05:6a20:2d22:b0:b0:30d8:d48 with SMTP id g34-20020a056a202d2200b000b030d80d48mr71464071pzl.42.1673005438381;
        Fri, 06 Jan 2023 03:43:58 -0800 (PST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com. [209.85.214.170])
        by smtp.gmail.com with ESMTPSA id i7-20020a655b87000000b0049f476e9906sm765701pgr.53.2023.01.06.03.43.56
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 03:43:57 -0800 (PST)
Received: by mail-pl1-f170.google.com with SMTP id w3so1432956ply.3
        for <linux-hardening@vger.kernel.org>; Fri, 06 Jan 2023 03:43:56 -0800 (PST)
X-Received: by 2002:a17:902:934b:b0:191:2a9b:ec94 with SMTP id
 g11-20020a170902934b00b001912a9bec94mr3686097plp.8.1673005436272; Fri, 06 Jan
 2023 03:43:56 -0800 (PST)
MIME-Version: 1.0
References: <20230106061659.never.817-kees@kernel.org>
In-Reply-To: <20230106061659.never.817-kees@kernel.org>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 6 Jan 2023 12:43:44 +0100
X-Gmail-Original-Message-ID: <CANiDSCtTz4mpTz4RHBzNXL=yBvXNXHBZQ-HYMFegLytoScW4eA@mail.gmail.com>
Message-ID: <CANiDSCtTz4mpTz4RHBzNXL=yBvXNXHBZQ-HYMFegLytoScW4eA@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Silence memcpy() run-time false positive warnings
To:     Kees Cook <keescook@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        ionut_n2001@yahoo.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Kees

Thanks for the patch

Would it make more sense to replace *mem with a structure/union. Something like:
https://patchwork.linuxtv.org/project/linux-media/patch/20221214-uvc-status-alloc-v4-0-f8e3e2994ebd@chromium.org/

Regards!

On Fri, 6 Jan 2023 at 07:19, Kees Cook <keescook@chromium.org> wrote:
>
> The memcpy() in uvc_video_decode_meta() intentionally copies across the
> length and flags members and into the trailing buf flexible array.
> Split the copy so that the compiler can better reason about (the lack
> of) buffer overflows here. Avoid the run-time false positive warning:
>
>   memcpy: detected field-spanning write (size 12) of single field "&meta->length" at drivers/media/usb/uvc/uvc_video.c:1355 (size 1)
>
> Additionally fix a typo in the documentation for struct uvc_meta_buf.
>
> Reported-by: ionut_n2001@yahoo.com
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216810
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 4 +++-
>  include/uapi/linux/uvcvideo.h     | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index d2eb9066e4dc..b67347ab4181 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -1352,7 +1352,9 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
>         if (has_scr)
>                 memcpy(stream->clock.last_scr, scr, 6);
>
> -       memcpy(&meta->length, mem, length);
> +       meta->length = mem[0];
> +       meta->flags  = mem[1];
> +       memcpy(meta->buf, &mem[2], length - 2);
>         meta_buf->bytesused += length + sizeof(meta->ns) + sizeof(meta->sof);
>
>         uvc_dbg(stream->dev, FRAME,
> diff --git a/include/uapi/linux/uvcvideo.h b/include/uapi/linux/uvcvideo.h
> index 8288137387c0..a9d0a64007ba 100644
> --- a/include/uapi/linux/uvcvideo.h
> +++ b/include/uapi/linux/uvcvideo.h
> @@ -86,7 +86,7 @@ struct uvc_xu_control_query {
>   * struct. The first two fields are added by the driver, they can be used for
>   * clock synchronisation. The rest is an exact copy of a UVC payload header.
>   * Only complete objects with complete buffers are included. Therefore it's
> - * always sizeof(meta->ts) + sizeof(meta->sof) + meta->length bytes large.
> + * always sizeof(meta->ns) + sizeof(meta->sof) + meta->length bytes large.
>   */
>  struct uvc_meta_buf {
>         __u64 ns;
> --
> 2.34.1
>


-- 
Ricardo Ribalda
