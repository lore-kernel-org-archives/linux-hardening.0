Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A621B5BB
	for <linux-hardening@vger.kernel.org>; Mon,  5 Feb 2024 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131279; cv=none; b=DOAA/z1QS3rbFTvrMGBjzi/iy3SGR1s6aUrZBUkZYuziteKcpraP425m9mN23AR4kkNMRgXhkunahfqp8CfItqNmq3PIMFJVBIwmuUIUPVlJfr8r0RYO23mTfcRzpHCWO5s4nqNn5hcnWVTdckuOCHgS3rDongOBphAvEel2Xic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131279; c=relaxed/simple;
	bh=LSXUDuZ3hWNAcz8vkmNgC731XOYklVfnxXuzJDSI/9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=km4DETVUSfyNYQHMYDPSJLoMaLN6gbhPDXlF/XCe+zEg+EDSxrYfq7w6z7z58MdZndLgy/HzaPyihk8RIt728EUn8CYc3VyJ6Hqvq9ggy04nDuaKzbfSoIj64YYxJCXvggyN/M0psRCZRN4bTj0wEccoXYw5LnmYwDlPGUxRTBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zPN75X/J; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zPN75X/J"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d2e15193bbso2215264241.0
        for <linux-hardening@vger.kernel.org>; Mon, 05 Feb 2024 03:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707131276; x=1707736076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b2S4QWg5rbsM0zVoer/U9D2xYC6cQRyp0XiaCDO+VCA=;
        b=zPN75X/JrioyDUMUPP12+FLv0N1fvLfINcgU7LjNOoPJeAssIuDUFF+Dlfbi+M7rzc
         gAQunAJh1gEvPGqk1htNnXlsijsbAEioIU0ZyX+sftljTjO2unTT13FQWr+aTDCSYX42
         /VFuB0k2PUVxMrhw5oRT2M0r3CIYxHNLjPm1vq0YtfEOBJ2t3vJ7nN2aKMtD+TedPvOy
         2s3JOpSQszFKCXG5L/3tSSUhe9C3dCGS+ychrjj52breGZxVLoha0iPksJ1hZet/XfXT
         HP84MVe+0YIL5jNcLt6507dzlmWRrE/FOxJ0+C4kEgTiInUKwX56YX1Vq85D/UAmLxHs
         5hxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707131276; x=1707736076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2S4QWg5rbsM0zVoer/U9D2xYC6cQRyp0XiaCDO+VCA=;
        b=B2izwnr1T6Xax+k0rX/5FakPQSk3irX4f/7iSm1tXZ4yfoB+LcqPyilZRe1aKSv6/Z
         HsanP8A6GJhpj7V4KCRf+ihGfoqe+C/iOql0EIoYQltE7C0IhI8jLgxw2YGz0DO6h1xc
         DUE1TGF7yIO5FsOrqoi/tT413gTVZCkoepndCfdv4AL7Yd7mR44aUk92mBvH7ToMFwMD
         1BhZsjI7HgOKQ8frD1+wGhMgkNIjTFMFjJ2YOHWYIJAAvTqQPPTL0j2QIaLB0MEUdIA2
         kpxDtPKrtrDHU/xXflINilNb3Cgbjcd7wVfDkRqRka2INAsaf2BElynMeiFQbtRAcVkh
         N6FQ==
X-Gm-Message-State: AOJu0YwvodGlceN7VhfIFin1pHd9YVL7tMoq8eYx7kn9WA/nXpH7zeZ9
	o7noz6EbHbF2p4bMoLY60ATTNg2f6QEKQSV4aAO962CmLxNkaYUUZofE3gBg02SnHayiUqqefxZ
	sK3HPgy6G6sVnxHchYXhTLFbLPmtQ/AtEO956
X-Google-Smtp-Source: AGHT+IHRhimf5DlF5es9JL+ew8WM2cfwIdaMJg21KojI1oyI4onRpBN+2Gc5nqIg0PfsDGvIN3lXdt5v1nJMH2MUxQE=
X-Received: by 2002:a05:6102:2fa:b0:46c:fd6d:7233 with SMTP id
 j26-20020a05610202fa00b0046cfd6d7233mr7818207vsj.9.1707131276246; Mon, 05 Feb
 2024 03:07:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205090323.it.453-kees@kernel.org>
In-Reply-To: <20240205090323.it.453-kees@kernel.org>
From: Marco Elver <elver@google.com>
Date: Mon, 5 Feb 2024 12:07:20 +0100
Message-ID: <CANpmjNNMJn7xtpUxwxiUV1KXgMsDmyvGAq+4etFy5aiESdcDxg@mail.gmail.com>
Subject: Re: [PATCH v2] ubsan: Silence W=1 warnings in self-test
To: Kees Cook <keescook@chromium.org>
Cc: kernel test robot <lkp@intel.com>, Andrey Konovalov <andreyknvl@gmail.com>, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 10:03, Kees Cook <keescook@chromium.org> wrote:
>
> Silence a handful of W=1 warnings in the UBSan selftest, which set
> variables without using them. For example:
>
>    lib/test_ubsan.c:101:6: warning: variable 'val1' set but not used [-Wunused-but-set-variable]
>      101 |         int val1 = 10;
>          |             ^
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401310423.XpCIk6KO-lkp@intel.com/
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> v2:
>  - add additional "volatile" annotations for potential future proofing (marco)
> v1: https://lore.kernel.org/all/20240202094550.work.205-kees@kernel.org/
> ---
>  lib/Makefile     | 1 +
>  lib/test_ubsan.c | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/lib/Makefile b/lib/Makefile
> index 6b09731d8e61..bc36a5c167db 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
>  obj-$(CONFIG_TEST_IDA) += test_ida.o
>  obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
>  CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
> +CFLAGS_test_ubsan.o += $(call cc-disable-warning, unused-but-set-variable)
>  UBSAN_SANITIZE_test_ubsan.o := y
>  obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
>  obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
> diff --git a/lib/test_ubsan.c b/lib/test_ubsan.c
> index 2062be1f2e80..f4ee2484d4b5 100644
> --- a/lib/test_ubsan.c
> +++ b/lib/test_ubsan.c
> @@ -23,8 +23,8 @@ static void test_ubsan_divrem_overflow(void)
>  static void test_ubsan_shift_out_of_bounds(void)
>  {
>         volatile int neg = -1, wrap = 4;
> -       int val1 = 10;
> -       int val2 = INT_MAX;
> +       volatile int val1 = 10;
> +       volatile int val2 = INT_MAX;
>
>         UBSAN_TEST(CONFIG_UBSAN_SHIFT, "negative exponent");
>         val1 <<= neg;
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20240205090323.it.453-kees%40kernel.org.
