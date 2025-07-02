Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8297246797
	for <linux-hardening@vger.kernel.org>; Wed,  2 Jul 2025 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449976; cv=none; b=qZE3VBEwK7dYGxuZr5X0rfjmA7rxzbi9GxdYR+LRLRBKt8D5amATJaZnfQhpWED4xmvoPsvJe+Og6QOfXpbE/I/VTe499qQmqfSE0BplJXeCiWt8f5UPQubHXfHf1HXGjxh8JTJlpqspeocmMvOuYL6UvuTGltKkh0fJL8e0moM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449976; c=relaxed/simple;
	bh=6pWPj9yJPA1F97NyK/mMakcPyrDtppLr0XwrcICNR0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/Xb3Zc4kaEQXSqhJRkGuZ4znDBOvA3uy8tDE5xWsKheTGbIDMP1TaM1E9bvC+IdAYK1zBMr4kDQX4KwzeG+TBXL/LU1B8q9cRunAb5vb+1uzLx+MduCIVFNfgMA56XB7kXK4AT8ZwL39wuKRJ63Uiv80uxnSa/UlW1pK4V5nBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nxQnPSzC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=B17rtKYb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nxQnPSzC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="B17rtKYb"
Received: from pathway.suse.cz (unknown [10.100.208.146])
	by smtp-out2.suse.de (Postfix) with ESMTP id 9A7AE1F454;
	Wed,  2 Jul 2025 09:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751449973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cGCtkuQDf7npqLhgpdL8AUxIksP8IpG+SBwNiySulak=;
	b=nxQnPSzCutIWWBuqIvM+lU33+l9SWhyEVKr3ykznNrZ6T7hOXneR7f3WuYca5DNxlnsdd1
	24o4yX+2dcIXqS1wo/8XuDpDAyKrSdY2YcdPFz3OQQ45mBDWsaZdJxSJCbFAo80AsRi2Wo
	V9xhd6otm3b9L+7awkwXgAAGRT72OC8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751449972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cGCtkuQDf7npqLhgpdL8AUxIksP8IpG+SBwNiySulak=;
	b=B17rtKYbBzAkxUVY7QhgThXZpVzb8+vgr5zYWWxQW6z9BTKWjQ3c13mCY5PhUZXBuvgf02
	7wnfNUCyXvnfOHYkwBd57CcGA8YV+RAbn67+zFDJuK0YlGYbE0vWSH4lOWhNMDUy/3EuSq
	xdXADjzeYqtXEIQR0+DrMpgfFZNc1HA=
