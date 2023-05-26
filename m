Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FF5C7EE23
	for <linux-hardening@archiver.kernel.org>; Fri, 26 May 2023 17:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjEZRQt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 26 May 2023 13:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjEZRQs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 26 May 2023 13:16:48 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F339B
        for <linux-hardening@vger.kernel.org>; Fri, 26 May 2023 10:16:47 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-52cbd7d0c37so644772a12.3
        for <linux-hardening@vger.kernel.org>; Fri, 26 May 2023 10:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685121407; x=1687713407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tt/68vR6SyeC2sLBcDQmwXBv1ANp28ndmxJPUsWE9hM=;
        b=LnkvrIlQ8Tok1eY3MzXaVX3kUwG4iQ/TiKFyN8pB9xmQgyIk1TWe7Rhr0DTtyZlcDs
         eVfyKux69riINbAJ3ut36H1rVoRrwRJT4yCWqFMFjVVbBMYEs2dxvwSjolS7rd4aewK5
         xwaoXlV1TqZNJcLRm1EvoAdemOvEOa/ETWhKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685121407; x=1687713407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tt/68vR6SyeC2sLBcDQmwXBv1ANp28ndmxJPUsWE9hM=;
        b=KKaydNqMD7cYiWH/OSE2JyHOxEQNBZ2+HXDHmfczEMLryTQoc2wvPHIXjD5vEzcp2Q
         CG5OdG//Kv2V1GF8Lj1QEPPJgQKhaZUhHGeD18WvY5DTnINrpkqJJs2R8G8lL+A2N02i
         L/RWGB3GuJ6qstG8Cgxp++XeRr/PJgNL8m08NMU6TBQdRKfqDuzh3XzTL2So98Zc87hJ
         3q+Vi6s8N5MjxfF7hC03fjXFthqmtjsLfjXZF1UotmJFiab8xOXv9J5lihRFgDKCiyaW
         60YAQcAbINsgQ849LK4IgFQcUB0NITH/0k/dgJmVK930OOA+H9YJMfXPUXT5O2YQcvmx
         tHkw==
X-Gm-Message-State: AC+VfDxV2E6F2hXnoFtiAl53PUC+3a1oYOwp1Ac1Ybf3mqVVnatolDLs
        y0Atck0S7+Ka1WbeLXru/mz728iNCPoTO7AU4CY=
X-Google-Smtp-Source: ACHHUZ5x1UtHJq0vBgeGLgQxf+Iim5Mb2xwowdl86d42mrNau8iDDUGU9hQVFxLDmRhXDrvIjkEZwQ==
X-Received: by 2002:a17:903:10c:b0:1ac:8062:4f0b with SMTP id y12-20020a170903010c00b001ac80624f0bmr2720843plc.59.1685121407089;
        Fri, 26 May 2023 10:16:47 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p23-20020a170902a41700b001aaecc0b6ffsm3490147plq.160.2023.05.26.10.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 10:16:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     ojeda@kernel.org, keescook@chromium.org
Cc:     qing.zhao@oracle.com, morbo@google.com, llvm@lists.linux.dev,
        trix@redhat.com, linux-kernel@vger.kernel.org, nathan@kernel.org,
        linux-hardening@vger.kernel.org, gustavoars@kernel.org,
        ndesaulniers@google.com
Subject: Re: [PATCH v2] Compiler Attributes: Add __counted_by macro
Date:   Fri, 26 May 2023 10:16:29 -0700
Message-Id: <168512138720.187005.8346289423859319616.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517190841.gonna.796-kees@kernel.org>
References: <20230517190841.gonna.796-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 17 May 2023 12:08:44 -0700, Kees Cook wrote:
> In an effort to annotate all flexible array members with their run-time
> size information, the "element_count" attribute is being introduced by
> Clang[1] and GCC[2] in future releases. This annotation will provide
> the CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE features the ability
> to perform run-time bounds checking on otherwise unknown-size flexible
> arrays.
> 
> [...]

FYI, applied to for-next/hardening:

[1/1] Compiler Attributes: Add __counted_by macro
      https://git.kernel.org/kees/c/86a76e91cbab

-- 
Kees Cook

