Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392740;
	b=ZwVEqvMI8ZK6qhg1YWhngCpg4p0XNflFwbR0YDDsGfuNn2ptvjajR1CnbepvoUAeIHpE
	 eLLMpTWf+b3aiRBi95DLUProA212hJE3AwrTg1WQfl29uk9dwzxffXgPPkkUMtRY+fG8u
	 xMSTWRB8H0r69Qz8JfD+7P6srBKH3JbNydVzkdUijmBoyvOqLm7WpwUXJ25cpsVVd9aay
	 kwKwuCqdnm+73I3ucA1eM0gveGmhv8MdWGrqRaxHeoRgdIQBi1QY81Cr1tCg/dbuTtNP+
	 gfJJe3mp/k2saXY2RRAgJYbOslx6MvcKOLzoBEXPOE5KxJkvMBpqUPFqMpEyVd1H4SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=WCGh2v7nU1b/qpgNrVkksi8LEcAJjTlz9SScJQHog1U=;
	b=3dqGvJBjzRwn/ScM3qyFJvW3wJb07EpiUNgCSuDiWPgTRLg/u64L2oldvaCBAd9+pKgp
	 hYW4vk09KaRlroJ8P9z0jAzaFMUIhMDj/bl5ychAZXHZoz4rQPzPG7C7fdfMgCMhDl35t
	 e1aXfF1URSP5aafFIJbiiaS5xgDcNWQPwIxtefGrkwLFp0eCBeTtgOK9LWYpg3gs2ta+W
	 3zl8fm+GfVMccz25UpVzo96TBujPII6uHxD9ptSTNE/jlaJTxJVX3cgwPqPYWR2xfVVMZ
	 vkY68IH8ft+ZbWDwFAFbPsRgUMudphXcJcyqyyy4KE7MU4Pssv/H7o4auzHeMEjKRQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mb3uhiUC;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719E6606A324
	for <linux-hardening@vger.kernel.org>; Wed, 11 Nov 2026 10:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 719E6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mb3uhiUC
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a210470b49so24528925e9.2
        for <linux-hardening@vger.kernel.org>; Wed, 11 Nov 2026 02:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794392738; x=1794997538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WCGh2v7nU1b/qpgNrVkksi8LEcAJjTlz9SScJQHog1U=;
        b=Mb3uhiUCOo+9OL8nkk0DPqlbHMU+U3YfPJtQRGohaqBLQ8OevIfv8dsETu4ueSqwRn
         NFUTwQnpCyUxKUDcsxzqJiYueO55nV4pkpQgYg9LUK5WPus9n/ERdDgHae8RQ7j2Dw+4
         fM3ibr2Y6ts1e/OTqbgJiTQW3L8WDSaeJuxScEHyWMzPN+bGBiq2tlQqZ+g6LQEpKD58
         mnmah5jGdWJ/FHCGptkaUokAM2nmjVjDMlQqXY1Y0+QNVEBolaI9RZeQ+wAs3afJIVDJ
         0j7wdyVZa4FS6RKopL2kvM92RArS1Tu/5W/MXYkBtd4iocmh7ndrHYxmSyr8Mi6yyFzr
         +H+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794392738; x=1794997538;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WCGh2v7nU1b/qpgNrVkksi8LEcAJjTlz9SScJQHog1U=;
        b=pr43B8P2//xJIRgXGSz1mOgn/EA3HYb/INv876Are6is03LatUqe6kxO9w5USMuARV
         iO85zh6ap3+MD6YE1iOQBMPogWDFSvgsFIv9m2hVlCdH/lVYpxJaTXfI542hQmtC4MuK
         03gm8t2eOGDq40XGEOF7OvSEBlRIA+TTV/DYx7JSH2b+kJ5/VWsZmUtVGTo2DuLapcE1
         BUswINzq2uyHIoP5cfnPBAjFZOu1jEnidH4MFrLGA38nB9xobCpvfeMMeVV24u46EWXL
         5O6B9MjP2ZaLQ/qWMuDqR4FUKK+4+siaczLX12iNORrMuqiKInP7iomVCSL1P+b0eZm7
         lhZQ==
