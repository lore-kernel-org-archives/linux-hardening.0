Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794393283;
	b=XSKXP5NFlOSr2MaBv9BT2UDrjRzIKizwm4qZ8VLJlPvDyaCFMY3pbMExUA1tHn+v7kYD
	 yPyHh4JMGG+kROCOyiJIZuou7AGOm7O1/aczDW8ZzYYP8+bd0kN22GBtSfjIGSLWBzXZT
	 Mb5cTLQX4UrPZVD68DNYv/U3jZttvIgYbemZeZUyS5YKkePG9ZuRwZwRky4vpbUIXh5F9
	 RIMYWUqRlsoJdm86HtQ85E1cx2JuHW4OLkBMlsX09Hv0O6T8Ur5Q/QJ22eH8F5B1obeBC
	 GGVX3taBAGku7CSVVGFV05jVy5Lwg3/8e28QgwRxdIqAYXjXmJdzTH7+o00wPsO7Leg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=B0BstBB2s+mXG455PQXyfJhRhSXomdgOjXb5/JFNaGE=;
	b=1QWtDLeexdOFc2LdDWog87GunE9zm292TLLHGgAaWi/2h3NBH2IpL/Qu44yvMr4qOV+S
	 QjpcAeCgNGsg4/g/1Dk9DLBgomHZFTsP7rp3PnjiU7xD5OHu5Ugr51HKctTTfTy0KzYZh
	 RfmrjyUOCWOwvnqg8TgV+ERI0pKNWxct9+/89mQlQQKA9gTeqo4w14aYnG4bRT10YcTCh
	 0K4eKUSj1OYHK28h1VTGw6VVGomFGdgNx4Nx1kdVtK5GOP2w8VtRGE9ntSKsJ3EXC5re1
	 FPGmxzEJI2IDg8x2XJVCxHyAICuGQM2QI06c4/+5me9nZxDd8GJM1Pd8ZB+1VVItGzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wo4+YNlr;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D320606A32D
	for <linux-hardening@vger.kernel.org>; Wed, 11 Nov 2026 10:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D320606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wo4+YNlr
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so31742085e9.2
        for <linux-hardening@vger.kernel.org>; Wed, 11 Nov 2026 02:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794393281; x=1794998081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B0BstBB2s+mXG455PQXyfJhRhSXomdgOjXb5/JFNaGE=;
        b=Wo4+YNlrKrnltc3dTrFhFyp8o565rovrnVKvkcx3eVzs7mE3qiNP4os9f3zKzIUO7q
         Mo/E6HxBENrz/Twy6Hr0jn0S9RD9and66fqE4mLAn/XVoQ9oGhz/5FprThWZmcB1lSHC
         Xw3GiW0FU0e05EIYsy/TOTtxkzFOG4Rc7Et1sma46iXKPmLCVl1BoEbBdP3bAJIvboW5
         RDrss8nRI9XAY9vaYK8uPgGc9tmFypYAcAnxtmeiIEQdKL+6MGcergbBBIDQPsOYUs9v
         8reLcEbCJIqvaqTXvPspIf7k32+QOuydWVQAkHaiFp6OoRWnSK1pNXkuh2Jp185lV3Xr
         MWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794393281; x=1794998081;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B0BstBB2s+mXG455PQXyfJhRhSXomdgOjXb5/JFNaGE=;
        b=C73wHTkJ2z03eeP125vB0z9hyN7Je4o+iR09Akl3WT2IsmrSzBOs95xCtFKo48r+cf
         iVGIhTRh0A80cJrbWkS1D7c7tFEBRQcdD1GoQrlNiXkl6D63EOKXyM/8ULd4ViwQRb6t
         dbYioSgfJk4dfIDUS43tITjagRmaYXKkWTwHKhhY7Hz7gOHKCQUaAym3YrnAyaU4vcDR
         1ycKIKJVcBTJYSNIwkas/8WRpAy6AaNnuYVp/wrJcoXUTFVaVdZn53nROcsJhBbtdXAL
         TiX+lP5+a+y+28Pt2sHSobxCA/47f+mqi9wTFILYwCDu8L13meUG5ILsXu2YxnTf8+li
         TdiQ==
