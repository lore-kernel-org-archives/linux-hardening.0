Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B830376BCA
	for <linux-hardening@vger.kernel.org>; Tue, 24 Feb 2026 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771927823; cv=pass; b=oEHzUfeX9f+fnluCDr4oVJpd3HnmSnBLf62S3yVnYQPE6voGFtRYa7TLXHPfN2Wt0GF2Dp8NaMEGB4TarrevwP1MLFnQTKR449wUqqRGG1dCv9SJT1Ozd5NrTgBC3fcyVuMfh2EbdRl7sz3AGWBeD4C9dP3xEYfRUn8zQW+l/V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771927823; c=relaxed/simple;
	bh=+t2PT6Z4lBpa8MWsVUg2Sq4D1GAFAZsUMwYHdUQ35Hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkewNmJJZ4KGBK68FCfA5p2ptPC2bazCoEsbdDNznChR86XRWm0ysrzTJkyPxO+T46kxIHKbGr0UO+jTqaVN5DHFeddRGxQIiq/sn/8TvQ/0MkkRFNZ+OwWVPajKSazgidzcu3B97bEEAOgp6nYmpxzKDNB7Qqq4gy7xVFYde7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z5B2CuOk; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z5B2CuOk"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1271195d2a7so1942802c88.0
        for <linux-hardening@vger.kernel.org>; Tue, 24 Feb 2026 02:10:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771927821; cv=none;
        d=google.com; s=arc-20240605;
        b=BMLnW6mLr5JDwHR1xI5vj/EpCfPq2hkEn5cxSEJIGzmsaEdaTDuSArgACoMIqRIKaq
         cZsjBAK+d5kG3BfJa7QkhnmQGub32nBHwORPR75LUuZQ3Rs438JoXcGslIYXrlwhNVti
         4uAJ646S4WdmGkq1FR8lPyWuMyMza8CTEHSu/7V3aY9LkQNMjB3nZnIMY8lVY/POzchL
         2yKRR6E4pFkwreHv5C8mAv9G6mS7VhacCVSHg5fbL/e6jjm/6MO2rdtDycNxgYfPzK0j
         kRqUWsF9UWAkey2hKUNqj8pQUGSDrAIcTMJ8oTVs6DIXxqwqJST3OSWWZYImPpLCDjJ7
         dlkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cU+7ICKZHFM5pmHnJJKLvE0nvJUxV3pF6UBqyGhCb3c=;
        fh=q9M7m8tnyR0iSrRGuEXuklx472wZLToYbW6LxcUPaWA=;
        b=LBhBdcTf0HHsG9is48haMwLmWInstkWZ5v/VZl+KSazbZvS/Omad/F+OFSvDT9NJ6P
         3Q/foGp2nWVrZdG6KOe5klEDlpMAe04SzuvhXg25sYiWlJRkv9pdV1QfZnDOyLGLf8wn
         cUc7NQ1HVbAIenPllmOUiDY4JmmgQT2/dMKjdQSFaJfFtr3a/UonB1jlPE65V7yk0wwb
         OC1Bbn0S46VMT1L+TvAmVApQ1m5dpeDVL/Oe/xqfoN1FR7tf/q6PqaxzwaNcVf9D0CK7
         yINapV5MWLc4UiyILTFJD809rsTJumptVPHl4akO0b9NpwoaCJJNJplI2FdQIdk3NT9q
         jEnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771927821; x=1772532621; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cU+7ICKZHFM5pmHnJJKLvE0nvJUxV3pF6UBqyGhCb3c=;
        b=Z5B2CuOkhlP8y64+ZoG8oOzL5SY0vncn1WDghrkUh7nyRbNRBiqm7JC/oC8TKwIkrQ
         bKS1M5vA1XEd/CkhAUhC5nZ5LiUzSk+RBkPb14WR/Gr/llgbFAjTr/mkRTyOhZtm8YDK
         qbtSBrUBUjtnOp/69L+j7mKcIxCTif4/Jr9S9XKoelea60DxevwyMuTOQ9XGtEHq44TQ
         bjJEMtEtKdNG+VSLfRsPMAgtax6XUbxD0ydO7xXE5yzvwS+TlxRETK11wrFeAD8XYy+a
         WQuAV3hmT7mJWXSWNI93D4DrX+16MaQvdmw3t9L0dfdRkvZkUFlTsgmFUH5pZ1MMsO4j
         wjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771927821; x=1772532621;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cU+7ICKZHFM5pmHnJJKLvE0nvJUxV3pF6UBqyGhCb3c=;
        b=LhjN2Khm0g81khxHFK6weldMP4SVhJtJe7rSuCw4AYUs2GaQCBVhOeNmh09uRKi+78
         m7mLYWsKdU7l2Aq1sTIUmf8nfRpIf8tPtHLgnlzoL1zGZwSK+VdH7dEUHoRVPPYbjPhf
         N9JHlVQdoZLVXgwhyTQmmOUpoanWN2vQKSBNE+Pujdic7FKqaao5xmXx8xXcBVGinx6B
         jlJNimor0RuARYoEZpHOkQNdlCw0oie9TdqlVWy8Mm89HbdGgBS8dZqpOVJQ6V+kzzpr
         DTFv8xWujvRmbthqQTtm/iwD/GopxpgqUjw7cuREkTbbIDR1XX8qfpSG4lxnYcVLGVHn
         7x8w==
