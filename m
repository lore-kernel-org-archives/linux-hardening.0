Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883123;
	b=bYCtQWVDn3ktjbTmMoMNK4sStBThrRtld+Uzusgfiu37PXaZQTGsMUdbWCRxqnDHIg08
	 n75GC2kLdAL0bpu0QAwbWjPqTsYfnTnssV6ZvTdRnJs048jR2kNW4HAudVEI2j1wlxM9T
	 maq6oN3U1Bs5IXRNF6DzQOsYagqHUaPm6GskeOi8GQkGWKEdGCcSgljbEC1RDrA8Spdal
	 u6T5g5lYvkenlfT+4tofUmc0IxRTuK+kUauwCgXsxLRtNF5fvY0HAJub/yMUJePdnnptO
	 Z+joM8zlAeTwJw77UmiJJi9Wxq4Vz2RVAAxk71EG4QW0kX2418fzeZubhQMDNRc0G7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883123;
	h=Received:From:To:List-Id:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fLAksqUutuMmZ393ZwmJo+qovjnv36EAtEGhBHrix14=;
	b=TnKm2oTtGUmrlSIfZ+hRC7Q9mh/VZiFA/CNhtMignA6oCiVHH6uF0fKm8s73yyqZEzr1
	 hRoCnlCVIBvzsgZyb9g5yMvpiVF3xbBvk0QizBZM8W+xuOxTD8SRVp9BUXPf4Pnf9sNpS
	 BqutCGQbkyUeRJu+0IDpx6agYeRWNIjdDOsJDr8qf26xrEX9fZAeYT5C/sjO4AoFPxDFf
	 PJxNt05WbavT7tY/P+kIE+64wuhVQS8iTw28R4cATivCbhyU6eGnT7SVyLBrE4uzOrmFL
	 xKBaMXRcMquXdkMzDBawmw2zQitc2zw0W9EpmZwK5mTz5bbVwFHhbJJTy00xvUt9pWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E4B606D810;
	Thu,  5 Nov 2026 12:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268F41F00919;
	Thu,  5 Nov 2026 12:51:55 +0000 (UTC)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: alx@kernel.org
Cc: alx+linux-hardening@kernel.org,
	andy@kernel.org,
	bartosz.golaszewski@oss.qualcomm.com,
	brgl@kernel.org,
	dakr@kernel.org,
	devicetree@vger.kernel.org,
	djrscally@gmail.com,
	driver-core@lists.linux.dev,
	gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com,
	hverkuil-cisco@xs4all.nl,
	joe@perches.com,
	johan@kernel.org,
	kees@kernel.org,
	laurent.pinchart@ideasonboard.com,
	lenb@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	namhyung@kernel.org,
	rafael@kernel.org,
	robh@kernel.org,
	rostedt@goodmis.org,
	sakari.ailus@linux.intel.com,
	saravanak@kernel.org,
	schwab@linux-m68k.org,
	torvalds@linux-foundation.org,
	zanussi@kernel.org
Subject: Re: [PATCH v2 1/2] string: Add strprefix(), and deprecate str_has_prefix()
Date: Thu,  5 Nov 2026 13:51:54 +0100
Message-ID: <20261105125154.83478-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d3b325ecefd1d991ca25a4de2a859353f3ad7cfb.1793882260.git.alx@kernel.org>
References: <d3b325ecefd1d991ca25a4de2a859353f3ad7cfb.1793882260.git.alx@kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi Alejandro,

On Thu, 5 Nov 2026 13:46:29, Alejandro Colomar wrote:
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
> Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>

Thanks for your patch!

> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -545,16 +545,33 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
>  	       sizeof(*(obj)) - offsetof(typeof(*(obj)), member));	\
>  })
>  
> +/**
> + * strprefix - string prefix

Naive me assumes this function must return the prefix of the string,
so IMO is it named badly.

> + * @s: The string to be tested
> + * @prefix: The string to see if @s starts with
> + *
> + * Returns:
> + * *  @s+strlen(@prefix) if @s starts with @prefix
> + * *  NULL if @s does not start with @prefix
> + */
> +static __always_inline char *strprefix(const char *s, const char *prefix)

This returns a non-const substring of the original const parameter, thus
allowing the caller to modify the original even when it is const.

While this is not uncommon behavior for existing standard string
helpers, I think it would be good to make new functions safer, by not
allowing to drop constness.  Using _Generic() can be used to support
both const and non-const strings in a safe way.

> +{
> +	size_t len = strlen(prefix);
> +	return strncmp(s, prefix, len) == 0 ? (char *) s + len : NULL;
> +}
> +
>  /**
>   * str_has_prefix - Test if a string has a given prefix
>   * @str: The string to test
>   * @prefix: The string to see if @str starts with
>   *
> + * DEPRECATED: Use strprefix()
> + *
>   * A common way to test a prefix of a string is to do:
>   *  strncmp(str, prefix, sizeof(prefix) - 1)
>   *
>   * But this can lead to bugs due to typos, or if prefix is a pointer
> - * and not a constant. Instead use str_has_prefix().
> + * and not a constant. Instead use strprefix().
>   *
>   * Returns:
>   * * strlen(@prefix) if @str starts with @prefix

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
