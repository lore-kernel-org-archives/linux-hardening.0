Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43ACC433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Feb 2022 21:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiBBV10 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Feb 2022 16:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239820AbiBBV1Z (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Feb 2022 16:27:25 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6376BC06173B
        for <linux-hardening@vger.kernel.org>; Wed,  2 Feb 2022 13:27:25 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id n8so1733695lfq.4
        for <linux-hardening@vger.kernel.org>; Wed, 02 Feb 2022 13:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vk5wYy3sT4I5WW+WUYmWyAImSgUa3X6inu5KcZCXPKY=;
        b=aENyZMxtUMXciI8o8/Vm8rLMVTMwkMTUfjJ/Gv61rnrp1fCHNR+qb4Ih6z3KIWHXhw
         s373VCw9AWxxeLrFacSEm4Gnpw0b+qTknppxCbYyULRkOKgD6E9pz34SgGO8qj+IPsdi
         YnqpBtc56ZqzQQjKXV9BQmLDHQNKnEu6G4Bg9LYVdTi7cllMQ0ThOesYqVblF5tRNKe7
         xOIQyekXcQTHn5EzdoIeKu6Iv3dQ6jyhNYlzRhFnEcI94cKlrmCoUSI1tYWV1F2FuP2K
         vmZkR7+CzSYMh0k0GdSower3/61Aazzj6k2MEh5MgsBbBZCStEbc/DRnHefWMmmTQ2Ha
         4sYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vk5wYy3sT4I5WW+WUYmWyAImSgUa3X6inu5KcZCXPKY=;
        b=upCmrCm1Aiiv+kX6qP3Y1IAw/tT+3Gg5dlZRjcCfus51CnyrnogulEFOSJuaTHHD0P
         wWRDMnHbMfuUKf+eKOg68ZmM1lSnaZMNl97hVK90cjD7ZSQ/MN/hTKmZ8enOCv2DgKtt
         T+mSlaD4I3ZaUVLFwpddK+rEv7zrY/BM0+X4dH1pZ/DqDkRbDY3JLWwRPy8ZTa8bBgIO
         DRmMkjC0hoZEKkMgfgAcFekGGvF0xzkuXffJpUdEGhcJOInr6hbElL8NHQBU8BDuF6t4
         3cEuKIViqCRW8gfiFlB1b7NNN/tGK97gCyem/W/xv7mXj1rTKT99WStewFhE7CUUAULy
         sLYQ==
X-Gm-Message-State: AOAM531LawVAP8IbfkUHRmsyJ31LaA6yrJBCYhyRcewxpLEPGUGqki2W
        jrnNvxRdTe2QyOIZiIuc0F47es77+87U7B7JpIXI+Q==
X-Google-Smtp-Source: ABdhPJyVqcYu3VpsE+xUOxSO999oM0orrVsNe7CURCcH7MfcCvDqjXznVMXZdNpW6flzSa772wPoyzvt1jlwncMP0EQ=
X-Received: by 2002:a05:6512:3ba5:: with SMTP id g37mr24568699lfv.651.1643837243564;
 Wed, 02 Feb 2022 13:27:23 -0800 (PST)
MIME-Version: 1.0
References: <20220202003033.704951-1-keescook@chromium.org> <20220202003033.704951-5-keescook@chromium.org>
In-Reply-To: <20220202003033.704951-5-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 2 Feb 2022 13:27:11 -0800
Message-ID: <CAKwvOd=icTwyFb39U3OO5i_2YNJMiCMteeNTrVe-Q0tcmmnBJQ@mail.gmail.com>
Subject: Re: [PATCH 4/4 v5] fortify: Add Clang support
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Feb 1, 2022 at 4:30 PM Kees Cook <keescook@chromium.org> wrote:
>
> +#define BOS    const __pass_object_size(1)
> +#define BOS0   const __pass_object_size(0)

A dumb bikeshed, but would you mind naming these BOS1 and BOS0, and
perhaps consider adding a comment or pointer or link to something that
describes why we use the two different modes?  I recognize that the
code already uses the two different modes already without comments,
but this might be a nice place to point folks like myself to so that
in a month or so when I forget what the difference is between modes
(again), we have a shorter trail of breadcrumbs.
-- 
Thanks,
~Nick Desaulniers
