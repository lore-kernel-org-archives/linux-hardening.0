Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C39C433FE
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Nov 2022 22:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKAWmB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiKAWl7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Nov 2022 18:41:59 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94F31DDF7
        for <linux-hardening@vger.kernel.org>; Tue,  1 Nov 2022 15:41:56 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y4so14919605plb.2
        for <linux-hardening@vger.kernel.org>; Tue, 01 Nov 2022 15:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=549rWF/Cs3zs/38lC9NGwtRSOQOXjmIrrlVQub1z2o8=;
        b=X8yNsPnmPfT3SN6GNaL+qXXP6PlWP+tNfOepu9Waku/e8TbMh5Teg/RoEAaxBvZAyp
         86MoLHZvivJ51VxIIlJcdpz/F5d7/wyZli/YZPlxZeL30msR5HHRyHoxNWtQDgse6TbY
         lBpkMDv9gA8YENbSvr5jeWlK6hF7bphcC4SUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=549rWF/Cs3zs/38lC9NGwtRSOQOXjmIrrlVQub1z2o8=;
        b=v7AzPuUHld2ekIrrm5strpTe+vfvuaILgi8sVg7mxZ63C+TcyR7qnTdMWcB1Kezudk
         dUORDsPlXO8KJ2+5uT8fZLOy5K8VNr+KpAGsMCTW25hcoJsHYzODuikuRkLILwgDlPdV
         aiP7RsUZzL4xZtO+lg/0ZHr4owYtIzsJ+JE4AjnpJGGn6JsTiKq4oFy6N96kmV+QFVE6
         22rv9d6JZv0cC3S9x3prcZFNL9JKjNRMG2SCfPqzPFzbe+3mJ7G0mY/jDRlcSNkpJJtK
         NXPebqsr1FNld+F4FjWLx+7zr9HcBIHNyVThFUhGrV/q7Ej9HhqhuF3Wh8+86NVK+mMB
         dPUQ==
X-Gm-Message-State: ACrzQf1v5JAxT+9lBB8OmdSwIuzPCGgcLIWfqFRD+qXF4tkWMntd0SOE
        MqJG9o6gYEz3RGXpxzok9JU6sDdrcHQfHQ==
X-Google-Smtp-Source: AMsMyM5ebbfmmxQLSRv1+X29/5hLVS8lb8HR1kl72PW5ICE/mOVinx4Zw3IXtyUk1+PYEjtzhsFvlg==
X-Received: by 2002:a17:90b:4d0e:b0:1f7:ae99:4d7f with SMTP id mw14-20020a17090b4d0e00b001f7ae994d7fmr38881630pjb.200.1667342516227;
        Tue, 01 Nov 2022 15:41:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b138-20020a621b90000000b0056bc742d21esm7194023pfb.176.2022.11.01.15.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:41:55 -0700 (PDT)
Date:   Tue, 1 Nov 2022 15:41:54 -0700
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
Message-ID: <202211011538.B7548FDDE@keescook>
References: <Y1trhRE3nK5iAY6q@mail.google.com>
 <Y1yetX1CHsr+fibp@mail.google.com>
 <CADnq5_Mod90O=tN26+Yi74WPYxpVtss+LG_+_HZyFv2EtzR+MA@mail.gmail.com>
 <202211011443.7BDB243D8D@keescook>
 <CADnq5_Ou9HnZjQx5WaAZW+iu24g_eS2hh25xhExeQjdMOXYfCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_Ou9HnZjQx5WaAZW+iu24g_eS2hh25xhExeQjdMOXYfCQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 01, 2022 at 06:09:16PM -0400, Alex Deucher wrote:
> On Tue, Nov 1, 2022 at 5:54 PM Kees Cook <keescook@chromium.org> wrote:
> > Does the ROM always only have a single byte there? This seems unlikely
> > given the member "ucFakeEDIDLength" (and the code below).
> 
> I'm not sure.  I'm mostly concerned about this:
>
>             record += fake_edid_record->ucFakeEDIDLength ?
>                       fake_edid_record->ucFakeEDIDLength + 2 :
>                       sizeof(ATOM_FAKE_EDID_PATCH_RECORD);

But this is exactly what the code currently does, as noted in the commit
log: "It's worth mentioning that doing a build before/after this patch
results in no binary output differences.

> Presumably the record should only exist if ucFakeEDIDLength is non 0,
> but I don't know if there are some OEMs out there that just included
> an empty record for some reason.  Maybe the code is wrong today and
> there are some OEMs that include it and the array is already size 0.
> In that case, Paulo's original patches are probably more correct.

Right, but if true, that seems to be a distinctly separate bug fix?

-- 
Kees Cook
