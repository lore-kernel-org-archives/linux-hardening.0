Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794829984;
	b=JpvvMh23MOgaP6NLlPvM68QDjRjT9oh9YIl0t0HTNvBqpHfnCWhJId/Q6Uj5WKS4qlBu
	 v2KsgppP/EDdxd23zXQWQZih2Dt6+/6/SX4/nJlPete5s1pj2MUgwOjGEXY3L2E5e+j06
	 GkkAQuPGyeFlBIl0lC2+wxv/nJqZshxUcrv50Q5GzLjbLnNKwBx08qPXNIaojRep7ES3l
	 M2PA7Auo6sgkZJuVcisvh38h8i2sgwVD4nTW530qGTnLateaVhOMgYUopAmqCoUyBV1Qo
	 nzKHVj1Q6z7UMrgGazwgw5rOzfSAv642rBkK5PUWuDq1jrAh2Gq30lch8YTorv3Ks5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794829984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pO7ejxuisYFiK67OM4MpgvsVQ7/7ICx6J2Ag4S25/oU=;
	b=0TL3LUtmtxcVl9KxLqWON/F/BHt/vE7n8MU5Z2P1VDVJK1DfAIM2S9RaH2aPYSeovBDV
	 mRnJHjWkJKWzcpWhVFhoBl4eztYyq9NSCC2Qsi1Dlbd3auDFPk/p40HZn5EeBGslZTbPx
	 Q0qfmemVvYB9wYNo4p5AutIFTy6POnw99Z40VdHGgYpTBGO/jWfTKJ3uuy1GIpHLV30XJ
	 td8HoHv9PHfARtSsvlWO+4LyoY76QknlkR7rPU7D7rMgofMHB4ZoCvHszknQGF4kxda3Y
	 UQdg2p5lFp6vN26W9hnBphjbM6v/VkvQ1TrAKxQR8g1YA/H8z5hpQ7jbp0EDXppxkuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="EQorfjr/";
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C4C606A335
	for <linux-hardening@vger.kernel.org>; Mon, 16 Nov 2026 11:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85C4C606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EQorfjr/
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-491f34b4e0fso1380779f8f.2
        for <linux-hardening@vger.kernel.org>; Mon, 16 Nov 2026 03:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794829983; x=1795434783; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pO7ejxuisYFiK67OM4MpgvsVQ7/7ICx6J2Ag4S25/oU=;
        b=EQorfjr/le+xrt6rRx0aqewV5C/72AyI7slViP9I2mMqrY2frCMiC9eA2kU6PldTfe
         d2ppNxxBW57kub0UzJYDi2m1bmxBnaQkiv+DBn7m73b82wtWpXZge2XEBVq8Yj5BdyiG
         YuY+Hzn4cGfJDC2pvnbKrEDdfYWt2Z2iBDbH4ycXbvMHzeqt/2lqu3i70CUXVOK26kmu
         GVLINhavriOSnCa0I1E/mKgT9MiAv+t0eJFkLeN7vlyZTXhcdbFV3CpeBKR3d8JeJxZI
         3rV3PATeMttVTD4o/HvUX4HGKlhQviYoK1XMcV4K8Zc9LjGTSHhnLxeKxHdxvvktLTto
         fhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794829983; x=1795434783;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pO7ejxuisYFiK67OM4MpgvsVQ7/7ICx6J2Ag4S25/oU=;
        b=noWluyw2S1/EEQTHfbz9l6kT1qmUsijZ/zBaPFBY+AmZCOFrkyNBQdXsNIcm16MNCL
         OudBqidRKzxKeuAPTHGYKTA0OMPnw0E+b/MkKMod/c/5QimMxdLdVPB8camAVUO9qfUb
         QEavUNF8G/6qm+SPA8AiJaVpERfQ86v3kZCZ7ALXBFGbxhhOnodAY3vfTUOlSX+P91xi
         LSJm+E0Muktsgx8PY/rIPYpfXBjpFnYCfqud8vUcBKpe4EqxOUdWYKVBsxdDnBnfMuiJ
         uQKcdo+bcRw0DwtF8fo4t1Z0ML4AjkWsLxDkh6qM0zJFGbULgZd5ajNYMbqQh/iZkseo
         kKKQ==
X-Forwarded-Encrypted: i=1; AL+hErGic7rNmmBkPkkkD7ngaEHS665pq3IkLX1M7wkzNS2giJtQrGmVF8pjG0+BSAvJTq1AmlZoEVqV7GqgQwdFFs0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+cS0AD1ecWCFRp8sTNoSrRgHRs4hJ1/iDkoZpVkTViO9BsbZP
	uuHDRRn5SkjPmq9EmLR4PiqcO2Mumw6HyN9BkGp68RDs7hGABgQV2jBQ
