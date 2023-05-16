Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8022C7EE23
	for <linux-hardening@archiver.kernel.org>; Tue, 16 May 2023 22:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjEPWYZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 May 2023 18:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjEPWYZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 May 2023 18:24:25 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4EB59F4
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 15:24:23 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bf7bb76d0so1614a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 15:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684275861; x=1686867861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AU+G8+xjWKVQ5QpMo/ZQtkQQPbKk/ob+AkurzetYB3A=;
        b=I+12tB8k6cmWXNu4K8IeyT6yX//Q7Lt11e1U3ivqkeeNZeBZsEkMyNEb257HXDCD/2
         PIc8KE7K+G3HfXqeTtrQkxcylFnF/5nD16KKO7uUQseU9uhkiM3IOhP6SCc+F1aiSGF1
         It+znTfuWuEtYPBXDJOi6/4iyA12Ty+0Puwk6l9QPMWjarCK5iqt0Fu+nr2+yFa1KLIJ
         z4LiEzTYlGNUBPhjuD6IMeJApIbg/QQMMOEGIRtIEJPAx3GLRnyGc+ZBOWrMAZblt0gX
         kfIk249OUMEGX3hdhtiR6QOY4uHtIbwdJ2mm+8Dqb109gAESymSqAXrAvsrF4sSSRZSf
         Od+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684275861; x=1686867861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AU+G8+xjWKVQ5QpMo/ZQtkQQPbKk/ob+AkurzetYB3A=;
        b=RoagRTDWJnDhH5dLuTjzcewmHGQsJy1jcFplYtjIlG6KeftQktgp/bMnf/b+aAkRvL
         XoheA8RK7Fcf4/ci/mwbgdKW0XeNzKHNSb/muN3iOSyLIC2CVvB0FJPydstW4ju2ugeU
         LWBpUw1Ajer14bYVvTHy28hkp1FdnppuIaG2I461TCbAkZeQLzZxyeDKgMcEg/1aApw+
         Ht62LsWUCaXfTbD1X5kawnHM6jv3xSsDAVly79gzRIBAWgZjfPJT9Kxv/nZ3BKMUda9m
         yQTwMXlrDDuRVtL2BP8puvzmse7FFaPhe3MHx2hx+uuFMoSvSHkky7ufwavphNR5q7DN
         dhkw==
X-Gm-Message-State: AC+VfDxj+wGEP2BQ3Y4QFZtvzJlfLl5nYm5zikNyqHjO1MqqPf1+lUFn
        EcqaNBm8YRRecAcYU9+1sCwk3el8P2Lv7xBDk6LBvg==
X-Google-Smtp-Source: ACHHUZ6I9F6ZxW6AR0PAmznGKdrruOuCBaUN+XoRqAFbHSGQ20hvl27t0+Ehm201A6rGO8XrNf3S3AD1GrFz6zCTvtE=
X-Received: by 2002:a50:99d3:0:b0:505:863:d85f with SMTP id
 n19-20020a5099d3000000b005050863d85fmr43123edb.4.1684275861049; Tue, 16 May
 2023 15:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <20230515130553.2311248-4-jeffxu@chromium.org>
 <202305161307.77B29D261@keescook>
In-Reply-To: <202305161307.77B29D261@keescook>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 16 May 2023 15:23:44 -0700
Message-ID: <CALmYWFujMVFLWDMMkdvWDDpXm+Z=b2vXapX1-2g1qe-qePMyhg@mail.gmail.com>
Subject: Re: [PATCH 3/6] PKEY: Apply PKEY_ENFORCE_API to mprotect
To:     Kees Cook <keescook@chromium.org>
Cc:     jeffxu@chromium.org, dave.hansen@intel.com, luto@kernel.org,
        jorgelo@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 16, 2023 at 1:07=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, May 15, 2023 at 01:05:49PM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@google.com>
> >
> > This patch enables PKEY_ENFORCE_API for the mprotect and
> > mprotect_pkey syscalls.
>
> All callers are from userspace -- this change looks like a no-op?
>
Yes. All callers are from user space now.
I am thinking about the future when someone adds a caller in kernel
code and may miss the check.
This is also consistent with munmap and other syscalls I plan to change.
There are comments on do_mprotect_pkey() to describe how this flag is used.


> -Kees
>
> --
> Kees Cook
