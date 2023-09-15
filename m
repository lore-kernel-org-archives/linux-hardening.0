Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3837EEED61C
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 17:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbjIORgk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 13:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbjIORgc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 13:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 290272700
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 10:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694799297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XXweTSxb9lF3B3Kz508TxEQymlimekhkNK/jKVtIHZ8=;
        b=NJeKf4L0Wzz2g2RCcYrL2InEwfkk8ulHXFpDmE2O5iwijGNpuvFBe4H33ijaKZqQdOHpO4
        EJJqFmohfr8QG3GZ+R7Sw7N5iIwQhqx/eK+PU9ZP82lc0NGp8muarn+LVfy51PWknuC+0g
        8qacKEYOC46HOvXZnorIuk0hbDznAGY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-sfyfKf1AOaKieYGMol0KlA-1; Fri, 15 Sep 2023 13:34:56 -0400
X-MC-Unique: sfyfKf1AOaKieYGMol0KlA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-770f43b042eso307305585a.3
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 10:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694799295; x=1695404095;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wg4EmNZIrmGv1tACZxeJZ0Y5VT57wRFa8YOjLPmyTEA=;
        b=rcO+DeJve7IaD7JcQq3S09VrfO8s+iws2kkwzDLUgr1yWa0lr9lNkE77ibpdduE12/
         lmy0CGtH0A8zE4LQnSMetyCeCP+3+V6urDxy9WlZNp190bQs0W+ODyTvGrAS003T1Qe/
         auzt1M2q2S0VRDYBAxbHR/YjReSxIrG3/rnVWZZkqMS+IqF41HZZlllZvWHDu3uIvGLn
         xLvQjX1wIKcccG5H5oVPvPRvqFLvItxa0K7alwMXfUBYd9w6uUQzRk5tpFbl9GGOLJ4j
         eDAuA/y0sQIjK5z0WcBb5hzjFElSXxBXx6S0ZgmOk+ekYJS5c1NBZ6d48x0qEzyx2umz
         BhFg==
X-Gm-Message-State: AOJu0YwTqkDazioqdHlYySF00YztaUy+J6NN4MaUQe25gXSYckOAqnJ0
        5aDLtPJNN9B9g/yY52EGVAQDW+V5EDAoefqrbbMGOX0bQq+HFtks/Cvn27UJroVkwCVnW42v2XS
        Nb7yWHzgqUlx99tPYdhMeCM1OYMQh
X-Received: by 2002:a05:620a:31a8:b0:76e:f38b:e87a with SMTP id bi40-20020a05620a31a800b0076ef38be87amr2532011qkb.48.1694799295662;
        Fri, 15 Sep 2023 10:34:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP11ZRbh22ddAzRnfdJhpVYsJBozLWaDGrgjYYQNVtI0psKjUDWcq5Q/AqsDQgs/wMdX3AMQ==
X-Received: by 2002:a05:620a:31a8:b0:76e:f38b:e87a with SMTP id bi40-20020a05620a31a800b0076ef38be87amr2531996qkb.48.1694799295431;
        Fri, 15 Sep 2023 10:34:55 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c6c:a300::feb? ([2600:4040:5c6c:a300::feb])
        by smtp.gmail.com with ESMTPSA id b1-20020a05620a118100b0076ca401d8c7sm1358150qkk.111.2023.09.15.10.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 10:34:55 -0700 (PDT)
Message-ID: <0a563e8d6e380e8f89956abc8b17090432a142b5.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/nvif: refactor deprecated strncpy
From:   Lyude Paul <lyude@redhat.com>
To:     Justin Stitt <justinstitt@google.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Fri, 15 Sep 2023 13:34:53 -0400
In-Reply-To: <20230914-strncpy-drivers-gpu-drm-nouveau-nvif-client-c-v1-1-dc3b3719fcb4@google.com>
References: <20230914-strncpy-drivers-gpu-drm-nouveau-nvif-client-c-v1-1-dc3b3719fcb4@google.com>
Organization: Red Hat Inc.
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push this and your other patches in just a moment

On Thu, 2023-09-14 at 21:30 +0000, Justin Stitt wrote:
> `strncpy` is deprecated and as such we should prefer more robust and
> less ambiguous string interfaces.
>=20
> A suitable replacement is `strscpy_pad` due to the fact that it
> guarantees NUL-termination on the destination buffer whilst also
> maintaining the NUL-padding behavior that `strncpy` provides. I am not
> sure whether NUL-padding is strictly needed but I see in
> `nvif_object_ctor()` args is memcpy'd elsewhere so I figured we'd keep
> the same functionality.
>=20
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strn=
cpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/gpu/drm/nouveau/nvif/client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvif/client.c b/drivers/gpu/drm/nouv=
eau/nvif/client.c
> index a3264a0e933a..3a27245f467f 100644
> --- a/drivers/gpu/drm/nouveau/nvif/client.c
> +++ b/drivers/gpu/drm/nouveau/nvif/client.c
> @@ -69,7 +69,7 @@ nvif_client_ctor(struct nvif_client *parent, const char=
 *name, u64 device,
>  =09} nop =3D {};
>  =09int ret;
> =20
> -=09strncpy(args.name, name, sizeof(args.name));
> +=09strscpy_pad(args.name, name, sizeof(args.name));
>  =09ret =3D nvif_object_ctor(parent !=3D client ? &parent->object : NULL,
>  =09=09=09       name ? name : "nvifClient", 0,
>  =09=09=09       NVIF_CLASS_CLIENT, &args, sizeof(args),
>=20
> ---
> base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
> change-id: 20230914-strncpy-drivers-gpu-drm-nouveau-nvif-client-c-82b023c=
36953
>=20
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

