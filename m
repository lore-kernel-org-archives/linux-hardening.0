Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01503C433ED
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 19:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A958360241
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 19:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbhDAT2u (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Apr 2021 15:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbhDAT2p (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Apr 2021 15:28:45 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504E3C0465C0
        for <linux-hardening@vger.kernel.org>; Thu,  1 Apr 2021 12:17:50 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id cl17-20020a17090af691b02900da5fe25f0eso4965734pjb.1
        for <linux-hardening@vger.kernel.org>; Thu, 01 Apr 2021 12:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nlEty8FbrPXfEuiwzU9OVAHqfrb/3joIbwaJdu5fO44=;
        b=QSntTpECX8es2vOgpgsVQixFbafEesFafN4Bzaq4712xl6Lp68jJHZTkl1YI177619
         QEKerfpHXNaHIDUo4BJsh5aj285zB/9VcoH1lBKIIiJneIq2vX5upBnfgQa2X+IZK9bQ
         ut9PpEQaCNQgfDmNUQ3EygQyX0QErvgOBAFzNoPBbRSTXozlbZ0sWDOP9h7TMEPZP+MG
         3jehI4bc4N7gPWyM5smNvhfx0L6UfgJMoPMZY6Bo0dsmMTINhiqu/x3MTUinFMBJOqFH
         LfsNqz1HkMyLVX6nLomMGzSoWbqeTscnmuH0A6FqFsxK17PjTMojKJMZ4zdHseqE1krr
         6L8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nlEty8FbrPXfEuiwzU9OVAHqfrb/3joIbwaJdu5fO44=;
        b=f8DF0307RxpRYjRq6n59j/H0Gx9HJcmYMtTlKK7QnvZhPG8+MXVnUiSAyuGZsoAzHt
         yfVlEoC7Q8QNXXTiQvj2QFjxT0/QewHjW8aLJsy7Q4EpXpYDRhZKnQf9SpDApZr+fS/9
         KmSn420m9MmHJGWx44eoCoHaF1e3JHIDkEnwdxNpcWP05hOjWsjYNmJJM7+Z7+hqocaW
         TzuikCa09dPoGqgXdodwXB/RzSuqyQqdm0VcOCWob1gmNrjScvi9tf7H5GMImvC6yobT
         dF/U4fIR/QUoxODPExBr9NB7UBHaxA9sixv6kSPOEjxyQzJSEfcVskIgHWouDhGlfBM6
         /z5w==
X-Gm-Message-State: AOAM530hQzP1/Kk04TK+zEn8ZUI6in9hBEbRvsixgkoO1MnLPGA35bW0
        MS/hQuT0I1FEcdR6HOqafMNGaT6Dmcsq
X-Google-Smtp-Source: ABdhPJz+iVbbW+Al8L02mPKFb3osxiJwm1KiVsG7416KcEaTmWJ3FCuEaDnnEeHvkJrncERy0gmFN5EuygRJ
X-Received: from royyang.svl.corp.google.com ([2620:15c:2cd:202:a838:37b3:5242:e2c3])
 (user=royyang job=sendgmr) by 2002:a62:7c17:0:b029:1f1:9ef7:163a with SMTP id
 x23-20020a627c170000b02901f19ef7163amr8859557pfc.51.1617304669075; Thu, 01
 Apr 2021 12:17:49 -0700 (PDT)
Date:   Thu,  1 Apr 2021 12:17:44 -0700
In-Reply-To: <20210330205750.428816-1-keescook@chromium.org>
Message-Id: <20210401191744.1685896-1-royyang@google.com>
Mime-Version: 1.0
References: <20210330205750.428816-1-keescook@chromium.org>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH] Where we are for this patch?
From:   Roy Yang <royyang@google.com>
To:     keescook@chromium.org
Cc:     akpm@linux-foundation.org, alex.popov@linux.com,
        ard.biesheuvel@linaro.org, catalin.marinas@arm.com, corbet@lwn.net,
        david@redhat.com, elena.reshetova@intel.com, glider@google.com,
        jannh@google.com, kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com,
        peterz@infradead.org, rdunlap@infradead.org, rppt@linux.ibm.com,
        tglx@linutronix.de, vbabka@suse.cz, will@kernel.org,
        x86@kernel.org, Roy Yang <royyang@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Both Android and Chrome OS really want this feature; For Container-Optimized OS, we have customers
interested in the defense too.

Thank you very much.

Change-Id: I1eb1b726007aa8f9c374b934cc1c690fb4924aa3
-- 
2.31.0.208.g409f899ff0-goog

