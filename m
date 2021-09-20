Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7069C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Sep 2021 01:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86B9461168
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Sep 2021 01:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhIUBhP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 20 Sep 2021 21:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhIUBfA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 20 Sep 2021 21:35:00 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87035C03402F
        for <linux-hardening@vger.kernel.org>; Mon, 20 Sep 2021 11:08:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id me1so3936542pjb.4
        for <linux-hardening@vger.kernel.org>; Mon, 20 Sep 2021 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ghoO8vylrdI8hi6Tt30rRCJNGnXjoCjzQ+6Kg2uuqtk=;
        b=Mb/S0HS3nmZk/74q7Z77YZ+J8jlDOkyRESjhg0+WBGWdwYK47aKB7HsFRpZSB+aDnn
         YoKnxbcb2UdFBwEkYE+iUyi99i+5SqrOay4/tEzkCeP19IZj2YcTSUst0GPRvad/+Nui
         hUciPCLK78KvOR/dLI7Py4VuKg3s3XCwcs960=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ghoO8vylrdI8hi6Tt30rRCJNGnXjoCjzQ+6Kg2uuqtk=;
        b=GvcnGzaG26sYL/FDU5YUg02d6stNNQuzNIZ2gYMOdc1E2ERnmQFZrWJ8YeTIjGJMjW
         DyO5CFKi3ccfddujKvYjbatHuq9xA1EqkE2e8BSlxRjn8n3k4x5WHsgigcA7+tXFY3aE
         Jcm/jgwc9ptN818kpVAyr4wcV/ucJ0YUM7OoZtdsqxb2Sy4R3vV+xZnxs2kxfhsdn8Zx
         a88L6l984hwNurfYf5Ss98QFAQXKXJdkCIkYb5cLi69B/sWIE3zcLByCVqGkivK5Ci/7
         808BuqSFxsimehAkJ7BZ+chywO9q/1WE7YffybZv1G1XthwQggAP9AA7v+cRYInSnNsp
         aSXA==
X-Gm-Message-State: AOAM531j70jTKq8SKTRV+RZ5U3ZzVfHAOTT1g/eQIJbSbmYeBQFff5+G
        BfyLiGeDarOsYrNkSFZfxdsF/Q==
X-Google-Smtp-Source: ABdhPJxxNE9E0ONnMG7IKmLV3vOgEPcmq68f2gc8ALCv0/GbLpIdnN9VP01X374pPq3Fyw90oaGLEw==
X-Received: by 2002:a17:902:7144:b0:13c:9821:75cb with SMTP id u4-20020a170902714400b0013c982175cbmr23915047plm.33.1632161337116;
        Mon, 20 Sep 2021 11:08:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 141sm16720868pgf.46.2021.09.20.11.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:08:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Leon Romanovsky <leon@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Len Baker <len.baker@gmx.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 2/2] test_overflow: Regularize test reporting output
