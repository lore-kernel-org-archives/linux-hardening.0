Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DCFEB64DA
	for <linux-hardening@archiver.kernel.org>; Fri,  7 Jul 2023 21:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjGGVK2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 7 Jul 2023 17:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjGGVKT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 7 Jul 2023 17:10:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D332700
        for <linux-hardening@vger.kernel.org>; Fri,  7 Jul 2023 14:10:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-577323ba3d5so50920427b3.0
        for <linux-hardening@vger.kernel.org>; Fri, 07 Jul 2023 14:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688764208; x=1691356208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OCdYM+laUObv12QZRXNdyVrCp7VSyxqP7z9SYrIpXU4=;
        b=C/48yVJ/nm+zWtoBMLXZov8rRtY6Dd85sMEM1zZkoGRnXkmj1f6P/U44LGP6EGYupB
         WgcYdWylvSC9ii73E/WJW3Kjv1jy3av9qdSG1IYQpmNTodvJABuoVo2Lm9ingiBVUwz5
         mEGzz/H4uZLdI3jZ0B95NmYlheKDTEAtqgNNyCto+EMQRiv4nZvES74zlTFmSTm97Ea5
         R3dDO8FIL1zFvSspQd1Lhwn14HQLlHfHMnW9RjQIyWlLv8Wgf9pqPRsJiit+RLkhITS/
         X+BzBxAKK/nLe2f/koHvgoD6d6oBQwgo3pjFP8wYy0y7noDPVwXptPBO+RU3mM6SF+Uj
         ssWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688764208; x=1691356208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCdYM+laUObv12QZRXNdyVrCp7VSyxqP7z9SYrIpXU4=;
        b=Gm5OuHtYc+dCBOmj6BaLwj+flcxe4y8xrVJuy8OyC/GnGERkifDAtGU69Nqe+QO8xZ
         laK7+AhAN8LtX1OabQfCpa3jOmoppNs3nn1EJolZpH4v3Dm+35gVeAPRbW6Biq5A+tOL
         n59uFoVtTmu48r5RawbmFcBND5C0ocsPAGqB4NA4z/sN7f6SBaG/YJKwFiv4PUw8em4a
         LXgZSCYQTzKBFctj1uYsZ0Rv5HEyTLR1Wbpw33oOZ6Bvy6EeUVPQxVlEXWKJshEaBk3X
         0kR0S5uNiQ1EBynHRg8h0TJ4ue4QqPLAQOQZvYBDxQWXf5ogRNtM8hK+HQDSNlDzuyu/
         Otjw==
X-Gm-Message-State: ABy/qLYG69SDT2JmRnAOsnthzmDFZLomR6gvLwU83MDdeWG5HyfoYyZx
        Eo/jc4GefGvxjV/vJ2SxcwTRZoh7Kg==
X-Google-Smtp-Source: APBJJlEs5OZxQPiNeSdA/0xabXaPbo1L+lfKhNCS4popcodYKFWq9jpcdFvx+Q/T4vdhuAAyqQI4Dj44Rg==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:ef0f:0:b0:56c:f903:8678 with SMTP id
 o15-20020a81ef0f000000b0056cf9038678mr79465ywm.2.1688764207805; Fri, 07 Jul
 2023 14:10:07 -0700 (PDT)
Date:   Fri,  7 Jul 2023 21:09:46 +0000
In-Reply-To: <20230707210947.1208717-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230707210947.1208717-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707210947.1208717-9-rmoar@google.com>
Subject: [RFC v2 8/9] kunit: add tests for filtering attributes
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

Add four tests to executor_test.c to test behavior of filtering attributes.

- parse_filter_attr_test - to test the parsing of inputted filters

- filter_attr_test - to test the filtering procedure on attributes

- filter_attr_empty_test - to test the behavior when all tests are filtered
  out

- filter_attr_skip_test - to test the configurable filter_skip option

Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes since v1:
- This is a new patch

 lib/kunit/executor_test.c | 107 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index d7ab069324b5..145a78ade33d 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include <kunit/attributes.h>
 
 static void kfree_at_end(struct kunit *test, const void *to_free);
 static struct kunit_suite *alloc_fake_suite(struct kunit *test,
@@ -22,6 +23,14 @@ static struct kunit_case dummy_test_cases[] = {
 	{},
 };
 
+static struct kunit_case dummy_attr_test_cases[] = {
+	/* .run_case is not important, just needs to be non-NULL */
+	{ .name = "test1", .run_case = dummy_test, .module_name = "dummy",
+	  .attr.speed = KUNIT_SPEED_SLOW },
+	{ .name = "test2", .run_case = dummy_test, .module_name = "dummy" },
+	{},
+};
+
 static void parse_filter_test(struct kunit *test)
 {
 	struct kunit_glob_filter filter = {NULL, NULL};
@@ -108,11 +117,109 @@ static void filter_suites_to_empty_test(struct kunit *test)
 				"should be empty to indicate no match");
 }
 
