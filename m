Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0336C77B61
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Apr 2023 15:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjDXPWa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Apr 2023 11:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjDXPW0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Apr 2023 11:22:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65E76193
        for <linux-hardening@vger.kernel.org>; Mon, 24 Apr 2023 08:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682349703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h9mLtuhNzL4W66bGMVKcTb36aTtFdYTyTbAVeY28DY4=;
        b=Y2sGcfYSzmUJ2qi/Pzau/pUkucUl+lStJFiB8+mYS2K3VqKj7fk4400K3zGfYe6P7EDkcM
        peIVdWruha49iHp8G11nPMtPRJtJcNtv63tCJvFfOjzfs2nSXfs9AjSjTNapVq90warFe9
        D9YwWUVwHywxD/jKBUpXQq/9F71ezZY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-YJVlbVJuM5e0oATULxNdCw-1; Mon, 24 Apr 2023 11:21:39 -0400
X-MC-Unique: YJVlbVJuM5e0oATULxNdCw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4ec55b6b585so721692e87.0
        for <linux-hardening@vger.kernel.org>; Mon, 24 Apr 2023 08:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682349698; x=1684941698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9mLtuhNzL4W66bGMVKcTb36aTtFdYTyTbAVeY28DY4=;
        b=YRu16/owfPmVmFAewe2PJCsE08Lne/OzVV4VQT128hxsNsjlwBAgioRcO+FVt5yknB
         EaRTGFmBPYuPyI4OM0KlzdMAYLI3zjPtE5/2JWC3FGXaPoFwr68pOSHB9V3jg4AQoTDK
         d6qVWGovBPoWaTkHCQ4W6lZ7QpV+RYvjTNYe1ymDiqfHpd6MQVltLM7V/L290jb5UnTc
         Y7UPnrJaogd199/O5aAr6SNnSwyUS6wJ9pd4eU24v/tx3A1IP8ArrchpGC5zrNUfUTIj
         9we7rwoisz8sJ9xw2nvpAp3H0/VwE7Z8P/UE/y5sVEmvwVIlB0/O/igvuX142XRGtzaH
         VYww==
X-Gm-Message-State: AAQBX9cy/BcWaERfLitu3kH5gsTwtRvgrO6SQeeyyKyHem0nZ3yAGXWA
        m/NXd2ZBBLJ4vBVc2p5Otv2i87YCqZptSi1D+hd3VfPFeqHi4uJjYkSFtIUot0cgNZzRVVtiNbj
        3F4e22dsa+afFEb0VjJKXmA6LlSRs9pcCmB4li9x8rAMh
X-Received: by 2002:a2e:bea2:0:b0:2a7:ab72:1687 with SMTP id a34-20020a2ebea2000000b002a7ab721687mr3595014ljr.5.1682349698373;
        Mon, 24 Apr 2023 08:21:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350YxGt6Cwo4tIqSGLrVoLpjanytXyrNDC0r+4Mb8YdvhCBq1mG2uXlYEQc0hcpiACAZU/uRrtQYtpZLEX+kTCpc=
X-Received: by 2002:a2e:bea2:0:b0:2a7:ab72:1687 with SMTP id
 a34-20020a2ebea2000000b002a7ab721687mr3595004ljr.5.1682349698092; Mon, 24 Apr
 2023 08:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whMiMqAv5ATKRkjrdgP2R7WgWmCS4hW2mPwBcL=gzdDNw@mail.gmail.com>
 <D57F9A07-AB77-4FF9-B0A6-C502DC60D093@kernel.org>
In-Reply-To: <D57F9A07-AB77-4FF9-B0A6-C502DC60D093@kernel.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 24 Apr 2023 17:21:27 +0200
Message-ID: <CACO55tvLHh4jfdT==t=B9JpPGEH-5vnEE3Q6AfJWZ_v_1uC6pg@mail.gmail.com>
Subject: Re: Disabling -Warray-bounds for gcc-13 too
To:     Kees Cook <kees@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, gustavo@embeddedor.com,
        nouveau@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        qing.zhao@oracle.com, Ben Skeggs <bskeggs@redhat.com>,
        linux-hardening@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Apr 23, 2023 at 10:24=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On April 23, 2023 10:36:24 AM PDT, Linus Torvalds <torvalds@linux-foundat=
ion.org> wrote:
> >Kees,
> >  I made the mistake of upgrading my M2 Macbook Air to Fedora-38, and
> >in the process I got gcc-13 which is not WERROR-clean because we only
> >limited the 'array-bounds' warning to gcc-11 and gcc-12. But gcc-13
> >has all the same issues.
> >
> >And I want to be able to do my arm64 builds with WERROR on still...
> >
> >I guess it never made much sense to hope it was going to go away
> >without having a confirmation, so I just changed it to be gcc-11+.
>
> Yeah, that's fine. GCC 13 released without having a fix for at least one =
(hopefully last) known array-bounds vs jump threading bug:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D109071
>
> >And one of them is from you.
> >
> >In particular, commit 4076ea2419cf ("drm/nouveau/disp: Fix
> >nvif_outp_acquire_dp() argument size") cannot possibly be right, It
> >changes
> >
> > nvif_outp_acquire_dp(struct nvif_outp *outp, u8 dpcd[16],
> >
> >to
> >
> > nvif_outp_acquire_dp(struct nvif_outp *outp, u8 dpcd[DP_RECEIVER_CAP_SI=
ZE],
> >
> >and then does
> >
> >        memcpy(args.dp.dpcd, dpcd, sizeof(args.dp.dpcd));
> >
> >where that 'args.dp.dpcd' is a 16-byte array, and DP_RECEIVER_CAP_SIZE i=
s 15.
>
> Yeah, it was an incomplete fix. I sent the other half here, but it fell t=
hrough the cracks:
> https://lore.kernel.org/lkml/20230204184307.never.825-kees@kernel.org/
>

left a review on that patch. Any preferred way of getting it upstream?
I could push it through drm-misc, but the delay until it reaches
Linus' tree is a bit high.

>
>
> >
>
> >I think it's all entirely harmless from a code generation standpoint,
> >because the 15-byte field will be padded out to 16 bytes in the
> >structure that contains it, but it's most definitely buggy.
>
> Right; between this, that GCC 13 wasn't released yet, and I had no feedba=
ck from NV folks, I didn't chase down landing that fix.
>
> >
> >So that warning does find real cases of wrong code. But when those
> >real cases are hidden by hundreds of lines of unfixable false
> >positives, we don't have much choice.
>
> Yup, totally agreed. The false positives I've looked at all seem to be si=
milar to the outstanding jump threading bug, so I'm hoping once that gets f=
ixed we'll finally have a good signal with that warning enabled. :)
>
> -Kees
>
>
> --
> Kees Cook
>

