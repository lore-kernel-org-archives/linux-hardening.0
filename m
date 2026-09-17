Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AD0371CE4
	for <linux-hardening@vger.kernel.org>; Thu, 17 Sep 2026 01:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607646; cv=none; b=VTTomleeFOPiGR7sIdJvWNCqFLsctWY9rj8N+hVkQjt00a2RfPGD1ucPZP9VoL74RmDUC1zLTxOmiqyB1cbbuFUGCKrqqN2NJdLuIISrDCSmC/59PX3any4gLVmzIDJEez/N0UFESt0EbtHcQHDicIppTfq5tvfTAjIB6i9YEZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607646; c=relaxed/simple;
	bh=Ul6j9WsyP/r/ydqbSfLgKbi1bbJx+nz92awCbQVj1eM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b8gvGs0WeLwKe/RFPj5+0PM+ToFBXA6W4DsGYt9/CSyk4oo9D76B7hqJ/c0zH248w5n61wZkbrXdDpCTFeWmHuD7vpI3AYTC5edHPeCfu5qPjnhVqtbpJmlXhyuWAQUmlRZYR7ocNg7qsgvSFGgF7Pi+hHqXGZRj2D+jQj4XFOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LTruY1Ul; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LTruY1Ul"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso361815a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 16 Sep 2026 18:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789607643; x=1790212443; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a+CdnO7yh4efRshGKkV5OBVfJv13nuMpKztWCTLiXjE=;
        b=LTruY1Ul670RJDhVV+Rl9kI7Chsnp+tcmrzI/yfpY/dwxpYOM9pshD68YCW/FRpGV0
         Z8uaaxOe5Qch8gojqY3oGPTdpmeaHdAYb2KjyzTrg8rB0KOf6sFYC5Mty3R+KZCmWbTt
         Gz7zapMTW3cdKdrhnmj19FbBy6z/+Z7ozcciQQFSChx9xIMkxN/MchvWO8MP6lTrEs9M
         DH3Uu8oV8w0AU7S0BghX4mP1DfbO7fqv6s3qLBxPx8FiCI+292MWk8/hKCxH2BvkCb2b
         Hx7fvbj069/NwbrZD4/RV9GjIENeEG4zU6kd5TPzaOBkVLSLPWi5ZyzVX5sp+m3wybsd
         Vasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789607643; x=1790212443;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a+CdnO7yh4efRshGKkV5OBVfJv13nuMpKztWCTLiXjE=;
        b=QczNaaR6r1JDhRG9aesddxOWBIcLpM1fixfbdxkY9J3IzRtdNoG+BgK7/ISN0KJ4C/
         dfyLH1MyflcP8MAx0XuSpi1PMhVgn8cjgF8/INp6U1YBSnNBXn8YMapmL+k7Gx5kTKTu
         GMP1t6YYGra69V076XMmdYTOk2pniQCGSUoW+UyBYkVNILbaJKtYEcpsRlTFI6tS7MEz
         rNAgxzPRUnlZ5eFH8Xy3qhwZmoL6hGzBGYy6rPj7ASGR68HLWaNt7PsLmdHZozri2pXG
         yB4f9VuRt/eJpSA+39IpUOGf77LLFBEbPMlf5IeC2RjJISzS6i6mDtweHisYNOKkfU9H
         6UxA==
X-Forwarded-Encrypted: i=1; AKwUvBy+HMBJ+MiHCpGPJRwmD+QuS2clCWD7R3m9RibLzlKZF8VoLwzp5qJkerQSJTxX3ay4/3w0W8V6/xdHK4wsbNY=@vger.kernel.org
X-Gm-Message-State: AFuF++ntArrZMVWz945CGRRyrIILklpJdCtPXSTbKVeUai8WP1F2wrgt
	3+kftUsVksWKkMDc8x1plzSnMmlvOY/WNyWls+MhmjuBmKav9p7TGNtKHAGYNqwN8e6Heubz280
	1
X-Received: from plcg5.prod.google.com ([2002:a17:902:c985:b0:2db:6c6c:8a80])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b0b:b0:2dd:7646:35cd
 with SMTP id d9443c01a7336-2dd8ccccf6fmr106356295ad.0.1789607642593; Wed, 16
 Sep 2026 18:14:02 -0700 (PDT)
Date: Thu, 17 Sep 2026 01:13:59 +0000
In-Reply-To: <20260916222125.1259631-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916222125.1259631-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917011359.1585961-1-morbo@google.com>
Subject: [PATCH v3] seq_buf: add seq_buf_strlen(), seq_buf_init_append(), seq_buf_puts_trunc()
From: Bill Wendling <morbo@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"

