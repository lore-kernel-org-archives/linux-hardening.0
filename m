Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A48CC433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 29 Sep 2021 03:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41614613CE
	for <linux-hardening@archiver.kernel.org>; Wed, 29 Sep 2021 03:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243926AbhI2Dan (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 28 Sep 2021 23:30:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243941AbhI2Dam (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 28 Sep 2021 23:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632886141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ypu7lSHLqUrP/H0+g4r3QAtlIt7DSpEMHZQnw4kUfiM=;
        b=J/TaCPWlw6a+Yy6aQoP2Z70dpkeBcdprbkFXeU3+1P2w78vYbGex1HnbbTDjmLbD4FR/LN
        lO0tedduUwng0kEdYAdZH/dFIdwlyTWzRjwYmzP1YoNPLgIntpG8Z7QCfZhdkV5QfRj064
        a4FD7hWr3xkaKgzfK6mlm04BYi/rmSw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-5bwgFm9PNY-Y4w-837zB6Q-1; Tue, 28 Sep 2021 23:28:59 -0400
X-MC-Unique: 5bwgFm9PNY-Y4w-837zB6Q-1
Received: by mail-wm1-f69.google.com with SMTP id p25-20020a1c5459000000b0030cac3d9db1so518200wmi.6
        for <linux-hardening@vger.kernel.org>; Tue, 28 Sep 2021 20:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ypu7lSHLqUrP/H0+g4r3QAtlIt7DSpEMHZQnw4kUfiM=;
        b=ptjxExm5f2KnZ9A1dsS201xct1aUscpZRgTmts6VkF3n/Db1VS/J7EeeOF+eeEuKtU
         xYlMaXOU7f78ac3bL7wzG0aHDXAtp4uAGLFMviE+Xh8US0sPMAFfeOnMn4KpOG7otRfZ
         d58vHjouMeQYcx38YhtE8HUV2+aKwRd0slHsrcSDdKOpL5ERd3TTLIF0RN0txawChIbK
         RdHPMT51D5o6qP2hZt6U72Ftiy0nGveFpwrm7lly1UCZJWINZRb2K2E3p8SsYofRlSyl
         d9xQQ2hIrtRnNxz6uVyT1IDyMI/u9ad+uwbhj9IBeEL1gaKiry/j6AYRZnpkE5m+KVwZ
         GRIA==
X-Gm-Message-State: AOAM531IGzLh5lvIWrkHw/WkDzj7I7UHc42YBIEHUgSLr3qdr3V/nafI
        tDVN7rLAdv6C1kB21pshxcV0tRw5omQwdVgmZmIOXzRP93sV/+I9tRKeA7Y36EBqdIhivrTYOzg
        gyEjBRavlFN02nTLgso24PdHfD3al6/49NmemQ7GuQrsO
X-Received: by 2002:a05:600c:4991:: with SMTP id h17mr8150561wmp.74.1632886138112;
        Tue, 28 Sep 2021 20:28:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6FKlEbCVhn+zhHA/mzkU4owvOyJWUbP+zvqJr/PTgo0iMkgM659VzGx/wX8Umvr4GJinRuUX0AjYIjW/UQVU=
X-Received: by 2002:a05:600c:4991:: with SMTP id h17mr8150552wmp.74.1632886137916;
 Tue, 28 Sep 2021 20:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210928222513.GA294575@embeddedor>
In-Reply-To: <20210928222513.GA294575@embeddedor>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 29 Sep 2021 05:28:47 +0200
Message-ID: <CACO55tsD98dNzw8fP=CiKLsdbnn2Vg78+wTRM90kutHtv1RZ5A@mail.gmail.com>
Subject: Re: [PATCH][next] nouveau/svm: Use kvcalloc() instead of kvzalloc()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kherbst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Lack of documentation inside Linux here is a bit annoying, but do I
understand it correctly, that the main (and probably only) difference
is that kvcalloc checks whether the multiplication overflows and
returns NULL in this case?

On Wed, Sep 29, 2021 at 12:21 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Use 2-factor argument form kvcalloc() instead of kvzalloc().
>
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/gpu/drm/nouveau/nouveau_svm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index b0c3422cb01f..1a896a24288a 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -992,7 +992,7 @@ nouveau_svm_fault_buffer_ctor(struct nouveau_svm *svm, s32 oclass, int id)
>         if (ret)
>                 return ret;
>
> -       buffer->fault = kvzalloc(sizeof(*buffer->fault) * buffer->entries, GFP_KERNEL);
> +       buffer->fault = kvcalloc(sizeof(*buffer->fault), buffer->entries, GFP_KERNEL);
>         if (!buffer->fault)
>                 return -ENOMEM;
>
> --
> 2.27.0
>

