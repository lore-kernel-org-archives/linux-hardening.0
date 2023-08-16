Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465BCC41513
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Aug 2023 21:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346302AbjHPU7r (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Aug 2023 16:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343531AbjHPU7S (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Aug 2023 16:59:18 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299A3270A
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 13:59:17 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bdb801c667so46046745ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 13:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692219556; x=1692824356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlGgwWTf/nLP2TlwAmP1MWgMzO0RJqkyJNjk5XF286w=;
        b=da09eNAHkWEo/pEOng7AkizliA/xPdjEjR4w1hWOr6cprU1HJasY8mlRG3X5jlWYpR
         TQDai+S04x09MlFWQVCyVt7TvTg1NKjygAq0L4ybvBKX1MYRtaJyrZl/Er9T6P7t0k6G
         VQXoEBwVTI+LCFVKl9WnKuSx+eCIgamm9s9+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692219556; x=1692824356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlGgwWTf/nLP2TlwAmP1MWgMzO0RJqkyJNjk5XF286w=;
        b=XKrsEHru952SUuqn872114UzrCnXH3FBVkGt6pbU/jGj9YwHxx2tWq4mWfg9tyyAk1
         1lYQGX6J79RXmwawjLxk+r6jDLUMd0vg90SwIRSeK1cjUPxfXh9/ZYTxusbrVRBJiZmk
         QTAvIRGZgRtUwyaDWydHN7xqM2ckjUr+SJ6zhHZ7Zhx/Yh1pxeeo8LLXqSZrT5pYYrKI
         4wijVF1TqOllb9Rfty5ztxh2uXzsCnOD0UWIC/oz0D0tr5xQ4jy8wzk3LetESNokEBKK
         yiDxrjDHRAtRXIFtiOZR774TDEhV3J2NSX6DlPlOCHf1OgGHBjoWlK7EqlfERWuG/QAI
         xLKQ==
X-Gm-Message-State: AOJu0Yz9tQ2ZSZlhJZoMbj4spAsEdyOuSTF9t9OW1EFRRxPleQb6KlvD
        kxPaWw7vbhhxGvO9FEgb1K6/yA==
X-Google-Smtp-Source: AGHT+IFScTCnLhDPzkRADw5u9zcBAk0sLroO3CH7he7HPI1WAHYwTrUUwVGAXpnxTWUxsTPr96Os9w==
X-Received: by 2002:a17:903:11d1:b0:1bb:cf4e:ccd with SMTP id q17-20020a17090311d100b001bbcf4e0ccdmr4098212plh.28.1692219556713;
        Wed, 16 Aug 2023 13:59:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902bc4300b001b8c6662094sm13505194plz.188.2023.08.16.13.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:59:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Russell King <linux@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ARM: ptrace: Restore syscall skipping and restart while tracing
Date:   Wed, 16 Aug 2023 13:59:08 -0700
Message-Id: <169221954681.1236522.6821211749332698917.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810195141.never.338-kees@kernel.org>
References: <20230810195141.never.338-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 10 Aug 2023 12:54:17 -0700, Kees Cook wrote:
> Fix tracing on arm since commit 4e57a4ddf6b0 ("ARM: 9107/1: syscall:
> always store thread_info->abi_syscall"). This was seen with the broken
> seccomp tests "syscall_errno", "syscall_faked", and "syscall_restart".

Applied to for-next/seccomp, thanks!

[1/2] ARM: ptrace: Restore syscall restart tracing
      https://git.kernel.org/kees/c/cf007647475b
[2/2] ARM: ptrace: Restore syscall skipping for tracers
      https://git.kernel.org/kees/c/4697b5848bd9

Take care,

-- 
Kees Cook

