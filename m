Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5FCEB64D7
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Jun 2023 03:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjFVDKy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 21 Jun 2023 23:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjFVDKw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 21 Jun 2023 23:10:52 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5161728
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jun 2023 20:10:52 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666e3b15370so3894327b3a.0
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jun 2023 20:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687403450; x=1689995450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bgLDqCZpojqPASYki3iZZPdkOuhPJ8cSSL0f5T0zXIA=;
        b=NaDa2kmtGYXFAl5nKLBIfYEThEldVX1HQN1gWRxGOcR/tb2DdTg4FasoBgOfrzSQGX
         Wrd+fdQeOHg+rZkvxGKK2aYG+Cm4brn8actk4tnZaqCuLMXQg7JApNCdgBDwlQFoLFY/
         9UxhiL6JHCQT1rHWSM+mJUOqFCLcK2RrCaoaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687403450; x=1689995450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgLDqCZpojqPASYki3iZZPdkOuhPJ8cSSL0f5T0zXIA=;
        b=HTi9y6/DfLA9VjyFScvGCi+S0rKeaS9jv6MAJru56aZ6M6Pq++TwRHYXN3niFAtALH
         Y2CNXoyg30ITuEcLB0n8EMWhnKKcxK5GOCRYQmTyaTUsgqHLGknW7yXqMfIz/0Kq2JmI
         1mHJkCqFl8B/zbzT77y5vQgMAt/SyBEXEujvIqxOofstwSUEH20lF+HsyqtQoGKvhu80
         lPqjELG7rn0eg0DegV6Mfq4hBh5TMTkTpF5mzprenHCEJT8/W7XeoT+no/2Xi8Nujdis
         hXfuhzKlOYtJR34NX38nEQFIjqLf3047mWOGhxkgeZzXPKUf9BWwFrXgYxNlw1mf0ba0
         3jrg==
X-Gm-Message-State: AC+VfDwqHYCEGZcjweNptFzpMVkN5cKRdKDw6sUvnKWIfgx3hXiD/ZEn
        vbcZukmCQihAIuSlyzK5aOeUB/5xPV/VO0oXifY=
X-Google-Smtp-Source: ACHHUZ79yf/HjOkQELPW9oOGSexnnFnYi5yuKVtJf8q0GZydqQ65xtZYCRFUeOHxeaV/PHnK2RNtCg==
X-Received: by 2002:a05:6a20:160d:b0:111:c8a6:88ca with SMTP id l13-20020a056a20160d00b00111c8a688camr17825068pzj.58.1687403450536;
        Wed, 21 Jun 2023 20:10:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b001a2104d706fsm4125573ple.225.2023.06.21.20.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 20:10:49 -0700 (PDT)
Date:   Wed, 21 Jun 2023 20:10:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, Hongren Zheng <i@zenithal.me>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usbip: usbip_host: Replace strlcpy with strscpy
Message-ID: <202306212010.E6CBCE23E@keescook>
References: <20230615180504.401169-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615180504.401169-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jun 15, 2023 at 06:05:04PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since return value of -errno
> is used to check for truncation instead of sizeof(dest).
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
