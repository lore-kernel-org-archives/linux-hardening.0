Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2439E37EFE7
	for <linux-hardening@vger.kernel.org>; Tue,  1 Sep 2026 00:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224051; cv=none; b=WQB4xlExACHg9pkGO5sF1Sd51u0FEAci7odQqqVgrj+hiht/vC/+PgWlIB3HwZPEP10Pc6kybjtYZtJ03Baiyt0p6xB9CVFBrvBrlczvNMEGOX1g2wppRSBd+NAUemfm7aHJ5wP/5Ui6wELN63lYdTBOZPTnwFt+kf5PdOv04RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224051; c=relaxed/simple;
	bh=ojofH+DBwrtlXR+jm3f6lWSyg4U83Fo+JcCGuWLCSkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cac2KZUKJZGZSRFGG5mDVqpvtdgEG2zQNw7D7hpjZ/JAVkwqUlU0LFDCIL+SJE3FhSHRVERY1OVYcUW4KOs0P8aBUcVxC09nKsGwkQU4iQ7DP8FIkz69sJxWKrNOcbWnhIk8jZ+0JDCgDgBJF7deTAcxHrtGmaJCuKEsAMRiprU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLGM6UvZ; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLGM6UvZ"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66c744a00edso395161d50.2
        for <linux-hardening@vger.kernel.org>; Mon, 31 Aug 2026 17:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788224049; x=1788828849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=43wKJtwDjfuuZoIKBALy8jyb5Xwlew7WFV5ccmoVfUQ=;
        b=TLGM6UvZGCHM3j5VsFYxPc6kd50dgAZ+43kDeWVwsPEiLS2YzprVhr/BPiXnSxfmDK
         wIFRail4ok2DAER5HYB4wurSbEWQxpX7hDFTn2xQbESsFsg5L6AoZprmJCN7XiVfp0Ks
         NM4iPmDsqUOGxStQUF1A4hGbtPuRz2ujAHcuS6l+uarZRq3G1xl1OT9YVVtY5LzyKzVw
         dDSK01pmJTJQq1s2mt0VKZVun3uaFp4rOuTB7/W1CBrEY1AIfVW5ijrT4+B54nbUjnvB
         TvfdHKQXeTLRZ8yExcr6MuaQirTNLgW/nM8SvAP2p9dQF8IglbEWIr4atX2fBUjT4e07
         GTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788224049; x=1788828849;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=43wKJtwDjfuuZoIKBALy8jyb5Xwlew7WFV5ccmoVfUQ=;
        b=R1Yn51XUAOf7eflyCbNPoU68IqBguG0zYhbshb+MFWtWSiVSKM4sZTpt3PIRcz7zJG
         nxBrj3imL3j/TZhznqSnOD/bN//8q5GLGK8xl3NW/U3Sm9Ay9mrwYsYcSgOAi5c/y8+9
         mRagtRgKIVqMayX3MLZ8roXht6++v9qTXIU3b4Jfa/XIkYWCpn3kGPfR5qFZU0fZnYjB
         JZNgAuNX6K+tjVpvcUdbYZqIBhYXpzpfbcIeNVAqUl3N7oEwQM2fX+vGFIpa7QE8Xoo7
         9mI/f3WfeZ6Kvay6yx6G16QswtLFJgXtcmZZ4MBoIm1+h1UMkav9XuzNwBOakINzHTkX
         MaVA==
X-Forwarded-Encrypted: i=1; AKwUvBxXqfZ1ZwiGlBXlGimx69AjPT7QMfBVv/DDe0OAmD3o1yKqSBG6CZZD+kZEwawPYaHFY2/fQMJQQCdmHsdZGbQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kcPiSmETh5/cLLEcZhP8sE5aEN3ghrEnFuycGsfPAkxwPCVxjj
	sqzMBH0wvEf8DnAT/E0HdVkF4splx1Ql7z65b0+ivw7gH2hj39Lj4Ou+
