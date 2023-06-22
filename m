Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B1CEB64D8
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Jun 2023 00:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjFVAFq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 21 Jun 2023 20:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjFVAFn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 21 Jun 2023 20:05:43 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAD71BFC
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jun 2023 17:05:14 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b51488ad67so34602405ad.3
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jun 2023 17:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687392239; x=1689984239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xq0dkv7azkvedb0KULWF4WuIbSO15dlwApz3MpULLXE=;
        b=AwtajXI8+J6DndfxRUIKzXCkBY8xGz60/k5sDcezJKwVGjGClzxX4hXpgteDe2dQ9h
         4d2HnnsDKY90T8y0a3ww96+rL99eVgWq1UXwqto72GaZgsChKyMxxDHywAY92C/ZdF6T
         X74yKEqM1f90KQ6KGhb8eT7QKMRkG+1RM2z/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687392239; x=1689984239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xq0dkv7azkvedb0KULWF4WuIbSO15dlwApz3MpULLXE=;
        b=e/P9Kaa7a2UCG8Eai5RAJEJ88Zwla2CDx06C/FmSa533tYPnu6QrPxpgngZCAJ3msU
         EyyIcCj1b2Pgkm8BQmgiVedmatZi3fKU8BvtWJe9GUflRuOqJs2TC3kwohG8CnL9wnIS
         CuRh767JIYkIvSAKnqbCTS10rRQEN5JWehsPJBE0SkEh7cG4ZUMfKwxCdchrGTAQSY0Y
         Cwss21ohp3Q7w+Sp/UffR4qhiJu8pJeF8lYbBz6eWMsfhOJayt1E5TQ2EETAwMZqbiFw
         bYy3KrcLDVzrlCx2iU5zXPIZVPGD5pOkMW7pBpwoZrZG/WZmXlyT65oOyAVGSPQB8UBc
         kb6w==
X-Gm-Message-State: AC+VfDw0bDWN9Co3UIp7opBgGP92U54S75rYtyjLbzS/PIvFdqN8PYrY
        G2qHTmNtFUtHzBWsoEWSpl3f+g==
X-Google-Smtp-Source: ACHHUZ53xmAEhlIo0pgHgTU4ZsSk7xwA4q8JgCHr72rMOhDtXySNGOwMcP4W8fBuxFBj5os20ReXhQ==
X-Received: by 2002:a17:902:e544:b0:1b6:7c9a:3a53 with SMTP id n4-20020a170902e54400b001b67c9a3a53mr6912803plf.67.1687392239478;
        Wed, 21 Jun 2023 17:03:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id lg13-20020a170902fb8d00b0019aeddce6casm4013845plb.205.2023.06.21.17.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 17:03:58 -0700 (PDT)
Date:   Wed, 21 Jun 2023 17:03:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] reiserfs: Replace one-element array with
 flexible-array member
Message-ID: <202306211703.9AC418A@keescook>
References: <ZJN9Kqhcs0ZGET/8@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJN9Kqhcs0ZGET/8@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 21, 2023 at 04:43:54PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in direntry_uarea structure, and refactor the rest of the code,
> accordingly.
> 
> Worth mentioning is that before these changes, the original implementation
> was returning two-too many bytes in function direntry_create_vi():
> 
> fs/reiserfs/item_ops.c:464:     int size = sizeof(struct direntry_uarea);
> ...
> fs/reiserfs/item_ops.c-490-     size += (dir_u->entry_count * sizeof(short));
> ...
> fs/reiserfs/item_ops.c-517-     return size;
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/290
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
