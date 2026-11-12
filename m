Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522673;
	b=lebO0hm21N3/MN/G/NMY1vfSN/IPVWow7l1tWQ18UM1V6xBd5Cn4+l9qrwehNn5EKTQF
	 Jm821EGSql30xT4Yunbcr4b3uwttzKP9GsWD+0fPHH+R9JAJu6KXpGToiAXnJj8VU/+zZ
	 8UZx1STs4Gy9rDTjeuzaWm/zbFYtQz5mlIteFicKz9olztETZBbzkIKnyO1rYkIKekPw8
	 H26tkzyb6vzG6VogV4f+lxN0J3n4wckTAPJUdzceW9PoT0zrF6GFdeZwPj0tKwsZLfqEV
	 cVrt74GX4LWeBMoyTWWolVEu98W4l298jwb8Rn49ldy+heqra7RpYpOv+XmCciJO0AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=+JTSqev9V+WnU5MiL+EzLENGXn9aXmam81GQLiwSL0o=;
	b=cw1ZCvzRxgP4JlbiUYxw8pBkXC66oVvW2KAXqp2fdWoWGfmWt/tqGzzjulXOFWEO4KCo
	 ipmApqy/QSIu29TuycYu3ZzeEqelBdW/Ay5AZ6/qzXA4fblAAFE73aTHLqyS0XkGTG4rr
	 Bd8delqaVWYOQFhNEer+Dk8FA7A4BsAiARnXwd1Ng0CTCrnpL8Vsi6BiNqnrTFAphTs6+
	 hSDEDH2AqAPdMu3yywlNQcRQ9gZatC0v97ZaKmuBVHZUfQmf0jJ/2G7szmnzO8Tn1ImT1
	 1SQ9Rf8s8E3sOC/acdmUqJuEuaHMUM9mgXM/qiuuizEd2pT8p/2UhP2rDgsbfJ2aGUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QK6ov+6P;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6CD606A321
	for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 22:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D6CD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QK6ov+6P
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso2174745e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 14:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794522670; x=1795127470; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+JTSqev9V+WnU5MiL+EzLENGXn9aXmam81GQLiwSL0o=;
        b=QK6ov+6PfLWnModUmHpQoTJIO9mbqa69iTI14JlGFF9k8M6Ls+sAJSveNj8g+ueWnu
         8b1zPQX2xIDQFGLZZjP1wMJvqMwZrq8x4IVPtqAZCLsofyk15O0AyKmBHtJfr6U8kAvS
         onsPYX4BfCr1/z4vKD/vtm5bTh4Ke0Nf0vZ5qmaap6QPuXT3JM5d70mPl8hNaMJiiXOV
         BS69sbm1OaKF8ENOfh8zbA3xf8oTQrmKxdb2EsE2Sq6SkJ/ifxcWmEnu3XuTthkueQEB
         tQEoWykjpdUTsskQqwORhSWLyFmUa+cB2XJayhfwgqwrS/xatUifmK6gAIoTkDZfBdkw
         PDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794522670; x=1795127470;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+JTSqev9V+WnU5MiL+EzLENGXn9aXmam81GQLiwSL0o=;
        b=Ua/csiMhSVKNBvagL/FHjNmiu94xAhSTYd2dKjW/hsRD/1P6S16YpuWSvRSsxBq0OV
         amP7ysQz+yzArtmElOuZtmHeL8BrdfOZBGFDrfDbAVDKYpTku2M6WFd+qlApzm46siDj
         GwzHiR2LqGxQmBc8Fe6w9BU/ggavuuJdMFepVi+oQfoeFwHLieuTaa0mMRBwpYPm0QEC
         g+jmmXr418KETJKfIG23rznPRDIljf4sIB3vcT+UP67r/D5sx1tfczHyl7kGwIH4blWx
         XycNBnCNEov/D/2phsye8TrU1Vzhrdkvl/N0CwJnsExgEr0F7p6KUkV1D8RjNB7mfChu
         caCA==
X-Gm-Message-State: APuU4Z9C4WIyEwMd2np99KYyKg3TQtsm6ElpiHicPceysytUt1nM9RME
	5XaJjosGbOGzyCjoMrMBD4ud4MrtglS6uETjqbDhnl65zVXxtbCNvj9o
X-Gm-Gg: AYBFou1ea3gfxe33h+HbeWUN+GMuZCJfggGCxlXJjxLFw8vyLrTjNXeWMmgju+lor+m
	1WfBCwgyWZcDVWIo/5bLv1Z8mEXNAOWYSlOFAxyqhFQj/NEW4iDgP5hq7LlDsU0X1+RGW75td7k
	Y90VHI1FI0y2AgWz4CEvGXx0cIGtGXltKA+5NWf8Zyv0Q3I/YBT/ibHWMfcD9ZZG49F2GGh0v+z
	m9sssZ8PXqvdExizSX4etBaMlCn2VI3uV3r8Rbm6KkIapRP/x1LAmTyMhMA8bDGJqFPU2n+1Ij2
	ZNjLsfrWhMXlobAJWE3bOoR/cZTj6WXZyPVSHOT1eqIf2cbVxC1E1T5NAIe8YSsJjR8lbVsmUbP
	lHyarQqb+xmWNz1lD3kUf/NzH2yZAjtioGm/wihX5xzeJlkquFnq4tWrXke1JLHWClSWXGHtxqE
	wQxBghl8f8thY2GeQH7M18sv61wruGnuJMsHogbnfCiXxBj4scbzaVpzfBk8kSjLz9BgnVQxBM8
	uBdc9Q2G3RJyPZoTXW+MlCM8uYM6/WQgbbEqTu8UjU5q+6Y7f7cyQ1kYaDnl0MmnQ/3IOFDda+s
	64CKVE8xtfkAvJeEpWyHbo+676dBrAM14i8s1y3gyK2iba5PJ8TFJQYux2auJ6sgnQ==
