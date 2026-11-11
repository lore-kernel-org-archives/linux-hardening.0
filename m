Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392920;
	b=g61pkv66TQW8FYuVvM6PdwHVrIy1hD+oDh5keENYSASPL8LJXU4K5uWF1o77ELR8ELNi
	 rNdN/zlK6mhTwgo85JsU2IyeYfWhJjW2bWcs7/gcV/d66h38rtfuGmD0Focugl1l0BSDB
	 7+w/K1EsyG0wUdl6uWEbA9wQNS9P9obHf4At0L/Q0LDA/8JaeTv83v1GHvdYhbw2+3KWb
	 3hulVn/P3ZR8n7l9jQu/61nmZHDKeFkC14rwZwFFZzVDjKgx6ambOcJju1S3Dm7q/o6zZ
	 vE2/ROlvtdWgPzXDH0UUV6dgn/d6QonUId1pnnEInvlegVwfe+DMmkonbg9rvvtpLgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FgfjZ6gPNStEt/RNYx2qJuKKf940MnozlyJhtYv0suI=;
	b=5VF3A9OELYNIMMELpXRmsl1VO3+KyrpnwAn+vzwXcLkDtxrXdaG462AagdcELDNjGgVp
	 8kZfhruVaCB36MzJTnOgqhdBgDQ2gzbHsO0L8JlNu1U3mlAZNfW/ooZ6Fvsb2I8RBZzVP
	 54ASEm8joF2AcT2GmD5c754zgLpLVCOO+wvGExa38BMyTi2LyVZqbkxRKPw6fqbjHKQvZ
	 Cgm3cBCNFiG0dUnMElrnrv4VXv8H1Aue987e/Q52H4v8ayGyDaMIu+IB1KNUlLbrYTe+5
	 mK5dZuQLKmNxwlZwS4VpXuJ864A7ZKNIIiQbH+wuCeyhYnqL6PqA7ER2ld+HdJnwAxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zWDbBcPl;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D88606A336
	for <linux-hardening@vger.kernel.org>; Wed, 11 Nov 2026 10:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28D88606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zWDbBcPl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-498f5fa5103so801204f8f.2
        for <linux-hardening@vger.kernel.org>; Wed, 11 Nov 2026 02:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794392918; x=1794997718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FgfjZ6gPNStEt/RNYx2qJuKKf940MnozlyJhtYv0suI=;
        b=zWDbBcPlqS1AC19c/HKVJJivTF+W3QDFDNQtIKOvb3hEChlZ4gd3uHJGRCqzbATgi+
         4WA95HRAW2CM31vuAQddh7JXzptPeou2EnYnKEFZGeKj3eOKR3tQjEXWHFnPKbtomdzT
         qYebL4M08+kzm+fecTEfuUPhgT3cf2mQl38aA0zBrA/RVjVllPMR7+CI+ypkaVRyCVHv
         JyASfAk8iIqtIvzNX4yFl994GJnBbETlTTUETK2oIjy7wEOHZ2MHdtCi1gKcVIEdxh/5
         IXw9112LmYt355Rq2qfFzl+8sFHcxLKC9TnUDf617SM9jDHfoqgOW4LLz/zDpS2v6VsY
         vYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794392918; x=1794997718;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FgfjZ6gPNStEt/RNYx2qJuKKf940MnozlyJhtYv0suI=;
        b=kZd9dapfbxbeWh0237Ra5Pi1lzEqIHmB2FqLKBlpy/a98VsLPvjqfrcGFUWDm5xjbs
         uQzo1F3vadkUDH6xTRpcrVgQBpARXHqlaUJQymdcYDwwUKJDlEw2a3WXzC+RRuyw+Z3G
         SIijMz2+jSvZP3a6vsnUfG4Y3O8RdjrBNxi1IBWT3moOS5ilZGjVwEb9eT1H4vNsdb54
         bQuMFyeax0j7RkIGsKGOjCaDRusOq6uXa/16aMX5sZwb0L6nsTm3SgaO7mz1hhPlel38
         hTYMIANk4JAYFB6lUEKspbvyVHGZ2v60d3JANpOyE+SVfdf1a5+Odct5uo4UUUwcez4v
         +9qg==
X-Forwarded-Encrypted: i=1; AL+hErGoMXCgkWZI3jgLBGP9mr+nrQPvZylYQG168siZhPS2iLjacpAz563Qa3WA0TmLsIsuzozXjM3RzunOidVTFZU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/logZKmsb4bRkcCavRRWJjWXNOf3Q1ylAk2ij74iML2nhvz2du
	AxLbzcV0aBfmR0yJPTm1FT+R2hScCpts00YRRLn+6JT7vw6Lfv9OPQ9J