Converting some strlcat() call sites seq_buf need behavior seq_buf
doesn't currently provide, either directly or without introducing subtle
bugs:

 - seq_buf_strlen(): seq_buf_used() reports the full buffer size when
   the buffer is completely filled, even though seq_buf_str() then
   overwrites the final byte with a NUL terminator, leaving only size -
   1 bytes of actual content. Callers that need the true length of the
   NUL-terminated string have to fall back to strlen(seq_buf_str(s)).
   seq_buf_strlen() mirrors seq_buf_str()'s NUL-termination logic but
   returns the resulting string's length directly.

 - seq_buf_init_append(): seq_buf_init() always clears the buffer it's
   given via seq_buf_clear(). Code migrating from strlcat(buf, ...),
   which appends to whatever @buf already contains, can't use
   seq_buf_init() without silently discarding that existing content.
   seq_buf_init_append() preserves it and positions the seq_buf to
   append after it.

 - seq_buf_puts_trunc(): seq_buf_puts() (like seq_buf_printf() and
   friends) writes nothing at all if the string doesn't fully fit,
   whereas strlcat() always copies as much of the source as there is
   room for. Converting a strlcat() call site that relied on that
   partial-copy behavior to plain seq_buf_puts() can silently drop
   content that used to survive truncated. seq_buf_puts_trunc() keeps
   the leading bytes of the string that fit.

Assisted-by: LLM
Suggested-by: Kees Cook <kees@kernel.org>
Signed-off-by: Bill Wendling <morbo@google.com>
---
v2: Reword the commit message to be clearer and not refer to a series of
    patches
v3: Add EXPORT_SYMBOL_GPL, make sure to overflow when truncating, correct
    some logic discovered by the KUnit tests, and add KUnit tests.
---
 include/linux/seq_buf.h   | 60 +++++++++++++++++++++++++++++++++++++++
 lib/seq_buf.c             | 33 +++++++++++++++++++++
 lib/tests/seq_buf_kunit.c | 48 +++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 9f2839e73f8a..a552bcaab07f 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -30,6 +30,10 @@ struct seq_buf {
 		.size = SIZE,				\
 	}
 
+/**
+ * seq_buf_clear - reset the seq_buf to be read / appended from the beginning
+ * @s: the seq_buf handle
+ */
 static inline void seq_buf_clear(struct seq_buf *s)
 {
 	s->len = 0;
@@ -37,6 +41,14 @@ static inline void seq_buf_clear(struct seq_buf *s)
 		s->buffer[0] = '\0';
 }
 
+/**
+ * seq_buf_init - initialize a seq_buf
+ * @s: the seq_buf handle
+ * @buf: pointer to the buffer
+ * @size: total size of @buf
+ *
+ * The contents of the buffer are ignored.
+ */
 static inline void
 seq_buf_init(struct seq_buf *s, char *buf, unsigned int size)
 {
@@ -45,6 +57,26 @@ seq_buf_init(struct seq_buf *s, char *buf, unsigned int size)
 	seq_buf_clear(s);
 }
 
