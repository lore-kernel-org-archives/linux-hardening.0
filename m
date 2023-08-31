Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FD5C83F3B
	for <linux-hardening@archiver.kernel.org>; Thu, 31 Aug 2023 18:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347051AbjHaSdE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 31 Aug 2023 14:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347052AbjHaSdD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 31 Aug 2023 14:33:03 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F20E79
        for <linux-hardening@vger.kernel.org>; Thu, 31 Aug 2023 11:32:51 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1c4dd644cf8so728727fac.0
        for <linux-hardening@vger.kernel.org>; Thu, 31 Aug 2023 11:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693506771; x=1694111571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QBmD6+hPqatJJamgU4HI6o0CO+57hmYKqdLd/YQCAyg=;
        b=h/klJj9osrf1NTqIwud0azELUQPqHnVQDONIQujQvn5rET1GyX+tw/x39Y9qwAQMJt
         /B7VUdEg6tFqzoQKeizbFRFwaFVPK94F2jJ32w3ipdUEaeAdq+KxYZDBib5JhfeqflnZ
         JXZXj3MeqvURecy92pbzccYXbvQP4jJeFN1Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693506771; x=1694111571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBmD6+hPqatJJamgU4HI6o0CO+57hmYKqdLd/YQCAyg=;
        b=CMNQcUK7fp0umViz+pe/2egTNZvEqHbFga5xUo9VKlr5XHbWDoH0pP64r92FP0NatQ
         T1AZCFMaaBLCzZpIGw52B2uOU/JVFwrMF3tQQeCiO3vaROc2veIvGc7j76SrXJ4zEr5t
         WYAha82cBwpaOgT0CGojA8i6CFACLFGvWr6TWNZnOI6YTEcRXt9yFJT6z0DURS2dR81q
         CXRLD+xPnX+9ZSIHVsdX417fUktcgZA1XAbSsaxeOGtGSu5ayJIVAm1JcmzOBxNNEetL
         TOhhQe9zSOdyREEholm6dEanIXLhkSUe5We+zfNAk7uTKUQbZxjFxNEUgZmePlk7uL2j
         ts5Q==
X-Gm-Message-State: AOJu0YwjcNENttn4InxHDDI+RYgMdnNcAc/SsqpgNsrOTQ3yHFtagKmK
        YLn70s2SSDTOWDm93BnNJxmfYIKZ89wkbCns5U8=
X-Google-Smtp-Source: AGHT+IF5/TlF/lQHblPVjGsswwKKZAwdedPWRSeqhvKS5yw01SH3v4w/rzlvbcG4HljdDHCJ90/d7w==
X-Received: by 2002:a05:6870:1cc:b0:1d0:f5bd:6d9 with SMTP id n12-20020a05687001cc00b001d0f5bd06d9mr281116oad.53.1693506771189;
        Thu, 31 Aug 2023 11:32:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u191-20020a6379c8000000b0056368adf5e2sm1634030pgc.87.2023.08.31.11.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 11:32:50 -0700 (PDT)
Date:   Thu, 31 Aug 2023 11:32:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kobject: Replace strlcpy with strscpy
Message-ID: <202308311132.246D40D2@keescook>
References: <20230831140104.207019-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831140104.207019-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 31, 2023 at 02:01:04PM +0000, Azeem Shaikh wrote:
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
