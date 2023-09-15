Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786E0EEEC00
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 19:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbjIOTGl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 15:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237057AbjIOTGe (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 15:06:34 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01822B3
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 12:06:28 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-6564515ec4eso830256d6.2
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694804788; x=1695409588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NNdNMoPNLRC5J4Us7rjn5YK+Bn2P8ki5j52BrAmQfc=;
        b=IcUP3ZThw4r0yzR1wPf2MKuL86qqJTY3lGmO5wVIwizbo32mHmJNZZSk/HLCKHmzhW
         Gla9MXisJOcGl205VuT46VlfVlhP6xgjKUvgEbqifKysED3psNQ5hqW3CZOjgckLmjeX
         43LkHAbC+H1FUTt/bAuUJd+MV8LWoq2/Z74adGTaSMb3PVcM6bURd5o8B0Dd8ZnDhmch
         F88soN5Lthi1YPNktkbKNwEd2wMiZaMQllXBNNsrJx1dLyIgTkvZTwdgw5Ap7ERCiBEj
         aEE4u5wKUgjHR8vyQY0ZFUpZ7YEJ7LxF7BwF+AgWpkAv65snr4p5kovPzR4wE932OWEy
         6kNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694804788; x=1695409588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NNdNMoPNLRC5J4Us7rjn5YK+Bn2P8ki5j52BrAmQfc=;
        b=wWDsLvcTt+WhdkJU9CG56uVqFITWW6pZmhdd1cKyzJuxtHOcwnFNoJmZTsDs3mV1Pg
         2MVSmjKBoJiP/MvSTLwiY5FMhnyW7e8NKIaJ6L2gMlJutM4iGwVr7+yHXWKEtAy4vulG
         zZyU12RS9TdGcD5BmlIWpbACAA241WUqrOyBdjgZ2T7Vq2eMbOhcZZhOUWj4wcUjxJFc
         8k+Uxtt37kc+isdMCdtsPWyasWKQQo2w+kCzzLH4x+GhSL40rO7GQZ2uid34jzAdUKyS
         X1RWurQbmblWL3oD1db5AK90Tl3G5CDXeL3BfKSsRO4pArXiQSPIVHXhKYcovRqJ0cUL
         faJQ==
X-Gm-Message-State: AOJu0Yxyk5IaM7u9NeNMtdAjApM6atXf6r4QUPXmuRvAW8APU0n9UIRt
        DW/D/YeQOcd+fpU4N0PxbHbV0usuJWZLTv/fzgx1WQ==
X-Google-Smtp-Source: AGHT+IHnUmEPsIeFlP8ufy20De8OLVwpSSqcrp7lDWmTe6PTj/7WjDAOWdhgq5G3z26K+KHrakYbT0n8GVD/uGs4Htc=
X-Received: by 2002:a0c:e301:0:b0:651:65ca:141d with SMTP id
 s1-20020a0ce301000000b0065165ca141dmr2504505qvl.37.1694804787931; Fri, 15 Sep
 2023 12:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230915050125.3609689-1-davidgow@google.com>
In-Reply-To: <20230915050125.3609689-1-davidgow@google.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 15 Sep 2023 12:05:50 -0700
Message-ID: <CABCJKueOu+MwgvTcEUY51tJ1YjNjS-3zHhAHP=1TQUC1wd_1VA@mail.gmail.com>
Subject: Re: [RFC PATCH] kunit: Add a macro to wrap a deferred action function
To:     David Gow <davidgow@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <rmoar@google.com>, dlatypov@google.com,
        Benjamin Berg <benjamin.berg@intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi David,

On Thu, Sep 14, 2023 at 10:01=E2=80=AFPM David Gow <davidgow@google.com> wr=
ote:
>
> KUnit's deferred action API accepts a void(*)(void *) function pointer
> which is called when the test is exited. However, we very frequently
> want to use existing functions which accept a single pointer, but which
> may not be of type void*. While this is probably dodgy enough to be on
> the wrong side of the C standard, it's been often used for similar
> callbacks, and gcc's -Wcast-function-type seems to ignore cases where
> the only difference is the type of the argument, assuming it's
> compatible (i.e., they're both pointers to data).
>
> However, clang 16 has introduced -Wcast-function-type-strict, which no
> longer permits any deviation in function pointer type. This seems to be
> because it'd break CFI, which validates the type of function calls.
>
> This rather ruins our attempts to cast functions to defer them, and
> leaves us with a few options:
> 1. Stick our fingers in our ears an ignore the warning. (It's worked so
>    far, but probably isn't the right thing to do.)
> 2. Find some horrible way of casting which fools the compiler into
>    letting us do the cast. (It'd still break CFI, though.)
> 3. Disable the warning, and CFI for this function. This isn't optimal,
>    but may make sense for test-only code. However, I think we'd have to
>    do this for every function called, not just the caller, so maybe it's
>    not practical.
> 4. Manually write wrappers around any such functions. This is ugly (do
>    we really want two copies of each function, one of which has no type
>    info and just forwards to the other). It could get repetitive.
> 5. Generate these wrappers with a macro. That's what this patch does.
>
> I'm broadly okay with any of the options above, though whatever we go
> with will no doubt require some bikeshedding of details (should these
> wrappers be public, do we dedupe them, etc).
>
> Thoughts?

Using a macro to generate a wrapper is a reasonable approach IMO, and
we've used it before in the kernel to fix type mismatches in
indirectly called functions (v4l2-ioctl and cfg80211 come to mind at
least).

Sami
