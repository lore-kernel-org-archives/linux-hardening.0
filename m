Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878098;
	b=IGkL1HjycTcAmUPe/bRB2aiDIXsq0QNSJdMyoBZkaz09Fgqj9I/OTuz7HP1T3Iesu7Mr
	 imQmYhN+g44PeTC/IBer+dNjIrm9y4PaUcFfkcpb2UFflWOYF15IHRAkC7zZJVrUUGp67
	 uuHyg27xirA8w2m8Ts53OO+cIONQlhJ3H27gAzH2CqDCeCCgVYx4yq8NpOJI9RbD6KJVj
	 eHaghyx8N1WYUmPMsJV3nyvREsM3rYatRweeO/1c0T9/VvcP1RtKbooyAdHjvUv1ay7Yz
	 0hKq1yWn3bULQgDEmWuAoQk4u/Nk7uLgB4BKkIonRdq8AwDf0Ht1DieOYE21aT+voAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XIvvCs+k7eLYLtLSx2FRqYXI7MEHUp/Na9v+SW9QvaM=;
	b=H91191CPpqyKwRPhYLIQ6XsiOXjKB+zh8y9lfguYshHIK8fB6qwWSCht1Ru0dZ9+2wPr
	 sgsvy+KGhQrCuCVVkh8LwadaNbIPT4AUzseAEy73NNTeiUMQyWA8IVlUfIbibSomnpxPZ
	 YUHXLxsW02CrBOg9oL02z/T9c+8Z6Jr1zVaf5ixo4VQi/SQHL5/KSydqQpUDm+kL/VFac
	 Xav/2DQVVxSPErYNS1ih0yneZq1zpBgOQY5r5iRzp1rFCVuZUQRlRjma14ltzRYjIIkDa
	 BDYtEKSUzLtSDXZQmZ8MhXCYkjsPCd3DCbzuzUm9bVgtgUMih6mC7/vZgCG7O7Ebmug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="xhGPxa/r";
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296EC606A32E
	for <linux-hardening@vger.kernel.org>; Thu,  5 Nov 2026 11:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 296EC606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xhGPxa/r
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48e47347279so1027833f8f.1
        for <linux-hardening@vger.kernel.org>; Thu, 05 Nov 2026 03:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793878095; x=1794482895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XIvvCs+k7eLYLtLSx2FRqYXI7MEHUp/Na9v+SW9QvaM=;
        b=xhGPxa/rgYkWlxNrvyrwQEkX6SzKw0FYWANtKQnChjWff3XwBBq3mGwV5BQErdoyek
         mPuRE+JIKIEQtG5UVyRs89ovm3SCV9fvObum9cS6jw3bmURv9nKALqe+uwI3/oHxs5gJ
         yWGOSI/cqyTNlsqGfHQqUW55btccS5uqIHBJHfRTYDBTzTTknIpTMyGTx7hvYxVQS5X9
         +Tt3oRfWlpgEfLP1vXhYzoukbzBiypRrLZbhUSH0eN4/hOLA3uXjMoq9fu1kj5oDfB/J
         qejJ8Oo5lNpID6G0YuAX+Y9Pk1Il63eLoEn7pgv/ZeEF1AlO4qLd1Xxv3DwmyWF8/qaz
         dWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793878095; x=1794482895;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XIvvCs+k7eLYLtLSx2FRqYXI7MEHUp/Na9v+SW9QvaM=;
        b=oitu+lZd4aw79taHsGpiouWp2TNctpu8mfFVk5KdeMRL1eOnGz+ciYtGkj/WQNhXDO
         UUvBgoRNcMUSmItP9dQq5r1J4GCM+U+zYcxIEpe9VH6vnOeSIhxQl0qD8jfdPinfboVc
         F1WtVpvorBhnit6rMjJV0Ns6n24nXdB/2eiuFWevXt3j47249yDo51/IymUkSHayi4fZ
         C+87PEgt73FbCpW+bQZ+bYienG6sRzX81TeJvJhUKHFcs64GfaJnMWDxNW/y51vgqWse
         q1LuYZfJ08VfCNHsyMZVZXyEcuCMFcGtnGmcRkJLpDIrNgoT1ZuqnnZsRZ9e6rfYDQ2c
         a12g==
X-Forwarded-Encrypted: i=1; AKwUvBxy9Gi3dgs0LOXq8SoaHOBB04h2q81FwQEApqG2/0fA0qZhu8aWZ2+SGUposMaDYdlfijXJRAd/xT3PT0CCFJg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/CYwdHrk1VmU4D6wtU1d1l3TdyROuB19ZX4s52+CDIgf4aqrWb
	dVJTU1VPV7gPFooDGJSJK8/XY/pWWXaTCnJc//hlPRD1IGxYRxFfaibK
