Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C62CC83F01
	for <linux-hardening@archiver.kernel.org>; Wed, 30 Aug 2023 22:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343894AbjH3WfV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 30 Aug 2023 18:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237283AbjH3WfR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 30 Aug 2023 18:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D62FD
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 15:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693434843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yTsZyqKXCjKhOJ70mLm50QiCTy9IG31Ajtx/kBK1zM0=;
        b=Tv2Y/Q6Tgh5t1dM6xm5p26QNTh4s70xbGo4ekKhLlHbhA+mgXK82GmBvr1pcJJMcok6tb2
        vXEP3Pw4pv+mKx6yz9GgVoUuCyPOMn5ikYkSlOiBjDIgFnrxUdFh23GW9QhJuNgWemC5/C
        MTf1kb7EGDrK+VkpndWlUBVyf/HYNDU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-miDgt0wGMRa2CE3wbzrgQA-1; Wed, 30 Aug 2023 15:15:31 -0400
X-MC-Unique: miDgt0wGMRa2CE3wbzrgQA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a1c4506e1eso98158466b.1
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 12:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693422930; x=1694027730;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iBV0HnyI31Hv2AWMsxadgPSfaYJpOZDq2RNuu2t2Z+8=;
        b=VoKC8rc624iMKfjmeBaBh+nj3ZWz3vMWPKTrsdMjQHTANHN5SJU0H6Mt/3RBUe+uJ3
         ALwh4rA5+wPvzmsVk/kLHeyvuj8Xn9NP9vpbEpvC0bYXVidjrkLFdvI+lecHV7Y17bcG
         wK39F/EbOKNjD3u5HBB2aVusIJGAww6/IgxLURcUzA0XFluF6Yer8VqOY5cJU8IHOnNr
         R8fZ6Qk5LDYAnJhRYiPg2Rx6qmU7MynxD4XVcrEHynxqXPSzdf8ex5/oI/7Rzeqa/DBj
         NMvE2qGqO9Y+hDN2uAoxhLKutHWxz9AZrnl31v7Tcpwic5lP3kHjKBbbyefxe0B8ttS4
         d+DA==
X-Gm-Message-State: AOJu0YxiETpCk7rhVd6dsHHV08nPzIw3rjhoDwFZrXLi4N+F7gDayxHP
        Ii5w7sS3g8/BmB6kBmxJlHfNWty5q2aRrX1uFwAFnBMtk/oxXU3S0VtLrK9EMlDNJh92mVO+FQa
        VmaljVhHN3+x5893mtGUjHxU0MtWN
X-Received: by 2002:a05:6402:51c8:b0:523:37cf:6f37 with SMTP id r8-20020a05640251c800b0052337cf6f37mr2290530edd.4.1693422930288;
        Wed, 30 Aug 2023 12:15:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjUvAuvkykbuXvqA8bQi1z8q8Gj4+iVBJgsW7l3Dh0c5JlqxFhMaKRno+cvmE8+cDwXXn9mg==
X-Received: by 2002:a05:6402:51c8:b0:523:37cf:6f37 with SMTP id r8-20020a05640251c800b0052337cf6f37mr2290516edd.4.1693422929985;
        Wed, 30 Aug 2023 12:15:29 -0700 (PDT)
Received: from ?IPv6:2001:9e8:32e4:1500:aa40:e745:b6c9:7081? ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id i9-20020aa7c709000000b0052a198d8a4dsm7116533edq.52.2023.08.30.12.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:15:29 -0700 (PDT)
Message-ID: <a4ba0493965ad32fcf95cd6e2439096668a9ed46.camel@redhat.com>
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
Date:   Wed, 30 Aug 2023 21:15:28 +0200
In-Reply-To: <CAHp75VdS=kSWnz8FzHcdrZPaeZKsQNbzjE9mNN7BDvZA_nQpaA@mail.gmail.com>
References: <cover.1693386602.git.pstanner@redhat.com>
         <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
         <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com>
         <721a70c347d82931d12e5b75b19d132f82ee5ed2.camel@redhat.com>
         <CAHp75VdS=kSWnz8FzHcdrZPaeZKsQNbzjE9mNN7BDvZA_nQpaA@mail.gmail.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 2023-08-30 at 17:29 +0300, Andy Shevchenko wrote:
