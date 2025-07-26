Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C47620E33F
	for <linux-hardening@vger.kernel.org>; Sat, 26 Jul 2025 09:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753520915; cv=none; b=HO4zcKAMbFTNoReJ/vO4V+CDM5KuVwdP32C3n7SDAHryMWrGaCQEEpnjO96+JAleuCUFXJ1HB+f6kgpL9v1FvIshHnhD2OqY/V8kRdMbCwwlagYaXWuHJukeQeQ5lCfRlMwas/n5v7Ohf6FqJI/pMdnSEyH+R1vzyCm42sD2lbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753520915; c=relaxed/simple;
	bh=PG/Z6iYIUx0CAk7VwOdrs/JG9IcS+1B73LH8uedfdHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dgVuBHPnrno61d5zu1HZzCpPbHYc42QtkEopncrInoBXXUYQNZCKXTtzpr1z80MVzX//5CO2vtCwNd+egLB6vEcUMVvcPOua44t98210RtYFLeptLwC1c20Iktyi4ENbA9fTXS8Kt2g8bgfct2y7pb7Vyu63N7LS7BE4Y+rSCrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i7p3weA3; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i7p3weA3"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fafb6899c2so33990686d6.0
        for <linux-hardening@vger.kernel.org>; Sat, 26 Jul 2025 02:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753520912; x=1754125712; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1qPpszzKik+iQmlJEfm7WgEHaYxkwn/LQ796eFNw9tM=;
        b=i7p3weA3BjoW2jccjXTiEwIgt/o3qXZfZ4S4/nkBR4edb/PaLU1XY0aaFNu52DBeDd
         PT03uIT2xKS74rIvXU9zBrjM/hAtCxnqi8PiHnRc7QhVtPLdggfTGnVrhaKZkk9PYJpz
         SMk9NTGXI6yfaAn2Q2rV4FeZauGNdPpDimfE1cz4dGcjsGIHiwUtF46TgCVivztgSDFn
         lpfXDNL/+9IRKGPdHG/H1FwTMCiOFneAmEdpkGXshcP+huyIWigHn8rpB00o62Had3P5
         ccQAJy8sPpNGGzdBJWri91Jy4ofZsX5dHgf23FrtMlcC+98vPmeq2Nd9tcvCCIjFWfPR
         +fpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753520912; x=1754125712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qPpszzKik+iQmlJEfm7WgEHaYxkwn/LQ796eFNw9tM=;
        b=EZlPaE3FWxvOpUd7wp6THTN76VzlybebrRNVgnNxASxjg8y9PTs8v1Y4zJvWh5ItEC
         HTJdtvx/kAHvmlClF8qBzim9cdJTDapgnkJ0xUJQWrjUJRFHb9iwiwYshfglJ0VIVk3i
         xFYnq0GlX4AF8gzxc3CN90u/qmhEuErISSx22l5pD3EtenYHW+cE89s1DWlORjYjMkcY
         leJVoUIWYAntL1dm+3MGlNDCsqrNozAxWBRI1r0P8Uld66NaNAOODl20cBQKdFzd6POb
         EAefJwEvlfG326b2vhhvK2HgDdQ9sOKJaEgN4tcbSHY82n3W1Rs2X/Lj+8Ua51ApLo8W
         0U1A==
X-Forwarded-Encrypted: i=1; AJvYcCWjb3ay9uwKxdqgdHtmxgdlv2/FDHFODQ+9LhdtSMOmLKOfvrnYiiHu2ZnrXgGoz9jCRN6bbdxv3Fb8wQvqb8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/wB/1K1omd+PVGnOEv8lDYjTc8yn446gjtVmdbP0ShVRult68
	IA7eoAr8MVwIR0D/V/VIZbWdvsupBZD6jA8olFMY9SfyULE+vCRM+UuvRTd3GyaWjg7MWjQXYiY
	GjTjT+SlfeH51jpYJ9+N6twRDgwA9RgYLf+phnq4m
