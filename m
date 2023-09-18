Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC21CD37B0
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Sep 2023 09:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjIRJPO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 18 Sep 2023 05:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjIRJOr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 18 Sep 2023 05:14:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E642D10E
        for <linux-hardening@vger.kernel.org>; Mon, 18 Sep 2023 02:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695028434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ySETEWMBBYemMdp3jyvFHrMDlDasjAvK3U0xoCA3NQU=;
        b=cd42VR+RzlMdxl2zq5h68JxAWA8yz9ZBAJOKiUVT3dhi3Lh3XLe7PsYjrzdRkGYwBOj9Zg
        RQ5B9x9uDHJvs+J7Ose05SKJ2WJjpmWVxfvQlBQ2QwXTknFhm9r27dysILszFa1kVglnSs
        Lg2Q1OKi5RFTi1boQdgEFkBDB2qbXMY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-j4xzdZEuP72jSBTd_grxlA-1; Mon, 18 Sep 2023 05:13:51 -0400
X-MC-Unique: j4xzdZEuP72jSBTd_grxlA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-404fc59b8acso5768565e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 18 Sep 2023 02:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695028430; x=1695633230;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ySETEWMBBYemMdp3jyvFHrMDlDasjAvK3U0xoCA3NQU=;
        b=TJuoDSJfvnXc+giCGU88Tq639RANQjQGB0qJznI8512jP/MZ0IdxDH5WZ1YNIgbgGZ
         j3ypx8QvrVbX3B8nUsX8KeQ/iSKosj1r6HIuzUUaZu74ncPFjdVke7LAwfeyfby/gyuj
         41BtbaTS9qYADU0NNF8CKXFPANDEx75vOWfXU7jJGTHnyMtTgspN59aEO5cblH+fsZ3m
         z9B6/zr5Hx1zLYzg3qsFMMK4C0nVD8RLQ4BYKXzg9U718FLd303Fv7bMBICLEVfrJSvD
         KmRCxjo3GfkdHtK5hHHml0zKE3OmXw2iCFuRbcwzxHfN7I6j9dND0pY10QyNznISVZMw
         R6PA==
X-Gm-Message-State: AOJu0YzfJM5cIhlKkJLc32vLVF20TuxG858ynBPSRTCVidL0ZCE08ue1
        KNdtaugxRW2MhugagPktTCqPWRZG9U2Puer4H8OaOdF6H4O5V4lFr/amFrhE0AqexFhB3pytYLG
        B1EfrYrYHTI84WK2JRcXnEmAIx2J3
X-Received: by 2002:a5d:508e:0:b0:317:73e3:cf41 with SMTP id a14-20020a5d508e000000b0031773e3cf41mr6416379wrt.1.1695028430599;
        Mon, 18 Sep 2023 02:13:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB8VnbhuBBqYU4diZ/ky5juLhWgDDI8ddqsgXauCCvjjTxBkK6OXa7bUUeWyDSF9cThUqM3g==
X-Received: by 2002:a5d:508e:0:b0:317:73e3:cf41 with SMTP id a14-20020a5d508e000000b0031773e3cf41mr6416363wrt.1.1695028430263;
        Mon, 18 Sep 2023 02:13:50 -0700 (PDT)
Received: from [10.32.64.2] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id b16-20020a05600010d000b0031aef72a021sm11830334wrx.86.2023.09.18.02.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 02:13:49 -0700 (PDT)
Message-ID: <72a444cd42629f5bdd56647e7aa24588d6964bec.camel@redhat.com>
Subject: Re: [PATCH v2 1/5] string.h: add array-wrappers for (v)memdup_user()
From:   Philipp Stanner <pstanner@redhat.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Siddh Raman Pant <code@siddh.me>,
        Nick Alcock <nick.alcock@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
        David Airlie <airlied@redhat.com>
Date:   Mon, 18 Sep 2023 11:13:48 +0200
In-Reply-To: <b219788a-69e6-44cf-a609-91f9640967f5@moroto.mountain>
References: <cover.1694202430.git.pstanner@redhat.com>
         <93001a9f3f101be0f374080090f9c32df73ca773.1694202430.git.pstanner@redhat.com>
         <b219788a-69e6-44cf-a609-91f9640967f5@moroto.mountain>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, 2023-09-16 at 17:32 +0300, Dan Carpenter wrote:
> On Fri, Sep 08, 2023 at 09:59:40PM +0200, Philipp Stanner wrote:
> > +static inline void *memdup_array_user(const void __user *src,
> > size_t n, size_t size)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size_t nbytes;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (unlikely(check_mul_overf=
low(n, size, &nbytes)))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ERR_PTR(-EOVERFLOW);
>=20
> No need for an unlikely() because check_mul_overflow() already has
> one
> inside.

ACK. I overlooked that as it was hidden in the callstack.


> =C2=A0 I feel like -ENOMEM is more traditional but I doubt
> anyone/userspace
> cares.

I agree with Andy here. We're not allocating, so -ENOMEM makes no sense
IMO.


P.

>=20
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return memdup_user(src, nbyt=
es);
> > +}
>=20
> regards,
> dan carpenter
>=20

