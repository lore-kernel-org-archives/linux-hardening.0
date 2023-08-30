Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6A1C6FA8F
	for <linux-hardening@archiver.kernel.org>; Wed, 30 Aug 2023 18:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242582AbjH3S4U (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245013AbjH3OU0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 30 Aug 2023 10:20:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01539132
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 07:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693405178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GV/8QzaCRMszcMvgwKB+jPm2RB1o5GXV7tIF+sEGovU=;
        b=J+Z8QAZ4VLI0OEaHcLaoPdiCSD83mkTsDIbiwxTCSS/MJMWOQ3A1feE+AyQO/ub41uBiAE
        mZqJCTdWN97NcvoRzfVEiPid1vvrgxQW/rafZSHeO2rYeXgIEcrXYmOlQkN8EDSfOBETNp
        FLfZTg15rshsfXqPShefRXFWX+boJq0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-fqwLz28EMr2senc3LM7cgg-1; Wed, 30 Aug 2023 10:19:35 -0400
X-MC-Unique: fqwLz28EMr2senc3LM7cgg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a1c758ef63so61779066b.1
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 07:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693405174; x=1694009974;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GV/8QzaCRMszcMvgwKB+jPm2RB1o5GXV7tIF+sEGovU=;
        b=Wwglfh8AoU5azBDdH9Fw5G4K9vwIIULbGcjhfnZKHH5nlakN9WiKCBJyrr5ouq8/TT
         8hrqXydHXt/NCDTEVUZ64wonrIdp8PTHcQ5TZKEY2MsOe7Jtb2naT6A0ikIPbaLCxp4U
         vt4RAe3JV4jPNLTEZaQbUZjsxY3D1PHJhFFHkFiG97NHpYsYaKxvAzqfjglVyKOKKjq7
         JA7ab9g8yytKrt0faNDTf8+JKCWRT2xvTa90qVPjrKySdrTXOc9nCM6thzDVGPgmoKJE
         1fHp2dtuksNKKp6huPPhGx+vkbWS8qKo0yHHP6uzkeXKzOxud178ytAY6qKz/FckqLzP
         hBPA==
X-Gm-Message-State: AOJu0Yxe8DQJH6XmdgkhSsQhgTL+Wj/90j6nI0nwamrxtaura6i2jwzo
        ORcUUbW8WEpxkSLW3+3g6SYqBbyZfUbXkhKnVusu5WHRMQEEVGrqEm2M0NDhF2xWxLl0ekfuFWI
        Zdp2NsRp1nZq+zjSIT5JvsRyZuCy5
X-Received: by 2002:a17:906:739c:b0:9a1:c951:19f3 with SMTP id f28-20020a170906739c00b009a1c95119f3mr1414683ejl.0.1693405174420;
        Wed, 30 Aug 2023 07:19:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzgX4N7o6LrqPe58Ba+4el88eUYu7+fOIk9nSYCp19l8FNrUVkg7t2XIL0g9pv34yH61rp8Q==
X-Received: by 2002:a17:906:739c:b0:9a1:c951:19f3 with SMTP id f28-20020a170906739c00b009a1c95119f3mr1414658ejl.0.1693405174044;
        Wed, 30 Aug 2023 07:19:34 -0700 (PDT)
Received: from ?IPv6:2001:9e8:32e4:1500:aa40:e745:b6c9:7081? ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id ck17-20020a170906c45100b009a1a5a7ebacsm7182791ejb.201.2023.08.30.07.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 07:19:33 -0700 (PDT)
Message-ID: <721a70c347d82931d12e5b75b19d132f82ee5ed2.camel@redhat.com>
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
Date:   Wed, 30 Aug 2023 16:19:32 +0200
In-Reply-To: <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com>
References: <cover.1693386602.git.pstanner@redhat.com>
         <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
         <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 2023-08-30 at 17:11 +0300, Andy Shevchenko wrote:
> On Wed, Aug 30, 2023 at 4:46=E2=80=AFPM Philipp Stanner <pstanner@redhat.=
com>
> wrote:
> >=20
> > Currently, user array duplications are sometimes done without an
> > overflow check. Sometimes the checks are done manually; sometimes
> > the
> > array size is calculated with array_size() and sometimes by
> > calculating
> > n * size directly in code.
> >=20
> > Introduce wrappers for arrays for memdup_user() and vmemdup_user()
> > to
> > provide a standardized and safe way for duplicating user arrays.
> >=20
> > This is both for new code as well as replacing usage of
> > (v)memdup_user()
> > in existing code that uses, e.g., n * size to calculate array
> > sizes.
>=20
> ...
>=20
> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
>=20
> I'm wondering if this has no side-effects as string.h/string.c IIRC
> is
> used also for early stages where some of the APIs are not available.
>=20
> > @@ -6,6 +6,8 @@
> > =C2=A0#include <linux/types.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* f=
or size_t */
> > =C2=A0#include <linux/stddef.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* for NU=
LL */
> > =C2=A0#include <linux/errno.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* f=
or E2BIG */
> > +#include <linux/overflow.h>=C2=A0=C2=A0=C2=A0 /* for check_mul_overflo=
w() */
> > +#include <linux/err.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 /* for ERR_PTR() */
>=20
> Can we preserve order (to some extent)?

Sure. I just put it there so the comments build a congruent block.
Which order would you prefer?

>=20
> > =C2=A0#include <linux/stdarg.h>
> > =C2=A0#include <uapi/linux/string.h>
>=20
> ...
>=20
> > +/**
> > + * memdup_array_user - duplicate array from user space
>=20
> > + *
>=20
> Do we need this blank line?

I more or less directly copied the docstring format from the original
functions (v)memdup_user() in mm/util.c
I guess this is common style?

>=20
> > + * @src: source address in user space
> > + * @n: number of array members to copy
> > + * @size: size of one array member
> > + *
> > + * Return: an ERR_PTR() on failure.=C2=A0 Result is physically
> > + * contiguous, to be freed by kfree().
> > + */
>=20
> ...
>=20
> > +/**
> > + * vmemdup_array_user - duplicate array from user space
>=20
> > + *
>=20
> Redundant?

No, there are two functions:
 * memdup_array_user()
 * vmemdup_array_user()

On the deeper layers they utilize kmalloc() or kvmalloc(),
respectively.


Greetings,
P.

>=20
> > + * @src: source address in user space
> > + * @n: number of array members to copy
> > + * @size: size of one array member
> > + *
> > + * Return: an ERR_PTR() on failure.=C2=A0 Result may be not
> > + * physically contiguous.=C2=A0 Use kvfree() to free.
> > + */
>=20

