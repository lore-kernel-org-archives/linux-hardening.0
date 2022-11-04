Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F26EC433FE
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Nov 2022 19:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiKDTct (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Nov 2022 15:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKDTcm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Nov 2022 15:32:42 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF54945084
        for <linux-hardening@vger.kernel.org>; Fri,  4 Nov 2022 12:32:40 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id z26so5368681pff.1
        for <linux-hardening@vger.kernel.org>; Fri, 04 Nov 2022 12:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJx5Vo13L9gX9apUbugbGq7p+vwBn4IOzk+4YVYJbZo=;
        b=PWyXmK+bN4YM6UWblyRMVutXuc2f46M8K5kj7AsPvSQYau24NgfA3c14hTpOkY/lXh
         TgZknkLqE8+M15xi09X/3zFxiyUz3OD4glTMJZRgR90wrf2JsTPhor8EbFM0YrK/rKoG
         YgSETYSHttYklZcLjRGnOLHKMpA0xM6Z8PDlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJx5Vo13L9gX9apUbugbGq7p+vwBn4IOzk+4YVYJbZo=;
        b=piF12f+dYOSl7APWA2i8OfLhSLO3SeL4aqEJEPsZIfhQxjN7pKJO3i9BNklAxEptC/
         Dbs/5hAOIR3otITa+V26/6wx15rYykrn1t4ICN1K/VT1lunJRg0yUfv3vuyN12OFKm7r
         2ZhOYZ/Ys4FcAlX9A4RfYJ1j1YsC9gAatLbhk5w5OYVZSog9r+anPonVYV8TeDwrCemy
         1tOJi1bcMpJN+ac1py7WXkcPfFHUpd/OFG3sWJFGaYeZYmBdrI1XjHtLu0AZNLldnwNC
         opufkDFvHJLpfdk5AynM61qpFY0r01UUNoJuYRxxcKC+ZK5mYcRuq50bYMWJA+lHnSwl
         +TYA==
X-Gm-Message-State: ACrzQf1Bckkaab7wZRN+sXO2f/f+B1N39JhqLQzPdjk4LELHj4rv2pR4
        0Py1BpBnd1IQL+OxU2LlR8kfzg==
X-Google-Smtp-Source: AMsMyM6b3yzI6tcnLNCUvQjftaq74cgnM4/tQtryFCIdjr3n8azek7qjQaYlxgkqWKXcmSealD9oKA==
X-Received: by 2002:a05:6a00:a8c:b0:558:991a:6691 with SMTP id b12-20020a056a000a8c00b00558991a6691mr37351768pfl.53.1667590360362;
        Fri, 04 Nov 2022 12:32:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090a684400b00212daa6f41dsm95856pjm.28.2022.11.04.12.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 12:32:39 -0700 (PDT)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Fri, 4 Nov 2022 12:32:38 -0700
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org,
        Mikulas Patocka <mpatocka@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Borislav Petkov <bp@suse.de>, Yujie Liu <yujie.liu@intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: elf_create_prefix_symbol(): Resource leaks
Message-ID: <202211041232.6071ACE@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221104 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Tue Nov 1 13:44:09 2022 +0100
    9f2899fe36a6 ("objtool: Add option to generate prefix symbols")

Coverity reported the following:

*** CID 1527141:  Resource leaks  (RESOURCE_LEAK)
tools/objtool/elf.c:833 in elf_create_prefix_symbol()
827     	struct symbol *sym = calloc(1, sizeof(*sym));
828     	size_t namelen = strlen(orig->name) + sizeof("__pfx_");
829     	char *name = malloc(namelen);
830
831     	if (!sym || !name) {
832     		perror("malloc");
vvv     CID 1527141:  Resource leaks  (RESOURCE_LEAK)
vvv     Variable "sym" going out of scope leaks the storage it points to.
833     		return NULL;
834     	}
835
836     	snprintf(name, namelen, "__pfx_%s", orig->name);
837
838     	sym->name = name;

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527141 ("Resource leaks")
Fixes: 9f2899fe36a6 ("objtool: Add option to generate prefix symbols")

Thanks for your attention!

-- 
Coverity-bot