X-Forwarded-Encrypted: i=1; AJvYcCU+3DJPlsHo/AXF1nkKh3R3tT1rG+2s1hTxyUCY4PfUz6kz7kL5HnWggfIyjPAs/WlK3LV9nTstz2uwOmXmbc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpKxPuCkf0bu4vUPS6+PTuQHMK99xx/sJIZgGhy+OsxNwpgZCj
	6WCg1EzBsInrZq9youiTra2aKlpcwWw5KftQNuZInr5HubAI7R4GW4laDdg322GJ0AgzlWMlASC
	BE8j7Go2juWe8Mv3SRo8pSVixGIF3sDwb7pg5W68x
X-Gm-Gg: AZuq6aKEBZAsfvTNsZew3iIg8pKkdyTgq2zafsWp5K2pDwbFJgq+0wZN9ddBJYT9vLx
	Qry2b01r1+ZLSyaQVRK8iN9v9IbOg3SaOQN7Y/xUFOwzuqpppzpNEjCz+IVHyi59pSrdw69CYF0
	xprvpJf4so4B9HlmcGU5wGcIKsp/0Tt7Q0JmJ41XfgiPzeY1QkqhYRizHZiSU/FDVS9R8zzKRfG
	E4h2wOm+tUcE/VDJ6wn7Pvx17TU5AxwdFO2MULVz6kus8KTMt0+OZzBvpD60cI19vXapnvsOMgm
	jOfMndiV7ByXnjRG1l76Gzsyx2FzQTtMulnWKw==
X-Received: by 2002:a05:7022:b94:b0:119:e569:f268 with SMTP id
 a92af1059eb24-1276acc04cdmr5060553c88.17.1771927820975; Tue, 24 Feb 2026
 02:10:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223222226.work.188-kees@kernel.org>
In-Reply-To: <20260223222226.work.188-kees@kernel.org>
From: Marco Elver <elver@google.com>
Date: Tue, 24 Feb 2026 11:09:44 +0100
X-Gm-Features: AaiRm52EJS5rgTYBcMR4dvDDf9YsS_mzcf4b8zQ6Hta7CXM46-hJuj2wDErJbiQ
Message-ID: <CANpmjNOpXe7tCP7tyR04Hm+a8zdiBWWQdK=US-qTL31mm+Yzkw@mail.gmail.com>
Subject: Re: [PATCH] kcsan: test: Adjust "expect" allocation type for kmalloc_obj
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Feb 2026 at 23:22, Kees Cook <kees@kernel.org> wrote:
>
> Instead of depending on the implicit case between a pointer to pointers
> and pointer to arrays, use the assigned variable type for the allocation
> type so they correctly match. Solves the following build error:
>
> ../kernel/kcsan/kcsan_test.c: In function '__report_matches':
> ../kernel/kcsan/kcsan_test.c:171:16: error: assignment to 'char (*)[512]' from incompatible pointer type 'char (*)[3][512]'
> [-Wincompatible-pointer-types]
>   171 |         expect = kmalloc_obj(observed.lines);
>       |                ^
>
> Tested with:
>
> $ ./tools/testing/kunit/kunit.py run \
>         --kconfig_add CONFIG_DEBUG_KERNEL=y \
>         --kconfig_add CONFIG_KCSAN=y \
>         --kconfig_add CONFIG_KCSAN_KUNIT_TEST=y \
>         --arch=x86_64 --qemu_args '-smp 2' kcsan
>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: <kasan-dev@googlegroups.com>
> ---
>  kernel/kcsan/kcsan_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> index 79e655ea4ca1..056fa859ad9a 100644
> --- a/kernel/kcsan/kcsan_test.c
> +++ b/kernel/kcsan/kcsan_test.c
> @@ -168,7 +168,7 @@ static bool __report_matches(const struct expect_report *r)
>         if (!report_available())
>                 return false;
>
> -       expect = kmalloc_obj(observed.lines);
> +       expect = kmalloc_obj(*expect);

This is wrong. Instead of allocating 3x512 bytes it's now only
allocating 512 bytes, so we get OOB below with this change. 'expect'
is a pointer to a 3-dimensional array of 512-char arrays (matching
observed.lines).