X-Received: by 2002:a05:600c:8b8a:b0:4a1:9078:911 with SMTP id 5b1f17b1804b1-4bb55abbadamr13368985e9.31.1794522670201;
        Thu, 12 Nov 2026 14:31:10 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5720e9c2sm42715e9.3.2026.11.12.14.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:31:09 -0800 (PST)
Date: Thu, 12 Nov 2026 22:31:07 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, Andy
 Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Daniel
 Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil
 <hverkuil-cisco@xs4all.nl>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, Johan
 Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, Linus Walleij
 <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>,
 linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, Bartosz Golaszewski
 <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/6] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <20261112223107.3a9efb85@pumpkin>
In-Reply-To: <a74fabd985a874da7556ae1601053b4bcc100f13.1794425425.git.alx@kernel.org>
References: <cover.1794425425.git.alx@kernel.org>
	<a74fabd985a874da7556ae1601053b4bcc100f13.1794425425.git.alx@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 20:55:15 +0100
Alejandro Colomar <alx@kernel.org> wrote:

> As Bartosz reported, str_has_prefix() has a bug: it can't differentiate
> between an empty prefix matching an empty string from a non-matching
> prefix.  This is a fundamental design flaw in this API, and not
> something that can be fixed.
> 
> As always, this is a consequence of choosing sizes instead of pointers.
> Sizes are often the wrong choice.  In this specific case, pointers are
> more capable of differentiating these cases, as NULL is a special
> sentinel value that doesn't need to overload a valid value.
> 
> Let's implement strprefix(), a function that returns a pointer
> right after the prefix if found, and a null pointer if not found.
> 
> We'll slowly migrate existing code from str_has_prefix() to strprefix().
> 
> Move the description from str_has_prefix(), and describe
> str_has_prefix() by comparing it to strprefix().
> 
> Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Link: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
> Cc: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
>  include/linux/string.h   | 28 +++++++++++++++++++++++-----
>  lib/tests/string_kunit.c |  9 +++++++++
>  2 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 6cb5cdd01158..d08ca10c39a2 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -545,16 +545,34 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
>  	       sizeof(*(obj)) - offsetof(typeof(*(obj)), member));	\
>  })
>  
> +/**
> + * strprefix - string prefix
> + * @s: The string to be tested
> + * @prefix: The string to see if @s starts with
> + *
> + * A common way to test a prefix of a string is to do:
> + *  strncmp(s, prefix, sizeof(prefix) - 1)
> + *
> + * But this can lead to bugs due to typos, or if prefix is a pointer
> + * and not a constant.  Instead use strprefix().
> + *
> + * Returns:
> + * *  @s+strlen(@prefix) if @s starts with @prefix
> + * *  NULL if @s does not start with @prefix
> + */
> +static inline char *strprefix(const char *s, const char *prefix)
> +{
> +	size_t len = strlen(prefix);
> +	return strncmp(s, prefix, len) == 0 ? (char *) s + len : NULL;
> +}

I suspect this would be better as a real function.
Possibly even just a simple loop rather than based on calls to
both strlen and strncmp().
(Even if the strelen() is mostly a compile-time constant.)

Something like:
#undef strprefix // Or put it the name in ()
const char *strprefix(const char *s, const char *prefix)
{
	do {
		if (!*s)
			return *p ? NULL : s;
	} while (*s++ == *p++);
	return p[-1] ? NULL : s - 1;
}

And in the header:
const char *strprefix(const char *s, const char *prefix);
#define strprefix(s, p) ((typeof(s))strprefix(s, p))

David

> +
>  /**
>   * str_has_prefix - Test if a string has a given prefix
>   * @str: The string to test
>   * @prefix: The string to see if @str starts with
>   *
> - * A common way to test a prefix of a string is to do:
> - *  strncmp(str, prefix, sizeof(prefix) - 1)
> - *
> - * But this can lead to bugs due to typos, or if prefix is a pointer
> - * and not a constant. Instead use str_has_prefix().
> + * This is similar to strprefix(), but returns an offset instead of
> + * a pointer.
>   *
>   * Returns:
>   * * strlen(@prefix) if @str starts with @prefix
> diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
> index 0819ace5b027..73d2614b1474 100644
> --- a/lib/tests/string_kunit.c
> +++ b/lib/tests/string_kunit.c
> @@ -287,6 +287,14 @@ static void string_test_strspn(struct kunit *test)
>  	}
>  }
>  
> +static void string_test_strprefix(struct kunit *test)
> +{
> +	KUNIT_ASSERT_EQ(test, 0, strcmp(strprefix("foobar", "foo"), "bar"));
> +	KUNIT_ASSERT_EQ(test, 0, strcmp(strprefix("foobar", ""), "foobar"));
> +	KUNIT_ASSERT_EQ(test, 0, strcmp(strprefix("foobar", "foobar"), ""));
> +	KUNIT_ASSERT_NULL(test, strprefix("foobar", "bar"));
> +}
> +
>  static char strcmp_buffer1[STRCMP_LARGE_BUF_LEN];
>  static char strcmp_buffer2[STRCMP_LARGE_BUF_LEN];
>  
> @@ -891,6 +899,7 @@ static struct kunit_case string_test_cases[] = {
>  	KUNIT_CASE(string_test_strnchr),
>  	KUNIT_CASE(string_test_strrchr),
>  	KUNIT_CASE(string_test_strspn),
> +	KUNIT_CASE(string_test_strprefix),
>  	KUNIT_CASE(string_test_strcmp),
>  	KUNIT_CASE(string_test_strcmp_long_strings),
>  	KUNIT_CASE(string_test_strncmp),

