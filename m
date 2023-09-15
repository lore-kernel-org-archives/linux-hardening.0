Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF76EED61A
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 17:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbjIORgJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 13:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbjIORfv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 13:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 215793596
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 10:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694799173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3iRbWt1YTt0h4sdUmK03Vi+q52/EZN5SzHkBsDxopwQ=;
        b=YKTQBk0/66u2MJHUd6wXkGX/l1O9sxjZnzqGsKoeT7ykN+G6aZT75g1yxFr7MYzb+eKq/T
        AmBx7unClSymt+/2PoVfeuYV6HP9u+oFU3lPgHM2X4Bf9NwgfoJbvXXk/TH5t0ddolMjzK
        xocFfdYZ1LoDKWqOrGVFSFw3wu2ZsmI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-LTJXDZi9PEiyi0EEObyIpA-1; Fri, 15 Sep 2023 13:32:52 -0400
X-MC-Unique: LTJXDZi9PEiyi0EEObyIpA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-770538a2946so326811385a.0
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 10:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694799172; x=1695403972;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3iRbWt1YTt0h4sdUmK03Vi+q52/EZN5SzHkBsDxopwQ=;
        b=mdusoZaAAAOn6QS+2iEEd/8SWvUrM8vMyYxqZr1/Owm6Sj3GVeVSEcQ9fe+vKY0JkF
         mq7m0pQYw3m0M1MLNdnYu0mXiO/OmFSnbS14ne65+blGRO40XemOz6g/0lJvQ5JGuLDF
         aE3TnPhBLjCU0B0tPI9lGXd9Xl/YAI4vRGwhN10GXtK7YdIOrCcCM4HrVvKmPpKntHiH
         ZMXXuz2xI7YRl3sXui5EQS65htTEMLKdvQJHVL6GIyuBug9+J3lVa4qKDs0FFkCQiiwd
         peMy+j4KubgS1c4kfUdSXrTO3QjPHR5pMQDgyscn4eyvyrIoWuBMR09Evl/ow/x21s98
         xrQQ==
X-Gm-Message-State: AOJu0YwdXgKpc0xBRdaCTiQe06yXk7JUdC7rI4oQqE+6MzzBGays8K9v
        ZnvSpLoP31QTIEz1uBTSLdXEPv8LZqvaYiWpSUm80I9FNGvjmfOjnoRa+3a6Lt16b4pZx+Yzt0o
        8hv/FcPd5c72Qs6wUqkN2t4D3JmC01CxLcQpL
X-Received: by 2002:a05:620a:450b:b0:76c:a9fb:6d07 with SMTP id t11-20020a05620a450b00b0076ca9fb6d07mr2820428qkp.2.1694799171849;
        Fri, 15 Sep 2023 10:32:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETBX46w8bl1e85ceIF07jVSYpOO67r7UYVTVMH7Dqpa2+cz1AIiLu9iLVGSZRmJCWMnZIaqw==
X-Received: by 2002:a05:620a:450b:b0:76c:a9fb:6d07 with SMTP id t11-20020a05620a450b00b0076ca9fb6d07mr2820408qkp.2.1694799171623;
        Fri, 15 Sep 2023 10:32:51 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c6c:a300::feb? ([2600:4040:5c6c:a300::feb])
        by smtp.gmail.com with ESMTPSA id pa9-20020a05620a830900b00767d572d651sm1364433qkn.87.2023.09.15.10.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 10:32:51 -0700 (PDT)
Message-ID: <43da274f22acaae8b917f51f6e62376928163e8f.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/pm: refactor deprecated strncpy
From:   Lyude Paul <lyude@redhat.com>
To:     Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Fri, 15 Sep 2023 13:32:50 -0400
In-Reply-To: <202309142158.59A6C62F@keescook>
References: <20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-engine-pm-base-c-v1-1-4b09ed453f84@google.com>
         <202309142158.59A6C62F@keescook>
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

Nice catch!

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push in just a moment

On Thu, 2023-09-14 at 21:59 -0700, Kees Cook wrote:
> On Thu, Sep 14, 2023 at 10:17:08PM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings [=
1].
> >=20
> > We should prefer more robust and less ambiguous string interfaces.
> >=20
> > A suitable replacement is `strscpy` [2] due to the fact that it guarant=
ees
> > NUL-termination on the destination buffer without unnecessarily NUL-pad=
ding.
> >=20
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
>=20
> The "- 1" use in the original code is strong evidence for this being a
> sane conversion. :)
>=20
> Reviewed-by: Kees Cook <keescook@chromium.org>
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

