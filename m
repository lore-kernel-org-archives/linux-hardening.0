Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4E8C05027
	for <linux-hardening@archiver.kernel.org>; Wed,  8 Feb 2023 18:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjBHSE7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 8 Feb 2023 13:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjBHSE5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 8 Feb 2023 13:04:57 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A093310C0
        for <linux-hardening@vger.kernel.org>; Wed,  8 Feb 2023 10:04:32 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id dr8so53093622ejc.12
        for <linux-hardening@vger.kernel.org>; Wed, 08 Feb 2023 10:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o2JJ1Ee32hzIiRwEE/z4UpbV3JncQtbQL6qzEOH/xcw=;
        b=oGMMmYh4GkhTX0eNkyArCY6BqW0VDFr1Kr7e2SS9bF4awixZHelJSp+hS3Y675NKyv
         7WToDTwrYVIshTFAv0oRAWjywd1yycWgTlOFWjV6HiFNXpUeRq9x2uFbNdrZbnNGiw2T
         d+on5n3MUTrinBoN4ycNqccuzk6QUOk7ZGVtXcIm0A1pmbtdDbw+rTaMeQ5mPqMlb1ta
         m5phSMCmSJYbb6CAdCPgJAZG2eUZbhqlycdK1rvYjHt9kFcKvMc7tfdMJvEr1UWZCYlL
         828yZKtyNDqbAR1eiItaby0ew+FUeAFxXrqaRIf9wkvKgTyv2MHuz8jNLT8UgwSTs755
         XDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o2JJ1Ee32hzIiRwEE/z4UpbV3JncQtbQL6qzEOH/xcw=;
        b=bVrJ+fe6tAOO4O6nvtnVqWcTaZLT4Y2BNj2J5yz4zaTyGCVSKpMWij8WkqQOypdQML
         ExjxAhUapDHHcqf130jIwas2R17ZaE7h9S+LUNPMzcg697w+XsUhzftugavNGGorcpfN
         0FrlBkG9A9k73gBlnJxDISwFgstVY8BmSquMN4iv+WXrMN2d3Z1+PjvLMSVHf3WtKUZT
         JFX3kcnN9LL7b/2eLogShHFfQ2EXSzpOvAR1RDQcglQ1s0WBr3VNF/tBYlBh042o2KkE
         52k8ksw3nXIbh76YApUfIfSWdH81bd4URp8DP1YfaXPiRo2BdTySXSxgb6U4m8mjdCQc
         I6HA==
X-Gm-Message-State: AO0yUKW81F6Y1eeRe/zMfLlVXgDhd6AZRBshz6FP4D3fVSeYbvU3RuLN
        44mtL5BA5RBmlqIfgAS6VvRfVcRFuu7xEstFqX2D
X-Google-Smtp-Source: AK7set/U+12GtAsfcKzD0M3TSL32ji0RZ/tnZtOfMOCEijGlqV7ApAv4stR7at0qeOETNwX3hFK0EmuNR5tP8WJ8UDY=
X-Received: by 2002:a17:906:7f8c:b0:88d:3f80:d57d with SMTP id
 f12-20020a1709067f8c00b0088d3f80d57dmr1507150ejr.302.1675879470272; Wed, 08
 Feb 2023 10:04:30 -0800 (PST)
MIME-Version: 1.0
References: <20230208065133.220589-1-ebiggers@kernel.org> <Y+Oyi1eZqKtqbL40@dev-arch.thelio-3990X>
In-Reply-To: <Y+Oyi1eZqKtqbL40@dev-arch.thelio-3990X>
From:   Bill Wendling <morbo@google.com>
Date:   Wed, 8 Feb 2023 10:04:13 -0800
Message-ID: <CAGG=3QW_uRuL_WPHbHOWs0zKROxfcgJvvY-id1XaTbNGx-sD=w@mail.gmail.com>
Subject: Re: [PATCH] randstruct: disable Clang 15 support
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 8, 2023 at 6:32 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Tue, Feb 07, 2023 at 10:51:33PM -0800, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> >
> > The randstruct support released in Clang 15 is unsafe to use due to a
> > bug that can cause miscompilations: "-frandomize-layout-seed
> > inconsistently randomizes all-function-pointers structs"
> > (https://github.com/llvm/llvm-project/issues/60349).  It has been fixed
> > on the Clang 16 release branch, so add a Clang version check.
> >
> > Fixes: 035f7f87b729 ("randstruct: Enable Clang support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
Reviewed-by: Bill Wendling <morbo@google.com>

> > ---
> >  security/Kconfig.hardening | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> > index 53baa95cb644f..0f295961e7736 100644
> > --- a/security/Kconfig.hardening
> > +++ b/security/Kconfig.hardening
> > @@ -281,6 +281,9 @@ endmenu
> >
> >  config CC_HAS_RANDSTRUCT
> >       def_bool $(cc-option,-frandomize-layout-seed-file=/dev/null)
> > +     # Randstruct was first added in Clang 15, but it isn't safe to use until
> > +     # Clang 16 due to https://github.com/llvm/llvm-project/issues/60349
> > +     depends on !CC_IS_CLANG || CLANG_VERSION >= 160000
> >
> >  choice
> >       prompt "Randomize layout of sensitive kernel structures"
> >
> > base-commit: 4ec5183ec48656cec489c49f989c508b68b518e3
> > --
> > 2.39.1
> >
> >
