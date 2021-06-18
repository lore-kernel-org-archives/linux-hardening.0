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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931F0C49361
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Jun 2021 20:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70FB6613C2
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Jun 2021 20:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbhFRUiZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Jun 2021 16:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhFRUiX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Jun 2021 16:38:23 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1F7C061574;
        Fri, 18 Jun 2021 13:36:14 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so10999344otl.0;
        Fri, 18 Jun 2021 13:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FwzvVbuJlgu6DBRUWFo9BEm/hzQ+wY0U0PlSZsQGHWY=;
        b=WdnhFyyu6n7P6JsoopbACwoe7AOK+QOg+3/Ko1PmYCVdMIS9EvhxqPe0fqh4xbv28G
         KQFDPBb7TRq7Fgk2W4R7099i+F1aW8MPrZwKy+1LSEYUzzEuodod0s6kK3yNfs8rlb3e
         sgPgI+EEWNOuaE/XLVE3Sb8oehkfPQxQuebacQnQ3s3wsVwZoFmR5/Kw+KU7zrADZyDK
         qeyEC4D8QyUHfcJsUtKp1JbWcaFW1YCI1HvXIDHw2gljF+Yd4flqBwhj8xsLMHYeXyTH
         IJbq8gN4BgMZVAqLoRwYa0/ZyR2pQLD7tiJ3Kn3cSE/E/0UYO3mTAZJsfM4Qyg22Zb69
         ioMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FwzvVbuJlgu6DBRUWFo9BEm/hzQ+wY0U0PlSZsQGHWY=;
        b=qP6I0lsy6SlPPxSYBsjOHTb3shqO4WW5TLNtd/7GESrqxbAgTzIYLqdXJ7svzdQZq/
         z/vAqvgwWB/jqov2a+GkzPjOaxAVSwVqyZaGkLiqjLFDLkvWTNvucMEX0xtnVxh9CxF1
         euMlyqCyKc1S4vGx5km6bGpdTtdmIGLN6ENNhwPdeHok71wBB9xl7hWxX2kTv/Z9egvC
         uI9fKKCs/kydoRUhFf4EinF1yCD7E816V7MyAJwFhfCkqx5quaz5Xu6tj9EqBCxYJ/aY
         2fehK/F9twM9y8WOG4xpEiVTt9mn7CydJWTkXs2gBdEMUUtw5Bb59PMUtzFMEy9d4qJO
         0mlA==
X-Gm-Message-State: AOAM533tHSe7ZqiHb09kpMhCS9I1nvHDeGxZA+DM5puwUITYLWHgXXMb
        hKfnABL7fEJvqV2yowqhgvBdDHI/EcVi4qJeLSE=
X-Google-Smtp-Source: ABdhPJzF78KAFsqPc87SewWRBrPw3zNm1t0kg3ndekO4Ac022ElkbsuZKs6pwn6DG0+gmaEZzECQIoIb8XCyvEaP2MI=
X-Received: by 2002:a05:6830:33ef:: with SMTP id i15mr11036214otu.311.1624048573626;
 Fri, 18 Jun 2021 13:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210616205206.GA17547@embeddedor> <3e68b60f-a9af-1f58-076d-1d348e3bf892@amd.com>
In-Reply-To: <3e68b60f-a9af-1f58-076d-1d348e3bf892@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 18 Jun 2021 16:36:02 -0400
Message-ID: <CADnq5_MZ7vTxH6aB-rsZqSLGaffi6OwgVBDAFcT=16RRNw+UKA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: Fix fall-through warning for Clang
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
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

On Thu, Jun 17, 2021 at 3:20 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
>
>
> On 2021-06-16 4:52 p.m., Gustavo A. R. Silva wrote:
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix
> > the following warning by replacing a /* fall through */ comment
> > with the new pseudo-keyword macro fallthrough:
> >
> > rivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c:672:4: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> >                         case AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER:
> >                         ^
> >
> > Notice that Clang doesn't recognize /* fall through */ comments as
> > implicit fall-through markings, so in order to globally enable
> > -Wimplicit-fallthrough for Clang, these comments need to be
> > replaced with fallthrough; in the whole codebase.
> >
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> > JFYI: We had thousands of these sorts of warnings and now we are down
> >       to just 15 in linux-next. This is one of those last remaining
> >       warnings.
> >
> >  drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> > index 28631714f697..2fb88e54a4bf 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> > @@ -668,7 +668,7 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
> >                               /* polling_timeout_period is in us */
> >                               defer_time_in_ms += aux110->polling_timeout_period / 1000;
> >                               ++aux_defer_retries;
> > -                             /* fall through */
> > +                             fallthrough;
> >                       case AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER:
> >                               retry_on_defer = true;
> >                               fallthrough;
> >
>
