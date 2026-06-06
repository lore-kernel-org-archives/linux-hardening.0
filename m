Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524203C13EC
	for <linux-hardening@vger.kernel.org>; Sat,  6 Jun 2026 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777647; cv=none; b=GNcCExxpDctLjy9bvp4Y7Y3E/pfTJiLH14fgEvpY+AHYLvYevvsN1buzb0r5m+uFDz1Y/RqzTJRWqy078De/rnQbd/iBBBAj9JxZlHFHZ03n0uGXvXAL66ie1voKhuoly3KbBSnjRZ/mPa9Vi6rJGuoaqBtQVNwrQTuCLL8uGwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777647; c=relaxed/simple;
	bh=Z8BhDAA/5J1h7pKvkQWkO78M1jmQ+SppQVyUT60dv7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fpnmgdJ6skGfmcdqXMUTLAD2r5hcKHQLcDYlaFVGawB1AxE2Jg4m7dTONh2FnwImxJlaYcC1ud5JJJGBC14gmfSzcLqBSgtqIuBC8/b9PID+DHj+W6CUKwdqAZSK1LHE4u4JUVvDK1II7zLOpWHWpcds9wrP3nfAQPzug4J2v4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=avS67snj; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="avS67snj"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbs-007NQX-Iu; Sat, 06 Jun 2026 22:27:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=tVrxHagyiN7+Sk4EZn18sJM4wcXexSjb7mWF03ybYZg=; b=avS67s
	nj63m5fSykrYbvM1t91XuG7HHhXHfPqs8n+sQxPQR2NE631xpPX5xf0iAeRjRrbUZtUcl6TGVia/U
	pax+SIBUOZkfS6jzTrQB5rmN9zz07x7FVcdFIj91hpVGQo1x0tEhvhIBnXksT6PTu4stbSwYwffyr
	6VaC1h7XxT/5MwPehI3oWhSBsZTtgOaH2B1ZapyTlhP2u/aRZfZqKNonwmxYBhUoDJ/hd+g/O5dGp
	Vy+/mJfmDTn4gaiNxvz6D16EsrEEWx0gQXiDXL82V/PHXR5oy4x1Ry+xZLDMW5p3xRBocvqeDLOaQ
	CEUNJOIbBsB2yAA4N3MzgzwGzneQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbs-0000tU-6q; Sat, 06 Jun 2026 22:27:12 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbn-006V18-IP;
	Sat, 06 Jun 2026 22:27:07 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/clk/clk_test: Use strscpy() to copy the test description
Date: Sat,  6 Jun 2026 21:26:29 +0100
Message-Id: <20260606202633.5018-35-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

The buffer length is known to be KUNIT_PARAM_DESC_SIZE

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 drivers/clk/clk_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index b1961daac5e2..1d8cf902d3a0 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -2232,7 +2232,7 @@ static void
 clk_leaf_mux_set_rate_parent_determine_rate_test_case_to_desc(
 		const struct clk_leaf_mux_set_rate_parent_determine_rate_test_case *t, char *desc)
 {
-	strcpy(desc, t->desc);
+	strscpy(desc, t->desc, KUNIT_PARAM_DESC_SIZE);
 }
 
 static const struct clk_leaf_mux_set_rate_parent_determine_rate_test_case
@@ -2644,7 +2644,7 @@ static void
 clk_register_clk_parent_data_test_case_to_desc(
 		const struct clk_register_clk_parent_data_test_case *t, char *desc)
 {
-	strcpy(desc, t->desc);
+	strscpy(desc, t->desc, KUNIT_PARAM_DESC_SIZE);
 }
 
 static const struct clk_register_clk_parent_data_test_case
-- 
2.39.5

