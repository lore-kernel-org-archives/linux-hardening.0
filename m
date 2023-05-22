Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0588AC77B73
	for <linux-hardening@archiver.kernel.org>; Mon, 22 May 2023 19:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbjEVTqk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 May 2023 15:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbjEVTqi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 May 2023 15:46:38 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E2B1A5
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 12:46:26 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6af7a84b2bdso1088445a34.2
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 12:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684784785; x=1687376785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNAaP6+XJai6xtjlcDTjy2E1GXqny00MK+4AdCDW8Kw=;
        b=CEbrAHkKfWpDr5aXtC8dd41LHhr0aDW0A3uu5Ep+0Prgf0gcnleZef6tUe/P4FHS/E
         +mciFmzJQvYGI3mnESpfWCQIuOJFdF9Wks1IStOh2Im7UDjCVXrUDfoYaPGU+hJqQsM9
         b+1ixcc4nT/4aeea+DUtT5y7GgH/6OMfziuyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684784785; x=1687376785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNAaP6+XJai6xtjlcDTjy2E1GXqny00MK+4AdCDW8Kw=;
        b=hP6LUTbpEJxGbVhLfeUAaWBeHclJXbbI+Ld9Lo4o5ewtUy0faegWZzHYBRk7S667yz
         Hpr8LqqV4mC3NTq+4C28QAlB8Mmh2wih4cTkLHF35K7/Py51sOXKDKvfKCSgtjSr8jBP
         j5JBxzQ1T+s5hbvA0i5yntCUMsVSay2uyIqFNd9E/p33NFwFt+PU4MfVDK4XuqHFktwz
         bERIA03VbIWckDry25DitTY1JqDtpAqByiF6gGdbx2FBCzmODvnIfOKBVFag/aYd9e5x
         kqU6RHLQQMAUj/rCNWo7usgEIqe/KIZ2CudDRfWE79GjJ9rTHkCwgbfkq4v4cVGyXaih
         MTig==
X-Gm-Message-State: AC+VfDwX4cEVjqhu+P7jYcW3UN/C7J5C/mBUeVE9wkVuhcYNrR8CqMQx
        n3CPmJ0V4Ka60IbaBIEYYDLdgcfWzWPhB8otqPQ=
X-Google-Smtp-Source: ACHHUZ7XSGaVK8OAFHtgEWwhmN/dPCgY/hsNSkZ6wHyqo93wCVtLQOXdhbv7Nf33xNA7cZ9ma8oqXA==
X-Received: by 2002:a17:90a:70ce:b0:255:4f4c:368 with SMTP id a14-20020a17090a70ce00b002554f4c0368mr5138998pjm.27.1684784390970;
        Mon, 22 May 2023 12:39:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r13-20020a17090a940d00b0025352448ba9sm6234829pjo.0.2023.05.22.12.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:39:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     azeemshaikh38@gmail.com, tyreld@linux.ibm.com
Cc:     Kees Cook <keescook@chromium.org>, mpe@ellerman.id.au,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        christophe.leroy@csgroup.eu, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, jejb@linux.ibm.com,
        linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] scsi: ibmvscsi: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 12:39:40 -0700
Message-Id: <168478437624.244538.16463667694387498508.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517143409.1520298-1-azeemshaikh38@gmail.com>
References: <20230517143409.1520298-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 17 May 2023 14:34:09 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] scsi: ibmvscsi: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/015f6618194e

-- 
Kees Cook

