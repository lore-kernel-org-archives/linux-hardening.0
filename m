Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654F8C41513
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Aug 2023 20:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjHBUl5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Aug 2023 16:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjHBUlz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Aug 2023 16:41:55 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17324171B
        for <linux-hardening@vger.kernel.org>; Wed,  2 Aug 2023 13:41:54 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a3efebcc24so142744b6e.1
        for <linux-hardening@vger.kernel.org>; Wed, 02 Aug 2023 13:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1691008913; x=1691613713;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOTW7tSWYTyx7UDF6T+TXg8EIzNOXTAibUlBcE38vs8=;
        b=NG+5rMrhgt8ajv9MPHJRkksDamIASvOjqTTUPHyRoobNVDQSWi0PwWWph2HSzMcdMl
         A9HE9kmImry6AtWp2gUbGM/jK8r16N1j7DiuzIHODeQu+mzVZ4Nc5x80Zx5JkiFmSnHO
         uOPUvvmMKURIHUCoWtfp9Rlg7pLfP0EZa3t0rZOpEmSucSQRceq09vtlxx1NioyJNNkD
         4fSrS7ibFXvZGGzqE3oJeBJyMSPtz7hFdkn4SO1BzNbBZRtfBvnbzCIbSBnhKY/50gMF
         g9/Y7yRXXe9yhQWo6eyNbq0BU8fTMdr0BTKZOgC0cNhC2TxijnG1xbfqy5nF/bsinVyn
         22ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691008913; x=1691613713;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOTW7tSWYTyx7UDF6T+TXg8EIzNOXTAibUlBcE38vs8=;
        b=FQGdXTCKZNlfM32QpCbNVKPUhGptnGt2tXULSP/LMzD9nOhnOiVcpovHSUR8RuW5JC
         y5UG5rDalHtDjUpMrzjC6v863Kj1i8RZu7WMkDIJoWiucheDtx5I1kwTXK+BOGlLIMer
         sHx7gAo1qloXKCfN9YiPK7P0ItEELWtImImUGCa9j9PVVO2nOrvDJXbM+5Fj96g+AdYj
         rVDQ6qm1RnLewXwFcquIL/xPAaeuKtRga9IUBp68+7xSody677eSW/7Dx2QMm6jDKXGt
         C4cwjnaR4KoxZTPZ4qUvUC99Ly5v0WTSO+FqAdSpAJ48c6WKwdvHzg+2W9NlUzrITujZ
         1uTQ==
X-Gm-Message-State: ABy/qLbmfXJRxC+6Mwct0JQcv2dwexRq5fgNMdSQw9j2WFN8rEqvyb2e
        seqSt2pr5oKrjO1+ydyZUjQufVGCwtyQiagukp0=
X-Google-Smtp-Source: APBJJlEXOupr/w6qEt7CH3EMjhe/cVyQh8/dfxz/mVjhJayN0odRX4LdG0uM3l2H+YiBj1QobSkLpg==
X-Received: by 2002:a05:6808:21aa:b0:3a3:dc0e:4d0f with SMTP id be42-20020a05680821aa00b003a3dc0e4d0fmr20856581oib.22.1691008913338;
        Wed, 02 Aug 2023 13:41:53 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id l4-20020a63be04000000b0055386b1415dsm10930827pgf.51.2023.08.02.13.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 13:41:52 -0700 (PDT)
Date:   Wed, 02 Aug 2023 13:41:52 -0700 (PDT)
X-Google-Original-Date: Wed, 02 Aug 2023 13:41:50 PDT (-0700)
Subject:     Re: [PATCH v2] RISC-V: cpu: refactor deprecated strncpy
In-Reply-To: <202308021335.8010D08B@keescook>
CC:     justinstitt@google.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        linux-hardening@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     keescook@chromium.org
Message-ID: <mhng-93dd039a-f342-4239-a0a8-f1e31f7d8b5e@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 02 Aug 2023 13:36:03 PDT (-0700), keescook@chromium.org wrote:
> On Wed, Aug 02, 2023 at 12:21:58AM +0000, Justin Stitt wrote:
>> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
>>
>> Favor not copying strings onto stack and instead use strings directly.
>> This avoids hard-coding sizes and buffer lengths all together.
>>
>> Link: https://github.com/KSPP/linux/issues/90
>> Cc: linux-hardening@vger.kernel.org
>> Suggested-by: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> I like it! ;)
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks, I just queue it up for fixes (might take a bit to build test, 
I'm a bit backed up).

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

If you wanted to take it for some hardening thing, though -- otherwise 
it'll likely end up on my fixes later today.
