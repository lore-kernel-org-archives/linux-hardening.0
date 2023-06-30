Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0073C001DB
	for <linux-hardening@archiver.kernel.org>; Fri, 30 Jun 2023 03:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjF3DRj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 29 Jun 2023 23:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjF3DRi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 29 Jun 2023 23:17:38 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8C23595
        for <linux-hardening@vger.kernel.org>; Thu, 29 Jun 2023 20:17:33 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a1ebb79579so988439b6e.3
        for <linux-hardening@vger.kernel.org>; Thu, 29 Jun 2023 20:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688095052; x=1690687052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZoSuQHQ27DM/d6b7OOglRkF4w/BysG+jSVaxzCus5g=;
        b=HeDRz1ERohiy6m7ihytJYCLaW66pr6T/yVt3YJJVg+ByWiKq4yaXI4f/SVp6flkL+e
         MUFr8LdBari+Ig036YI4Hq83c5hmfUGZoLtXb3P2kvkgdyi+f132IV8Ci/c9QnPKnrFC
         QTiFkcVn8WpLZV0/xbD4SyhXu+ltOEWK6gsGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688095052; x=1690687052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZoSuQHQ27DM/d6b7OOglRkF4w/BysG+jSVaxzCus5g=;
        b=DIjx8BT8Tv9OaHNvs+cKkEoWUUj6baFFroOdGiZkzn73e/Z1bWOasYuzEA7r43Zm1h
         Q3npafVgCcbxyY9X83/xobjRybUvNQDhTHvA7C8G+UxYXbnhIeQMjiO0jTFPzOdU9SqO
         f2exJWcfczGRmttf3SUsuq69d4C2H0v77K7W/o6v1yVQp6qEo/mdLrSM0BcaKMNoP1js
         vhF6RfinMBjvtHe6pOKrgNQoSWbC9Fk2r5Kyrx315tjNN76s03LOk3RS3965xUyfW2ht
         terwyzrndlTYISAbFF6JlmkKNZKoWLh9nKRd+ZM+ePzspftKpNTC2ImYut1DD6swLlL1
         s1wA==
X-Gm-Message-State: AC+VfDxbzD7+yCErNn0uIlr873IWf4qRf8Sx/YaU5w1PM870T7OKLdsh
        2WBVZM0ZdK0HxCXkd71nuWexBw==
X-Google-Smtp-Source: ACHHUZ5ieji9f9FFgUwk0QNqn8Z7w6bi8Vxc4p96KvUt1caQq7AD4bSuKudaVKFZdPoLr4vL1DK+jw==
X-Received: by 2002:a05:6808:d4e:b0:3a3:7e8d:b0b with SMTP id w14-20020a0568080d4e00b003a37e8d0b0bmr1648172oik.22.1688095052740;
        Thu, 29 Jun 2023 20:17:32 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id y12-20020a655b4c000000b0055adf339c35sm6407088pgr.31.2023.06.29.20.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 20:17:32 -0700 (PDT)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, asmadeus@codewreck.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 2/2] selftests/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
Date:   Fri, 30 Jun 2023 03:17:20 +0000
Message-ID: <20230630031721.623955-3-jeffxu@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230630031721.623955-1-jeffxu@google.com>
References: <20230630031721.623955-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

Add selftest for sysctl vm.memfd_noexec is 2
(MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED)

memfd_create(.., MFD_EXEC) should fail in this case.

Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index dba0e8ba002f..dbdd9ec5e397 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -1147,6 +1147,11 @@ static void test_sysctl_child(void)
 	sysctl_assert_write("2");
 	mfd_fail_new("kern_memfd_sysctl_2",
 		MFD_CLOEXEC | MFD_ALLOW_SEALING);
+	mfd_fail_new("kern_memfd_sysctl_2_MFD_EXEC",
+		MFD_CLOEXEC | MFD_EXEC);
+	fd = mfd_assert_new("", 0, MFD_NOEXEC_SEAL);
+	close(fd);
+
 	sysctl_fail_write("0");
 	sysctl_fail_write("1");
 }
-- 
2.41.0.255.g8b1d071c50-goog

