Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D15EB64DB
	for <linux-hardening@archiver.kernel.org>; Wed, 14 Jun 2023 18:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjFNSTG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 14 Jun 2023 14:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbjFNSTD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 14 Jun 2023 14:19:03 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DCA2122
        for <linux-hardening@vger.kernel.org>; Wed, 14 Jun 2023 11:19:02 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6664a9f0b10so700446b3a.0
        for <linux-hardening@vger.kernel.org>; Wed, 14 Jun 2023 11:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686766742; x=1689358742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DVA52p4YcILRY7L9DFLvbAPwmdSgMbGdjvMaWJxlDM=;
        b=gSR6K+IoSV4UcCbyThkovBW84pwErtTdN1Lf7dIi/cT8a82OBj/zR29k4NSaiwqtOV
         7cF8XAMnN61CQS7d0sNglKn71UYX2nesvdOVddooAVbOyKrTIZZKSCtAY9RE9t6DzcWb
         VjfBQ8FsLUvPZiGPjEyfjN+9oZ0Yo1ktN6GfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686766742; x=1689358742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DVA52p4YcILRY7L9DFLvbAPwmdSgMbGdjvMaWJxlDM=;
        b=HobrMISy0p8EStdDWuZ9i5y4G16D08I1fsnqXNH6vW6szinbzfn71Qm+a4478nIeHE
         cgBPd2G7b/beyJd1G8TuUrBKWyBW50YHmgMw/aKBafkKewqTAzGvYR3adZ7m36q2rPjN
         Vgn2OWBJT5YI7o4nfEEqrNL6/3G+lGrCTQVSJARGMdy8Mtf5TS2YoNxoc7G6KdTFRW/S
         K9GSGsxrM/uyddkufBDK3crXOKPuJNUM4eGQqsJpxtwIS8fV7tkNDFrwf7OnHWKsc12n
         mUyR+PU9yNem73uUDjv8ec41uGmpOR+zu79hLIR5suvivlx+lSV7h9JwCvHrSCwKjVRk
         lJhA==
X-Gm-Message-State: AC+VfDwNb17KJ+8CXlYppP7KvDzuIZUNVy1j3O2lWioVEoCiztZL7Zwe
        60Cbpz/ZCbi9Op040TDPpS26SQ==
X-Google-Smtp-Source: ACHHUZ4GcPsyjlJGS/SC+rTk2s17/0RS900BeVxk31L9Js8pVErRtiRqW2zIDPgZTsdmkP5avz+iig==
X-Received: by 2002:a05:6a20:3d8b:b0:117:a2f3:3c93 with SMTP id s11-20020a056a203d8b00b00117a2f33c93mr2636606pzi.2.1686766741971;
        Wed, 14 Jun 2023 11:19:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902b70c00b001b3f9a5d4besm2585326pls.255.2023.06.14.11.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 11:19:01 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     azeemshaikh38@gmail.com, bcain@quicinc.com
Cc:     Kees Cook <keescook@chromium.org>, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Hexagon: Replace all non-returning strlcpy with strscpy
Date:   Wed, 14 Jun 2023 11:18:31 -0700
Message-Id: <168676670780.1815023.2376604888079665488.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530162608.984333-1-azeemshaikh38@gmail.com>
References: <20230530162608.984333-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 30 May 2023 16:26:08 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Successfully build tested with Clang 17.

Applied to for-next/hardening, thanks!

[1/1] Hexagon: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/f0e212de87a1

-- 
Kees Cook