X-Gm-Message-State: APuU4Z+wkao0jJdNs+jjrpH4+QklTVPCHUd0pToV4PRGEb3lfCox2xcI
	WPWkr5HoTwA/DJL927QiSvp/RClBp15vv4bOuaNnAXDVBJkxCXRlx3Ue
X-Gm-Gg: AYBFou11Yn5XDByayG1AJ0cBYRoFD5uBjoPAve6QVbPEyv0k2Ej7fwfqpu2Q2lc2M1l
	H6zlcUwejbMQkEl+39FS46h/T15u37m64VtPaiersfuVRVecJmvBbISUf0e/pWukW1YJAHMh0x8
	VpYgwEASJga0gIeBNzIxtvggoeAqvAirLeQCp7Aikzm/V8JaN44fBgjkzf0gbha9cXx/wLCKc42
	UcSqgzfBnZsLEmCHm3se5MSrD22NBjSdW2IrgnvhXkqiQykqrK5fyqRTYw3n5J5Tgz+3TScMqWK
	yYlgGTKyc/Uajwe4ej1SVdhILlOvr435qRRTcf/HFvFNMCQAFMMDU98ys8uuZVxzlQRJZMQtEtX
	fD/C4lOr1mJwTVL0vJw5do/WtRmbknPgShr6Q9o2tjbD1muwaCDjccPTvUzHsuOxzhiuqKgsZY2
	9E/Ia4yoOAMUx9xYEypzr+nIWTRP60ov+yTP1urbPy2vy2utpEDhclU5kNYs5pEyLCRk2G7Z66s
	j5YRIDQTdlqUh68TYurQ0Vct9lcCLrmrEL8aOvPXmO0zu6QEfCpPN4OioK8l500vm2bS+/rE0gH
	wly2tK6/qVnBgAE6D64G1fbQC93OZYUzhMexgxAbJDVdzXAIgUTeIwpFzwDIck8x984=
X-Received: by 2002:a05:600c:4f14:b0:4a6:44b:2593 with SMTP id 5b1f17b1804b1-4ba093b5ec4mr41235955e9.29.1794392737707;
        Wed, 11 Nov 2026 02:25:37 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4988f5b1ce3sm8610917f8f.14.2026.11.11.02.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 02:25:37 -0800 (PST)
Date: Wed, 11 Nov 2026 10:25:35 +0000
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
Subject: Re: [PATCH v3 3/5] stddef: Add const_cast()
Message-ID: <20261111102535.434c2eee@pumpkin>
In-Reply-To: <2bf5cf7baad87b5b7b7f833df390596a033fd6f6.1794323750.git.alx@kernel.org>
References: <cover.1794323750.git.alx@kernel.org>
	<2bf5cf7baad87b5b7b7f833df390596a033fd6f6.1794323750.git.alx@kernel.org>
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

On Tue, 10 Nov 2026 16:33:40 +0100
Alejandro Colomar <alx@kernel.org> wrote:

> This macro serves to cast const away without risking unwanted
> conversions due to mistakes in the cast.
> 
> It's similar to C++'s const_cast(), but it is more restrictive: it can
> only cast away 'const', and not arbitrary qualifiers.
> 
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
>  include/linux/stddef.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/stddef.h b/include/linux/stddef.h
> index e1851c50c89b..d79a81406b78 100644
> --- a/include/linux/stddef.h
> +++ b/include/linux/stddef.h
> @@ -194,4 +194,16 @@ enum {
>  #define TRAILING_OVERLAP(TYPE, NAME, FAM, MEMBERS)				\
>  	__TRAILING_OVERLAP(TYPE, NAME, FAM, /* no attrs */, MEMBERS)
>  
> +/**
> + * const_cast() - Drop const in the left-most derivation of a pointer
> + *
> + * @T: Type for the cast.
> + * @p: Pointer to be casted.
> + *
> + * If @p is of type const @T, then it is casted to @T.
> + * Otherwise, @p is returned without any casts.
> + * This avoids mistakes that change anything other than 'const' in a cast.
> + */
> +#define const_cast(T, p)  _Generic(p, const T: (T) (p), default: (p))

Should it be de_const_cast(), or just de_const().
It is a shame you need to specify the type, but why not:
	_Generic(p, T: p, const T: (T)(p))
so that you get a compile time error from the _Generic() if the type
is wrong.

David


> +
>  #endif

