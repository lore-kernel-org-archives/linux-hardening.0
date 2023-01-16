Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A191CC677F1
	for <linux-hardening@archiver.kernel.org>; Mon, 16 Jan 2023 16:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjAPQhd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 Jan 2023 11:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjAPQhJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 Jan 2023 11:37:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DB22B0BD
        for <linux-hardening@vger.kernel.org>; Mon, 16 Jan 2023 08:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673886301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SapRDhSD4bg3SNicTSW2wGgbS66LIJZoHqZZ/9cufV4=;
        b=KKec3WhzPW49Hf4c0lgI1FRD59s0ltp1jZD5Yma+1MwitgrYXw0tyZPhSThkpO6AHUUO4v
        OYHEynqate4/Ir6Jo0Oi4hL3BoIw4aiXylOydVFyoQRLwAb159N6mDYGCmhqIGiDvDtLrq
        Uxt37DiTFFr5SFf1rS0ymavoWvHpDfk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-246-lMZAZEBqOPq-hywVjxmMcQ-1; Mon, 16 Jan 2023 11:25:00 -0500
X-MC-Unique: lMZAZEBqOPq-hywVjxmMcQ-1
Received: by mail-lf1-f72.google.com with SMTP id bf20-20020a056512259400b004b57544aad2so10597750lfb.14
        for <linux-hardening@vger.kernel.org>; Mon, 16 Jan 2023 08:25:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SapRDhSD4bg3SNicTSW2wGgbS66LIJZoHqZZ/9cufV4=;
        b=joRXUyd39JahCqihc1fQot6MUnhH5mDVQUqZrHR7dnbXmiY6y/z7lNaKWndzPy/gkr
         C+3n/ZMoKnX7b9w+Nge0jrKr4XtSAh/JXin0WhAe6YZAfAHGXQHFxHJfx+gRKdzs9Pys
         m2mT2nqgb7/vePfvFt/3fUDDDgDVMvGXThDdtslj3LU9SBAXq9Tw0GU9TbtkpcvO6wLO
         9JJydSkUqA6qJ8P+Ds/Oj4XzMR2q+M3zfSSc00oR7a/8QedkcjPRR8K9SOaeb/2WpyDx
         vuvUSUBuyMPTUIMYSzTyo1uM1K5aLezBvpx6kJZDU9AU2ujhTsuSpr9Uwme19TO7Dy6o
         Msnw==
X-Gm-Message-State: AFqh2koFwdqwDACEPpVgNftYf7ePzpmrd++dZ2vs/c0DgJALgmdEWFrg
        ZqDpXXTKdidgX5AracwpqzWM1RBnV+sMkNTvr08hcQKDjodWzCwN87xMt38DxsS0dogXooggMwo
        7m9xw9TICbeeUt3f+gr2DgAsGmbPa+knnprBJWxujo4/4
X-Received: by 2002:ac2:4f8c:0:b0:4d0:7b7:65dc with SMTP id z12-20020ac24f8c000000b004d007b765dcmr483287lfs.122.1673886298915;
        Mon, 16 Jan 2023 08:24:58 -0800 (PST)
X-Google-Smtp-Source: AMrXdXskVXALh3cMxytws6o+ulKkC0aRueGIcJS8YRlvP7WpfCxojGKp4y72qPmz5veoTJzcgsV96C0ycbrb/7Q/f08=
X-Received: by 2002:ac2:4f8c:0:b0:4d0:7b7:65dc with SMTP id
 z12-20020ac24f8c000000b004d007b765dcmr483278lfs.122.1673886298656; Mon, 16
 Jan 2023 08:24:58 -0800 (PST)
MIME-Version: 1.0
References: <20230103234835.never.378-kees@kernel.org> <Y7TNtQqunHIW8her@work>
In-Reply-To: <Y7TNtQqunHIW8her@work>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 16 Jan 2023 17:24:47 +0100
Message-ID: <CACO55tsyCtf-_mCPVEo-4Dj_mAu-tnNTTjP75wx=9n+TS1XVvw@mail.gmail.com>
Subject: Re: [RESEND][PATCH] drm/nouveau/fb/ga102: Replace zero-length array
 of trailing structs with flex-array
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-hardening@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Gourav Samaiya <gsamaiya@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jan 4, 2023 at 1:52 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> On Tue, Jan 03, 2023 at 03:48:36PM -0800, Kees Cook wrote:
> > Zero-length arrays are deprecated[1] and are being replaced with
> > flexible array members in support of the ongoing efforts to tighten the
> > FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> > with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> >
> > Replace zero-length array with flexible-array member.
> >
> > This results in no differences in binary output.
> >
> > [1] https://github.com/KSPP/linux/issues/78
> >
> > Cc: Ben Skeggs <bskeggs@redhat.com>
> > Cc: Karol Herbst <kherbst@redhat.com>
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Gourav Samaiya <gsamaiya@nvidia.com>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: nouveau@lists.freedesktop.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Here is my RB again:
>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

will push in a moment

> Thanks!
> --
> Gustavo
>
> > ---
> > Sent before as: https://lore.kernel.org/all/20221118211207.never.039-kees@kernel.org/
> > ---
> >  drivers/gpu/drm/nouveau/include/nvfw/hs.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/include/nvfw/hs.h b/drivers/gpu/drm/nouveau/include/nvfw/hs.h
> > index 8c4cd08a7b5f..8b58b668fc0c 100644
> > --- a/drivers/gpu/drm/nouveau/include/nvfw/hs.h
> > +++ b/drivers/gpu/drm/nouveau/include/nvfw/hs.h
> > @@ -52,7 +52,7 @@ struct nvfw_hs_load_header_v2 {
> >       struct {
> >               u32 offset;
> >               u32 size;
> > -     } app[0];
> > +     } app[];
> >  };
> >
> >  const struct nvfw_hs_load_header_v2 *nvfw_hs_load_header_v2(struct nvkm_subdev *, const void *);
> > --
> > 2.34.1
> >
>

