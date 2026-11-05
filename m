Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793878074;
	b=l5Akoju2v/VcRyD1bDzowVPnwvbbpaH99BICSItpwNDeIzOETtRLjvylvXLHYQgxO/1/
	 EqaeuMPs2F6rJX/XjWnyrQRVm4QURV6HZY6v2mtkhePcrNgrI1xJ7hAC9dO9MYi435HmG
	 hKkVJQzYZoFa4+EMsSbDC8XqlSQPbzJrlyGVDCcN3g5lcqO2pBZLzDnr8SoR/bWZB4NBx
	 fnoqOAnd74RUDsBXVMxXBFvhCbAJX72LGuUs9ifp0F1c4y1cV/6fv8f7Fo9FqWnSh7uos
	 FM8SZl1JnFMj0BpW8ewzKkv0N9RGsqMOqYN1Pl9e0xwX4D5VkC0mFlpkMz1pVGVHNmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=UgymWUGDvRFV30kELqGcA8Yq/kp5tSw6vqhDEg+/UkU=;
	b=sWFspDvX1diYxOubaXChsd0HSRmcOW6N3WJAeOdk9jwPZx95UhijoqFYtbOsfsR1nBHg
	 f6WrNUnPM4tPanS2TC0AQCHv+tZuQrb7h70eyoUZqljapjMCijtUH7vsKUd85W2Masyc0
	 4lh3gl0o6SxyKtKyxemeCr9AJ7UwHTdwYRRQESfplXVz8K7SAAiGH2gqh8/EisgD35L+h
	 jXCLoqmfTZxOxxL7AmX6F4YHUG0+vM6yPC1JlldOLYW/ZMdwNmlO0DFRXpU74rfGkJWXF
	 OZqOYYdPuVIKegE+lGiSdx9fI5KYUMv726QrComHjYCpk5VEtD7A5L1Vky1SZ2BYyrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=skgm5fm6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80580606A326
	for <linux-hardening@vger.kernel.org>; Thu,  5 Nov 2026 11:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80580606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=skgm5fm6
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4ced671398so270329866b.3
        for <linux-hardening@vger.kernel.org>; Thu, 05 Nov 2026 03:27:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793878073; cv=none;
        d=google.com; s=arc-20260327;
        b=b8TMVDO3sQJJP2OmkQiwJDV3CjGYmPGwlJaHcnhAanrb3Sa8Bb++i2Y8SCksgsMhxM
         qoWuQiOvv6Ju1gk7nUnrgTSGXMoD/Hnt0vbyLcxQZVDoMcMzo/lK4z2SIAPcu0opvIpN
         jGfj/LmdJE8GO20h1MMJSYh5RioTObO/tB+nukphnoqGT/r632LVUdErdy7VYHoYJrg9
         H3llnREljeFHuyniaj2/o277O1ny2v2MGZTmFA2V6UHQbA4S5QkgblAIZO80bmBugAx4
         7dDUGY+ZMn8gyXT0K+cZWxCieQuYRTXsCM8ZPfH71jYsKzATmPAKi/N5SB19D5Ovp+s1
         w6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UgymWUGDvRFV30kELqGcA8Yq/kp5tSw6vqhDEg+/UkU=;
        fh=SI9ztXFtTQCiY8LKqI9tKrldJ/VI0eHg8D3TWZuxBD0=;
        b=FRszPuiHY0pygGWnHJIVPDeC8YptbZYFNpj1FkHQh1hk3RZ8KxbNMDm9CEnJJJQ3x9
         XIC9beLBpd39rJee6kLvvmKYfm/DLYMlK6u6wQci3vEjOnuhyw0gv7Oihqy8y2GATgth
         uxFRJuoK/92MSNXkhUIusPictWkHZ9LduIBIy2stKFAX8wfFAS3mzxhwM925G50U1/sq
         Z9F2G0F2Ourlx5A7u3tc4Mw4hVLpThQX8uMbh8Q4fbTf/Dwcfb9Hxxk8l6ADFDAMo+tw
         pWB33/ekysvjGpbKl91DW0ZtMOEXoqhNwYOzDp8o/SCizlDRCd39CwaNDY5yaYoqXR99
         p+Yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793878073; x=1794482873; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UgymWUGDvRFV30kELqGcA8Yq/kp5tSw6vqhDEg+/UkU=;
        b=skgm5fm6oAWAgv/QVCq1EFm/mHk6ogMQEriq5kNbbrdxCpxscJsl+DVbnoxhuFlxLd
         vpOEAXk4t8Us8lYbydo4Lkh/rrArrqli9+hvlvKBU8YfaDLyI9GZGKoooB/b0vdPaMYV
         JuKkZi4KuhaladOnnC30rn5+5auFXjI7odgfwe3bCKV6tngTAW6ACSoUfVCWKJqsXKIX
         jxEtLNpajovzg1ZAn6mqM9CQndl7qv0vcjhh+A3vKBUj/zkiqZVv5xWyOSeziy9qx4zd
         Srk8GDlwmg/wA20VyrcEYyztNba9JvovUh1RMB2E2C1KTO6V0On70HG6wXIEyNfWKBLP
         SN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793878073; x=1794482873;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UgymWUGDvRFV30kELqGcA8Yq/kp5tSw6vqhDEg+/UkU=;
        b=yZhjDR0D1JJPqlJ3wFSwVaNPmFmHDo9RBkC3Ln0x+JanQsoWwL+7hlsc0btVSOL8XK
         KS1vQygNB/DugnmCbHktse4RLSFcngBylCngvlVEBgYkCualGyBprW8Jd3NCZEzrZBuc
         vzn/Tm4JGjwzCTXKZkNbLKIvuh6WZmbSsf7Ivpet5PRTrA+eGfUp4ZRMubHeE4X1OQg2
         BgS+wxSzr+AFs+qp7idaklhPHJqDZfW/d5w29i1A+WNSmS5wVIAR75TLTVeTKifKT5Pa
         sT5azHvhpIJ/bfF4t/4tcWWuv67FEUEagZJiMO7t+wXmaaPJYzgfBwNyKRgF2Gc/Fwlz
         lTOA==