From: Petr Mladek <pmladek@suse.com>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	David Gow <davidgow@google.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 3/3] printk: kunit: Fix __counted_by() in struct prbtest_rbdata
Date: Wed,  2 Jul 2025 11:51:57 +0200
Message-ID: <20250702095157.110916-4-pmladek@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250702095157.110916-1-pmladek@suse.com>
References: <20250702095157.110916-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-7.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	R_RATELIMIT(0.00)[to_ip_from(RLpam4jm9phgcop7d53x6uygpb)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,linaro.org:email,pathway.suse.cz:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -7.30

__counted_by() has to point to a variable which defines the size
of the related array. The code must never access the array
beyond this limit.

struct prbtest_rbdata currently stores the length of the string.
And the code access the array beyond the limit when writing
or reading the trailing '\0'.

Store the size of the string, including the trailing '\0' if
we wanted to keep __counted_by().

Consistently use "_size" suffix when the trailing '\0' is counted.
Note that MAX_RBDATA_TEXT_SIZE was originally used to limit
the text length.

When touching the code, make sure that @text_size produced by
get_random_u32_inclusive() stays within the limits.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/eaea66b9-266a-46e7-980d-33f40ad4b215@sabinyo.mountain
Suggested-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk_ringbuffer_kunit_test.c | 47 +++++++++++---------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer_kunit_test.c b/kernel/printk/printk_ringbuffer_kunit_test.c
index 0c3030fde8c2..088fe4d8c9b6 100644
--- a/kernel/printk/printk_ringbuffer_kunit_test.c
+++ b/kernel/printk/printk_ringbuffer_kunit_test.c
@@ -52,13 +52,12 @@ module_param(runtime_ms, ulong, 0400);
 
 /* test data structure */
 struct prbtest_rbdata {
-	unsigned int len;
-	char text[] __counted_by(len);
+	unsigned int size;
+	char text[] __counted_by(size);
 };
 
-#define MAX_RBDATA_TEXT_SIZE 0x7f
-/* +1 for terminator. */
-#define MAX_PRB_RECORD_SIZE (sizeof(struct prbtest_rbdata) + MAX_RBDATA_TEXT_SIZE + 1)
+#define MAX_RBDATA_TEXT_SIZE 0x80
+#define MAX_PRB_RECORD_SIZE (sizeof(struct prbtest_rbdata) + MAX_RBDATA_TEXT_SIZE)
 
 struct prbtest_data {
 	struct kunit *test;
@@ -74,25 +73,29 @@ struct prbtest_thread_data {
 
 static void prbtest_fail_record(struct kunit *test, const struct prbtest_rbdata *dat, u64 seq)
 {
-	KUNIT_FAIL(test, "BAD RECORD: seq=%llu len=%u text=%.*s\n",
-		   seq, dat->len,
-		   dat->len <= MAX_RBDATA_TEXT_SIZE ? dat->len : -1,
-		   dat->len <= MAX_RBDATA_TEXT_SIZE ? dat->text : "<invalid>");
+	unsigned int len;
+
+	len = dat->size - 1;
+
+	KUNIT_FAIL(test, "BAD RECORD: seq=%llu size=%u text=%.*s\n",
+		   seq, dat->size,
+		   len < MAX_RBDATA_TEXT_SIZE ? len : -1,
+		   len < MAX_RBDATA_TEXT_SIZE ? dat->text : "<invalid>");
 }
 
 static bool prbtest_check_data(const struct prbtest_rbdata *dat)
 {
 	unsigned int len;
 
-	/* Sane length? */
-	if (dat->len < 1 || dat->len > MAX_RBDATA_TEXT_SIZE)
+	/* Sane size? At least one character + trailing '\0' */
+	if (dat->size < 2 || dat->size > MAX_RBDATA_TEXT_SIZE)
 		return false;
 
-	if (dat->text[dat->len] != '\0')
+	len = dat->size - 1;
+	if (dat->text[len] != '\0')
 		return false;
 
 	/* String repeats with the same character? */
-	len = dat->len;
 	while (len--) {
 		if (dat->text[len] != dat->text[0])
 			return false;
@@ -114,10 +117,14 @@ static int prbtest_writer(void *data)
 	kunit_info(tr->test_data->test, "start thread %03lu (writer)\n", tr->num);
 
 	for (;;) {
-		/* ensure at least 1 character */
-		text_size = get_random_u32_inclusive(1, MAX_RBDATA_TEXT_SIZE);
-		/* +1 for terminator. */
-		record_size = sizeof(struct prbtest_rbdata) + text_size + 1;
+		/* ensure at least 1 character + trailing '\0' */
+		text_size = get_random_u32_inclusive(2, MAX_RBDATA_TEXT_SIZE);
+		if (WARN_ON_ONCE(text_size < 2))
+			text_size = 2;
+		if (WARN_ON_ONCE(text_size > MAX_RBDATA_TEXT_SIZE))
+			text_size = MAX_RBDATA_TEXT_SIZE;
+
+		record_size = sizeof(struct prbtest_rbdata) + text_size;
 		WARN_ON_ONCE(record_size > MAX_PRB_RECORD_SIZE);
 
 		/* specify the text sizes for reservation */
@@ -140,9 +147,9 @@ static int prbtest_writer(void *data)
 			r.info->text_len = record_size;
 
 			dat = (struct prbtest_rbdata *)r.text_buf;
-			dat->len = text_size;
-			memset(dat->text, text_id, text_size);
-			dat->text[text_size] = 0;
+			dat->size = text_size;
+			memset(dat->text, text_id, text_size - 1);
+			dat->text[text_size - 1] = '\0';
 
 			prb_commit(&e);
 
-- 
2.50.0

