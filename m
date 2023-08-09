Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A2DC001B0
	for <linux-hardening@archiver.kernel.org>; Wed,  9 Aug 2023 14:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjHIOLT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 9 Aug 2023 10:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjHIOLS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 9 Aug 2023 10:11:18 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8141FD2
        for <linux-hardening@vger.kernel.org>; Wed,  9 Aug 2023 07:11:17 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686f090310dso6670005b3a.0
        for <linux-hardening@vger.kernel.org>; Wed, 09 Aug 2023 07:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691590277; x=1692195077;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6l11VxyDZSaUALoCccZa3ct54qsws22cbS5n25+v6E=;
        b=cunsTonL+/rWgH+Lz4jAFC9Fo4cKyoBxC4j8WwFEL0jWFMA+joGcIwndpf6zjM5229
         dx6v9awRlPeyKhuvOZRcrwlygUYnDLfH+Qf932m5p+FEeyQ32VubnIHh37ergH2QyDIH
         ihBHO08YMM+DYT6tf5UHpbNyycbFk9p46sIjtWMyGoYhKL9ZNbZsX9PuWvdcUU9tn8f8
         1+718/OVevz8jTL02NAoVMe2BjJWYV6FQVrsntfs5HWe0o6+l3QEf0NiVLqboOXmhn3i
         M3AgIxnXhvi72UTRCLEep+//oU3BH6phQpMtFQeH7t4r8ty6APS9Hy8D9WqnWF8SDIqs
         WJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691590277; x=1692195077;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6l11VxyDZSaUALoCccZa3ct54qsws22cbS5n25+v6E=;
        b=OM/hcko2TchhaN6OYVryvdB3ZuM8YOFlAdNruNBZu7pgmOUTq0qNrqrKex/K0JgQtz
         RoktYlq7X1OWCGT4m0cYO8ypS3HT0zFpr0tO4OUKxoeRiiioABk+3UIgcDyTpEXdoEsN
         TvjBB2cuF7xxwHm/QPmd/tMl0Rv7Cl3sRhdZvjqOkvUvKkE/DcRR8VfsKaiZJVJRTS/D
         XgNoXZr81Zr2lAtHUslHQ7EjIcibl3nv0PktfMPgA/x2YiVgXitadiEJIbZLlQA1ehTY
         yUxyLnnjL8WKpmNchdwXua/MiaDLTzCAev7GB9rAdQUvrKWE5lH0ZMl2+UdjPRhjafIa
         Hwbw==
X-Gm-Message-State: AOJu0Yz9Qs3fZxVXLo2GN302WdmdJbC453oyTspsJHSDKx43sSLSKIoF
        IHclDHkRHNZjMF4r739PjUbGDw==
X-Google-Smtp-Source: AGHT+IGJs9oapfzMEWX52Fz5gVTa0qKJex1tBzNPZgE7G5boBtfBncAYJ0Pu4Kz3A4DTnKHPFOHGhA==
X-Received: by 2002:a05:6a21:7787:b0:126:92de:b893 with SMTP id bd7-20020a056a21778700b0012692deb893mr2471053pzc.31.1691590277193;
        Wed, 09 Aug 2023 07:11:17 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id u6-20020a62ed06000000b006833bcc95b0sm10012207pfh.115.2023.08.09.07.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 07:11:16 -0700 (PDT)
In-Reply-To: <20230802-arch-riscv-kernel-v2-1-24266e85bc96@google.com>
References: <20230802-arch-riscv-kernel-v2-1-24266e85bc96@google.com>
Subject: Re: [PATCH v2] RISC-V: cpu: refactor deprecated strncpy
Message-Id: <169159026875.18421.15201020596285945791.b4-ty@rivosinc.com>
Date:   Wed, 09 Aug 2023 07:11:08 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Justin Stitt <justinstitt@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


On Wed, 02 Aug 2023 00:21:58 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> Favor not copying strings onto stack and instead use strings directly.
> This avoids hard-coding sizes and buffer lengths all together.
> 
> 

Applied, thanks!

[1/1] RISC-V: cpu: refactor deprecated strncpy
      https://git.kernel.org/palmer/c/12d61a1bc28e

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