+/**
+ * seq_buf_init_append - initialize a seq_buf over a buffer that may
+ *			 already hold NUL-terminated content
+ * @s: the seq_buf handle
+ * @buf: pointer to the (possibly non-empty) buffer
+ * @size: total size of @buf
+ *
+ * Unlike seq_buf_init(), which always clears @buf, this preserves
+ * whatever NUL-terminated content @buf already holds and positions
+ * @s to append after it. Useful for converting code that used to
+ * append to an existing buffer with strlcat()/scnprintf() and friends.
+ */
+static inline void
+seq_buf_init_append(struct seq_buf *s, char *buf, unsigned int size)
+{
+	s->buffer = buf;
+	s->size = size;
+	s->len = strnlen(buf, size);
+}
+
 /*
  * seq_buf have a buffer that might overflow. When this happens
  * len is set to be greater than size.
@@ -108,6 +140,33 @@ static inline const char *seq_buf_str(struct seq_buf *s)
 	return s->buffer;
 }
 
+/**
+ * seq_buf_strlen - get the length of the NUL-terminated string in seq_buf
+ * @s: the seq_buf handle
+ *
+ * Like seq_buf_str(), this makes sure that the buffer in @s is
+ * NUL-terminated, and returns the length of the resulting string.
+ * Unlike seq_buf_used(), the returned length is always correct, even
+ * when the buffer is completely full: in that case seq_buf_used()
+ * reports @s->size, but the last byte was overwritten with the
+ * trailing NUL, so only @s->size - 1 bytes of content remain.
+ *
+ * Returns: the length of the NUL-terminated string in @s->buffer.
+ */
+static inline size_t seq_buf_strlen(struct seq_buf *s)
+{
+	if (WARN_ON(s->size == 0))
+		return 0;
+
+	if (seq_buf_buffer_left(s)) {
+		s->buffer[s->len] = 0;
+		return s->len;
+	}
+
+	s->buffer[s->size - 1] = 0;
+	return s->size - 1;
+}
+
 /**
  * seq_buf_get_buf - get buffer to write arbitrary data to
  * @s: the seq_buf handle
@@ -179,6 +238,7 @@ extern int seq_buf_putmem(struct seq_buf *s, const void *mem, unsigned int len);
 extern int seq_buf_putmem_hex(struct seq_buf *s, const void *mem,
 			      unsigned int len);
 extern int seq_buf_path(struct seq_buf *s, const struct path *path, const char *esc);
+extern size_t seq_buf_puts_trunc(struct seq_buf *s, const char *str);
 extern int seq_buf_hex_dump(struct seq_buf *s, const char *prefix_str,
 			    int prefix_type, int rowsize, int groupsize,
 			    const void *buf, size_t len, bool ascii);
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index a92093f346da..831a1542fb78 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -199,6 +199,39 @@ int seq_buf_puts(struct seq_buf *s, const char *str)
 }
 EXPORT_SYMBOL_GPL(seq_buf_puts);
 
+/**
+ * seq_buf_puts_trunc - append as much of a string as fits, keeping any of it
+ * @s: the seq_buf handle
+ * @str: the string to append
+ *
+ * This copies the leading bytes of @str that fit, reserving room for the NUL
+ * terminator later added by seq_buf_str(). This differs from seq_buf_puts(),
+ * which writes nothing at all if @str doesn't fully fit.
+ *
+ * Unlike seq_buf_puts(), this does NOT NUL-terminate @s->buffer as it
+ * goes (it copies raw bytes via seq_buf_putmem(), not @str's own
+ * terminator). Callers MUST call seq_buf_str() or seq_buf_strlen()
+ * before using @s->buffer as a C string.
+ *
+ * Returns: the number of bytes copied from @str.
+ */
+size_t seq_buf_puts_trunc(struct seq_buf *s, const char *str)
+{
+	size_t len = strlen(str);
+
+	WARN_ON(s->size == 0);
+
+	if (seq_buf_can_fit(s, len))
+		return seq_buf_puts(s, str);
+
+	/* Truncate the string to fit the buffer. */
+	len = s->size - s->len;
+	memcpy(s->buffer + s->len, str, len);
+	seq_buf_set_overflow(s);
+	return len;
+}
+EXPORT_SYMBOL_GPL(seq_buf_puts_trunc);
+
 /**
  * seq_buf_putc - sequence printing of simple character
  * @s: seq_buf descriptor
diff --git a/lib/tests/seq_buf_kunit.c b/lib/tests/seq_buf_kunit.c
index eb466386bbef..a16b1365b503 100644
--- a/lib/tests/seq_buf_kunit.c
+++ b/lib/tests/seq_buf_kunit.c
@@ -23,6 +23,21 @@ static void seq_buf_init_test(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "");
 }
 
+static void seq_buf_init_append_test(struct kunit *test)
+{
+	char buf[32] = "hello world";
+	struct seq_buf s;
+
+	seq_buf_init_append(&s, buf, sizeof(buf));
+
+	KUNIT_EXPECT_EQ(test, s.size, 32);
+	KUNIT_EXPECT_EQ(test, s.len, 11);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_buffer_left(&s), 32 - 11);
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 11);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello world");
+}
+
 static void seq_buf_declare_test(struct kunit *test)
 {
 	DECLARE_SEQ_BUF(s, 24);
@@ -51,6 +66,36 @@ static void seq_buf_clear_test(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "");
 }
 
+static void seq_buf_strlen_test(struct kunit *test)
+{
+	DECLARE_SEQ_BUF(s, 16);
+
+	seq_buf_puts(&s, "hello world!");
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), 12);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello world!");
+
+	seq_buf_puts(&s, " It's a small world!");
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), s.size - 1);
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello world!");
+}
+
+static void seq_buf_puts_trunc_test(struct kunit *test)
+{
+	DECLARE_SEQ_BUF(s, 10);
+
+	seq_buf_puts(&s, "hello");
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 5);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello");
+
+	seq_buf_puts_trunc(&s, " world!");
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), s.size - 1);
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello wor");
+}
+
 static void seq_buf_puts_test(struct kunit *test)
 {
 	DECLARE_SEQ_BUF(s, 16);
@@ -218,8 +263,11 @@ static void seq_buf_putmem_hex_overflow_test(struct kunit *test)
 
 static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_init_test),
+	KUNIT_CASE(seq_buf_init_append_test),
 	KUNIT_CASE(seq_buf_declare_test),
 	KUNIT_CASE(seq_buf_clear_test),
+	KUNIT_CASE(seq_buf_strlen_test),
+	KUNIT_CASE(seq_buf_puts_trunc_test),
 	KUNIT_CASE(seq_buf_puts_test),
 	KUNIT_CASE(seq_buf_puts_overflow_test),
 	KUNIT_CASE(seq_buf_putc_test),
-- 
2.55.0.1082.g2b9226bbc0-goog