Date:   Mon, 20 Sep 2021 11:08:53 -0700
Message-Id: <20210920180853.1825195-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920180853.1825195-1-keescook@chromium.org>
References: <20210920180853.1825195-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5283; h=from:subject; bh=ngvKd0VV85H03jehfbaSVhjFlezpvhhQZYYqP8+XnJI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhSM40EEDAZt7CSShMBrgESBuI4VDuu8KznCLXKNBF goT3bNuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYUjONAAKCRCJcvTf3G3AJvLSEA CFFg0tEU3pFeHEdgWciKQj6HTHc7OvzAda2N6R9ilIOY9UeRdMsrPgiggtN80z4Thgs6DZF8p4OES8 lW7G8Dah0PTRgp/9zpuT39cbqdOJmWsydNMuEIWNcBS8SZdLc62mDWco1e+gG6a8/uua6lyeuJOBiI sX4/9kAqgoT69k3NgjmqX7rS/9/ERWoimcggooy5Y5emcKKAZipjoyHzCsFngP3rgX5DfuI/Dw72U0 T6W0+sPU2eDwvtE52V6OM2NtexEp99HPPU5WlTAuIsTe5xPPxDhRF1qmraXA5MfWpVzqLk9WdeZ4eg /mRoryGB0ZxQOF3fmBsB46O2Atdm2iBqpxyiYla+jK6p4pXM3tAsDmpaNYcNKrseqbUM7pVHp6gyMX FGuWDaomvu/ac3QiEXi/FdnGj6bsdm5AzjmRZU+dC1TAxWkbWTMh4mDEwHhQEUXINbIHTlIj29+9Vd CErLkZgOMK9DaoxUVMI8vIQmBqeROZKll62SAUlXMQbJwqNY7CNBOUZoeClCJ7NuLRkwBX5Yaph7rk N6tScoWL58ZO+hl6IsEnG8/a6vyYi/agmtJXYhm1Gl7JHhQ1WEqYHh2h3vWD4PvoSDrF+Q3qniNiOm OeAZ84fVoGQmvfawT3VfG+BtOSHjZyxkVmSQ6HXl5SDCPm2W2yRdTE1ZkKIQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Report test run summaries more regularly, so it's easier to understand
the output:
- Remove noisy "ok" reports for shift and allocator tests.
- Reorganize per-type output to the end of each type's tests.
- Replace redundant vmalloc tests with __vmalloc so that __GFP_NO_WARN
  can be used to keep the expected failure warnings out of dmesg,
  similar to commit 8e060c21ae2c ("lib/test_overflow.c: avoid tainting
  the kernel and fix wrap size")

Resulting output:

  test_overflow: 18 u8 arithmetic tests finished
  test_overflow: 19 s8 arithmetic tests finished
  test_overflow: 17 u16 arithmetic tests finished
  test_overflow: 17 s16 arithmetic tests finished
  test_overflow: 17 u32 arithmetic tests finished
  test_overflow: 17 s32 arithmetic tests finished
  test_overflow: 17 u64 arithmetic tests finished
  test_overflow: 21 s64 arithmetic tests finished
  test_overflow: 113 shift tests finished
  test_overflow: 17 overflow size helper tests finished
  test_overflow: 11 allocation overflow tests finished
  test_overflow: all tests passed

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/test_overflow.c | 50 +++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/lib/test_overflow.c b/lib/test_overflow.c
index 01a469ff7ff6..e1fd2d72dc61 100644
--- a/lib/test_overflow.c
+++ b/lib/test_overflow.c
@@ -252,10 +252,10 @@ static int __init test_ ## t ## _overflow(void) {			\
 	int err = 0;							\
 	unsigned i;							\
 									\
-	pr_info("%-3s: %zu arithmetic tests\n", #t,			\
-		ARRAY_SIZE(t ## _tests));				\
 	for (i = 0; i < ARRAY_SIZE(t ## _tests); ++i)			\
 		err |= do_test_ ## t(&t ## _tests[i]);			\
+	pr_info("%zu %s arithmetic tests finished\n",			\
+		ARRAY_SIZE(t ## _tests), #t);				\
 	return err;							\
 }
 
@@ -291,6 +291,7 @@ static int __init test_overflow_calculation(void)
 static int __init test_overflow_shift(void)
 {
 	int err = 0;
+	int count = 0;
 
 /* Args are: value, shift, type, expected result, overflow expected */
 #define TEST_ONE_SHIFT(a, s, t, expect, of) ({				\
@@ -313,9 +314,7 @@ static int __init test_overflow_shift(void)
 			pr_warn("got %llu\n", (u64)__d);		\
 		__failed = 1;						\
 	}								\
-	if (!__failed)							\
-		pr_info("ok: (%s)(%s << %s) == %s\n", #t, #a, #s,	\
-			of ? "overflow" : #expect);			\
+	count++;							\
 	__failed;							\
 })
 
@@ -479,6 +478,8 @@ static int __init test_overflow_shift(void)
 	err |= TEST_ONE_SHIFT(0, 31, s32, 0, false);
 	err |= TEST_ONE_SHIFT(0, 63, s64, 0, false);
 
+	pr_info("%d shift tests finished\n", count);
+
 	return err;
 }
 
@@ -530,7 +531,6 @@ static int __init test_ ## func (void *arg)				\
 		free ## want_arg (free_func, arg, ptr);			\
 		return 1;						\
 	}								\
-	pr_info(#func " detected saturation\n");			\
 	return 0;							\
 }
 
@@ -544,10 +544,7 @@ DEFINE_TEST_ALLOC(kmalloc,	 kfree,	     0, 1, 0);
 DEFINE_TEST_ALLOC(kmalloc_node,	 kfree,	     0, 1, 1);
 DEFINE_TEST_ALLOC(kzalloc,	 kfree,	     0, 1, 0);
 DEFINE_TEST_ALLOC(kzalloc_node,  kfree,	     0, 1, 1);
-DEFINE_TEST_ALLOC(vmalloc,	 vfree,	     0, 0, 0);
-DEFINE_TEST_ALLOC(vmalloc_node,  vfree,	     0, 0, 1);
-DEFINE_TEST_ALLOC(vzalloc,	 vfree,	     0, 0, 0);
-DEFINE_TEST_ALLOC(vzalloc_node,  vfree,	     0, 0, 1);
+DEFINE_TEST_ALLOC(__vmalloc,	 vfree,	     0, 1, 0);
 DEFINE_TEST_ALLOC(kvmalloc,	 kvfree,     0, 1, 0);
 DEFINE_TEST_ALLOC(kvmalloc_node, kvfree,     0, 1, 1);
 DEFINE_TEST_ALLOC(kvzalloc,	 kvfree,     0, 1, 0);
@@ -559,8 +556,14 @@ static int __init test_overflow_allocation(void)
 {
 	const char device_name[] = "overflow-test";
 	struct device *dev;
+	int count = 0;
 	int err = 0;
 
+#define check_allocation_overflow(alloc)	({	\
+	count++;					\
+	test_ ## alloc(dev);				\
+})
+
 	/* Create dummy device for devm_kmalloc()-family tests. */
 	dev = root_device_register(device_name);
 	if (IS_ERR(dev)) {
@@ -568,23 +571,22 @@ static int __init test_overflow_allocation(void)
 		return 1;
 	}
 
-	err |= test_kmalloc(NULL);
-	err |= test_kmalloc_node(NULL);
-	err |= test_kzalloc(NULL);
-	err |= test_kzalloc_node(NULL);
-	err |= test_kvmalloc(NULL);
-	err |= test_kvmalloc_node(NULL);
-	err |= test_kvzalloc(NULL);
-	err |= test_kvzalloc_node(NULL);
-	err |= test_vmalloc(NULL);
-	err |= test_vmalloc_node(NULL);
-	err |= test_vzalloc(NULL);
-	err |= test_vzalloc_node(NULL);
-	err |= test_devm_kmalloc(dev);
-	err |= test_devm_kzalloc(dev);
+	err |= check_allocation_overflow(kmalloc);
+	err |= check_allocation_overflow(kmalloc_node);
+	err |= check_allocation_overflow(kzalloc);
+	err |= check_allocation_overflow(kzalloc_node);
+	err |= check_allocation_overflow(__vmalloc);
+	err |= check_allocation_overflow(kvmalloc);
+	err |= check_allocation_overflow(kvmalloc_node);
+	err |= check_allocation_overflow(kvzalloc);
+	err |= check_allocation_overflow(kvzalloc_node);
+	err |= check_allocation_overflow(devm_kmalloc);
+	err |= check_allocation_overflow(devm_kzalloc);
 
 	device_unregister(dev);
 
+	pr_info("%d allocation overflow tests finished\n", count);
+
 	return err;
 }
 
-- 
2.30.2