X-Gm-Gg: ASbGncskFbK63CyQuOjyGZ0Un9cPL4WKhSz6LdSucBw9GR/KqLGKKHMq4w3XkcpUnLv
	H5TbNmV5XlRon/hK0o92JqZz8iLaCdwYGnDLmE8pZutc+6jYqh9tzhZ5ZlWKmShdVCO9M0EnuZC
	BpXPwDNXnYdcIJxvbz1LazOSwQB0FQawsZ+Z+XIwSKUujyHEnYTDIDspN9C49MpAhOI7166itSk
	YsCHdiV
X-Google-Smtp-Source: AGHT+IHzeoVvOsILHZKC+EZ2N92jCp5skq/8Dc9MELWpvNbcvDOh1q6g9CCEw9YoliQJD9X7A7gI/ENH+nYS+e7ReTQ=
X-Received: by 2002:a05:6214:e89:b0:6fa:abd2:f2bb with SMTP id
 6a1803df08f44-7071fe1bb1dmr50656846d6.8.1753520911680; Sat, 26 Jul 2025
 02:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717085156.work.363-kees@kernel.org>
In-Reply-To: <20250717085156.work.363-kees@kernel.org>
From: David Gow <davidgow@google.com>
Date: Sat, 26 Jul 2025 17:08:19 +0800
X-Gm-Features: Ac12FXwd4cC11bTIu7kCuOCDE-7bp3o4bxMHb62MGMxnOmu8Kw8li7Ytn1ESexg
Message-ID: <CABVgOSkf+v6vGvUCQ6eo3_RXZvmzRpLgA1PmpQ-Bd90iD4yzZA@mail.gmail.com>
Subject: Re: [PATCH] seq_buf: Introduce KUnit tests
To: Kees Cook <kees@kernel.org>
Cc: Rae Moar <rmoar@google.com>, Tamir Duberstein <tamird@gmail.com>, 
	Eric Biggers <ebiggers@kernel.org>, "Steven Rostedt (Google)" <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Petr Mladek <pmladek@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000019f8f8063ad1678d"

--00000000000019f8f8063ad1678d
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Jul 2025 at 16:52, Kees Cook <kees@kernel.org> wrote:
>
> Add KUnit tests for the seq_buf API to ensure its correctness and
> prevent future regressions.
>
> The tests cover the following functions:
> - seq_buf_init()
> - DECLARE_SEQ_BUF()
> - seq_buf_clear()
> - seq_buf_puts()
> - seq_buf_putc()
> - seq_buf_printf()
> - seq_buf_get_buf()
> - seq_buf_commit()
>
> $ tools/testing/kunit/kunit.py run seq_buf
> =================== seq_buf (9 subtests) ===================
> [PASSED] seq_buf_init_test
> [PASSED] seq_buf_declare_test
> [PASSED] seq_buf_clear_test
> [PASSED] seq_buf_puts_test
> [PASSED] seq_buf_puts_overflow_test
> [PASSED] seq_buf_putc_test
> [PASSED] seq_buf_printf_test
> [PASSED] seq_buf_printf_overflow_test
> [PASSED] seq_buf_get_buf_commit_test
> ===================== [PASSED] seq_buf =====================
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> I used an LLM to produce this; it did pretty well, but I had to help it
> get the Kconfig and make targets in the right places, and I tweaked some
> of the edge cases and added a bit more (perhaps redundant) state checking.
>

This patch looks good to me. A couple of very minor notes below, but
nothing I think is a big issue.

I don't have much to say on the LLM use -- it definitely looks better
than the last time I tried it. If something like Sasha's suggestion
for how to tag LLM contributions[1] goes through, I do think noting
what was used could be a useful thing to have.

Reviewed-by: David Gow <davidgow@google.com>

-- David

[1] https://lore.kernel.org/all/20250725175358.1989323-1-sashal@kernel.org/

> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Tamir Duberstein <tamird@gmail.com>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> ---
>  lib/Kconfig.debug         |   9 ++
>  lib/tests/Makefile        |   1 +
>  lib/tests/seq_buf_kunit.c | 205 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 215 insertions(+)
>  create mode 100644 lib/tests/seq_buf_kunit.c
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index cf05bf1df983..048efc3183d5 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2470,6 +2470,15 @@ config SCANF_KUNIT_TEST
>
>           If unsure, say N.
>
> +config SEQ_BUF_KUNIT_TEST
> +       tristate "KUnit test for seq_buf" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         This builds unit tests for the seq_buf library.
> +
> +         If unsure, say N.
> +

FYI: Checkpatch complains a bit that this is too short a description.
It doesn't bother me much, though:
WARNING: please write a help paragraph that fully describes the config
symbol with at least 4 lines

>  config STRING_KUNIT_TEST
>         tristate "KUnit test string functions at runtime" if !KUNIT_ALL_TESTS
>         depends on KUNIT
> diff --git a/lib/tests/Makefile b/lib/tests/Makefile
> index 84b15c986b8c..fa6d728a8b5b 100644
> --- a/lib/tests/Makefile
> +++ b/lib/tests/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
>  obj-$(CONFIG_PRINTF_KUNIT_TEST) += printf_kunit.o
>  obj-$(CONFIG_RANDSTRUCT_KUNIT_TEST) += randstruct_kunit.o
>  obj-$(CONFIG_SCANF_KUNIT_TEST) += scanf_kunit.o
> +obj-$(CONFIG_SEQ_BUF_KUNIT_TEST) += seq_buf_kunit.o
>  obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
>  obj-$(CONFIG_SLUB_KUNIT_TEST) += slub_kunit.o
>  obj-$(CONFIG_TEST_SORT) += test_sort.o
> diff --git a/lib/tests/seq_buf_kunit.c b/lib/tests/seq_buf_kunit.c
> new file mode 100644
> index 000000000000..74648dbda13f
> --- /dev/null
> +++ b/lib/tests/seq_buf_kunit.c
> @@ -0,0 +1,205 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit tests for the seq_buf API
> + *
> + * Copyright (C) 2025, Google LLC.
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/seq_buf.h>
> +
> +static void seq_buf_init_test(struct kunit *test)
> +{
> +       char buf[32];
> +       struct seq_buf s;
> +
> +       seq_buf_init(&s, buf, sizeof(buf));
> +
> +       KUNIT_EXPECT_EQ(test, s.size, 32);
> +       KUNIT_EXPECT_EQ(test, s.len, 0);
> +       KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
> +       KUNIT_EXPECT_EQ(test, seq_buf_buffer_left(&s), 32);
> +       KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 0);
> +       KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "");
> +}
> +
> +static void seq_buf_declare_test(struct kunit *test)
> +{
> +       DECLARE_SEQ_BUF(s, 24);
> +
> +       KUNIT_EXPECT_EQ(test, s.size, 24);
> +       KUNIT_EXPECT_EQ(test, s.len, 0);
> +       KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
> +       KUNIT_EXPECT_EQ(test, seq_buf_buffer_left(&s), 24);
> +       KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 0);
> +       KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "");
> +}
> +
> +static void seq_buf_clear_test(struct kunit *test)
> +{
> +       DECLARE_SEQ_BUF(s, 128);
> +
> +       seq_buf_puts(&s, "hello");
> +       KUNIT_EXPECT_EQ(test, s.len, 5);
> +       KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));

My gut feeling seeing this was that we should test that
seq_buf_clear() also clears the overflow flag, though the separate
overflow tests below all do seem to test that, so it's probably
redundant.

