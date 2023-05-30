Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94956C77B7A
	for <linux-hardening@archiver.kernel.org>; Tue, 30 May 2023 23:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjE3XGV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 May 2023 19:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbjE3XGR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 May 2023 19:06:17 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D54CEC
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:06:16 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5304d0d1eddso2594923a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685487976; x=1688079976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIZITtN2bKn4epnZA2aYk+MPyTdtLfd4FD17Mvvuc+s=;
        b=c0hOeQpScZnxVdLys+GcGo36POTD+McxKYLKI2O2AJP93Y+cMku8bLaYjilcymC99G
         ajnfrL573vrFpsgBn7xnJi1Eb3TQetX1BSBfOMfUoZh6xoPjFrnTrPTojvFJxekXH0/k
         AkrK5vEFS4WJq6XtyNCJ0ZQBHeoQmBD8CIPWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685487976; x=1688079976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIZITtN2bKn4epnZA2aYk+MPyTdtLfd4FD17Mvvuc+s=;
        b=J04X5ZVXfahxliLTFxCtrX0gIhw3kgo1eC1F/hanETO9i1owXQqBnsZZOS8QKs5tp5
         l74Zd4Z7xJZuj7pSGHGTITh4fb6EHSD6cG6cStbL6SDjOBhIqxHVV8m28kyNu27Uzo/B
         YdG2DI5OXhzCmZqEyc5fR7MJcp92CSeY/Dmu75Dv1mMPWeJq8P/RHNe+PIcseL1ShT/P
         BFkrFtZ4TEmzK/QQQ3LgAH62lhx4vDEPrs7KBtkcFqkUgLlxBb9RVK0sH9Xqp+jy+lg6
         41NPE4XKGypPhmHbSkWoV4GND4Xa3IpF296fFl5PKsvBh160mOANtP+EokglnTWIlLTG
         VgQw==
X-Gm-Message-State: AC+VfDz+Sz3QEratzP918fcNIbqALem2csfZsjX1ibkQFhIt+Jkqrb9P
        xJYa2dvCZWzTGsCx3pcuteovrA==
X-Google-Smtp-Source: ACHHUZ5jQFK+2MaC3xETbHHaMeqzbXfvABdTY+M1OZIR00QqD/GOmMTju4UsQ3310f7NZCUs1aUCcA==
X-Received: by 2002:a17:90b:3908:b0:255:c461:6405 with SMTP id ob8-20020a17090b390800b00255c4616405mr3924044pjb.15.1685487976005;
        Tue, 30 May 2023 16:06:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090a77c800b0025695b06decsm3351803pjs.31.2023.05.30.16.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:06:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux@armlinux.org.uk, azeemshaikh38@gmail.com
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, airlied@gmail.com
Subject: Re: [PATCH] drm/i2c: tda998x: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:06:02 -0700
Message-Id: <168548796309.1350188.15805729218836239223.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522155350.2337029-1-azeemshaikh38@gmail.com>
References: <20230522155350.2337029-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 22 May 2023 15:53:50 +0000, Azeem Shaikh wrote:
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

[1/1] drm/i2c: tda998x: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/a7aba6fa2750

-- 
Kees Cook

