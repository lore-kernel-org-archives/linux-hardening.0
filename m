Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA151A3168;
	Mon, 17 Mar 2025 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233724; cv=none; b=ZpE93FnBBYJVFdd0P8tt0FEXn0nQ2ekHP9Ku2tQBpO3e2k8BE+u59zMUfZ5/vQ0K71pzWBNsX2av/iuKh0WR64X0PoUyabFMQpQRWI9ZjLQDRcyZGIbYKJMpE6RHG9pjqetcHkWZRa8Emw8P0cCcmWZ081jDjSCX81H+t52YXyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233724; c=relaxed/simple;
	bh=+ajp6u19uztN9LzhI5yDd7wErjsDqGFizACW7A6xC28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fr5kIsbxYRHWlqk0VzbGcvH7oO18tVCwtoUDFHveK/Gbi3au+dHkKuGHhq8oFeoRhfKGK7TjM61QwIXs2OK1p7hWqracLOJXu0Tw0L8OOGlE9w7RbXjXFxek1yLKowSRd4SZGFDFctxuiD59H5WK4ZmUr0Tq1oXNCx63wIUNJME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCrp7lBT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCrp7lBT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BBFC4CEE3;
	Mon, 17 Mar 2025 17:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742233724;
	bh=+ajp6u19uztN9LzhI5yDd7wErjsDqGFizACW7A6xC28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nCrp7lBTfGBqEHXP48lS3nqfXNtJcLXmHOLTVKNxn/BVY19ocTZGdVNaB/S3V6Pwv
	 LV4eJWxg4H7bSJh0ygVFuyxV4RqnMp6iHK6QJAerqlupxFR3VlN7L/i2pQa/bLfj7O
	 yC+MSAE9n1MCRl4XZ1hFL8f3iM5KI/hDP9Hax2aS4vCUZTTTfczePnoXai42KwFlqm
	 l92dF/vj8UKz4QRPBqI8uxery3W7Go8XmEhLeltylK0ismLDLNdiRql6S0QymXYYBh
	 bP/zKaL8oxzwvo8QN9qv2Z2EGBl1vcRsXsmrB+pXtho9Q24dJAiAHw46pcMPBW+ZV+
	 7jZklMlRKpmFg==
Date: Mon, 17 Mar 2025 10:48:40 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit/fortify: Replace "volatile" with
 OPTIMIZER_HIDE_VAR()
Message-ID: <20250317174840.GA1451320@ax162>
References: <20250312000439.work.112-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312000439.work.112-kees@kernel.org>

Hi Kees,

On Tue, Mar 11, 2025 at 05:04:40PM -0700, Kees Cook wrote:
> It does seem that using "volatile" isn't going to be sane compared to
> using OPTIMIZER_HIDE_VAR() going forward. Some strange interactions[1]
> with the sanitizers have been observed in the self-test code, so replace
> the logic.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2075 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
...
> diff --git a/lib/tests/fortify_kunit.c b/lib/tests/fortify_kunit.c
> index 18dcdedf777f..29ffc62a71e3 100644
> --- a/lib/tests/fortify_kunit.c
> +++ b/lib/tests/fortify_kunit.c
...
> @@ -993,8 +1003,11 @@ static void fortify_test_memcmp(struct kunit *test)
>  {
>  	char one[] = "My mind is going ...";
>  	char two[] = "My mind is going ... I can feel it.";
> -	size_t one_len = sizeof(one) + unconst - 1;
> -	size_t two_len = sizeof(two) + unconst - 1;
> +	size_t one_len = sizeof(one) - 1;
> +	size_t two_len = sizeof(two) - 1;
> +
> +	OPTIMIZER_HIDE_VAR(one_len);
> +	OPTIMIZER_HIDE_VAR(two_len);
>  
>  	/* We match the first string (ignoring the %NUL). */
>  	KUNIT_ASSERT_EQ(test, memcmp(one, two, one_len), 0);

I am sorry for bringing this up some time after you sent this change, as
I have only now had a chance to actually sit down and understand the
results of my bisect. I am still seeing a __read_overflow error when
building lib/tests/fortify_kunit.o with Fedora's configuration + LTO in
next-20250317, which contains this change. I do not think it is issue
2075, as I can reproduce it without UBSAN enabled altogether. This is
with LLVM 20.1.0.

$ cat kernel/configs/repro.config
CONFIG_FORTIFY_KUNIT_TEST=m
CONFIG_FORTIFY_SOURCE=y
CONFIG_KUNIT=y
# CONFIG_LTO_NONE is not set
CONFIG_LTO_CLANG_THIN=y

# or x86_64
$ make -skj"$(nproc)" ARCH=arm64 LLVM=1 mrproper {def,repro.}config lib/tests/fortify_kunit.o
ld.lld: error: call to __read_overflow marked "dontcall-error": detected read beyond size of object (1st parameter)
make[6]: *** [scripts/Makefile.build:203: lib/tests/fortify_kunit.o] Error 1

Selectively reverting this avoids the problem, which is definitely
odd... Maybe issue 2075 is related more to issue 2077 and this patch
should not be entertained?

Cheers,
Nathan

diff --git a/lib/tests/fortify_kunit.c b/lib/tests/fortify_kunit.c
index 29ffc62a71e3..1164223654ac 100644
--- a/lib/tests/fortify_kunit.c
+++ b/lib/tests/fortify_kunit.c
@@ -411,6 +411,8 @@ struct fortify_padding {
 	char buf[32];
 	unsigned long bytes_after;
 };
+/* Force compiler into not being able to resolve size at compile-time. */
+static volatile int unconst;
 
 static void fortify_test_strlen(struct kunit *test)
 {
@@ -1003,11 +1005,8 @@ static void fortify_test_memcmp(struct kunit *test)
 {
 	char one[] = "My mind is going ...";
 	char two[] = "My mind is going ... I can feel it.";
-	size_t one_len = sizeof(one) - 1;
-	size_t two_len = sizeof(two) - 1;
-
-	OPTIMIZER_HIDE_VAR(one_len);
-	OPTIMIZER_HIDE_VAR(two_len);
+	size_t one_len = sizeof(one) + unconst - 1;
+	size_t two_len = sizeof(two) + unconst - 1;
 
 	/* We match the first string (ignoring the %NUL). */
 	KUNIT_ASSERT_EQ(test, memcmp(one, two, one_len), 0);
