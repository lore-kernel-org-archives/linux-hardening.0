Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7B4C7EE24
	for <linux-hardening@archiver.kernel.org>; Tue, 30 May 2023 23:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbjE3XRe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 May 2023 19:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbjE3XRd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 May 2023 19:17:33 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35918118
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:17:28 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d2a613ec4so3732108b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488647; x=1688080647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GHUteLUYvh/51uT822wgzC3UC/lmseb/CzQL8BFKOrc=;
        b=LSb8+cHv8sZlouoCKJB81L8JFOiBRG3ScU+UmR/rKy5K1ASuQ8WY2wLLUv3ygI7wQv
         6O8r5uvdKzrZzuh8OD890tkQ7V2yMRN6neekkRSBVLLmzlOeMr6l6lkdFimxsF0IcoXQ
         klZKH7zz53Bq/nHFRp57i/ZRuUzmFm8BwMteA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488647; x=1688080647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHUteLUYvh/51uT822wgzC3UC/lmseb/CzQL8BFKOrc=;
        b=YScHfIz7niU3W5N9EQN2HI4fQUD3nbaXz0rPFqvWCsxGxBsR1PFV7Oo7T3Glf8VUNC
         ueHn2WehNXFOCQTSzr2CQ0eE4ROyUiukxv4NIm6tWCYFepIotGFcwkH+y9JSzbuyi7o7
         YGafjfmAbPaAQ0oMdbuXB3OCnbs7dXgh6eVYtL5HYBHn+/NbnoC2TTlOPKIg7sQhEQt7
         d/XFBTmg/AO4HCE1Buy8ntgBKJB9ewPKrfYMefYb6h9BtlWXiN/E/21ND8usazZGadLe
         AHkHreBkFKTeWRC2/8N7Oy+9AhAaV2ueGvm2OkoyclUXOYRz/iuhyZvn8VIJXaYQgkeA
         aQqQ==
X-Gm-Message-State: AC+VfDw0lGo0+h8e72yxFGOyD9EWRoAnM5ngU7ho7FIx9U1iJv/AAPoY
        v9sYY0csXx9ROhO0vdJftp/Sog==
X-Google-Smtp-Source: ACHHUZ6fNaQeRwTLdgTPTxJeYnGX1s6sOgZQ3jUFobl2MDArHnYkD1mA6XM0wA5m29XTuVrRMEZelQ==
X-Received: by 2002:a17:902:e74f:b0:1b0:2658:db00 with SMTP id p15-20020a170902e74f00b001b02658db00mr4762889plf.31.1685488647652;
        Tue, 30 May 2023 16:17:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902e85000b001ac912cac1asm10861519plg.175.2023.05.30.16.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:17:27 -0700 (PDT)
Date:   Tue, 30 May 2023 16:17:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-hardening@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Replace all non-returning strlcpy with strscpy
Message-ID: <202305301617.A25BC88@keescook>
References: <20230530155608.272266-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530155608.272266-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 30, 2023 at 03:56:08PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