X-Gm-Message-State: APuU4Z/eTIjcLN8736g9mCVb0Xy7aB4Yd2cT21iJ7arVyEg1xCJ/Rj8+
	6/zJb1MroRFG5zI91Wgs+mrTOOa2KI/gu7dAHgCBD8ZIg79EKdRwWOaT
X-Gm-Gg: AYBFou1QV3lG2Hx2q81K5Ry6UmEYjj9GxMzjhsgprV9bgy/IMKHV9876RJDknH7bV6K
	vdj/eY7/DXvLZ/c7RuUmWqkT9EXC/KbJXMPB1KJQ9rbd8yeIwEGWNawwdZJHO7+O2fwaWfn+afd
	RFDb0M6H00bamf9K+LZzN9YP68SfjukF1j6ItnwDSwgTK4YSh9Iex1yZvnxexesYzRUIkOVgQIy
	GpJcZqs4Mi8ZYRyaQIVuMDql0yqqK7Cn2c9kdaoaospqAX7wOvjf/t+N1MvblFcInAmd8p5o/Xh
	M0mjTfp1/rBHgXYGG8GhH9DQ9r9lfScWc51SJNhlTp+6o88hdURVdbsYEpfPEmmjsEKYhiNI8ra
	G3ot28KqDVOJ00mn/pCuDc7TeWi4dz++WAiG6dBQhHiZQO0FFA5HBDSI5Oz44bShnLsywxEhOZ/
	cPuSVJ0ELjMFaqZtmm3JcdgEvKvWFXyE7irrK1He/NMf+T5q29n4Y3hKq76YlM9BPQzlElDvm4m
	CltxxiNybshDIdJM1blsBITJhluNC/xREpBdC+kuFFT6k9+3zOP+3y8N93F76OMVJOup5NCikmn
	bg7gqWNT1TjuLh9jz9GC7uWAZzzU5KaiMrUEue6bHXI3CWW17t52HtOk3kQ4ceOITU4=
X-Received: by 2002:a05:600c:b86:b0:4a3:2f35:38b4 with SMTP id 5b1f17b1804b1-4ba09377b2amr30972055e9.10.1794393281331;
        Wed, 11 Nov 2026 02:34:41 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fba476sm157078915e9.2.2026.11.11.02.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 02:34:40 -0800 (PST)
Date: Wed, 11 Nov 2026 10:34:38 +0000
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
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 5/5] string: Make strprefix() const-qualifier-generic
Message-ID: <20261111103438.2f822202@pumpkin>
In-Reply-To: <35bf6672f84f07de3f40e8db9e7fcfd643894fec.1794323750.git.alx@kernel.org>
References: <cover.1794323750.git.alx@kernel.org>
	<35bf6672f84f07de3f40e8db9e7fcfd643894fec.1794323750.git.alx@kernel.org>
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

On Tue, 10 Nov 2026 16:33:56 +0100
Alejandro Colomar <alx@kernel.org> wrote:

> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
>  include/linux/string.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 9e59f9697c9e..55ca4cb5122c 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -590,7 +590,9 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
>   * *  @s+strlen(@prefix) if @s starts with @prefix
>   * *  NULL if @s does not start with @prefix
>   */
> -static inline char *strprefix(const char *s, const char *prefix)
> +#define strprefix(s, pfx)  const_cast(CQChar_of(s) *, strprefix(s, pfx))

Isn't in enough to do:
#define strprefix(s, pfx) ((typeof(s))strprefix(s, pfx))

which correctly preserves all qualifiers.

David

> +
> +static inline char *(strprefix)(const char *s, const char *prefix)
>  {
>  	size_t len = strlen(prefix);
>  	return strncmp(s, prefix, len) == 0 ? (char *) s + len : NULL;

