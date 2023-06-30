Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC69EB64D9
	for <linux-hardening@archiver.kernel.org>; Fri, 30 Jun 2023 03:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjF3DZk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 29 Jun 2023 23:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF3DZj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 29 Jun 2023 23:25:39 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686BE359C
        for <linux-hardening@vger.kernel.org>; Thu, 29 Jun 2023 20:25:38 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b7f68f1c9eso11186015ad.2
        for <linux-hardening@vger.kernel.org>; Thu, 29 Jun 2023 20:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688095538; x=1690687538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qGZNY/d45qcsqv/6dK9Kz1D5j5tQyoBwHqcnw/3xWks=;
        b=ClO4Qqdk//HiL4nAnF+jD3EXrUP0WC/6JqzrvFwxUaQAnuTb8GhL6XjHKC0M5ZnWer
         q/QyM079DUjYyDDb55dxU0VEZkgtgl707aXs/D3aUAnFICB1gvftBkzo+qbnZ+XHv7Xg
         dpb6aAnBl6WZhLhF8JseLS8FEa3OkLY5IW4HQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688095538; x=1690687538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGZNY/d45qcsqv/6dK9Kz1D5j5tQyoBwHqcnw/3xWks=;
        b=HjJBU8UxX1ITujyu/FP1Vfi70pWk8EqsmYI9MmxZU17sa05mryEcKDrKJwUoVoFfbb
         gg9fqyObQkvXNFZ97k8Vu4OnWn1UOjB09mwpAGx8VZKgmKX7C6ctbJk+gWdTAwHaCJbv
         ye/OQlivVB1VnJg0SDBPUM+HCGXFZFBmGLQfXhUvxD4UhhptekLJC77sTlBmajUywM0Q
         N/ISVZ9rsNkv6g2wEYPsK3KsS9ba+VQ6SGmjXtj06Mn6Gdmfd/n5zdMbH9rKl+VFDqVp
         yADncQAp7of63vboXXytwzHz7thMldwQLYJFDBU1RqgbuvzRDw6eisN9KD5O+o82HKEu
         Nmww==
X-Gm-Message-State: ABy/qLaWwnUiVUYIQD9ukXghTEH6WZXlx6HjDevLPFdaep/grqvekfr3
        HoZwR2A7J7Yb97cxdkaLgo1ZrQ==
X-Google-Smtp-Source: APBJJlE7RIil3rQSgYWENbH10+1mHtgxaRDkTD8nyfCULDKfglAL51FCHofXxyxl+cjgtq0ZR5dd4Q==
X-Received: by 2002:a17:902:d2cd:b0:1b8:16c7:a786 with SMTP id n13-20020a170902d2cd00b001b816c7a786mr1379879plc.4.1688095537808;
        Thu, 29 Jun 2023 20:25:37 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id x3-20020a1709027c0300b001ae5d21f760sm9728322pll.146.2023.06.29.20.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 20:25:37 -0700 (PDT)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, asmadeus@codewreck.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 0/1]  Add documentation for sysctl vm.memfd_noexec
Date:   Fri, 30 Jun 2023 03:25:34 +0000
Message-ID: <20230630032535.625390-1-jeffxu@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

Add documentation for sysctl vm.memfd_noexec

Thanks to Dominique Martinet <asmadeus@codewreck.org> who reported this.
see [1] for context.

[1] https://lore.kernel.org/linux-mm/CABi2SkXUX_QqTQ10Yx9bBUGpN1wByOi_=gZU6WEy5a8MaQY3Jw@mail.gmail.com/T/

V3: resend V2 with cover letter.
V2: revise.
V1: initial version.

Jeff Xu (1):
  Documentation: mm/memfd: vm.memfd_noexec

 Documentation/admin-guide/sysctl/vm.rst | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

-- 
2.41.0.255.g8b1d071c50-goog

