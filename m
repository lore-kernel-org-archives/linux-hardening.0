Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20EFC04A95
	for <linux-hardening@archiver.kernel.org>; Thu, 29 Sep 2022 03:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbiI2DI5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 28 Sep 2022 23:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbiI2DIy (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 28 Sep 2022 23:08:54 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC6C12647B
        for <linux-hardening@vger.kernel.org>; Wed, 28 Sep 2022 20:08:51 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id e68so287035pfe.1
        for <linux-hardening@vger.kernel.org>; Wed, 28 Sep 2022 20:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=8yca42gpvOWRcNPhSb40oWPuRcE31ugOvkjTdRn+Mq8=;
        b=O5spaRHmvJKFtZyyd1opgOtyv+QcTqB+xpgqHPIoZC5m/aw/TiHHfYyJce/aKbhLPr
         9fvxHE+fhFyGGb5/bnz7OrMldWA6HwVpAv9qAjFRLYse26d0+L0HEjX8RhvsWesKJYMJ
         38hx+6o9PQtUs/wyW1fET8S4UrLIa0TzXzHk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=8yca42gpvOWRcNPhSb40oWPuRcE31ugOvkjTdRn+Mq8=;
        b=uidzf3PNwIh+/qwmJhhZLAoRkMdDY0R8VOHvu6jShU+l/Rf6W+9a8WWwBVI7t29sdN
         Wo4mTeEdVLp4cJb7CugaEv21MkPxfortrFaHGOT5QMcsQrRzlAkqg9ANMQ0zpG8xgSLe
         k2YydyRSS8G0QW3jbdl8dNqCAOnukrpRDLJ1ljuvlakUv3KaOR8E16wCDMKN4odTX1yG
         3cjhw7cx85ufXaekqmn+FWFnxipa0w+9bhvBIY33E13xWpmZJgm2Y2/vcweGP9qJH6nO
         qp9e1q/CYlk7pY12Ja2JR6JAgACnQSMfoDW42fE6eQAtsbq+JYXLvQr1phVcWrfUrAr3
         CCmQ==
X-Gm-Message-State: ACrzQf23m+oo8odRgyADUVDNXRIC/lpn7pQyWhT1LtcpGGeUlbP1gzSU
        rgON5DTcG9n7mm1Im5aQ21CPEQ==
X-Google-Smtp-Source: AMsMyM4Lc6UXUZ1W8tsbIOm2T3omQShHPzi6AAT4My9wC2ffV4AvV6ZPaTYe16xPoJZY3r2rtfINFw==
X-Received: by 2002:a05:6a00:2385:b0:544:c42d:8a72 with SMTP id f5-20020a056a00238500b00544c42d8a72mr1308578pfc.84.1664420930186;
        Wed, 28 Sep 2022 20:08:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b001783a917b9asm4280054plk.127.2022.09.28.20.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 20:08:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] kunit/memcpy: Adding dynamic size and window tests
Date:   Wed, 28 Sep 2022 20:08:46 -0700
Message-Id: <20220929030846.1060818-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7487; h=from:subject; bh=Pye2ul4IL81wuXiXNLB1/uzjad7esLmZJ2BsfjKW3o0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjNQw++oNYNS5NFICpGKQhObIvZOVxSkpej8HGlQTN FdlUNd2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYzUMPgAKCRCJcvTf3G3AJj0xD/ 4hAQLxTamEXjxsg4LTJ2limFqp/OLrPW/4ZSOl59PaKRGo3kZ5TNcvgv6QH8klIzQD73wnDuk8KpE+ 28zpLs+CwC8d4778UZ0/SjuZS1JZfB0qEUBmFS7IQ1/k38Y/pgxQ2StdfDFFCrcmQuoySESNOwPrXH Tw3Mi6bPPhN7rFYlY2AIvjc3YrtMnQShXz+5q4L6WaX3UiiyJkPs59L42lOKtSCNEM7F6T+67Zz8mB TUO9zfv3L2OZazwNUub89EIKkfUgHaM4+dtN8w87O1DfMDoJQ1gH+iuG7lj2wAdmkcQLAsd10FQKTG M/9dv3dJlef/tbzzrOypy30rZs277kwbf56mU4TQzSOep0FXlz8+1dFVRG71QJBX/hRe94QSlrJKFA YJQUqtLvOdAj3QpJS0dcb8tmQMkit9h6z260V0gNIsZCUOqT8FqUIkp7rzDYdV15EnmX4u26QRkZYY C433MIwCiVmYo3RkAEuZ6p85wyQf7aRIt+6sZRd2PYSlfdZb5GMyeh3Pws+MgnK6qeAXR/bTdikTSK Y3/sTXfX/zZVYeco+S67RMflhlhwplABF1Ko93JgNo2t2k7XjQff1L7pnTt26D64j/117SZ1F+HVpm x7ud6GrAI1SmUTgUjFcU/oeoOXpVqYmh3QIv6M1S7xLL54q3KJStTl9vrU9w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The "side effects" memmove() test accidentally found a corner case in
the recent refactoring of the i386 assembly memmove(), but missed
another corner case. Instead of hoping to get lucky next time, implement
much more complete tests of memcpy() and memmove() -- especially the
moving window overlap for memmove() -- which catches all the issues
encountered and should catch anything new.

