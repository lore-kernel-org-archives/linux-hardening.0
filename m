Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262F2EE021A
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 04:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjIOEyw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 00:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjIOEyv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 00:54:51 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61888270C
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 21:54:46 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c1ff5b741cso15908505ad.2
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 21:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694753686; x=1695358486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ToW+0xnZZSn2haYogSaseRbGCEN/c/VaxynOQEBf2ck=;
        b=Bps9Vp7zhomDOUgRGJNGFjVjFWTEXCpNHObgBwzUaPcu7Dbxyv0P0h2UqxROoDopiU
         sfrWwYWPupob+koUj6QJiKqGh5jzWx7pJLNprx6/Rz/qKZnAo2nFwGw+CnnKrYUrHQj7
         qzQAuWf1Jex9927dxBEeDRFZQznXsGsjBwaGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694753686; x=1695358486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToW+0xnZZSn2haYogSaseRbGCEN/c/VaxynOQEBf2ck=;
        b=bkcpIIK4V3KFyJnK0OqXL2iBIcK9dsmP3cK1do0F9A1sci7IomPsAYd970xDpo6VmD
         Rk5lGusDLQeAnnDxjwGcjmsCsuydxVLHkIvtRv5h4vDODcmBmqMi2fniV207L1fVrZrI
         gTlOiDeg56nUJYa5sy4BLjQnizgtaASz4yXtyvq4OBRU7rWNedGh/KVrtQhu9Wu4HfRC
         0GP6uybKEasnq5zO50T+HQKYNybCmJRUSzEEqMYHLLL+jdKM7+FddvOvt4DuE9hoJ++T
         khFu8YunKQLLhodOzEXzJZkZHMidpUFsUzr5G96FkD8QAZD7hyj5Vm7LuKNe6IzjMt3l
         9TOQ==
X-Gm-Message-State: AOJu0YyepH+qPmZEGva04j7OQTNUINP6EKWvJzu62IEtqyvzszBSTSEt
        OQwyzfMcvehE2FnDOeOxP0f3lw==
X-Google-Smtp-Source: AGHT+IEcCPpurVZaVmMfJTxE+QBrjIRFGRhM4z9e+DIud9rnr99x7LR9itVZkiVtL8ZoPc40jrO71A==
X-Received: by 2002:a17:903:2447:b0:1c3:a396:25ae with SMTP id l7-20020a170903244700b001c3a39625aemr647937pls.56.1694753685862;
        Thu, 14 Sep 2023 21:54:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902789700b001b8a3dd5a4asm2425048pll.283.2023.09.14.21.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 21:54:45 -0700 (PDT)
Date:   Thu, 14 Sep 2023 21:54:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau/nvif: refactor deprecated strncpy
Message-ID: <202309142139.1C068523@keescook>
References: <20230914-strncpy-drivers-gpu-drm-nouveau-nvif-client-c-v1-1-dc3b3719fcb4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-strncpy-drivers-gpu-drm-nouveau-nvif-client-c-v1-1-dc3b3719fcb4@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 14, 2023 at 09:30:37PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated and as such we should prefer more robust and
> less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy_pad` due to the fact that it
> guarantees NUL-termination on the destination buffer whilst also
> maintaining the NUL-padding behavior that `strncpy` provides. I am not
> sure whether NUL-padding is strictly needed but I see in
> `nvif_object_ctor()` args is memcpy'd elsewhere so I figured we'd keep
> the same functionality.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/gpu/drm/nouveau/nvif/client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvif/client.c b/drivers/gpu/drm/nouveau/nvif/client.c
> index a3264a0e933a..3a27245f467f 100644
> --- a/drivers/gpu/drm/nouveau/nvif/client.c
> +++ b/drivers/gpu/drm/nouveau/nvif/client.c
> @@ -69,7 +69,7 @@ nvif_client_ctor(struct nvif_client *parent, const char *name, u64 device,
>  	} nop = {};
>  	int ret;
>  
> -	strncpy(args.name, name, sizeof(args.name));
> +	strscpy_pad(args.name, name, sizeof(args.name));
>  	ret = nvif_object_ctor(parent != client ? &parent->object : NULL,
>  			       name ? name : "nvifClient", 0,
>  			       NVIF_CLASS_CLIENT, &args, sizeof(args),

Right, I see the memcpy too:

nvif_object_ctor(struct nvif_object *parent, const char *name, u32 handle,
                 s32 oclass, void *data, u32 size, struct nvif_object *object)
{
	...
                memcpy(args->new.data, data, size);

However, "args" is already zeroed:

        struct nvif_client_v0 args = { .device = device };

So there's no need for _pad(). However, I couldn't immediatley see
why args.name must be %NUL terminated. It's ultimately passed through
an ioctl:

        return client->driver->ioctl(client->object.priv, data, size, hack);

But I did find it...

args is:

struct nvif_client_v0 {
	...
        char  name[32];
};

And "name" only ever comes through nvif_client_ctor(), which all end up
via here, using "cli":

struct nouveau_cli {
	...
        char name[32];
...


        snprintf(cli->name, sizeof(cli->name), "%s", sname);
	...
                ret = nvif_client_ctor(&drm->master.base, cli->name, device,
                                       &cli->base);

So we'll always be %NUL terminated.

Therefore, yes, conversion looks good:

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

> 
> ---
> base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
> change-id: 20230914-strncpy-drivers-gpu-drm-nouveau-nvif-client-c-82b023c36953
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