X-Gm-Gg: AYBFou1U8uK4SxGEDyDguSantwcLbPEIeVfwsSlcd01BF81piDTc3/jz/RIFuI9VpyU
	TSQX8pJKv/WAHhvNwLlNoDJ4+AOFemxEztz8GxqwsAQYkhRgLYNVvqKl1sEjHp/+7tUTI6EWeMP
	PVnoETNAalHOKcob1nepsfWj/YBObl9TTBkr8J/iaWS7aa7SCL9ylolkKFNPuTPWuvjLXUeBtoS
	RkmRP+SoJDRXMJy1wAFPHMgLOAJ4HAld1EqREhmQ78bPSCSXzMCnDEq6mRh7UfLUAEn7CV9kjs+
	rud0mp3iWeg4gepNEbI2DpQAAdqLA/8hP5SOpYLSzEuFMFE4nObg3OWAE6KKRVX21dzOMklck+z
	UEOwHKAdKWF5lizYRCwoDPIkrGC1uh9WL49YdODYS8WstOK9ViWRPlCfKSrZY/x6K4H1L0KGo+d
	4Lsd05hG/X5ZKn3T8asca0PkbvfNWWVKx2pxK8Z0szc38EG0WqtrlDjdQSn1UXtIJxy7UAr64vU
	OqXNj2+X25qQ7R2hRaZJDZCqdYvSopoXFuna1WMCOYqKMIb4e802sgbg8wq6eNGazLJ0zGxy1BM
	1neTpWScVieBhirnzU7stuuMls2rq6gfyBWMkDij6o/CB5oFH0HmD5h1MFOGP+13+A==
X-Received: by 2002:a5d:5f47:0:b0:48d:ef7a:e59f with SMTP id ffacd0b85a97d-499c75528cdmr3034821f8f.17.1794392918442;
        Wed, 11 Nov 2026 02:28:38 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498361f674fsm10337668f8f.33.2026.11.11.02.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 02:28:37 -0800 (PST)
Date: Wed, 11 Nov 2026 10:28:36 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Joe Perches <joe@perches.com>, Alejandro Colomar <alx@kernel.org>,
 linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, Andy
 Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Daniel
 Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil
 <hverkuil-cisco@xs4all.nl>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>, Johan Hovold <johan@kernel.org>, Kees
 Cook <kees@kernel.org>, Laurent Pinchart
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
Message-ID: <20261111102836.759ec121@pumpkin>
In-Reply-To: <avOn57pfHntiwcaD@devuan>
References: <cover.1794323750.git.alx@kernel.org>
	<35bf6672f84f07de3f40e8db9e7fcfd643894fec.1794323750.git.alx@kernel.org>
	<64aa89daf23821f95780813fe96882ff61688578.camel@perches.com>
	<avOn57pfHntiwcaD@devuan>
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

On Wed, 11 Nov 2026 00:27:28 +0100
Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:

> Hi Joe,
> 
> > Date: 2026-11-10 08:32:41-0800
> > From: Joe Perches <joe@perches.com>
> >
> > On Tue, 2026-11-10 at 16:33 +0100, Alejandro Colomar wrote:
> > 
> > no commit description on proposed patch  
> 
> There isn't much to say, but I'll add something (the explanation of why
> the parentheses are needed around the function name, for example).
> 
> > > Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Signed-off-by: Alejandro Colomar <alx@kernel.org>
> > > ---
> > >  include/linux/string.h | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/string.h b/include/linux/string.h
> > > index 9e59f9697c9e..55ca4cb5122c 100644
> > > --- a/include/linux/string.h
> > > +++ b/include/linux/string.h
> > > @@ -590,7 +590,9 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
> > >   * *  @s+strlen(@prefix) if @s starts with @prefix
> > >   * *  NULL if @s does not start with @prefix
> > >   */
> > > -static inline char *strprefix(const char *s, const char *prefix)
> > > +#define strprefix(s, pfx)  const_cast(CQChar_of(s) *, strprefix(s, pfx))
> > > +
> > > +static inline char *(strprefix)(const char *s, const char *prefix)  
> > 
> > Why introduce a new coding style?  
> 
> It's not style; the parentheses are technically needed to avoid macro
> expansion, since the macro has the same name as the function.
> 
> Alternatively, I could rename the function to __strprefix().

Or put the #define after the function definition.

David

> 
> 
> Have a lovely night!
> Alex
> 

