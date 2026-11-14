Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794671620;
	b=QaLALX4jUIbcV3hfFLqjCxxwBL89hvAb7CT41Y7mz543pRMIYUqIyyU6K0dmEt+iK2FA
	 AyhTBjMVYMpI2Md60T0pJF09Uit1cFsueKG/L33fiv39an0Y36NDCc4ibxK4JvWBHdAh8
	 MwxPs+66c9B/KYsNFf83gmBmPcGXWy61hnk9zctxfUgDYULrI0mwxoNGqGPHH1gVk/NYW
	 HftoOFu2PNHbLkD1y+kyAYf/BDO9XJ1r51zxHwit0NnRkBO+RTuQe+HTnAePG4E8WnQQH
	 r718yY4C4h2FZh4nlfCUudIPNz4I9TCuVe9ZetNtBLaO5p8WrCozIC83yaPozD/e3HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794671620;
	h=DMARC-Filter:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Rspamd-Queue-Id:X-Rspamd-Server:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:X-HE-Tag:
	 X-HE-Meta;
	bh=eNWfi9GOiU1H0L6HIja6i+gawTbPJhBoUQGTRucnQ9U=;
	b=LGT1C/gjitshqygSSqarb1wclX0sz6AEZcCotY3RW73xgBqL7l1L4x1fqR/3sku2D7Fa
	 6QDaWHSjooI3uHj8m+t6AGFzfdxYaNlKZSnWX09M5PVdOFyTAITFAZtamA25JqNhiN/vl
	 szasOfaaWEzST1rmgd3HwJyy+3w0QaoCnWuyQZfZuJKzP7OQFZI9KgNT4d7ZtdQHqkort
	 FFHGd/wPFKhZJUsuTlT9cSUA0ZTw+zIUUpPlNpn114q+MYT3jclsQG9FW5W4ajs1t+eqp
	 yCA+9gU3K4kOiRVlcaJiLB71yyTX6AuyV6GPsIiz+uawMWwTm7n7gourQhR5fuCV0qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=perches.com;
	spf=pass smtp.mailfrom=perches.com;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DC5606A323;
	Sat, 14 Nov 2026 15:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2DC5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 826291C36F3;
	Sat, 14 Nov 2026 15:53:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 1370B20026;
	Sat, 14 Nov 2026 15:53:25 +0000 (UTC)
Message-ID: <c113f651d1ce1b2d42ab9d0c59ae5a0cd17ddb6a.camel@perches.com>
Subject: Re: [PATCH v6 02/19] string: Add strprefix()
From: Joe Perches <joe@perches.com>
To: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki"	
 <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, Andreas
 Schwab	 <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, Bartosz
 Golaszewski	 <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, Danilo
 Krummrich	 <dakr@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Johan Hovold
 <johan@kernel.org>, Kees Cook <kees@kernel.org>, Laurent Pinchart	
 <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, Linus Walleij
 <linusw@kernel.org>, Namhyung Kim	 <namhyung@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Rob Herring	 <robh@kernel.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Saravana Kannan	 <saravanak@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi	 <zanussi@kernel.org>,
 linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Bartosz Golaszewski	
 <bartosz.golaszewski@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 07:53:25 -0800
In-Reply-To: <0eaa4ce73a2b164fd49e3a9f71244a2e3f45b7bb.1794667407.git.alx@kernel.org>
References: <cover.1794667407.git.alx@kernel.org>
	 <0eaa4ce73a2b164fd49e3a9f71244a2e3f45b7bb.1794667407.git.alx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Rspamd-Queue-Id: 1370B20026
X-Rspamd-Server: rspamout08
X-Stat-Signature: xnwnob8oq6t6i5c5p5cjbo3brg66pmci
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/iviamKIERabUGi7VyUJDz6YDYNMM0ODY=
X-HE-Tag: 1794671605-49699
X-HE-Meta: U2FsdGVkX1/PscWlXj8hrMl1UReSYw3dM2m3OiBWsvz3QyeKXfa9mr/+pRCD6ATTC2OKs3NQpXJcuoducTEvCc2emcwDrcObIvk4Gx48OMsXSH/TsUDdl72G/M2cyJ9H+vxXxdcdovXNA8lpy8Da9SXAmEmInPyI33xN5WLNIAjVXPHEOeBc4LBGkko3rT/TL6xeGVOpBt8xGl6OtBka7S8WaLAfXd3o/wEANc6uWX4CAiEYNiPEwlXB1mq3exRHaDvn8YQvxEYyO10MWg1d1u3mVBGGOj+4QV1Yzi8HjGXpUvmlkHqytcKlrbefNtuxfD2Q7nIFgS0mvSFf/tGEicSlADm5IA2G1s8rZ0z5vjQPUKspU/bztA==

On Sat, 2026-11-14 at 16:22 +0100, Alejandro Colomar wrote:
> As Bartosz reported, str_has_prefix() has a bug: it can't differentiate
> between an empty prefix matching an empty string from a non-matching
> prefix.  This is a fundamental design flaw in this API, and not
> something that can be fixed.
>=20
> As always, this is a consequence of choosing sizes instead of pointers.
> Sizes are often the wrong choice.  In this specific case, pointers are
> more capable of differentiating these cases, as NULL is a special
> sentinel value that doesn't need to overload a valid value.
>=20
> Let's implement strprefix(), a function that returns a pointer
> right after the prefix if found, and a null pointer if not found.
>=20
> We'll slowly migrate existing code from str_has_prefix() to strprefix().
>=20
> Move the description from str_has_prefix(), and describe
> str_has_prefix() by comparing it to strprefix().
>=20
> Closes: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-each-=
prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
> Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
>  include/linux/string.h   | 29 ++++++++++++++++++++++++-----
>  lib/tests/string_kunit.c |  9 +++++++++
>  2 files changed, 33 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 9b3e578d9aca..14e825e902eb 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -557,16 +557,35 @@ void memcpy_and_pad(void *dest, size_t dest_len, co=
nst void *src, size_t count,
>  	       sizeof(*(obj)) - offsetof(typeof(*(obj)), member));	\
>  })
> =20
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
> + * *  @s + strlen(@prefix) if @s starts with @prefix
> + * *  NULL if @s does not start with @prefix
> + */
> +__attribute__((nonnull(1, 2)))

__nonnull_args(1, 2)

A negative of this is that it implies the return should
always be tested even though it can be known that the
return is effectively bool.

Also the block

> + * A common way to test a prefix of a string is to do:
> + *  strncmp(s, prefix, sizeof(prefix) - 1)

IMO isn't useful and the description doesn't say what happens
when prefix is an empty string (which IMO should match).

And the name strprefix could be confused with a function
that actually prefixes a string to another string.

maybe strprefixed or str_is_prefixed ?

And these are all candidates for converted uses to
whatever is the function name or steq:

$ git grep -P '[^w]strncmp\s*\(\s*[\w\.\-\>\s]*,\s*\"\w*"\s*,\s*\d+\s*\)' -=
- '*.[ch]' | wc -l
946

[^w] because of prom_strncmp
