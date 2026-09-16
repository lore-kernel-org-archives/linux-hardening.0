Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACEF4BD35E;
	Wed, 16 Sep 2026 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580320; cv=none; b=rW5PuxBAv4hm4hjvEbB2+CVkesg0DJtf9KV6yPtYLCx47rBTR9GU2yC0rPCU3VJ+bagUDzW2GcqJs+9+eqUzGk2gwhSZaq/iMf4PiftyptYZ8pFiC5Em3v14OV34Cl0F0VnwfsU915pXLpPU/bEO/lT16LFWfLbVCyMfXE0KBIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580320; c=relaxed/simple;
	bh=Tmo6w2TfPA14tRt2/cUWegDWuBIQPArxHc2/r1qjpT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IB3zKITIIHi4X5nX9VOzKyK11nOjY3zDDJSSHwS7ULs35KIbwsjfi8MaivpNilr4du4rSdu83jQLR80bue/MvkskJKkkOyQw1CqGFBKcgh0GF4w13ymj2zu97d+iofjq9YyzMkk1QwalGXokeZJgM2aaCQdsHpD/tpRJLhfAYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
X-PTX-Original-Recipient: jre@pengutronix.de
X-PTX-Original-Recipient: kernel@pengutronix.de
X-PTX-Original-Recipient: akpm@linux-foundation.org
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-PTX-Original-Recipient: linux-hardening@vger.kernel.org
X-PTX-Original-Recipient: andy@kernel.org
X-PTX-Original-Recipient: kees@kernel.org
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 212A3200A7A;
	Wed, 16 Sep 2026 19:38:15 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x6taJ-001Go9-0A;
	Wed, 16 Sep 2026 19:38:15 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 16 Sep 2026 19:38:06 +0200
Subject: [PATCH 1/5] lib/tests: string_helpers: check null terminator too
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-string_unescape-v1-1-7f8bd986fa33@pengutronix.de>
References: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
In-Reply-To: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
To: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1366; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=Tmo6w2TfPA14tRt2/cUWegDWuBIQPArxHc2/r1qjpT4=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshadYVlCr/hJynlkkRx3TDbxfqczgdsm8ssPnPd/Spwa
 crjO9PPdJSyMIhxMciKKbLEqskpCBn7XzertIuFmcPKBDKEgYtTACYirMHwz8qm8OhHj+P2n6Y+
 eykn9bzukk3eveLm2MlrIo6vzM7ZnMTI0NkSk1+kUX1+5vzX76KcumrmacWXzGW74GG/XGPhvdu
 h/AA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

string_unescape() returns the number of character written to dst, not
counting the null terminator which is always written.

Ensure string_unescape has included the null terminator by adding a
separate check.

While at it, improve output for failed tests by showing the memory dump
even if the length differs.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 lib/tests/string_helpers_kunit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/tests/string_helpers_kunit.c b/lib/tests/string_helpers_kunit.c
index 9fbe91079c7e..9bc3acffaf2f 100644
--- a/lib/tests/string_helpers_kunit.c
+++ b/lib/tests/string_helpers_kunit.c
@@ -22,7 +22,7 @@ static void test_string_check_buf(struct kunit *test,
 				  char *out_real, size_t q_real,
 				  char *out_test, size_t q_test)
 {
-	KUNIT_ASSERT_EQ_MSG(test, q_real, q_test, "name:%s", name);
+	KUNIT_EXPECT_EQ_MSG(test, q_real, q_test, "name:%s", name);
 	KUNIT_EXPECT_MEMEQ_MSG(test, out_test, out_real, q_test,
 			       "name:%s", name);
 }
@@ -103,6 +103,7 @@ static void test_string_unescape(struct kunit *test,
 
 	test_string_check_buf(test, name, flags, in, p - 1, out_real, q_real,
 			      out_test, q_test);
+	KUNIT_EXPECT_EQ_MSG(test, out_real[q_real], '\0', "name:%s", name);
 }
 
 struct test_string_1 {

-- 
2.56.0.rc0.108.gf0ef1b96a0

