Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8E0C433FE
	for <linux-hardening@archiver.kernel.org>; Tue, 11 Oct 2022 20:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiJKU0R (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 11 Oct 2022 16:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJKU0Q (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 11 Oct 2022 16:26:16 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579BC796BE
        for <linux-hardening@vger.kernel.org>; Tue, 11 Oct 2022 13:26:15 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id a17so7780002ilq.1
        for <linux-hardening@vger.kernel.org>; Tue, 11 Oct 2022 13:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=po1IjVvNbfbkNgObAIQZQOCa9GvhgYqjWMEtcnXnmpc=;
        b=d6MtaVm6pP0yHYkMSOsLFHOxH5SVe6fGiLgMrrPMUGQpwYsNyBwYRXGyfmQ7V/MOHU
         josGyFZE7meSowi4YBlN2kf5OMx39SfNGpGa5ATdwq7h7jn8VpDjhlVfxUudxl62Vx33
         dzz0bUXSI3nF4o2FJ3Z1wxWzuUEasjt0+/IcYF6R58BaE/5p5U0JyBiCA73ODjYHi5GG
         vUrDDvSioW6eXlvBK1WGiSqHjeXA31Xxd61QfEF8tjtIkT0NvZbQArsewaW0kkrmYJzT
         spleOTxpeRlgFDIuE/oRQCZumpd0WAcvXD8QecHLaShxRVY0arhBGQyBewnh4HDWh3og
         kBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=po1IjVvNbfbkNgObAIQZQOCa9GvhgYqjWMEtcnXnmpc=;
        b=1+usd/m/tj8mC2g4zRuyXzP9EV6qhUDtmcwUR6+leOIv+3J2H3yq8gUwhFvXN5Ptah
         HZntpOz7WBuys8LHp/cvaxYi+1iYl1kVb3yGFzncGwsgWl5ALMAmnxAPszv3k9wQAaYD
         vHZaJTl1li8Vv0z9ro2GZ0v/xL03fhqRXp2UDaj23ek7yw07APWPZYe4TWMaYy5OcWhQ
         jiWs8VGzrcwFe0xPS0feybk2tcoNMHxxhemzv6yIfc6xEE2vUzpXRxcZqNQ1APmvle1r
         ioa74zeEN45A+H29DbTD5W17KcijNpOKaXAdTF4tyHHn4nFxA1XwqhEshahZo69ZJ3y6
         lSXA==
X-Gm-Message-State: ACrzQf31bGLWAd524lw464Of2oRBMzRQ4PjH/RqX8v5aob6jhix2c8GQ
        7pIgZOis9U0dBi4xezmfD8W2dfFK20zh8hD3zEvY8ZmwDoE=
X-Google-Smtp-Source: AMsMyM415+lMvVbX7yZEq7tZlWUuO3juBcQw6UXdl44PBZ6p/6LEI1BZ/phvFx/2s2QBTyfEqvspvNeGvv9GRetnYqg=
X-Received: by 2002:a92:6506:0:b0:2fc:37fb:60c2 with SMTP id
 z6-20020a926506000000b002fc37fb60c2mr6188696ilb.244.1665519974463; Tue, 11
 Oct 2022 13:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221011200112.731334-1-keescook@chromium.org> <20221011200112.731334-6-keescook@chromium.org>
In-Reply-To: <20221011200112.731334-6-keescook@chromium.org>
From:   Colin Cross <ccross@android.com>
Date:   Tue, 11 Oct 2022 13:26:02 -0700
Message-ID: <CAMbhsRT2KafJ8-mvKbi1MkY8T-0sZFdCg-Rb8FoUGorGH6jipg@mail.gmail.com>
Subject: Re: [PATCH 5/5] MAINTAINERS: Update pstore maintainers
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Anton Vorontsov <anton@enomsg.org>,
        Tony Luck <tony.luck@intel.com>,
        Paramjit Oberoi <pso@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 11, 2022 at 1:01 PM Kees Cook <keescook@chromium.org> wrote:
>
> Update pstore to better reflect reality of active contributors:
>
> - Remove Anton and Colin (thank you for your help through the years!)
> - Move Tony to Reviewer
> - Add Guilherme as Reviewer
> - Add mailing list
> - Upgrade to Supported
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  MAINTAINERS | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d7f64dc0efe..bb18a6c91c4e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16458,10 +16458,10 @@ F:    net/psample
>
>  PSTORE FILESYSTEM
>  M:     Kees Cook <keescook@chromium.org>
> -M:     Anton Vorontsov <anton@enomsg.org>
> -M:     Colin Cross <ccross@android.com>
> -M:     Tony Luck <tony.luck@intel.com>
> -S:     Maintained
> +R:     Tony Luck <tony.luck@intel.com>
> +R:     Guilherme G. Piccoli <gpiccoli@igalia.com>
> +L:     linux-hardening@vger.kernel.org
> +S:     Supported
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
>  F:     Documentation/admin-guide/ramoops.rst
>  F:     Documentation/admin-guide/pstore-blk.rst
> --
> 2.34.1
>

Acked-by: Colin Cross <ccross@android.com>
