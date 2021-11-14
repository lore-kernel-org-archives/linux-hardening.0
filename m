Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F43BC433F5
	for <linux-hardening@archiver.kernel.org>; Sun, 14 Nov 2021 00:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21BBA610F9
	for <linux-hardening@archiver.kernel.org>; Sun, 14 Nov 2021 00:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbhKNAGw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 13 Nov 2021 19:06:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:32942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229988AbhKNAGu (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 13 Nov 2021 19:06:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 770B860E90;
        Sun, 14 Nov 2021 00:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636848236;
        bh=PMTPg84tWVzIsSb/8MD2eDPfMjwfUddrlfdVPu0SH/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RD+sKFvattwHGDiSNWzBWlWi4PLpz6StgLwuPOzkfWGhMYAa5s8cUgTL7rrLywD54
         O6FHr6TOonkdgGsqUZvEmwTi72LgwSeYOf3NldkiN8AvJPNHCMWnAQsxJVwDLTCg8z
         P9TeBmGb6WZbFn/uO+K7n2l34RHn8Vo1JO2bAcAapqz+z168fNkXHsDcoQm+dzXSGU
         JhfYuT+0q2eF5GVTVwgYiSJR9x55GH5TmwOcGSMNp+L6UQttsX+4h3dcxAa455Tkxh
         2b7I6X93Znoknvoid1HzblwOqumKbQnnAPkKAgjK5lCQa+HxfBloqqEVfyzRJp0tLI
         QH5J+wJGQwF3Q==
Date:   Sat, 13 Nov 2021 18:08:56 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [GIT PULL] Enable -Wimplicit-fallthrough for Clang for 5.16-rc1
Message-ID: <20211114000856.GA25846@embeddedor>
References: <20211113214125.GA23640@embeddedor>
 <CAHk-=wj-yyR1s1LcnTspgpcriyX-nDruzSmEneA2U=bOj9gCuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj-yyR1s1LcnTspgpcriyX-nDruzSmEneA2U=bOj9gCuQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Nov 13, 2021 at 03:20:19PM -0800, Linus Torvalds wrote:
> On Sat, Nov 13, 2021 at 1:36 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
[..]
> Wouldn't something like this (TOTALLY UNTESTED!) work and do the right thing?
> 
> This seems like a natural for a Kconfig decision.
> 
> Also, does -Wimplicit-fallthrough=5 work with clang too? That would
> simplify things a bit, and then we could just use a regular boolean
> and do
> 
>   KBUILD_CFLAGS-$(CC_IMPLICIT_FALLTHROUGH) += -Wimplicit-fallthrough=5

It doesn't work:

error: unknown warning option '-Wimplicit-fallthrough=5'; did you mean '-Wimplicit-fallthrough'? [-Werror,-Wunknown-warning-option]

However, your patch does work. :)

I'll send it as a proper patch, shortly.

Thanks
--
Gustavo
