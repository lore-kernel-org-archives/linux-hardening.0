Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B136C433EF
	for <linux-hardening@archiver.kernel.org>; Tue,  8 Feb 2022 22:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbiBHWYg (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386330AbiBHUJX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Feb 2022 15:09:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 667F3C0612C0
        for <linux-hardening@vger.kernel.org>; Tue,  8 Feb 2022 12:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644350962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I3/8UwtTiLaHjDIsw5ToTGGU9VaJhcJtecxqfQCO+Kg=;
        b=T9LIjWSY8erc6swS5RMD3ac4dSW9AURKcftZzyOXsyqGJmKjzzPqkh90HhjVcM7hENPOZA
        o7U+e5K8KuV5/7OvHPXE6OfoIiUgeNG+gKJ4MXyzAOZfsgndgERkUxBXZZ2BZLb3jMm2JR
        rDsULcP42tEt8g/breLSYGzSF5tWTAI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-oKUkQaniOh-nlozL2ejzCw-1; Tue, 08 Feb 2022 15:09:17 -0500
X-MC-Unique: oKUkQaniOh-nlozL2ejzCw-1
Received: by mail-qk1-f199.google.com with SMTP id b204-20020a3767d5000000b004b2a0d2e930so11754304qkc.15
        for <linux-hardening@vger.kernel.org>; Tue, 08 Feb 2022 12:09:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=I3/8UwtTiLaHjDIsw5ToTGGU9VaJhcJtecxqfQCO+Kg=;
        b=HSgNsMYUuWk9UqXBg0Zy8FxaSHE/YawbHiJQualLomMDHA67Z7c5gWww+x/oPC0ISl
         KlWn/wzo/rcHzH5/IIgxDyL8jD7ZYNGsIVREu7EQAaxyPUESgUFZyYXumDOOyna83OCS
         EtuGEA57WD+TQayFNl+HE5uF2CHRjzYKYmh6LoQx5BEqJy8h9tUkms0B95I2UUAMOnU3
         Bre4Yj38p5ov+J72zZdlAeUCUUAAG79wJkSS3B5dZXZJO5JRHgYdFstRFF+K+zvl0kyj
         zBL8lBzmAkzCcK+1jNvaNEjNPPKURlVzbxP2vQYUkpYwPo65JAjPmxObc5P0N3eppfuM
         zYDg==
X-Gm-Message-State: AOAM530JlV2TXqlKRE3bdT/kX9fC9xOSF4j3MPX7H65HyRxrv8dTVp00
        vpGxkix05yYu268AYTx4WPbL5eQGkDHJoCrDBxACWu9bGRmmmFz3YePx5P7x1ewtMwc9He4YtDK
        zogU6wg6x6nQjVnbHSfqh4P7mL9Xu
X-Received: by 2002:a05:6214:4111:: with SMTP id kc17mr4417588qvb.61.1644350957410;
        Tue, 08 Feb 2022 12:09:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsREE/wlVXhB/X8tBjZ+cErEBHMvIYU1EUljfRg7HUFF85vJYIMBgalTBx0/F2MZWG8LFj8g==
X-Received: by 2002:a05:6214:4111:: with SMTP id kc17mr4417571qvb.61.1644350957203;
        Tue, 08 Feb 2022 12:09:17 -0800 (PST)
Received: from [192.168.8.138] (pool-96-230-100-15.bstnma.fios.verizon.net. [96.230.100.15])
        by smtp.gmail.com with ESMTPSA id p70sm7253061qka.62.2022.02.08.12.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 12:09:16 -0800 (PST)
Message-ID: <58cc03e21bdf8665f402c7eb9beed557f19a4be2.camel@redhat.com>
Subject: Re: [PATCH][next] nouveau/svm: Use struct_size() helper in
 nouveau_pfns_map()
From:   Lyude Paul <lyude@redhat.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Tue, 08 Feb 2022 15:09:04 -0500
In-Reply-To: <20220207233923.GA524723@embeddedor>
References: <20220207233923.GA524723@embeddedor>
Organization: Red Hat Inc.
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lyude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push this to drm-misc-next, thanks!

On Mon, 2022-02-07 at 17:39 -0600, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worse scenario, could lead to heap overflows.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/gpu/drm/nouveau/nouveau_svm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c
> b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index 266809e511e2..46a5a1016e37 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -925,8 +925,8 @@ nouveau_pfns_map(struct nouveau_svmm *svmm, struct
> mm_struct *mm,
>  
>         mutex_lock(&svmm->mutex);
>  
> -       ret = nvif_object_ioctl(&svmm->vmm->vmm.object, args, sizeof(*args)
> +
> -                               npages * sizeof(args->p.phys[0]), NULL);
> +       ret = nvif_object_ioctl(&svmm->vmm->vmm.object, args,
> +                               struct_size(args, p.phys, npages), NULL);
>  
>         mutex_unlock(&svmm->mutex);
>  }

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

