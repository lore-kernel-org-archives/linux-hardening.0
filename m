Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25A9C87FDE
	for <linux-hardening@archiver.kernel.org>; Sat, 10 Jun 2023 00:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjFJAwX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 9 Jun 2023 20:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjFJAwR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 9 Jun 2023 20:52:17 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587A89E
        for <linux-hardening@vger.kernel.org>; Fri,  9 Jun 2023 17:52:16 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d75a77b69052e-3f9a53add26so19639051cf.0
        for <linux-hardening@vger.kernel.org>; Fri, 09 Jun 2023 17:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686358335; x=1688950335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T3zbnVqAY087jc6zf5zGMbDLx4xURbX3P9p7/Tuiobs=;
        b=et/MOGBK43VQyQvYIB7WrQSc2K4IoXPVkm0UVfNUNy96HPcVZba6zLNT5urtOdGcBs
         P5jt2t2alfdalvP+MXwOg5CshT5nrkNH4RWZjKB7EdlIykKTWXG/akynbg/MxRcvIali
         cR6E0dGflT2FGLplmwq9iV7KLl5YiqcNNNeJqrHLkpgbofZ845oFq7BFKXlpp3VAZhyB
         0anqrIvE8hlk1cks2OHMBgZmMdPUQYGvDXR5uzuiNXd1k6vEEfIPVZWzwFBkXVAFjir+
         T7UvI1CHBZDi+GBLKQfZrLguMJw+Mcmyrl5IDqx5fM6Oa4UHrYFHXc04eE87IVZpjdve
         mT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686358335; x=1688950335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3zbnVqAY087jc6zf5zGMbDLx4xURbX3P9p7/Tuiobs=;
        b=XokSCcZd8kbnaZglfZV9oAcQ6bTkIucn1SRzv6eWCXh+z6Ht9S+I7TAafJF9o9mjPu
         jsz2M3rXXDtJO94q1oum4tUZPiSa1TA482OZELj5Z94J40QgyHtJFcQqZK/DWdRF7uoR
         W0G0wnimPm0lwLt1QCBhIpqVRn0dI6IXNDonEJwqR3iWU0qW5nzZYDMbUobUVbbTrOw/
         UN30/of9bpIL9bX65Sqd+JX2xx9UFDwaHeIf3AbyRUY+cvEpXvvTx88hNPZiKxicPi1/
         +XerjGe+M/iEJnMhk3vJ2mLo3y6YhbgASUrEKpgv3Ey+3f+ef5dMfwFeKhpvPFwhpOwE
         Rm2A==
X-Gm-Message-State: AC+VfDwHhh3RNnRkxgmNFgOuKBgXD/k9FoXagtZ/6YFiwP37u2xa5Mgp
        oKBelOMrmx8mNr2Sq6dh9tSxrsiS5g==
X-Google-Smtp-Source: ACHHUZ6dnvhynsP+qbvMSlLVpDX2UXxgBwmpdFpa0jMBlxgs6rhuAeeLQxvZlPYg2eocE1JYwxLuOIy3Sg==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:622a:1485:b0:3f7:469b:91a with SMTP id
 t5-20020a05622a148500b003f7469b091amr1337196qtx.6.1686358335447; Fri, 09 Jun
 2023 17:52:15 -0700 (PDT)
Date:   Sat, 10 Jun 2023 00:51:48 +0000
In-Reply-To: <20230610005149.1145665-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230610005149.1145665-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230610005149.1145665-6-rmoar@google.com>
Subject: [RFC v1 5/6] kunit: memcpy: Mark tests as slow using test attributes
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Mark slow memcpy KUnit tests using test attributes.

Tests marked as slow are as follows: memcpy_large_test, memmove_test,
memmove_large_test, and memmove_overlap_test.

These tests were the slowest of the memcpy tests and relatively slower to
most other KUnit tests. Most of these tests are already skipped when
CONFIG_MEMCPY_SLOW_KUNIT_TEST is not enabled.

These tests can now be filtered on using the KUnit test attribute filtering
feature. Example: --filter "speed>slow". This will run only the tests that
have speeds faster than slow. The slow attribute will also be outputted in
KTAP.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 lib/memcpy_kunit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
index 887926f04731..440aee705ccc 100644
--- a/lib/memcpy_kunit.c
+++ b/lib/memcpy_kunit.c
@@ -551,10 +551,10 @@ static void strtomem_test(struct kunit *test)
 static struct kunit_case memcpy_test_cases[] = {
 	KUNIT_CASE(memset_test),
 	KUNIT_CASE(memcpy_test),
-	KUNIT_CASE(memcpy_large_test),
-	KUNIT_CASE(memmove_test),
-	KUNIT_CASE(memmove_large_test),
-	KUNIT_CASE(memmove_overlap_test),
+	KUNIT_CASE_SLOW(memcpy_large_test),
+	KUNIT_CASE_SLOW(memmove_test),
+	KUNIT_CASE_SLOW(memmove_large_test),
+	KUNIT_CASE_SLOW(memmove_overlap_test),
 	KUNIT_CASE(strtomem_test),
 	{}
 };
-- 
2.41.0.162.gfafddb0af9-goog

