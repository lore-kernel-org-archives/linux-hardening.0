Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B894C25B7D
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Aug 2023 21:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346315AbjHPVBb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Aug 2023 17:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346318AbjHPVBU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Aug 2023 17:01:20 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D602716
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 14:01:19 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-565f58f4db5so761969a12.0
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 14:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692219679; x=1692824479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tueXu0Ns+Bnh4f2pFBmSiDXwjez31Lg3bE/m1p/Z7F8=;
        b=h4cypbZYEWuj6qfKg7BYlroI0Rq4iT9ZorXDMReDLbo9Wu+H21+QzHnh6cn+uH7FUH
         m5V6a0iKZYYt87hSYYjH4w5codj5mGYhURlwquaQ2fLaO+V47hqsxsbbhePO+MorB7XS
         d5+G+FTLYfTttycSUwBFJbf4BSCr7mVis1t/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692219679; x=1692824479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tueXu0Ns+Bnh4f2pFBmSiDXwjez31Lg3bE/m1p/Z7F8=;
        b=dT0vF9lIVUff75Tnj5jrWEgJx5IWDQwj1isYAe0d/AX8eQV8oeR0fIZyRb35iWZ9v0
         CMIwWkDmt6x+7/JyEV8AoU6KVOAZm3Hw+/DmWouPMtjioDTE6dgNT3y1TrXDJSqoujbS
         0DmLV3BwfdpoIO2DdBNk9UpivpUcSO8cZLG+SR4rlJEirv8EMt2PYpDbRY7OS+yp4hz+
         VZbWanDh/3WNzf43eYZSGsxi+xeN/m5N9hDpHmifueeUpQzdl75b6v20tF7BB9YHLkWD
         NG08y10lPKhRumJJTwMtDRrkHZeLEUSrMXPC8AvR0xFM2Pobk0DqQSNuUb+Y5Ki3kANV
         bp6Q==
X-Gm-Message-State: AOJu0Yye8q9cApWCX9UOA9Sa5P+CBlpwpbwhnjXDAuGibqmuUTUJ+UX4
        Qei0JWcHgEaAuGMuEPeUUR6C5A==
X-Google-Smtp-Source: AGHT+IEoTqsAY9X4d8zG8oJVSKdkfpXWnoDJkiEA4AHkAlofDdq5E5GGVkNjWu2cpshxXS33CUofZw==
X-Received: by 2002:a17:90a:f40d:b0:263:287e:3991 with SMTP id ch13-20020a17090af40d00b00263287e3991mr2358405pjb.22.1692219678711;
        Wed, 16 Aug 2023 14:01:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h18-20020a17090aea9200b00263f41a655esm161046pjz.43.2023.08.16.14.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 14:01:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] um: refactor deprecated strncpy to memcpy
Date:   Wed, 16 Aug 2023 14:01:14 -0700
Message-Id: <169221967233.1236805.5075481446836951537.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809-arch-um-v3-1-f63e1122d77e@google.com>
References: <20230809-arch-um-v3-1-f63e1122d77e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 09 Aug 2023 18:19:32 +0000, Justin Stitt wrote:
> Use `memcpy` since `console_buf` is not expected to be NUL-terminated
> and it more accurately describes what is happening with the buffers
> `console_buf` and `string` as per Kees' analysis [1].
> 
> Also mark char buffer as `__nonstring` as per Kees' suggestion [2].
> 
> This change now makes it more clear what this code does and that
> `console_buf` is not expected to be NUL-terminated.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] um: refactor deprecated strncpy to memcpy
      https://git.kernel.org/kees/c/be8dffa04de3

Take care,

-- 
Kees Cook