X-Gm-Gg: AZFdTZfP/kM8La5O12Fr9DCiNxx/Rjr0uN7y6bBy/j9tudwf+ob73saYKPaty3W+jwO
	fpPU+3tFaWCL5jGZ+fHiJzzL/f4I+bbIIkFXozPLZBAwec2s8GLI9CT5h30cDoGM2/VyZEPsVE9
	Z67saAIQ2X96oncTOlYEatbns0tEiVaMP6Epsp2TdoxNMS/5/5hgdZ5XhSlmvxEF1Cl1Ok1px1G
	7Fs5WVWn9GTslzQjP8S7NHABSJCzlaozV7ZQa4cAy78cDXEOcgg3Dumm30k0wUCsN6EG4NaSN5i
	aYIDi7T87KOTMKahzfBOTcZXkyiDEvz0kRV2LIObLq+U7q6Ge0W3qHNzsRYFzwspE9D0qHmCUP3
	xdvmFYM5/s08nVtmTYsJPufKALzJqH4w8Qmu33gyhgyI9cLNTXrBebAnamuXZgaxD0et2HHgKxP
	FKdR73tlE/R00EgKs0H935qenCqlEvNugVLkWGaHIFUUF1bhp25vMInx4LI9jzRAA+yXVR8yDAg
	RnCRdfqDjA9wA1EzKZq/bgMMu0AOrWFv3rOrUeuj1ZXtUsgxzF5hAhw+mdcu+przIpLakb6hNn9
	BKxvnKehKenwYQoc0ehfkNO4YLz+/9Wquz/J96QkyTdZ3045TPMwpjykAcPa9P+iJA==
X-Received: by 2002:a05:6000:2c01:b0:499:1c0d:4568 with SMTP id ffacd0b85a97d-49c741b14a0mr24577066f8f.48.1794829982872;
        Mon, 16 Nov 2026 03:53:02 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5a32d336sm23686370f8f.0.2026.11.16.03.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 03:53:02 -0800 (PST)
Date: Mon, 16 Nov 2026 11:53:00 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>, Hauke Mehrtens
 <hauke@hauke-m.de>, linux-mips@linux-mips.org, Ralf Baechle
 <ralf@linux-mips.org>, Joe Perches <joe@perches.com>, Alejandro Colomar
 <alx@kernel.org>, linux-hardening@vger.kernel.org, Krzysztof Kozlowski
 <krzk@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab
 <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, Danilo
 Krummrich <dakr@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Johan Hovold
 <johan@kernel.org>, Kees Cook <kees@kernel.org>, Laurent Pinchart
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
Subject: Re: Off-by-one in arch/mips/bcm47xx/time.c (was: [PATCH v6 02/19]
 string: Add strprefix())
Message-ID: <20261116115300.544a33ec@pumpkin>
In-Reply-To: <avriaVSTl4jL0OEo@ashevche-desk.local>
References: <cover.1794667407.git.alx@kernel.org>
	<0eaa4ce73a2b164fd49e3a9f71244a2e3f45b7bb.1794667407.git.alx@kernel.org>
	<c113f651d1ce1b2d42ab9d0c59ae5a0cd17ddb6a.camel@perches.com>
	<avi54hgKgovNHfKy@devuan>
	<avriaVSTl4jL0OEo@ashevche-desk.local>
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

On Mon, 16 Nov 2026 13:00:57 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Nov 14, 2026 at 08:49:21PM +0100, Alejandro Colomar wrote:
> 
> [...]
> 
> > > And these are all candidates for converted uses to
> > > whatever is the function name or steq:
> > > 
> > > $ git grep -P '[^w]strncmp\s*\(\s*[\w\.\-\>\s]*,\s*\"\w*"\s*,\s*\d+\s*\)' -- '*.[ch]' | wc -l
> > > 946  
> > 
> > Looking at those, I've seen a bug in BCM47XX, introduced in 2224de9d152b
> > (2013-10-29; "MIPS: BCM47XX: Fix clock detection for BCM5354 with 200MHz
> >  clock").
> > 
> > Look at this line of code:
> > 
> > 	$ grep strncmp arch/mips/bcm47xx/time.c
> > 			if (len >= 0 && !strncmp(buf, "200", 4))
> > 
> > That strncmp(3) call is wrong, as it's really behaving as strcmp(3),
> > since the 4 is off-by-one.  I'd like to know what was the intention.
> > Was it meant to be !strncmp(buf, "200", 3)?  Or was it meant to be just
> > !strcmp(buf, "200")?  
> 
> When in doubts, preserve current behaviour over refactoring.
> 

That entire function is strange...

David