> +       KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello");
> +
> +       seq_buf_clear(&s);
> +
> +       KUNIT_EXPECT_EQ(test, s.len, 0);
> +       KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
> +       KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "");
> +}
> +
> +static void seq_buf_puts_test(struct kunit *test)
> +{
> +       DECLARE_SEQ_BUF(s, 16);
> +
> +       seq_buf_puts(&s, "hello");
> +       KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 5);
> +       KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
> +       KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello");
> +
> +       seq_buf_puts(&s, " world");
> +       KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 11);
> +       KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
> +       KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello world");
> +}
> +
> +static void seq_buf_puts_overflow_test(struct kunit *test)
> +{
> +       DECLARE_SEQ_BUF(s, 10);
> +
> +       seq_buf_puts(&s, "123456789");
> +       KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
> +       KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 9);
> +
> +       seq_buf_puts(&s, "0");
> +       KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
> +       KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 10);
> +       KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "123456789");
> +
> +       seq_buf_clear(&s);
> +       KUNIT_EXPECT_EQ(test, s.len, 0);
> +       KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
> +       KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "");
> +}
> +
> +static void seq_buf_putc_test(struct kunit *test)
> +{
> +       DECLARE_SEQ_BUF(s, 4);
> +
> +       seq_buf_putc(&s, 'a');
> +       seq_buf_putc(&s, 'b');
> +       seq_buf_putc(&s, 'c');
> +
> +       KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 3);
> +       KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
> +       KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "abc");
> +
> +       seq_buf_putc(&s, 'd');
> +       KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 4);
> +       KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
> +       KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "abc");
> +
> +       seq_buf_putc(&s, 'e');
> +       KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 4);
> +       KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
> +       KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "abc");
> +
> +       seq_buf_clear(&s);
> +       KUNIT_EXPECT_EQ(test, s.len, 0);
> +       KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
> +       KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "");
> +}
> +
> +static void seq_buf_printf_test(struct kunit *test)
> +{
> +       DECLARE_SEQ_BUF(s, 32);
> +
> +       seq_buf_printf(&s, "hello %s", "world");
> +       KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 11);
> +       KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
> +       KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello world");
> +
> +       seq_buf_printf(&s, " %d", 123);
> +       KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 15);
> +       KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
> +       KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello world 123");
> +}
> +
> +static void seq_buf_printf_overflow_test(struct kunit *test)
> +{
> +       DECLARE_SEQ_BUF(s, 16);
> +
> +       seq_buf_printf(&s, "%lu", 1234567890UL);
> +       KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
> +       KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 10);
> +       KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "1234567890");
> +
> +       seq_buf_printf(&s, "%s", "abcdefghij");
> +       KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
> +       KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 16);
> +       KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "1234567890abcde");
> +
> +       seq_buf_clear(&s);
> +       KUNIT_EXPECT_EQ(test, s.len, 0);
> +       KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
> +       KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "");
> +}
> +
> +static void seq_buf_get_buf_commit_test(struct kunit *test)
> +{
> +       DECLARE_SEQ_BUF(s, 16);
> +       char *buf;
> +       size_t len;
> +
> +       len = seq_buf_get_buf(&s, &buf);
> +       KUNIT_EXPECT_EQ(test, len, 16);
> +       KUNIT_EXPECT_PTR_NE(test, buf, NULL);
> +
> +       memcpy(buf, "hello", 5);
> +       seq_buf_commit(&s, 5);
> +
> +       KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 5);
> +       KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
> +       KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello");
> +
> +       len = seq_buf_get_buf(&s, &buf);
> +       KUNIT_EXPECT_EQ(test, len, 11);
> +       KUNIT_EXPECT_PTR_NE(test, buf, NULL);
> +
> +       memcpy(buf, " worlds!", 8);
> +       seq_buf_commit(&s, 6);
> +
> +       KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 11);
> +       KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
> +       KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello world");
> +
> +       len = seq_buf_get_buf(&s, &buf);
> +       KUNIT_EXPECT_EQ(test, len, 5);
> +       KUNIT_EXPECT_PTR_NE(test, buf, NULL);
> +
> +       seq_buf_commit(&s, -1);
> +       KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
> +}
> +
> +static struct kunit_case seq_buf_test_cases[] = {
> +       KUNIT_CASE(seq_buf_init_test),
> +       KUNIT_CASE(seq_buf_declare_test),
> +       KUNIT_CASE(seq_buf_clear_test),
> +       KUNIT_CASE(seq_buf_puts_test),
> +       KUNIT_CASE(seq_buf_puts_overflow_test),
> +       KUNIT_CASE(seq_buf_putc_test),
> +       KUNIT_CASE(seq_buf_printf_test),
> +       KUNIT_CASE(seq_buf_printf_overflow_test),
> +       KUNIT_CASE(seq_buf_get_buf_commit_test),
> +       {}
> +};
> +
> +static struct kunit_suite seq_buf_test_suite = {
> +       .name = "seq_buf",
> +       .test_cases = seq_buf_test_cases,
> +};
> +
> +kunit_test_suite(seq_buf_test_suite);
> --
> 2.34.1
>

