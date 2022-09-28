Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E261C54EE9
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Sep 2022 17:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiI1RJi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 28 Sep 2022 13:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbiI1RJh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 28 Sep 2022 13:09:37 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4E7766A
        for <linux-hardening@vger.kernel.org>; Wed, 28 Sep 2022 10:09:35 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 3so8270162qka.5
        for <linux-hardening@vger.kernel.org>; Wed, 28 Sep 2022 10:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7vQ2L03NmZjTjKW7aYlNCJZqth3/yEDQLyW9BQRTAy8=;
        b=A+bgUQTLuISMRGKf3gH1kVvGmP3b/AaIOap7gHgA/PD0nbgpIKholTwlPXLri1af0K
         cnXmQYCXr6Teuy/PYE/inGfAxECxd/mCvZF/wqKa528cfQv970CHoLHSzLvnxIGoeg2I
         Wt438dq+Wr6ck6v+tRyZuqUTQ439HqIxvfrIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7vQ2L03NmZjTjKW7aYlNCJZqth3/yEDQLyW9BQRTAy8=;
        b=x/B2BW9xustC6en8DKEbjeoqQbyroDiRIYII62q+9u2sd42FP3Dau/+Wehra0Zu4YG
         zaNDR984zr0nPOzYQx9FJ62iLY4bymiezyOyNeOM5kG1btigsBjlXed4Vxd5u+jOZ9ww
         +OIGJtzPwYDWRwmT8SIJvDZNw25qz3txEDv+U9lh/FSvWVflG9vtPaGQEQ37QWqRda8X
         l17O/fwaiieZFIRyEha0BfhT/R6zHSPmzKAZuW2Ix+UDAu4kZCNw3ofe745sHEaq/fZo
         /x1ewMsQPYzkUn2jiQgUo6xWlncTuePFgtYpfsISLUVdGTnIM61dVu8nzzvyT+Z6kVPx
         T6Sg==
X-Gm-Message-State: ACrzQf0C5XJLDUNaWFs3S6YlCGOO71HXPsu9OyCfFH62KosUNhDtG0sr
        PjiaAjyAMPyu2Ljf+4SIp96+aSlZq7CHwQ==
X-Google-Smtp-Source: AMsMyM5oXpcRTFpE0CZrMNKbRPNkX5f5njQaeg5DNs/5i1tZ23FRp9ZFkcc1FtL24JNcfWFVoAwToA==
X-Received: by 2002:a05:620a:269a:b0:6cf:3f0b:8fb4 with SMTP id c26-20020a05620a269a00b006cf3f0b8fb4mr22253244qkp.100.1664384974306;
        Wed, 28 Sep 2022 10:09:34 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id i6-20020a05620a404600b006b8d1914504sm3864054qko.22.2022.09.28.10.09.31
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:09:32 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-3321c2a8d4cso136913317b3.5
        for <linux-hardening@vger.kernel.org>; Wed, 28 Sep 2022 10:09:31 -0700 (PDT)
X-Received: by 2002:a9d:2de3:0:b0:638:e210:c9da with SMTP id
 g90-20020a9d2de3000000b00638e210c9damr14921820otb.69.1664384960424; Wed, 28
 Sep 2022 10:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220928081300.101516-1-gwan-gyeong.mun@intel.com> <20220928081300.101516-6-gwan-gyeong.mun@intel.com>
In-Reply-To: <20220928081300.101516-6-gwan-gyeong.mun@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Sep 2022 10:09:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivJwvVbMUKma8600F6qaVLZHT=BY90SEnjiHWw2ZUVEg@mail.gmail.com>
Message-ID: <CAHk-=wivJwvVbMUKma8600F6qaVLZHT=BY90SEnjiHWw2ZUVEg@mail.gmail.com>
Subject: Re: [PATCH v13 5/9] drm/i915: Check for integer truncation on
 scatterlist creation
To:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mchehab@kernel.org,
        chris@chris-wilson.co.uk, matthew.auld@intel.com,
        thomas.hellstrom@linux.intel.com, jani.nikula@intel.com,
        nirmoy.das@intel.com, airlied@redhat.com, daniel@ffwll.ch,
        andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        keescook@chromium.org, mauro.chehab@linux.intel.com,
        linux@rasmusvillemoes.dk, vitor@massaru.org, dlatypov@google.com,
        ndesaulniers@google.com, trix@redhat.com, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org, linux-sparse@vger.kernel.org,
        nathan@kernel.org, gustavoars@kernel.org,
        luc.vanoostenryck@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Sep 28, 2022 at 1:15 AM Gwan-gyeong Mun
<gwan-gyeong.mun@intel.com> wrote:
>
> +       if (check_assign(obj->base.size >> PAGE_SHIFT, &npages))
> +               return -E2BIG;

I have to say, I find that new "check_assign()" macro use to be disgusting.

It's one thing to check for overflows.

It's another thing entirely to just assign something to a local variable.

This disgusting "let's check and assign" needs to die. It makes the
code a completely unreadable mess. The "user" wersion is even worse.

If you worry about overflow, then use a mix of

 (a) use a sufficiently large type to begin with

 (b) check for value range separately

and in this particular case, I also suspect that the whole range check
should have been somewhere else entirely - at the original creation of
that "obj" structure, not at one random end-point where it is used.

In other words, THIS WHOLE PATCH is just end-points checking the size
requirements of that "base.size" thing much too late, when it should
have been checked originally for some "maximum acceptable base size"
instead.

And that "maximum acceptable base size" should *not* be about "this is
the size of the variables we use". It should be a sanity check of
"this value is sane and fits in sane use cases".

Because "let's plug security checks" is most definitely not about
picking random assignments and saying "let's check this one". It's
about trying to catch things earlier than that.

Kees, you need to reign in the craziness in overflow.h.

                 Linus
