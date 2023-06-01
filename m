Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A03C7EE23
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Jun 2023 18:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjFAS1k (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Jun 2023 14:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbjFAS11 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Jun 2023 14:27:27 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15C0171B
        for <linux-hardening@vger.kernel.org>; Thu,  1 Jun 2023 11:27:05 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-53fa455cd94so646010a12.2
        for <linux-hardening@vger.kernel.org>; Thu, 01 Jun 2023 11:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685644025; x=1688236025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ctf1HD9q2IXAlWGZe0D1mEr62PaUnWG7sqP8wEigDAM=;
        b=oQgl78QYG5Oj68tYfu28Af11McToK99Xc7cFV/WH2ogHroD1GdfvX22wD/gSmA8aMP
         xqCFWhpZwhyN0YrqAvcKjFZdTkBLYFqwpi+GrPRnAe1zzZL0DZpvRCHlUNlpG4wyJSzO
         KPRVn/di/BWJKYn3/rifCxelC2KwvxVw4Wrx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685644025; x=1688236025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ctf1HD9q2IXAlWGZe0D1mEr62PaUnWG7sqP8wEigDAM=;
        b=fga8kb9g/EUnuoOe5YlyaHKi+Po9MEJIe3FoWdJhU9T+4r9zpccBRACEDwoBlcOzLu
         Mwgt+cWDbXmg7LuoHmddWC7td8EPSBBcVkZLJziqneEoNxYbK4VHrV2XgopHX+5PcZHR
         qH0KjVuvCXUvLPPvXcFoSloQ2mzSGyauw942PCz91+B49F5u5DBs0r+ANDde5JU3ZxP8
         Em3RvyzKx3aIUpRFNBnZt3RD4Cg4wsMamHpL4dsvzhxzPT9H1NeMmHoWCxaHdV/HE08e
         t2AOoWwTZ+1pZQq51Y0XHRvLdKy5FLxTURwXU/vBprnBXcPJjQcUA+aA4+qVLk7AcACv
         v72A==
X-Gm-Message-State: AC+VfDxhyka1kQfhO1iJaZx4oD9nZlVQuGq34ZqIICidfxwf46vVt2pZ
        ZbGkv489zbdQTtw5+LuI9k0SaQ==
X-Google-Smtp-Source: ACHHUZ7tPlL1ll6KCGCyuy9FbrvkGPsvnW5z4XOtzglH+OZASYBlfmRDsuL8K30dabeFU2fpmQaSgw==
X-Received: by 2002:a17:902:a710:b0:1b1:af8e:d31d with SMTP id w16-20020a170902a71000b001b1af8ed31dmr151235plq.40.1685644025042;
        Thu, 01 Jun 2023 11:27:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902e74500b001a505f04a06sm3797670plf.190.2023.06.01.11.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 11:27:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     keescook@chromium.org, paul.walmsley@sifive.com
Cc:     ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        gustavoars@kernel.org, linux@leemhuis.info,
        heiko.stuebner@vrull.eu, linux-hardening@vger.kernel.org,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        joanbrugueram@gmail.com, masahiroy@kernel.org,
        conor.dooley@microchip.com, ajones@ventanamicro.com, hi@alyssa.is,
        palmer@dabbelt.com
Subject: Re: [PATCH v2] riscv/purgatory: Do not use fortified string functions
Date:   Thu,  1 Jun 2023 11:27:03 -0700
Message-Id: <168564402237.2891605.1600418987887898293.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601160025.gonna.868-kees@kernel.org>
References: <20230601160025.gonna.868-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 1 Jun 2023 09:00:28 -0700, Kees Cook wrote:
> With the addition of -fstrict-flex-arrays=3, struct sha256_state's
> trailing array is no longer ignored by CONFIG_FORTIFY_SOURCE:
> 
> struct sha256_state {
>         u32 state[SHA256_DIGEST_SIZE / 4];
>         u64 count;
>         u8 buf[SHA256_BLOCK_SIZE];
> };
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] riscv/purgatory: Do not use fortified string functions
      https://git.kernel.org/kees/c/ca2ca08f479d

-- 
Kees Cook