Cc: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/lkml/CAKwvOdkaKTa2aiA90VzFrChNQM6O_ro+b7VWs=op70jx-DKaXA@mail.gmail.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/memcpy_kunit.c | 187 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 187 insertions(+)

diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
index 2b5cc70ac53f..f15daa66c6a6 100644
--- a/lib/memcpy_kunit.c
+++ b/lib/memcpy_kunit.c
@@ -270,6 +270,190 @@ static void memset_test(struct kunit *test)
 #undef TEST_OP
 }
 
+static u8 large_src[1024];
+static u8 large_dst[2048];
+static const u8 large_zero[2048];
+
+static void init_large(struct kunit *test)
+{
+	int failed_rng = 0;
+
+	/* Get many bit patterns. */
+	get_random_bytes(large_src, sizeof(large_src));
+
+	/* Make sure we have non-zero edges. */
+	while (large_src[0] == 0) {
+		get_random_bytes(large_src, 1);
+		KUNIT_ASSERT_LT_MSG(test, failed_rng++, 100,
+				    "Is the RNG broken?");
+	}
+	while (large_src[sizeof(large_src) - 1] == 0) {
+		get_random_bytes(&large_src[sizeof(large_src) - 1], 1);
+		KUNIT_ASSERT_LT_MSG(test, failed_rng++, 100,
+				    "Is the RNG broken?");
+	}
+
+	/* Explicitly zero the entire destination. */
+	memset(large_dst, 0, sizeof(large_dst));
+}
+
+/*
+ * Instead of an indirect function call for "copy" or a giant macro,
+ * use a bool to pick memcpy or memmove.
+ */
+static void copy_large_test(struct kunit *test, bool use_memmove)
+{
+	init_large(test);
+
+	/* Copy a growing number of non-overlapping bytes ... */
+	for (int bytes = 1; bytes <= sizeof(large_src); bytes++) {
+		/* Over a shifting destination window ... */
+		for (int offset = 0; offset < sizeof(large_src); offset++) {
+			int right_zero_pos = offset + bytes;
+			int right_zero_size = sizeof(large_dst) - right_zero_pos;
+
+			/* Copy! */
+			if (use_memmove)
+				memmove(large_dst + offset, large_src, bytes);
+			else
+				memcpy(large_dst + offset, large_src, bytes);
+
+			/* Did we touch anything before the copy area? */
+			KUNIT_ASSERT_EQ_MSG(test, memcmp(large_dst, large_zero, offset), 0,
+					    "with size %d at offset %d", bytes, offset);
+			/* Did we touch anything after the copy area? */
+			KUNIT_ASSERT_EQ_MSG(test, memcmp(&large_dst[right_zero_pos], large_zero, right_zero_size), 0,
+					    "with size %d at offset %d", bytes, offset);
+
+			/* Are we byte-for-byte exact across the copy? */
+			KUNIT_ASSERT_EQ_MSG(test, memcmp(large_dst + offset, large_src, bytes), 0,
+					    "with size %d at offset %d", bytes, offset);
+
+			/* Zero out what we copied for the next cycle. */
+			memset(large_dst + offset, 0, bytes);
+		}
+		/* Avoid stall warnings. */
+		cond_resched();
+	}
+}
+
+static void memcpy_large_test(struct kunit *test)
+{
+	copy_large_test(test, false);
+}
+
+static void memmove_large_test(struct kunit *test)
+{
+	copy_large_test(test, true);
+}
+
+/*
+ * Take a single step if within "inc" of the start or end,
+ * otherwise, take a full "inc" steps.
+ */
+static inline int next_step(int idx, int start, int end, int inc)
+{
+	start += inc;
+	end -= inc;
+
+	if (idx < start || idx + inc > end)
+		inc = 1;
+	return idx + inc;
+}
+
+static void memmove_overlap_test(struct kunit *test)
+{
+	/*
+	 * Running all possible offset and overlap combinations takes a
+	 * very long time. Instead, only check up to 128 bytes offset
+	 * into the destintation buffer (which should result in crossing
+	 * cachelines), with a step size of 1 through 7 to try to skip some
+	 * redundancy.
+	 */
+	static const int offset_max = 128; /* sizeof(large_src); */
+	static const int bytes_step = 7;
+	static const int window_step = 7;
+
+	static const int bytes_start = 1;
+	static const int bytes_end = sizeof(large_src) + 1;
+
+	init_large(test);
+
+	/* Copy a growing number of overlapping bytes ... */
+	for (int bytes = bytes_start; bytes < bytes_end;
+	     bytes = next_step(bytes, bytes_start, bytes_end, bytes_step)) {
+
+		/* Over a shifting destination window ... */
+		for (int d_off = 0; d_off < offset_max; d_off++) {
+			int s_start = max(d_off - bytes, 0);
+			int s_end = min_t(int, d_off + bytes, sizeof(large_src));
+
+			/* Over a shifting source window ... */
+			for (int s_off = s_start; s_off < s_end;
+			     s_off = next_step(s_off, s_start, s_end, window_step)) {
+				int left_zero_pos, left_zero_size;
+				int right_zero_pos, right_zero_size;
+				int src_pos, src_orig_pos, src_size;
+				int pos;
+
+				/* Place the source in the destination buffer. */
+				memcpy(&large_dst[s_off], large_src, bytes);
+
+				/* Copy to destination offset. */
+				memmove(&large_dst[d_off], &large_dst[s_off], bytes);
+
+				/* Make sure destination entirely matches. */
+				KUNIT_ASSERT_EQ_MSG(test, memcmp(&large_dst[d_off], large_src, bytes), 0,
+					"with size %d at src offset %d and dest offset %d",
+					bytes, s_off, d_off);
+
+				/* Calculate the expected zero spans. */
+				if (s_off < d_off) {
+					left_zero_pos = 0;
+					left_zero_size = s_off;
+
+					right_zero_pos = d_off + bytes;
+					right_zero_size = sizeof(large_dst) - right_zero_pos;
+
+					src_pos = s_off;
+					src_orig_pos = 0;
+					src_size = d_off - s_off;
+				} else {
+					left_zero_pos = 0;
+					left_zero_size = d_off;
+
+					right_zero_pos = s_off + bytes;
+					right_zero_size = sizeof(large_dst) - right_zero_pos;
+
+					src_pos = d_off + bytes;
+					src_orig_pos = src_pos - s_off;
+					src_size = right_zero_pos - src_pos;
+				}
+
+				/* Check non-overlapping source is unchanged.*/
+				KUNIT_ASSERT_EQ_MSG(test, memcmp(&large_dst[src_pos], &large_src[src_orig_pos], src_size), 0,
+					"with size %d at src offset %d and dest offset %d",
+					bytes, s_off, d_off);
+
+				/* Check leading buffer contents are zero. */
+				KUNIT_ASSERT_EQ_MSG(test, memcmp(&large_dst[left_zero_pos], large_zero, left_zero_size), 0,
+					"with size %d at src offset %d and dest offset %d",
+					bytes, s_off, d_off);
+				/* Check trailing buffer contents are zero. */
+				KUNIT_ASSERT_EQ_MSG(test, memcmp(&large_dst[right_zero_pos], large_zero, right_zero_size), 0,
+					"with size %d at src offset %d and dest offset %d",
+					bytes, s_off, d_off);
+
+				/* Zero out everything not already zeroed.*/
+				pos = left_zero_pos + left_zero_size;
+				memset(&large_dst[pos], 0, right_zero_pos - pos);
+			}
+			/* Avoid stall warnings. */
+			cond_resched();
+		}
+	}
+}
+
 static void strtomem_test(struct kunit *test)
 {
 	static const char input[sizeof(unsigned long)] = "hi";
@@ -325,7 +509,10 @@ static void strtomem_test(struct kunit *test)
 static struct kunit_case memcpy_test_cases[] = {
 	KUNIT_CASE(memset_test),
 	KUNIT_CASE(memcpy_test),
+	KUNIT_CASE(memcpy_large_test),
 	KUNIT_CASE(memmove_test),
+	KUNIT_CASE(memmove_large_test),
+	KUNIT_CASE(memmove_overlap_test),
 	KUNIT_CASE(strtomem_test),
 	{}
 };
-- 
2.34.1

