Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64186C77B73
	for <linux-hardening@archiver.kernel.org>; Tue, 30 May 2023 23:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbjE3XVE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 May 2023 19:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbjE3XVC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 May 2023 19:21:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00211118
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:20:55 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-256931ec244so2067291a91.3
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488855; x=1688080855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kJ6a9RtH2F2C5B3qsSQMBizrWtQVR2WGvbW6bWVaocA=;
        b=gcrM0wofjm3uTk2EqNaBReNhxZhQOm2fsXojumGzkhhMcX5YZeWAyb/hi7Z/f1B5/j
         VPApEkU3QnJHTT+Kn3Dj9YwPgoDLxMLJi5TIBEt6rbTjGjKhdaQjQRV0sFxry15VZl3u
         mksosL1lOmQAyskBHC3HRUpxVXByfu0Bsa0Uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488855; x=1688080855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJ6a9RtH2F2C5B3qsSQMBizrWtQVR2WGvbW6bWVaocA=;
        b=EozcWiA5QLCrhElur72dB8Lu4ueiPQgRmFgEQ6cmpcfFe7oUhgTyA9/m/1XbJBz9vL
         Mmk30A2zzq4hVkpNMvP3UdmtvAf/xKIb95X4kLOgMCtWjHqj2Rc5ad1GqYl04BLt0H97
         7UbMR7YN/p5oOlB03M5otvuS2usQjDOMRjlOsAHP1tCPsHMq20gZVOUZmQXD7MV6UqxA
         gIDQ9TEHF8EPJHCyELmSuP/OQoFdxBp+k28Lg8rYE3s8R8fEnI7aAzRk0av2KiTGq5Uh
         1FD7t6a1zwuO4XYg8NamKBWGxOR5bE3fzkNO7eU4UMD2wjQWN1PjUzMVXnT2UWhWUoga
         VdYg==
X-Gm-Message-State: AC+VfDxrC7Ph4DSuQW46LDpE4CgaWfEed2A1hTDo9pydzNCMQQNxqFa7
        M29I/moydymZMwFLOAtf6gjtaElzRaY3lZyXmqE=
X-Google-Smtp-Source: ACHHUZ5NIdQACilyOEd6vOtwPBrrplnflmqMi/bQOXKPE2KJZEl3cT2WLDvF40ib0I/zSXsic8GeMw==
X-Received: by 2002:a17:90a:6c64:b0:247:2874:a6a6 with SMTP id x91-20020a17090a6c6400b002472874a6a6mr3936156pjj.2.1685488855367;
        Tue, 30 May 2023 16:20:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o2-20020a17090a678200b0023fcece8067sm3510889pjj.2.2023.05.30.16.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:20:54 -0700 (PDT)
Date:   Tue, 30 May 2023 16:20:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Dinh Nguyen <dinguyen@kernel.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nios2: Replace all non-returning strlcpy with strscpy
Message-ID: <202305301620.346CC541@keescook>
References: <20230530162358.984149-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530162358.984149-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 30, 2023 at 04:23:58PM +0000, Azeem Shaikh wrote:
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
