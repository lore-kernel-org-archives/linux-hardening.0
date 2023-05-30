Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE12C7EE31
	for <linux-hardening@archiver.kernel.org>; Tue, 30 May 2023 23:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjE3XGW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 May 2023 19:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbjE3XGS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 May 2023 19:06:18 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EFFF7
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:06:17 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5289cf35eeaso238104a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685487977; x=1688079977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYokZxIOUVujp68h63xsKw8F957dSkticFKlcbqHhEs=;
        b=jLnDjUSR+F3a7ACJ+OuNUh2bkPR65jjgaho0TGEpJaufX0Id0PlgloFBPUEmkZ6RYP
         mABDYUwgLu8IjIKVr1udT2MlNeS/w7Xd5DAskUTmop25P0sYOI8KmJxrsamFDK362z9q
         HMlu3yKVX60sfqFCvdRpPwB+IKwkf9vr5zuTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685487977; x=1688079977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYokZxIOUVujp68h63xsKw8F957dSkticFKlcbqHhEs=;
        b=S8ruY+Uoqdtdu2BRXnPs1q8WSqqgVLnqGnR074Snu5WfKE/vuOH/EZyIo3vYR2xSuR
         ENBo8eP+CWlz1xK1o8yVv2plG7qY/HDcoKYe5zj3OIsJv/7X7dhAcji4UZQq5M6Z7ZlT
         FbcDKpu77Chxm3z3AmnkZEfOjPdaywmE1xjlNOE2ZM7RUWwlVg0LERV7F4fczrR630AW
         /78oIoyqFOxanFw399Cb4Z4+wITOiRjz4eSeMkB8V7z0XWlw7Bi8zsfNCOcemQNw6zCk
         yknGOtLEvY06jGP9qPI/gfTxMAa63ZST6FLHGnOJ2uV2JaBFatNoQOaf468uJQDwtgGo
         l0mg==
X-Gm-Message-State: AC+VfDxSPo1mt8YdU8n7y0KM0TLLXCi0b04HigwqLp2iGbZpDCciLEfW
        sZM5CrDlxjhEW9vy0qShcTAQ0A==
X-Google-Smtp-Source: ACHHUZ4OtGNFUdj4Dz7T+6p0N4d/4VLdKHYa3SVbaBygy+RKPK7o7dvXOoKBWUXL5DYe7ZiaLnJJhg==
X-Received: by 2002:a17:90a:ec10:b0:23f:962e:825d with SMTP id l16-20020a17090aec1000b0023f962e825dmr4091752pjy.1.1685487977114;
        Tue, 30 May 2023 16:06:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g20-20020a17090a7d1400b0024e37e0a67dsm9469124pjl.20.2023.05.30.16.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:06:15 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     parthiban.veerasooran@microchip.com, christian.gromm@microchip.com,
        azeemshaikh38@gmail.com
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: most: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:06:06 -0700
Message-Id: <168548796310.1350188.10745694845862015530.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523021640.2406585-1-azeemshaikh38@gmail.com>
References: <20230523021640.2406585-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 23 May 2023 02:16:40 +0000, Azeem Shaikh wrote:
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

[1/1] staging: most: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/32c7fb186c1b

-- 
Kees Cook

