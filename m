Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C65AC77B73
	for <linux-hardening@archiver.kernel.org>; Tue, 30 May 2023 23:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjE3X0y (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 May 2023 19:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjE3X0x (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 May 2023 19:26:53 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1829A9C
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:26:52 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d57cd373fso251779b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685489211; x=1688081211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20rREOO4ExsqpWtT25NbGtwxcNpitkrMts/CeDpG8is=;
        b=IOWJwO8cd4O72NmvBwHdGvQP3i7cqRoptJr1wMnEgtq33n37I4cIwcDx5x2FfX8XNk
         D9rBNzdr6Dpl7jXKPEzy/bLZQzu8npHnbDZh4qVObIkn6hJIWIcE8RRob8BYMAzARfGF
         H+KSnPUhh3BMrwv8YiDDXFpVabX4uDaPA6TjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685489211; x=1688081211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20rREOO4ExsqpWtT25NbGtwxcNpitkrMts/CeDpG8is=;
        b=YMyNXx0z8N2y74ScxObhODJB2wmML/XEPG+ScIsQgC7bDWZtJ5UXnlfTLnJvYEFRcQ
         9CWSnYAXa7FDbRgeaJEg1CeOYnX9Cx7t5Sx0JlUaV+34BdC0wHbfTjg67CiCknkd3kjP
         Sr9jP3bVwUt9NsF4FnHoEy4fr+HFwApVgkyw9QnAa4FBdcVbA5jRR7ehIofNiQUJMHAw
         5obvFtjh9yBBuebAtDe3K3JA4Gl0NKeF5IeFakYJDXCBFAFIWthEXuC31cyejsX1aF/c
         BkLd9LE9zU7x1cYYuJIdmH1WrM9YYC/llZao4AizoqoTR3g9HvpxfXF+X7thkiC4ZYst
         exIA==
X-Gm-Message-State: AC+VfDy3exGrjNMI5bv+I2Qrqia+ZJh63yZHo4wPG5+uVZCVjkGRT4sC
        gMNNxrSqskcSd+IXl3R5iCnsZg==
X-Google-Smtp-Source: ACHHUZ56FhVbFo+v/5QxJUxv9fOE+OkJsRH4Zi6ieowA+/ZNuWZvCGbZ7Trr9unf0U8xPAu9NSLSdA==
X-Received: by 2002:a17:903:2350:b0:1a6:f93a:a136 with SMTP id c16-20020a170903235000b001a6f93aa136mr13179454plh.22.1685489211573;
        Tue, 30 May 2023 16:26:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d20-20020a170902b71400b001a4edbabad3sm10817628pls.230.2023.05.30.16.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:26:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     tglx@linutronix.de, jstultz@google.com, azeemshaikh38@gmail.com
Cc:     Kees Cook <keescook@chromium.org>, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] clocksource: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:26:49 -0700
Message-Id: <168548920884.1352363.14399780018411204130.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530163546.986188-1-azeemshaikh38@gmail.com>
References: <20230530163546.986188-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 30 May 2023 16:35:46 +0000, Azeem Shaikh wrote:
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

[1/1] clocksource: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/40932d192ec8

-- 
Kees Cook