X-Gm-Message-State: APuU4Z9Ij36c8enroE2iqJuaGuhPqtSiHCidKN5grQNFVVVz40UfJSas
	1d6RSsrWh0P+qmJmuXLCUdmw4yznLpmaPDJ5T74yutHdPKx1QhqOoB0MvpsObQKBolTd7R7u08s
	4sB2C4fHq1OgQEifOOiTyKJZXXyGdL2Y=
X-Gm-Gg: AYBFou2rt9XPOZ0oRdNIjUZeRm9tPORIeyTY5XyVgEo5uJo2n31SZG4ylr10SnrcOUN
	w2l9wotbfeVkDDgqKsg/hjYQMdmmp9zTTqHytfuIhpaaUbQr+/31aqtcCqc8g/hP0IHoHob0vyF
	zeb2rTyRV0WqkE/eWmA1ZRhOpDOgo66aetvO7HwDLKNzGHsI13UjeFmrw5CrQdD2Stp5KpI9lCV
	64ojorruF0GWDRGmGGB6LpSv2e2FdYdvvjPepKyrecZdCWKQsIXn/IGSf90uAJf5iE8X+t3+//n
	XpdvvspHVTCV61ECwp31P15JxUYgVCm9rGKbPCwztc7HDJzI2yi1YqKdRbiCkYaVbCsqskMkcpv
	cCDC2vkT0Gi9IjH5UveyiJEXjxkAdWObtsAf3ZODMYiLh6KG/vPjANQ5JwsW1w7CQ8BMVa6DtBC
	ep/QaMtWUuNogzSZrlyE4Sa+xL6Npjv4xkg3G0Mdxni1vc0CKTsWHp3yfqSGse0K+tV7dczy+l5
	utbDMMnuPWXumk9o9wDFweT4MIVUL23pssObHnLUZkWDuKHdkmCqLapx4xN7Q==
X-Received: by 2002:a17:907:2d8e:b0:c42:102f:15df with SMTP id
 a640c23a62f3a-c4ca7a0dc8cmr1782618666b.8.1793878072888; Thu, 05 Nov 2026
 03:27:52 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793876837.git.alx@kernel.org> <9c81f6f62fd0e908e683c4c08b09a1f95bc2ec9c.1793876837.git.alx@kernel.org>
In-Reply-To: <9c81f6f62fd0e908e683c4c08b09a1f95bc2ec9c.1793876837.git.alx@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 5 Nov 2026 13:27:15 +0200
X-Gm-Features: AclHuK9RJR52OSPl8iPokfz3apA8SScdKPa_SxHmGln1p0LZpPbZ_VJGI1ROrO0
Message-ID: <CAHp75Veb=TsXJcjqQeD3ciNGRvLebGr8t8TnZju6FX5ANeVNTA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] string: Add strprefix(), and deprecate str_has_prefix()
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-hardening@vger.kernel.org, alx+linux-hardening@kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, 
	Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 1:13=E2=80=AFPM Alejandro Colomar <alx@kernel.org> w=
rote:
>
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

Ouch!

> Cc: Andreas Schwab <schwab@linux-m68k.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Bartosz Golaszewski <brgl@kernel.org>
> Cc: Daniel Scally <djrscally@gmail.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Saravana Kannan <saravanak@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tom Zanussi <zanussi@kernel.org
> Cc: linux-acpi@vger.kernel.org
> Cc: driver-core@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org

This list is twice as long as the commit message! That's why I highly
recommend moving it under the '---' line below. The email headers will
get all the listed Cc and git history will be clean from this rather
noisy list.

--=20
With Best Regards,
Andy Shevchenko
