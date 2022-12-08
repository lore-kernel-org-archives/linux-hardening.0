Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A1CC10F1B
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Dec 2022 18:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiLHSem (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Dec 2022 13:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiLHSeX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Dec 2022 13:34:23 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D598E99F30
        for <linux-hardening@vger.kernel.org>; Thu,  8 Dec 2022 10:33:56 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id jn7so2325474plb.13
        for <linux-hardening@vger.kernel.org>; Thu, 08 Dec 2022 10:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3HMnEdvlSF5TjjjrupZOysPGDweIaS3qD4bjjLotW48=;
        b=KE7SYRHqlqq8QkfVRH+aj5xt+UojUw/LjLkt04Mk33NpQt8FmxscR/m0rESsgU7iou
         hs3k530a6Nlc5wvphwXX/GwbcNynh5tBwKPHYG6Dlo5aonRwQc9tJkPnqX0uZUTIBOhp
         pQRoJWNjCM2NdrntCc241rXSsNInrTt1YhDAjfI2mtja0Rtb2C07/tj/ggrh90NhIsKc
         SuKzAZ0WEZDAjyM34QsXXFMsc99zHfeEmg+5qutqLe5DWCGdPy2WFJyLMQ1z9QH7YFGj
         f981OOSr1zCwl+I1ISonvF5sdNwUdDkYP6BPM7pP7mVl9FkQqHOP03wWry0uJP/Y5DEr
         426g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3HMnEdvlSF5TjjjrupZOysPGDweIaS3qD4bjjLotW48=;
        b=sA7E16UH8TCVfvsR14GaLxvyJbONfrhT6ia8iCebEP+CJBes9Yai2nxxS7k+39egwn
         k0++G1NDLmx5f1ayj7caSldzzgef33sdVgQWpSLbl7CvA8CUjBx1civHwkVRtS3/5QOJ
         +5Sy9ZugMh/uK8uJhYg/psTfhq6+JjG1W07tjjaMwc4W6M1czrpa8XXIXxzYktHEvIuD
         vD3vB35N40r0tWkLl8b4bgPmL1+Rs53DnrFYsvvn1v7oqkHReSkY2CYGIRxlH15oGUd2
         RsDCHjApuIAEjqZSQm0DvOS1kS91vgtQinoHzXrWIAffc1l2toMd0+3ShIagICiPkbaN
         +UaQ==
X-Gm-Message-State: ANoB5pmZ7MivUSuetoD01eTpcDy54lmjgYN+qJN0avuhD685MNgOI4vO
        rHRaJaWCzJbGczwvLk2cOsNP10MfLYc/m/xf67wi+g==
X-Google-Smtp-Source: AA0mqf7v9g7E7bWC/SwAnZzMQJjPNqcL7NCSx9bBhwK1qoxmDIDfQ2miJHi8NJFOjjeloV1lv0mzWXlBlxmWDysMHCU=
X-Received: by 2002:a17:903:3052:b0:189:63ef:ef3b with SMTP id
 u18-20020a170903305200b0018963efef3bmr64459851pla.112.1670524436153; Thu, 08
 Dec 2022 10:33:56 -0800 (PST)
MIME-Version: 1.0
References: <20221207154939.2532830-1-jeffxu@google.com> <202212080809.687CC8BC23@keescook>
In-Reply-To: <202212080809.687CC8BC23@keescook>
From:   Jeff Xu <jeffxu@google.com>
Date:   Thu, 8 Dec 2022 10:33:19 -0800
Message-ID: <CALmYWFukzdw4e3RHWRsdXvYr1RZs7Bx6NZ3AK91hoArgVy-RxQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] mm/memfd: introduce MFD_NOEXEC_SEAL and MFD_EXEC
To:     Kees Cook <keescook@chromium.org>
Cc:     jeffxu@chromium.org, skhan@linuxfoundation.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Dec 8, 2022 at 8:13 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Dec 07, 2022 at 03:49:33PM +0000, jeffxu@chromium.org wrote:
> > This is V6 version of patch: see [4] [5] [6] [7] for previous versions.
>
> When sending a new version, can you include an overview of what changed
> between this version and the prior version? This helps reviewers who are
> following along, so it's easier to focus our attention on the
> differences. Also, it's helpful to version the links:
>
> > [4] https://lwn.net/Articles/890096/
> > [5] https://lore.kernel.org/lkml/20220805222126.142525-1-jeffxu@google.com/
> > [6] https://lore.kernel.org/lkml/20221202013404.163143-1-jeffxu@google.com/
> > [7] https://lore.kernel.org/lkml/20221206152358.1966099-1-jeffxu@google.com/
>
> e.g.:
>
> v6:
> - moved foo to bar
> - improve comments for baz
> v5: https://lore.kernel.org/lkml/20221206152358.1966099-1-jeffxu@google.com/
> v3: https://lore.kernel.org/lkml/20221202013404.163143-1-jeffxu@google.com/
> v2: ...etc
>
Will do!
Much appreciated for helping me  through the process of my first patch
in the kernel.

Jeff

> -Kees
>
> --
> Kees Cook
