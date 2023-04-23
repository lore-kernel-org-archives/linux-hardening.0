Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85C4C6FD18
	for <linux-hardening@archiver.kernel.org>; Sun, 23 Apr 2023 20:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDWUXx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 23 Apr 2023 16:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjDWUXx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 23 Apr 2023 16:23:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96321E78
        for <linux-hardening@vger.kernel.org>; Sun, 23 Apr 2023 13:23:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38AD561151
        for <linux-hardening@vger.kernel.org>; Sun, 23 Apr 2023 20:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C6FC433EF;
        Sun, 23 Apr 2023 20:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682281430;
        bh=aJomo+1XriWp58HKaMQAxMIYXWh9x3/TZjRP96T4xvs=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=XQaAGwMCQAX9BzLybKa6RtI8RJAZPJJgnwb30OXkudNH8YKEXvgOlnidHt06Ud/+C
         gO8a1+yZG3vabIZx3Biz5B2/6tCmd85sTXYEcotmyInc6o22CVjoO+x+UqdLUefg9v
         FeOqv8S6PUILyAfsPQOO8NlE3qXzN1HNp/q3H7CQE4nK+rUPhCFaT30RClQkvSmSn6
         I+NpzpItMXfSdzFPDtbZ1NNDnyTbkSa8huvSkirtzf4YjaN1UiDNC8nr5eTvkHQs4Z
         SFq7jDhqfKfdYHPcJZyMtNm1JosFLLjJ1vNz/mvPnU9s3vZV66xXca/KdwgSvI4vUM
         Q/nL0OYBb3RGA==
Date:   Sun, 23 Apr 2023 13:23:48 -0700
From:   Kees Cook <kees@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
CC:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau@lists.freedesktop.org, linux-hardening@vger.kernel.org,
        gustavo@embeddedor.com, qing.zhao@oracle.com
Subject: Re: Disabling -Warray-bounds for gcc-13 too
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=whMiMqAv5ATKRkjrdgP2R7WgWmCS4hW2mPwBcL=gzdDNw@mail.gmail.com>
References: <CAHk-=whMiMqAv5ATKRkjrdgP2R7WgWmCS4hW2mPwBcL=gzdDNw@mail.gmail.com>
Message-ID: <D57F9A07-AB77-4FF9-B0A6-C502DC60D093@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On April 23, 2023 10:36:24 AM PDT, Linus Torvalds <torvalds@linux-foundatio=
n=2Eorg> wrote:
>Kees,
>  I made the mistake of upgrading my M2 Macbook Air to Fedora-38, and
>in the process I got gcc-13 which is not WERROR-clean because we only
>limited the 'array-bounds' warning to gcc-11 and gcc-12=2E But gcc-13
>has all the same issues=2E
>
>And I want to be able to do my arm64 builds with WERROR on still=2E=2E=2E
>
>I guess it never made much sense to hope it was going to go away
>without having a confirmation, so I just changed it to be gcc-11+=2E

Yeah, that's fine=2E GCC 13 released without having a fix for at least one=
 (hopefully last) known array-bounds vs jump threading bug:
https://gcc=2Egnu=2Eorg/bugzilla/show_bug=2Ecgi?id=3D109071

>And one of them is from you=2E
>
>In particular, commit 4076ea2419cf ("drm/nouveau/disp: Fix
>nvif_outp_acquire_dp() argument size") cannot possibly be right, It
>changes
>
> nvif_outp_acquire_dp(struct nvif_outp *outp, u8 dpcd[16],
>
>to
>
> nvif_outp_acquire_dp(struct nvif_outp *outp, u8 dpcd[DP_RECEIVER_CAP_SIZ=
E],
>
>and then does
>
>        memcpy(args=2Edp=2Edpcd, dpcd, sizeof(args=2Edp=2Edpcd));
>
>where that 'args=2Edp=2Edpcd' is a 16-byte array, and DP_RECEIVER_CAP_SIZ=
E is 15=2E

Yeah, it was an incomplete fix=2E I sent the other half here, but it fell =
through the cracks:
https://lore=2Ekernel=2Eorg/lkml/20230204184307=2Enever=2E825-kees@kernel=
=2Eorg/



>

>I think it's all entirely harmless from a code generation standpoint,
>because the 15-byte field will be padded out to 16 bytes in the
>structure that contains it, but it's most definitely buggy=2E

Right; between this, that GCC 13 wasn't released yet, and I had no feedbac=
k from NV folks, I didn't chase down landing that fix=2E

>
>So that warning does find real cases of wrong code=2E But when those
>real cases are hidden by hundreds of lines of unfixable false
>positives, we don't have much choice=2E

Yup, totally agreed=2E The false positives I've looked at all seem to be s=
imilar to the outstanding jump threading bug, so I'm hoping once that gets =
fixed we'll finally have a good signal with that warning enabled=2E :)

-Kees


--=20
Kees Cook