X-Gm-Gg: AYBFou2nwSVesLzmR0LICsxmIhkGXYpPIzjW96bipKsftHqSAxjOxdKVNxZAKARwFg8
	G+aJNhvFklRVuU1qFkuinWWrfNOeh2vY3PMsPvGqZ9AimbMHrkHjkYliAzNhB92TMdj+ZP4LAFH
	wsa472OMUO5W2kAU7VO+oYVTadkRMolPLQXdpLDGRBfqDz7zAh1f9QNEsYSBcDCggq9FWks8QHV
	WcZheiVgwUH0JckNeYKGwRhRlH8iLQCCFhB3QUNK9s0e3sfUreNe3+/bZFMrzMVRw2nxc+qxPb0
	n24BYGUBIhGFxgl6082+o2oE7nLsxtjZemuQbwOiaeZyEknqxoQKmOARlfyB/HWNXnvLkQ9yFGP
	KXxeoeTiuv2ZeTbeZ59fDTmmtd1wbXH8u877FcMXCxrF+ufOHydhqg4lHwAox+vEpkGFZL7Ib8r
	jAt573wN4RlphwPZWPtuaD3s+zODNePOrQ/IUftbYtMY5HsE7A9UIFUpk5VyCHnM81Ke0b
X-Received: by 2002:a05:690e:4543:10b0:66e:7307:4666 with SMTP id 956f58d0204a3-66e73075b91mr3196325d50.10.1788224048960;
        Mon, 31 Aug 2026 17:54:08 -0700 (PDT)
Received: from localhost ([2804:30c:94d:7300:da0f:c2c1:1aa6:43da])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4ed163bcsm7241718d50.16.2026.08.31.17.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 17:54:07 -0700 (PDT)
Date: Mon, 31 Aug 2026 21:54:58 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: light: stk3310: support the Sensortek
 STK36C61
Message-ID: <apYiYnlM-agfG9he@debian-BULLSEYE-live-builder-AMD64>
References: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net>
 <20260826175409.326131-6-jorijnvdgraaf@catcrafts.net>
 <apEMCqQXyj1tAMoP@debian-BULLSEYE-live-builder-AMD64>
 <20260828154705.11962-1-jorijnvdgraaf@catcrafts.net>
 <apRGQVfPKWHvE2Ct@debian-BULLSEYE-live-builder-AMD64>
 <20260830201950.63838-1-jorijnvdgraaf@catcrafts.net>
 <DL2YT4S4U7C4.2CPGBR94G01FD@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DL2YT4S4U7C4.2CPGBR94G01FD@fairphone.com>

On 08/31, Luca Weiss wrote:
> Hi Jorijn,
> 
> On Sun Aug 30, 2026 at 10:19 PM CEST, Jorijn van der Graaf wrote:
> > On Sun, Aug 30, 2026 at 12:03:29PM -0300, Marcelo Schmitt wrote:
> >> Having a closer look at the data sheet I found for STK36C61, I noticed registers
> >> 0x13 and 0x14 are not listed. Does the newer part has ambient light sensing
> >> besides the clear channel?
> >
> > That looks to be the "STK36C61-A Preliminary Datasheet v0.9" hosted by
> > LCSC [1], which I hadn't found before, so the cover letter's "There is
> > no public datasheet" is wrong. It documents the -A variant, however,
> > and gives PDT_ID as 0x93, while the part in the Fairphone 6 reports
> > 0x95. It does agree with the device on the colour-engine layout: RGBC

The data sheets I was comparing were from
https://datasheet4u.com/datasheets/Sensortek/STK3310/836592
https://jlcpcb.com/partdetail/SENSORTEK-STK36C61A/C49230205
which were the first links that appeared to me on an online search.

> 
> Just to chime in, the datasheet I have access to (STK36C61-A Preliminary
> Datasheet Version - 0.9.2) there are a few changes compared with the one
> from LCSC but nothing too interesting:
> 
> * On the overview page LED current 228.75 changed to 218.75 mA
> * ALSCTRL1 register (0x02) has different values for BIT[6:4]
>   (17.92 -> 143.36; 8.96 -> 35.84; 4.48 -> 8.96)
> * PDT_ID is indeed 0x95 - maybe the previous version just had wrong
>   copy-pasted info?
> 

Hmm, I was initially thinking about the added STK3310_PROXIMITY_CHANNEL for
stk36c61. If STK36C61 has ambient light sensing (similar to STK3310 light
sensing read from registers 0x13 and 0x14) then it makes sense to have that
channel for STK36C61 too. Otherwise, that specific ambient light channel
shouldn't belong to stk36c61_channels.

I didn't find a data sheet for the part with PDT_ID 0x95, though, that sounds
like another thing to tidy up. Update the naming from STK36C61 to STK36C61A.
So, if STK36C61 (without the A) is ever added, there will be no naming conflict.
Unless STK36C61 is never going to be released (which doesn't seem to be the case
cause I can find a data sheet for that).

With best regards,
Marcelo
