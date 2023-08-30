Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7315AC83F1B
	for <linux-hardening@archiver.kernel.org>; Wed, 30 Aug 2023 18:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344041AbjH3S4f (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245041AbjH3OYE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 30 Aug 2023 10:24:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7AF124
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 07:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693405394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LDWeZz8lwtK2Vw963Pp4K5umQAhzGapmgVnLNgStcjo=;
        b=Akvmh1yAb35F5xpAl/Lm+uXDZo+cFqsKdiy2StQEZmcccAC70cJXdAnVjUuk5LeaplByHJ
        wa4DSAAzvLYUHpkYfInM0lyNXTbGFPeecYT72loaFmLKFg7VJtXv6dr8F2FUfqVoaMhUkn
        Rzs/QTBGrzfX6EKAxmZe4w8CMYjOx+4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-hLRyqpIjMEypOzvUicuvEQ-1; Wed, 30 Aug 2023 10:23:13 -0400
X-MC-Unique: hLRyqpIjMEypOzvUicuvEQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5256c3803b4so365284a12.0
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 07:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693405392; x=1694010192;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LDWeZz8lwtK2Vw963Pp4K5umQAhzGapmgVnLNgStcjo=;
        b=SKO8yrQifhFNbmFXleU06hzCuAyPzkmY6yTZ/DOXdckvsxmiqy4kDtgu6pn2R8SX9i
         99NWd7eFx4M2rOMTHE5fOXDe3nGsaooSK0j+U94dEW3egfV1dgkTlUNUpMAQgW97BOgI
         aYgTyXHuFuaurpRL7x5E8EqJfJCsr1F0q3iI6MiIUeZ5IdQQAtpMLG4onxiCjdFcV24A
         o9d6jkomsyvHIb6IYOcOaRHOArQ+Lx8UpyWquaXE43rYW5bbRIw086QLZtt7H39L1/v8
         Wa6BMxlQaIvC3e7Wp2IAUp7zNiXJWNIuwcJMrenMPn2AHGxdzySusCb4j95IYVpQsssL
         Kk8w==
X-Gm-Message-State: AOJu0Yy0mqQOb4uBumLzaRgC6n5ViqDPhBdhyq179ROia1ugQJQ8ono8
        P03gEFD/1WziDjxM6fk8cHgvzBJrUf7T4dHul+fKc0qHWa5c+ym8LSEVwIPh9vXw1I9ZpDhZ6wf
        UEDXaraRPgM4R8dE9pb9+LD9M1nMs
X-Received: by 2002:a05:6402:4404:b0:51e:34d8:f4c7 with SMTP id y4-20020a056402440400b0051e34d8f4c7mr2019163eda.2.1693405392370;
        Wed, 30 Aug 2023 07:23:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEETjNW9wp/fQvTrgjMQpXcwVHdHwUrjVBdjXk8jizCaYvhqq5Q/jtzkYzdJEKBqJ9axaU5/A==
X-Received: by 2002:a05:6402:4404:b0:51e:34d8:f4c7 with SMTP id y4-20020a056402440400b0051e34d8f4c7mr2019152eda.2.1693405392119;
        Wed, 30 Aug 2023 07:23:12 -0700 (PDT)
Received: from ?IPv6:2001:9e8:32e4:1500:aa40:e745:b6c9:7081? ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id j4-20020aa7ca44000000b0052574ef0da1sm6830091edt.28.2023.08.30.07.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 07:23:11 -0700 (PDT)
Message-ID: <a79b3c34a12abc51bc5e840ae3a87ab9a47f7742.camel@redhat.com>
Subject: Re: [PATCH 1/5] string.h: add array-wrappers for (v)memdup_user()
From:   pstanner@redhat.com
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Date:   Wed, 30 Aug 2023 16:23:10 +0200
In-Reply-To: <CAHp75Vc72uuNvFxq4TGO=nXoGhbqVxyqvQ67ioL8ajtZwMUBgA@mail.gmail.com>
References: <cover.1693386602.git.pstanner@redhat.com>
         <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
         <CAHp75Vc72uuNvFxq4TGO=nXoGhbqVxyqvQ67ioL8ajtZwMUBgA@mail.gmail.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 2023-08-30 at 17:15 +0300, Andy Shevchenko wrote:
> On Wed, Aug 30, 2023 at 4:46=E2=80=AFPM Philipp Stanner <pstanner@redhat.=
com>
> wrote:
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(check_mul_overflow(n=
, size, &nbytes)))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return ERR_PTR(-EINVAL);
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(check_mul_overflow(n=
, size, &nbytes)))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return ERR_PTR(-EINVAL);
>=20
> Btw, why not -EOVERFLOW ?
>=20

Good question, actually.
To be honest I wasn't quite sure which code to pick (-E2BIG was also
once I candidate).

-EINVAL was picked because the idea was that a request overflowing a
size_t could surely be expected to contain an invalid parameter,
because no one would ever request an array _that_ large

?