+static void parse_filter_attr_test(struct kunit *test)
+{
+	int j, filter_count;
+	struct kunit_attr_filter *parsed_filters;
+	char *filters = "speed>slow, module!=example";
+	int err = 0;
+
+	filter_count = kunit_get_filter_count(filters);
+	KUNIT_EXPECT_EQ(test, filter_count, 2);
+
+	parsed_filters = kcalloc(filter_count + 1, sizeof(*parsed_filters), GFP_KERNEL);
+	for (j = 0; j < filter_count; j++)
+		parsed_filters[j] = kunit_next_attr_filter(&filters, &err);
+
+	KUNIT_EXPECT_STREQ(test, kunit_attr_filter_name(parsed_filters[0]), "speed");
+	KUNIT_EXPECT_STREQ(test, parsed_filters[0].input, ">slow");
+
+	KUNIT_EXPECT_STREQ(test, kunit_attr_filter_name(parsed_filters[1]), "module");
+	KUNIT_EXPECT_STREQ(test, parsed_filters[1].input, "!=example");
+
+	kfree(parsed_filters);
+}
+
+static void filter_attr_test(struct kunit *test)
+{
+	struct kunit_suite *subsuite[3] = {NULL, NULL};
+	struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
+	struct suite_set got;
+	int err = 0;
+
+	subsuite[0] = alloc_fake_suite(test, "suite1", dummy_attr_test_cases);
+	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_attr_test_cases);
+	subsuite[1]->attr.speed = KUNIT_SPEED_SLOW; // Set suite attribute
+
+	/* Want: suite1(test1, test2), suite2(test1, test2), NULL -> suite1(test2), NULL */
+	got = kunit_filter_suites(&suite_set, NULL, "speed>slow", NULL, &err);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	kfree_at_end(test, got.start);
+
+	/* Validate we just have suite1 */
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
+	KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->name, "suite1");
+	KUNIT_ASSERT_EQ(test, got.end - got.start, 1);
+
+	/* Now validate we just have test2 */
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
+	KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->test_cases[0].name, "test2");
+	KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].name);
+}
+
+static void filter_attr_empty_test(struct kunit *test)
+{
+	struct kunit_suite *subsuite[3] = {NULL, NULL};
+	struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
+	struct suite_set got;
+	int err = 0;
+
+	subsuite[0] = alloc_fake_suite(test, "suite1", dummy_attr_test_cases);
+	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_attr_test_cases);
+
+	got = kunit_filter_suites(&suite_set, NULL, "module!=dummy", NULL, &err);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	kfree_at_end(test, got.start); /* just in case */
+
+	KUNIT_EXPECT_PTR_EQ_MSG(test, got.start, got.end,
+				"should be empty to indicate no match");
+}
+
+static void filter_attr_skip_test(struct kunit *test)
+{
+	struct kunit_suite *subsuite[2] = {NULL};
+	struct suite_set suite_set = {.start = subsuite, .end = &subsuite[1]};
+	struct suite_set got;
+	int err = 0;
+
+	subsuite[0] = alloc_fake_suite(test, "suite1", dummy_attr_test_cases);
+
+	/* Want: suite1(test1, test2), NULL -> suite1(test1 with SKIP, test2), NULL */
+	got = kunit_filter_suites(&suite_set, NULL, "speed>slow", "skip", &err);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	kfree_at_end(test, got.start);
+
+	/* Validate we have both test1 and test2 */
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
+	KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->test_cases[0].name, "test1");
+	KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->test_cases[1].name, "test2");
+
+	/* Now ensure test1 is skipped and test2 is not */
+	KUNIT_EXPECT_EQ(test, got.start[0]->test_cases[0].status, KUNIT_SKIPPED);
+	KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].status);
+}
+
 static struct kunit_case executor_test_cases[] = {
 	KUNIT_CASE(parse_filter_test),
 	KUNIT_CASE(filter_suites_test),
 	KUNIT_CASE(filter_suites_test_glob_test),
 	KUNIT_CASE(filter_suites_to_empty_test),
+	KUNIT_CASE(parse_filter_attr_test),
+	KUNIT_CASE(filter_attr_test),
+	KUNIT_CASE(filter_attr_empty_test),
+	KUNIT_CASE(filter_attr_skip_test),
 	{}
 };
 
-- 
2.41.0.255.g8b1d071c50-goog