--00000000000019f8f8063ad1678d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
jmkLAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFBp5bTxrTm/d
WMmRETO8lNkA4c7fMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBF
tO3/N2l9hTaij/K0xCpLwIlrqpNo0nMAvvG5LPQQjSeHnTh06tWTgsPCOJ65GX+bqWRDwGTu8WTq
c5ihCNOikBs25j82yeLkfdbeN/tzRGUb2RD+8n9I3CnyMSG49U2s0ZdncsrIVFh47KW2TpHTF7R8
N1dri01wPg8hw4u0+XoczR2TiBrBOISKmAlkAi+P9ivT31gSHdbopoL4x0V2Ow9IOp0chrQQUZtP
KBytLhzUzd9wIsE0QMNDbw6jeG8+a4sd17zpXSbBywIGw7sEvPtnBjMaf5ib3kznlOne6tuDVx4y
QFExTCSrP3OTMUkNbpIdgzg2CHQ2aB8i8YsTZ8Q8Q8ztPJ+xDNsqBUeYxILLjTjxQQovToqipB3f
6IMyk+lWCdDS+iCLYZULV1BTHSdwp1NM3t4jZ8TMlV+JzAyRqz4lzSl8ptkFhKBJ7w2tDrZ3BEXB
8ASUByRxeh+pC1Z5/HhqfiWMVPjaWmlRRJVlRk+ObKIv2CblwxMYlo2Mn8rrbEDyfum1RTMW55Z6
Vumvw5QTHe29TYxSiusovM6OD5y0I+4zaIaYDx/AtF0mMOFXb1MDyynf1CDxhtkgnrBUseHSOU2e
MYs7IqzRap5xsgpJS+t7cp/P8fdlCNvsXss9zZa279tKwaxR0U2IzGxRGsWKGxDysn1HT6pqMDGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAUXA7LnOuRz2DvkWTeMc
0TANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgeftruAhbISvrsuaDynqY7WrOHQm7
dB5JD3GdNx6vHI0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
NzI2MDkwODMyWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAIpR7sHuoTzPJLLCzoSTKNQCPcSYxVxKOA1YO9lznoLVN8297Fy02H/+WP8qVjsfx
mDWvUH6TRSdL9Fok41WiB6HrfDsYkjjxJvewqYusVFjemFIkvHpG1RW4yMkBAH4I1tp52Y2AuC7f
PEknFHv0BTl2JOR5Of1G1o/7zYCUE+acLQuQrRQT2qAatdHqmVteWu3TKgV+8AcsNkK/S49RZznv
x6hFfVwOkPolkXIcazyxko6DTLuCJA6qV5vfm7HwH1ERHtq72QTvD6B4ZMChpMNePh56ZbYxB0JM
J7CDPB1J35jVMNui+5WP2VCie2dfxjpguIcGcMGiCeme1qcJ/w==
--00000000000019f8f8063ad1678d--