X-Gm-Gg: AYBFou12S9rc2mzdZdWA2fCfeWGzFKC0Mw+izSTXKy6t7JYahKESc/40R1wvVrkS557
	ViIIaKflGcmPWPPwxrttFmABEXFE+fqySbPzlUjlhfz8rDI10Q8TDW4ZyAyDphdOZAxqnqL5jGt
	a88vnlFelIkS9M9FJXUwlLGc383HQkTibX64elag8o/y6UalWFJMkgLetScfcBXIFg4qt9HcHUj
	IIEVxbqwkn6QOe7gjDE0u7Ni8RH7HBUf92CpHj+S1kkYcTayNIOPbHHAaFSeHly2+1KM1p7Mb9i
	6nS0u64QuhtlBJ0dPuY0e/OuEcAU4OxG1SxRA9iMz2liz9d+WCUAPG3uk5cj0mn2FUMRMiyiTy7
	RwgBHJChegHutzevHVGmHW+m56QWPIlzG89+OrRuigK6ZCNrS7XCmNVDPCH1LsSeAQTAQybdzbe
	Vqi1FT0vA0TnXLlayMUnMryPxS4FiOc68UjqnwW5gVS+SS4iXqCst763UIlUxOyRN9WMuER+ClJ
	6xc2JxwgtneZ/SwE7VNAqN5hIHzJPRo4wM3lXznpbnGnmg8CqOfbuG5r+vXLl5bdUhhhoXDQ2G0
	znYpOzUjwv4KUEfhEHTf5fLpIYNQu9rJSj7QfSsuFjyhjttI+NnShJwiRZlHwwpR
X-Received: by 2002:a05:6000:4310:b0:492:149f:67ae with SMTP id ffacd0b85a97d-492149f6981mr789005f8f.32.1793878095471;
        Thu, 05 Nov 2026 03:28:15 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fecac2772sm9135636f8f.18.2026.11.05.03.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:28:15 -0800 (PST)
Date: Thu, 5 Nov 2026 11:28:13 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 kees@kernel.org, justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] Input: mouse: vsxxxaa: Replace strlcat() with strscpy()
Message-ID: <20261105112813.13210334@pumpkin>
In-Reply-To: <20261104062319.288360-1-nikitash.mariiaw@gmail.com>
References: <20261104062319.288360-1-nikitash.mariiaw@gmail.com>
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

On Tue,  3 Nov 2026 22:23:18 -0800
Mariia Nikitash <nikitash.mariiaw@gmail.com> wrote:

> In preparation for removing the deprecated strlcat() API[1], use
> strscpy() to initialize the mouse device name.
> 
> The destination is zero-initialized, and the constant string fits
> within the buffer. Since the return value is unused, this preserves
> the existing behavior.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
> ---
>  drivers/input/mouse/vsxxxaa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/mouse/vsxxxaa.c b/drivers/input/mouse/vsxxxaa.c
> index 042a17fe81db..b3a0d7ff5738 100644
> --- a/drivers/input/mouse/vsxxxaa.c
> +++ b/drivers/input/mouse/vsxxxaa.c
> @@ -463,8 +463,8 @@ static int vsxxxaa_connect(struct serio *serio, struct serio_driver *drv)
>  
>  	mouse->dev = input_dev;
>  	mouse->serio = serio;
> -	strlcat(mouse->name, "DEC VSXXX-AA/-GA mouse or VSXXX-AB digitizer",
> -		 sizeof(mouse->name));
> +	strscpy(mouse->name, "DEC VSXXX-AA/-GA mouse or VSXXX-AB digitizer",
> +		sizeof(mouse->name));

You might as well use the 2 argument form.
Moreover, if you use strcpy() you'll get a compile-time error if the
string doesn't fit.
strscpy() will truncate and return an errors.

The other question is whether mouse->name even has to be char[].

Personally I think that while there are issues with strlcat()
(mostly to do with its return value), and that there are often
much better (and faster - so sprintf is out) ways of getting
the same result, the deprecation really needs to propose a
sensible alternative (not inlined strlen() + strscpy()).

This case is, of course one of the 'better ways' cases.

David

>  	snprintf(mouse->phys, sizeof(mouse->phys), "%s/input0", serio->phys);
>  
>  	input_dev->name = mouse->name;