> On Wed, Aug 30, 2023 at 5:19=E2=80=AFPM <pstanner@redhat.com> wrote:
> > On Wed, 2023-08-30 at 17:11 +0300, Andy Shevchenko wrote:
> > > On Wed, Aug 30, 2023 at 4:46=E2=80=AFPM Philipp Stanner
> > > <pstanner@redhat.com>
> > > wrote:
>=20
> > > > --- a/include/linux/string.h
> > > > +++ b/include/linux/string.h
> > >=20
> > > I'm wondering if this has no side-effects as string.h/string.c
> > > IIRC
> > > is
> > > used also for early stages where some of the APIs are not
> > > available.
> > >=20
> > > > @@ -6,6 +6,8 @@
> > > > =C2=A0#include <linux/types.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
/* for size_t */
> > > > =C2=A0#include <linux/stddef.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* fo=
r NULL */
> > > > =C2=A0#include <linux/errno.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
/* for E2BIG */
> > > > +#include <linux/overflow.h>=C2=A0=C2=A0=C2=A0 /* for check_mul_ove=
rflow() */
> > > > +#include <linux/err.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* for ERR_PTR() */
> > >=20
> > > Can we preserve order (to some extent)?
> >=20
> > Sure. I just put it there so the comments build a congruent block.
> > Which order would you prefer?
>=20
> Alphabetical.
>=20
> compiler.h
> err.h
> overflow.h
> ...the rest that is a bit unordered...
>=20
> > > > =C2=A0#include <linux/stdarg.h>
> > > > =C2=A0#include <uapi/linux/string.h>
>=20
> ...

I mean I could include my own in a sorted manner =E2=80=93 but the existing
ones are not sorted:

/* SPDX-License-Identifier: GPL-2.0 */
#ifndef _LINUX_STRING_H_
#define _LINUX_STRING_H_

#include <linux/compiler.h>=09/* for inline */
#include <linux/types.h>=09/* for size_t */
#include <linux/stddef.h>=09/* for NULL */
#include <linux/errno.h>=09/* for E2BIG */
#include <linux/stdarg.h>
#include <uapi/linux/string.h>

extern char *strndup_user(const char __user *, long);

We could sort them all, but I'd prefer to do that in a separate patch
so that this commit does not make the impression of doing anything else
than including the two new headers

Such a separate patch could also unify the docstring style, see below

>=20
> > > > +/**
> > > > + * memdup_array_user - duplicate array from user space
> > >=20
> > > > + *
> > >=20
> > > Do we need this blank line?
> >=20
> > I more or less directly copied the docstring format from the
> > original
> > functions (v)memdup_user() in mm/util.c
> > I guess this is common style?
>=20
> I think it's not. But you may grep kernel source tree and tell which
> one occurs more often with or without this (unneeded) blank line.


It seems to be very much mixed. string.h itself is mixed.
When you look at the bottom of string.h, you'll find functions such as
kbasename() that have the extra line.

That's not really a super decisive point for me, though. We can remove
the line I guess


P.


>=20
> > > > + * @src: source address in user space
> > > > + * @n: number of array members to copy
> > > > + * @size: size of one array member
> > > > + *
> > > > + * Return: an ERR_PTR() on failure.=C2=A0 Result is physically
> > > > + * contiguous, to be freed by kfree().
> > > > + */
>=20
> ...
>=20
> > > > +/**
> > > > + * vmemdup_array_user - duplicate array from user space
> > >=20
> > > > + *
> > >=20
> > > Redundant?
> >=20
> > No, there are two functions:
> > =C2=A0* memdup_array_user()
> > =C2=A0* vmemdup_array_user()
> >=20
> > On the deeper layers they utilize kmalloc() or kvmalloc(),
> > respectively.
>=20
> I guess you misunderstood my comment. I was talking about kernel doc
> (as in the previous function).
>=20
> > > > + * @src: source address in user space
> > > > + * @n: number of array members to copy
> > > > + * @size: size of one array member
> > > > + *
> > > > + * Return: an ERR_PTR() on failure.=C2=A0 Result may be not
> > > > + * physically contiguous.=C2=A0 Use kvfree() to free.
> > > > + */
>=20
>=20

