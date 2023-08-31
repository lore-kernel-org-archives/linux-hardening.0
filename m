Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DD1C83F12
	for <linux-hardening@archiver.kernel.org>; Thu, 31 Aug 2023 12:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjHaMRz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 31 Aug 2023 08:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244060AbjHaMRx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 31 Aug 2023 08:17:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A580DE4C
        for <linux-hardening@vger.kernel.org>; Thu, 31 Aug 2023 05:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693484220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1TIPZiS5WiygpRoovt73Dy9nOHlU7oscs2x344MogyU=;
        b=YqyeSK0nDsuNejJN0HhkwDcordPrukkRxA5WydjwfTNzsHXrO1Ir4z3S1ZaoQEogmGIoay
        v98r5ActOhYFjoVG1b133HVmxlSmj4Wukp+Af3sA0oHOplUpgOccoFZb5kbD/ezr0kdnas
        HNbZWMe+2sibfRo5kwN4qlGOcPRug+I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-twQkJfGRNMSafo5hSpNm_A-1; Thu, 31 Aug 2023 08:16:57 -0400
X-MC-Unique: twQkJfGRNMSafo5hSpNm_A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fe246ec511so1275955e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 31 Aug 2023 05:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693484216; x=1694089016;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1TIPZiS5WiygpRoovt73Dy9nOHlU7oscs2x344MogyU=;
        b=OjCUu3QELfneD2vjGSfujLtxl03sx//xm5dxi04Mwx2Lu7Vy4b8dQaFgw6Vsso3B+a
         rbJPYxYblHSIZ5rH1Eg3LTtD+Saw/sorHiCxUVIJQW6Ro9dZsXoizTcaK2c5YEGy3tBc
         wHfCYR/pJMMx8sy05yq281pAo5i5OqzQ7uy2pnP+Kw9OuRLiIxolarCyI8E7CHS8jq8b
         +rVtVF+xdQPUgyTDaTLk068Ws1sxuFlmIeCgDpKKKbGaW2jQRFFuyQhItlY102YISZ6l
         t7d1f5iLOwJo8KfPsYF4E8zD4IjuuuVwF6GDi+jJciEwVjdSBt0bEkuVkPSYqnphrA1b
         /q0w==
X-Gm-Message-State: AOJu0YxefDrI8t+KQfllWTyc4dxXpHLsKmzCiLQP+08wt2uHOK/clAqR
        pFyuilI5GZVOLHpM8woQ/5XpGRHVViVV98dYGRdT5TeFdUq9vPx4m7a4TqhTPcJg+rjQAUS2AcM
        guFDHMx0UmKTP76wHVVDWkyEzcJtL
X-Received: by 2002:a05:600c:5113:b0:401:c392:d28d with SMTP id o19-20020a05600c511300b00401c392d28dmr4029814wms.2.1693484216706;
        Thu, 31 Aug 2023 05:16:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGojultcfb0NIiOQPSvztdAjpKlNPabZq65nI0NSxG/DjDY/J8YCs5kvptoKVkC+FPxrHVegg==
X-Received: by 2002:a05:600c:5113:b0:401:c392:d28d with SMTP id o19-20020a05600c511300b00401c392d28dmr4029795wms.2.1693484216302;
        Thu, 31 Aug 2023 05:16:56 -0700 (PDT)
Received: from [10.32.64.120] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id z17-20020a7bc7d1000000b003fbdbd0a7desm4922787wmk.27.2023.08.31.05.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 05:16:55 -0700 (PDT)
Message-ID: <98bf616420e4ef3c7c18a1f52fda7cd410137f7d.camel@redhat.com>
Subject: Re: [PATCH 1/5] string.h: add array-wrappers for (v)memdup_user()
From:   Philipp Stanner <pstanner@redhat.com>
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
Date:   Thu, 31 Aug 2023 14:16:54 +0200
In-Reply-To: <CAHp75VdqFPJAnCm9A-S+TCChr9v9_s=Wfnb5wO2=vuwp1v+JvA@mail.gmail.com>
References: <cover.1693386602.git.pstanner@redhat.com>
         <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
         <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com>
         <721a70c347d82931d12e5b75b19d132f82ee5ed2.camel@redhat.com>
         <CAHp75VdS=kSWnz8FzHcdrZPaeZKsQNbzjE9mNN7BDvZA_nQpaA@mail.gmail.com>
         <a4ba0493965ad32fcf95cd6e2439096668a9ed46.camel@redhat.com>
         <CAHp75VdqFPJAnCm9A-S+TCChr9v9_s=Wfnb5wO2=vuwp1v+JvA@mail.gmail.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 2023-08-31 at 11:59 +0300, Andy Shevchenko wrote:
> On Wed, Aug 30, 2023 at 10:15=E2=80=AFPM <pstanner@redhat.com> wrote:
> > On Wed, 2023-08-30 at 17:29 +0300, Andy Shevchenko wrote:
> > > On Wed, Aug 30, 2023 at 5:19=E2=80=AFPM <pstanner@redhat.com> wrote:
> > > > On Wed, 2023-08-30 at 17:11 +0300, Andy Shevchenko wrote:
> > > > > On Wed, Aug 30, 2023 at 4:46=E2=80=AFPM Philipp Stanner
> > > > > <pstanner@redhat.com>
> > > Alphabetical.
> > >=20
> > > compiler.h
> > > err.h
> > > overflow.h
> > > ...the rest that is a bit unordered...
> > >=20
> > > > > > =C2=A0#include <linux/stdarg.h>
> > > > > > =C2=A0#include <uapi/linux/string.h>
> >=20
> > I mean I could include my own in a sorted manner =E2=80=93 but the exis=
ting
> > ones are not sorted:
>=20
> I know, that's why I put "(to some extent)" in my initial comment.
>=20
> > We could sort them all, but I'd prefer to do that in a separate
> > patch
> > so that this commit does not make the impression of doing anything
> > else
> > than including the two new headers
>=20
> But you can do your stuff first with better ordering than you
> proposed
> initially, so there will be less churn for any additional change
> (either that simply unifies the thing or something else).
>=20
>=20

I'll take care of those points in a v2 once I gathered some more
feedback from the other parties.

P.

