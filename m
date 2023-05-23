Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F58C7EE26
	for <linux-hardening@archiver.kernel.org>; Tue, 23 May 2023 17:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238062AbjEWRWs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 23 May 2023 13:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238086AbjEWRWr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 23 May 2023 13:22:47 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465E1E7A
        for <linux-hardening@vger.kernel.org>; Tue, 23 May 2023 10:22:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2554696544cso2440175a91.2
        for <linux-hardening@vger.kernel.org>; Tue, 23 May 2023 10:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684862536; x=1687454536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=03u0/tcn5hg59vj1b/y7vCowhQbtV8QG/zOnqJg2MbY=;
        b=Hk/CZQcslsvTHa6ce5OSHwlQoUefECc5fkXef1113Xfeu+osxIFBVYEpwvahPDsZI5
         xLrbQvGakq/+dDgqCnePUJKa03MzROJVFDBpWABeqaerNmeuHKqM9wZHe8BmJzlOZKWZ
         G026bOjWFvPMe3lyjUDRt9DsLtQSTuZdI3RrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862536; x=1687454536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03u0/tcn5hg59vj1b/y7vCowhQbtV8QG/zOnqJg2MbY=;
        b=EhNzMCg5hURt/AewOeYg0pmyNiytyG5lfJbts9s6zUXtEeMdJkQW9czczau1ss1l10
         sMI7o1t0I8Hin4Mv9eA9A3PYY5ecbiUGG3Xk4hVmNf7NmIcm3IKn5r7ExSiSfaA/W3vz
         6VkEnWOkBb9+kuuFxkd+V7hSW38gOx0+xJxmyL24uJoXr+SAPaXnU7OMVLI1/CxOkynR
         T9yuylcy5JHiqQFAnDtKKYCSnVap8dqELYAygMy0Ou/WpwWCkj3qb+Q4mGwhAk1Mc7bs
         ty1eyvLys+3JUBNByqhWCB1ZVh/VkZ0VfrEhhbjmXtyRf2CrEKf+WSRpkkh7Kz7pfPyQ
         MccA==
X-Gm-Message-State: AC+VfDyTZxa+Lc+YHe8ThQhmTta+xFf7sM+pzOFN3Et78TUF/0gspCLE
        sJn9q2IomeQj04F0PNrjGzzArA==
X-Google-Smtp-Source: ACHHUZ66f4U2B7XNJnJdnlmPlPJKIuCMl9ov9Fb1RZPfglQVpm+hpHJXFT6WCvySaTOZmyIl8ywRsQ==
X-Received: by 2002:a17:90b:384b:b0:252:e7e2:fefe with SMTP id nl11-20020a17090b384b00b00252e7e2fefemr13477732pjb.2.1684862535815;
        Tue, 23 May 2023 10:22:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bk3-20020a17090b080300b0024e0141353dsm7742411pjb.28.2023.05.23.10.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:22:15 -0700 (PDT)
Date:   Tue, 23 May 2023 10:22:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: sgi_w1: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305231022.4742A5B7@keescook>
References: <20230523022023.2406955-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523022023.2406955-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 23, 2023 at 02:20:23AM +0000, Azeem Shaikh wrote:
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
