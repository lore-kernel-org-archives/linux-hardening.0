Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDCCC77B73
	for <linux-hardening@archiver.kernel.org>; Thu, 27 Apr 2023 22:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbjD0WvM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 27 Apr 2023 18:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344053AbjD0WvL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 27 Apr 2023 18:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17822717
        for <linux-hardening@vger.kernel.org>; Thu, 27 Apr 2023 15:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682635821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XYwE6J+8fhzVxHGIhBXfS5rnsX56X4uP+Tk4MmEmW4c=;
        b=YpJxBH3oMapd/dL1MPVaQYyyn691DPYNinH0C2hRYaSScEtGxxYgFgfLBzPnvszOoKT6je
        0WNy2ipe6bBJD0JKWyABagbW49XtiTn7vIA20HHlpcx0l3MNGHGDNte0xfHSg9vKp9N8eg
        Cv2HES4f/PTaMtp0VvPjYbQbXinaVfs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-LGMpXvlkOMW1Zi8iOx2lQQ-1; Thu, 27 Apr 2023 18:50:19 -0400
X-MC-Unique: LGMpXvlkOMW1Zi8iOx2lQQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4edc965fd01so636904e87.1
        for <linux-hardening@vger.kernel.org>; Thu, 27 Apr 2023 15:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682635818; x=1685227818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYwE6J+8fhzVxHGIhBXfS5rnsX56X4uP+Tk4MmEmW4c=;
        b=V+nwhi800G17S0dJtgQ8uqytaJdi8meY5yJ+KbZmlNs1h6dpa4lDic6gsrOUU9nq+M
         qKymM1KElDrf1eXErHeUTSOY5YeA5O5d0fpyadbxe/ArR7eoW8G4JdBsW+6xqBGCW8bz
         3HUUq47cJN3ytBX/166JaMWt/H06sOBScdTQ+YZNxyWQdkbD/BA4u9Aj+/kuhowuKr8T
         +18s82b5mGj3o2uj2uUkSY5xY8a8cFSFKSmHAo3X4v6pHm6lwCXzCYB0puSHov9K8ptN
         etRY+vkwOhL4t7WlyQ31j4NrvGiGNwkomS1P94ah2ZEokj1TfksotBY626YS7+0UhMte
         U9kw==
X-Gm-Message-State: AC+VfDwhIEOZ2+G5wQ7bMJd43d1GEpLyQDvLVae2ChaSpHRTaHENz0c6
        KbjId9c6fmTyfbGsfuzGbD4gqkQlrDKgICKNDkHUKuXMEUPQIQ6AZxTXxJPi953SxQYYKx800AX
        peCc01n+6hEeGJs6IfSoLAg/N2OLfm2BmfK7OjvQkKnOX
X-Received: by 2002:a05:651c:1590:b0:2ab:2801:1735 with SMTP id h16-20020a05651c159000b002ab28011735mr929713ljq.3.1682635818402;
        Thu, 27 Apr 2023 15:50:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5FVGB+18TEDP08O0pAl9+pf4YrEeVgruqnJYSUblIZnaUtqwyJ1VdecyaJu9FFAUY4/+qLGMOJsDIuOIPBnV4=
X-Received: by 2002:a05:651c:1590:b0:2ab:2801:1735 with SMTP id
 h16-20020a05651c159000b002ab28011735mr929707ljq.3.1682635818083; Thu, 27 Apr
 2023 15:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whMiMqAv5ATKRkjrdgP2R7WgWmCS4hW2mPwBcL=gzdDNw@mail.gmail.com>
 <D57F9A07-AB77-4FF9-B0A6-C502DC60D093@kernel.org> <529e56c85732b0bfcf277de9c651f6c58f47b3b4.camel@redhat.com>
In-Reply-To: <529e56c85732b0bfcf277de9c651f6c58f47b3b4.camel@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 28 Apr 2023 00:50:06 +0200
Message-ID: <CACO55tvJE4UvsAY8yfY7j4gMRkk4kLUPedfL0Sw2B7OF=s-rEw@mail.gmail.com>
Subject: Re: Disabling -Warray-bounds for gcc-13 too
To:     Lyude Paul <lyude@redhat.com>
Cc:     Kees Cook <kees@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau@lists.freedesktop.org, linux-hardening@vger.kernel.org,
        gustavo@embeddedor.com, qing.zhao@oracle.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 28, 2023 at 12:46=E2=80=AFAM Lyude Paul <lyude@redhat.com> wrot=
e:
>
> Hey Linus, Kees. Responses below
>
> On Sun, 2023-04-23 at 13:23 -0700, Kees Cook wrote:
> > On April 23, 2023 10:36:24 AM PDT, Linus Torvalds <torvalds@linux-found=
ation.org> wrote:
> > > Kees,
> > >  I made the mistake of upgrading my M2 Macbook Air to Fedora-38, and
> > > in the process I got gcc-13 which is not WERROR-clean because we only
> > > limited the 'array-bounds' warning to gcc-11 and gcc-12. But gcc-13
> > > has all the same issues.
> > >
> > > And I want to be able to do my arm64 builds with WERROR on still...
> > >
> > > I guess it never made much sense to hope it was going to go away
> > > without having a confirmation, so I just changed it to be gcc-11+.
> >
> > Yeah, that's fine. GCC 13 released without having a fix for at least on=
e (hopefully last) known array-bounds vs jump threading bug:
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D109071
> >
> > > And one of them is from you.
> > >
> > > In particular, commit 4076ea2419cf ("drm/nouveau/disp: Fix
> > > nvif_outp_acquire_dp() argument size") cannot possibly be right, It
> > > changes
> > >
> > > nvif_outp_acquire_dp(struct nvif_outp *outp, u8 dpcd[16],
> > >
> > > to
> > >
> > > nvif_outp_acquire_dp(struct nvif_outp *outp, u8 dpcd[DP_RECEIVER_CAP_=
SIZE],
> > >
> > > and then does
> > >
> > >        memcpy(args.dp.dpcd, dpcd, sizeof(args.dp.dpcd));
> > >
> > > where that 'args.dp.dpcd' is a 16-byte array, and DP_RECEIVER_CAP_SIZ=
E is 15.
> >
> > Yeah, it was an incomplete fix. I sent the other half here, but it fell=
 through the cracks:
> > https://lore.kernel.org/lkml/20230204184307.never.825-kees@kernel.org/
>
> Thanks for bringing this to our attention, yeah this definitely just look=
s
> like it got missed somewhere down the line. It looks like Karol responded
> already so I assume the patch is in the pipeline now, but let me know if
> there's anything else you need.
>

uhm, I didn't push anything, but I can push it through drm-misct asap,
just wanted to ask if somebody wants to pick a quicker route. But I
guess not?

> >
> >
> >
> > >
> >
> > > I think it's all entirely harmless from a code generation standpoint,
> > > because the 15-byte field will be padded out to 16 bytes in the
> > > structure that contains it, but it's most definitely buggy.
> >
> > Right; between this, that GCC 13 wasn't released yet, and I had no feed=
back from NV folks, I didn't chase down landing that fix.
> >
> > >
> > > So that warning does find real cases of wrong code. But when those
> > > real cases are hidden by hundreds of lines of unfixable false
> > > positives, we don't have much choice.
> >
> > Yup, totally agreed. The false positives I've looked at all seem to be =
similar to the outstanding jump threading bug, so I'm hoping once that gets=
 fixed we'll finally have a good signal with that warning enabled. :)
> >
> > -Kees
> >
> >
>
> --
> Cheers,
>  Lyude Paul (she/her)
>  Software Engineer at Red Hat
>

