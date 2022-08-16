Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BBAC25B0E
	for <linux-hardening@archiver.kernel.org>; Tue, 16 Aug 2022 19:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbiHPTZd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 Aug 2022 15:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbiHPTZ1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 Aug 2022 15:25:27 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDF95E32B
        for <linux-hardening@vger.kernel.org>; Tue, 16 Aug 2022 12:25:27 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id v4so5752669pgi.10
        for <linux-hardening@vger.kernel.org>; Tue, 16 Aug 2022 12:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=a5SjQ9AEC/AYbATxtS93Zgv94cT2xe13yj4SFSKvsIA=;
        b=Il9X/STp6V9jcUaGx2WOrl/2yrZHrsz8cT7ebvlampboepQs9dAGad0VvgT4Olatjk
         OlDXwGxAQgmZiUQHOpJeM8neJBE8yN5R1PrOofZJcNJ1sDP2dSicGonwkrMYrdOqqmsW
         p1Ly68BgWg5AoIE0+KzMypl+WrEopij9J65M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=a5SjQ9AEC/AYbATxtS93Zgv94cT2xe13yj4SFSKvsIA=;
        b=MzViNkxhNaMDYcT4ykuMOQPYO0AxKVV+jtno7qQGYe0dGqrx1GZ7zyj4K1j/C2XoFa
         8NBkoX7ofOOZeBm7vldcYqyALnNggfoexHe6ni/HVo95SVXaxQKH31DqZrwfxglN4TC5
         IfGsChgb6ppU4AqLQ8ZaK64qUauWN+rI4rE3IbgntrDBGYIepXe7PFlJtdU/SElZpVsD
         IFLbUV5qJniSVPlcW4T2wvZ/ENsORuy9b5CEF/7GJ6xEkbm/tMdx+pF5DPZ8WUBeyLOE
         7cM0JDyhihiJaB0h3BwIBstgZvf/0bhcCzbu2hi3f0py/fhAEV+TuaXnm6PZlLYiuMvd
         u2cA==
X-Gm-Message-State: ACgBeo0va38UgwDHOLI8Kv2OPssWf8mEluqtf2iNBc6/++nHGSFb73Nf
        LweyU1Fhgn7R1HZUfqJcMsmyYw==
X-Google-Smtp-Source: AA6agR6WWo3/u3APAWhN8/0GZ1YW43LvZbtp82A+6RH1w8ZWfwDxYgvZvBY+tvcaBAYnXQRFDompUw==
X-Received: by 2002:a05:6a00:189d:b0:52d:d4ae:d9f7 with SMTP id x29-20020a056a00189d00b0052dd4aed9f7mr22322238pfh.18.1660677926802;
        Tue, 16 Aug 2022 12:25:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m9-20020a17090ade0900b001f3162e4e55sm6643744pjv.35.2022.08.16.12.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 12:25:26 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linuxppc-dev@lists.ozlabs.org, linux-hardening@vger.kernel.org,
        ajd@linux.ibm.com
Cc:     Kees Cook <keescook@chromium.org>, yury.norov@gmail.com,
        erhard_f@mailbox.org
Subject: Re: [PATCH] gcc-plugins: Undefine LATENT_ENTROPY_PLUGIN when plugin disabled for a file
Date:   Tue, 16 Aug 2022 12:25:08 -0700
Message-Id: <166067790682.7084.237943534143309650.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220816051720.44108-1-ajd@linux.ibm.com>
References: <20220816051720.44108-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 16 Aug 2022 15:17:20 +1000, Andrew Donnellan wrote:
> Commit 36d4b36b6959 ("lib/nodemask: inline next_node_in() and
> node_random()") refactored some code by moving node_random() from
> lib/nodemask.c to include/linux/nodemask.h, thus requiring nodemask.h to
> include random.h, which conditionally defines add_latent_entropy()
> depending on whether the macro LATENT_ENTROPY_PLUGIN is defined.
> 
> This broke the build on powerpc, where nodemask.h is indirectly included
> in arch/powerpc/kernel/prom_init.c, part of the early boot machinery that
> is excluded from the latent entropy plugin using
> DISABLE_LATENT_ENTROPY_PLUGIN. It turns out that while we add a gcc flag
> to disable the actual plugin, we don't undefine LATENT_ENTROPY_PLUGIN.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] gcc-plugins: Undefine LATENT_ENTROPY_PLUGIN when plugin disabled for a file
      https://git.kernel.org/kees/c/2d08c71d2c79

-- 
Kees Cook

