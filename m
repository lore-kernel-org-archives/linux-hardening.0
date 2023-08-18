Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9989AEE498F
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Aug 2023 18:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379316AbjHRSCB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Aug 2023 14:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379318AbjHRSBc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Aug 2023 14:01:32 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6072701
        for <linux-hardening@vger.kernel.org>; Fri, 18 Aug 2023 11:01:31 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-564b326185bso879308a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 18 Aug 2023 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692381690; x=1692986490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYBhb547ncMi3wuUeN47Qu32Xgp7Mgncg35363KdjMY=;
        b=e8Q1lB1q/5WpShrGBZOlVAiH4jHMVpOUuaOqIgAkBvaujIY8uzpya5ESLBaG3ix8nb
         FHUNTjwbqpghd11R4Q+G2sU0BtL4HRvOe1svnqwdTQzKOSgMk3Jyhq+iNgCDAYct9ETm
         lToX6VZMeh+e1RqjKH4Tk4VV24davAJq54e9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692381690; x=1692986490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYBhb547ncMi3wuUeN47Qu32Xgp7Mgncg35363KdjMY=;
        b=NTJxeU+JRHbAMZd6r4jp56wF4Nv8Ti+P/ayvyTGyqbDIe2TXAGgOybvHeGhWVwmn7Y
         PXNAt0DOIKE3avJ75rUk8633oLwQlZB3RvWWSaQ4ARRBpnyYxjv0JIfV5TfunMrvuDPA
         pdk1nTzWVSOrc4dl5a3eATb48omhgY8NRpOl0u1l0a4g6gSw3jpQH5ugDdNB/2uF+H9Y
         U2tU8YJsP8HB1Cp1z55fqMnsZ3MZSZrjzlY8j+pSxT/gxJzXQ7JqhVMqXjBdS5cBO1Ww
         5TboZm6akEO56ejg7eiZMVOLNGGcX8BarMx+JnXBQkzv1ur7NcQ93kMeZkucaWuYI+6V
         dBhw==
X-Gm-Message-State: AOJu0Yzqyb0ZUc3pxPtBGvH5czBBZvZKAJI15wnZtk2Tz2k4xNfcPspC
        S3l+OYPTeVPYtEJS6SF0NnLUrQ==
X-Google-Smtp-Source: AGHT+IHK7p11ROoF/GBRTRYvtIRFeZ79ofBB2FpFJ+GKVFcVF+S6Zy6V00Y0yvuoDiCNKNnDjwtw1A==
X-Received: by 2002:a05:6a21:3984:b0:135:10fd:31b0 with SMTP id ad4-20020a056a21398400b0013510fd31b0mr3565014pzc.15.1692381690480;
        Fri, 18 Aug 2023 11:01:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v21-20020aa78095000000b00687087d8bc3sm1883813pff.141.2023.08.18.11.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 11:01:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>, Kees Cook <keescook@chromium.org>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] integrity: Annotate struct ima_rule_opt_list with __counted_by
Date:   Fri, 18 Aug 2023 11:01:15 -0700
Message-Id: <169238167326.1457886.12849640803727382145.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817210327.never.598-kees@kernel.org>
References: <20230817210327.never.598-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 17 Aug 2023 14:03:28 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ima_rule_opt_list.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] integrity: Annotate struct ima_rule_opt_list with __counted_by
      https://git.kernel.org/kees/c/a4b35d4d05b9

Take care,

-- 
Kees Cook

