Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8421C433FE
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Nov 2022 21:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiKAVyU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Nov 2022 17:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiKAVyT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Nov 2022 17:54:19 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9843255A8
        for <linux-hardening@vger.kernel.org>; Tue,  1 Nov 2022 14:54:17 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so219044pjk.1
        for <linux-hardening@vger.kernel.org>; Tue, 01 Nov 2022 14:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GA8q7YVJ2PrEh80a5RzqM/oJzGj5JG0NgG09XRsMdqg=;
        b=JkZ+NC3LNfYR65ttedUVvXPCnV5s6itLxeP+NXZl9F+Hf2bi7IyxEl7/jUySG1Xjhe
         JqrcWbR3x+hL6Zr6k+XJrs31lcGRbWs9g5gNYujB0mhay/HUyNl68ZnjyhG6g1xE/v67
         ReYOIHvuBeyDa/kXn0GjMwwiX+LBbz10PDs/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GA8q7YVJ2PrEh80a5RzqM/oJzGj5JG0NgG09XRsMdqg=;
        b=YDiFHRJbN7EKtUyyAbJlGc+eS7bYEstxf4y3B3YpLFMPFy4JGswl/Uoz6IOroCJ/Vp
         qLAR7h0tU4u0UHBp4H7px4L6zTPFdjhoVZse3N5dQ8rYKzEcPCa5PhwXnYS45wKsoZRu
         KEGEx78uKFYFCB4ySo8JAGvdsrut9FCjnEGKr5PgI1Wbhad+I5zl+7eXBi2YsapIPlVv
         XNdU4pyx/HrTx0A2Cy79Q8kWvXWk+GUDGjy1NnaRZFV80BOrXPxmDeB0LMWdasaxawEB
         8ZPa+IXGpYIuBdIHKAqQbFnf+/WzRp8gHqgIEmOeS3PAUV/ZSAPWtrdp+ho2RdEX1V60
         XSWg==
X-Gm-Message-State: ACrzQf24ZtSfLzIhIRFjS6fEuMkTfLOYCScLrOKeLDK0875dowIP3ACn
        i/aWXyK4v6KHLfSrXE23aWzpnQ==
X-Google-Smtp-Source: AMsMyM5OvRjW3oHM3Bghe5cW2+FRx8fyhjBnToJnwrbr0Jg8a5Y/wWRZYIgidp7GwXYqel1nldMV0g==
X-Received: by 2002:a17:903:200b:b0:186:892f:9f0b with SMTP id s11-20020a170903200b00b00186892f9f0bmr21292591pla.56.1667339657068;
        Tue, 01 Nov 2022 14:54:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902e89200b0017f92246e4dsm6817494plg.181.2022.11.01.14.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 14:54:16 -0700 (PDT)
Date:   Tue, 1 Nov 2022 14:54:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] [next] drm/radeon: Replace one-element array with
 flexible-array member
Message-ID: <202211011443.7BDB243D8D@keescook>
References: <Y1trhRE3nK5iAY6q@mail.google.com>
 <Y1yetX1CHsr+fibp@mail.google.com>
 <CADnq5_Mod90O=tN26+Yi74WPYxpVtss+LG_+_HZyFv2EtzR+MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_Mod90O=tN26+Yi74WPYxpVtss+LG_+_HZyFv2EtzR+MA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 01, 2022 at 10:42:14AM -0400, Alex Deucher wrote:
> On Fri, Oct 28, 2022 at 11:32 PM Paulo Miguel Almeida
> <paulo.miguel.almeida.rodenas@gmail.com> wrote:
> >
> > One-element arrays are deprecated, and we are replacing them with
> > flexible array members instead. So, replace one-element array with
> > flexible-array member in struct _ATOM_FAKE_EDID_PATCH_RECORD and
> > refactor the rest of the code accordingly.
> >
> > It's worth mentioning that doing a build before/after this patch results
> > in no binary output differences.
> >
> > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > routines on memcpy() and help us make progress towards globally
> > enabling -fstrict-flex-arrays=3 [1].
> 
> This seems like a worthy goal, and I'm not opposed to the patch per
> se, but it seems a bit at odds with what this header represents.
> atombios.h represents the memory layout of the data stored in the ROM
> on the GPU.  This changes the memory layout of that ROM.  We can work

It doesn't though. Or maybe I'm misunderstanding what you mean.

> around that in the driver code, but if someone were to take this
> header to try and write some standalone tool or use it for something
> else in the kernel, it would not reflect reality.

Does the ROM always only have a single byte there? This seems unlikely
given the member "ucFakeEDIDLength" (and the code below).

The problem on the kernel side is that the code just before the patch
context in drivers/gpu/drm/amd/amdgpu/atombios_encoders.c will become
a problem soon:

        if (fake_edid_record->ucFakeEDIDLength) {
                struct edid *edid;
                int edid_size =
                        max((int)EDID_LENGTH, (int)fake_edid_record->ucFakeEDIDLength);
                edid = kmalloc(edid_size, GFP_KERNEL);
                if (edid) {
                        memcpy((u8 *)edid, (u8 *)&fake_edid_record->ucFakeEDIDString[0],
                               fake_edid_record->ucFakeEDIDLength);

                        if (drm_edid_is_valid(edid)) {
	...

the memcpy() from "fake_edid_record->ucFakeEDIDString" will eventually
start to WARN, since the size of that field will be seen as a single byte
under -fstrict-flex-arrays. At this moment, no, there's neither source
bounds checking nor -fstrict-flex-arrays, but we're trying to clean up
everything we can find now so that we don't have to do this all again
later. :)

-Kees

P.S. Also this could be shorter with fewer casts:

                struct edid *edid;
                u8 edid_size =
                        max_t(u8, EDID_LENGTH, fake_edid_record->ucFakeEDIDLength);
                edid = kmemdup(fake_edid_record->ucFakeEDIDString, edid_size, GFP_KERNEL);
                if (edid) {
                        if (drm_edid_is_valid(edid)) {
                                adev->mode_info.bios_hardcoded_edid = edid;
	...

-- 
Kees Cook
