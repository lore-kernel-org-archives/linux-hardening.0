Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C58936A023
	for <linux-hardening@vger.kernel.org>; Sun, 10 May 2026 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778403063; cv=none; b=eMmXKezNOA3wJWaWx4bScOunyxKsc04nFAAjPPnKcqIXA7SHncV8MTDuVwWGsTpQYIKSXytSeIG7DLlQdIUt2WKS3qxMaoER9z8CUnFRUyDPA3W7k1uIUQQ2cO/IrcMrMIDKFxnitBG/a6tsW2CFgnTVMyb/seC4Ae/heImxsxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778403063; c=relaxed/simple;
	bh=APsPwM7MyHrwDPyETr8QDqu7q2GGK+1JiXh2BcinVqw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3cM7MV363KzMRiql3s2slnPHP0lzmFLUeeAWf8DdEum9Mspq7gH6S+LuOFP2RiP8YhCLSP/8oAdm8BZbDo1OgfQ8ioeqlgP0KEPIl9R70B2XergAUgQs/l0pl+r5Ac2KOO7YVmzVErteJCz3R7v7Ib3HvdtEa9xKL9MaA0q6nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cu+7o7u8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu+7o7u8"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso6936605e9.0
        for <linux-hardening@vger.kernel.org>; Sun, 10 May 2026 01:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778403060; x=1779007860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZNF7ruP6zfWaL34BGu38nOIYnKqmgSGr7rjszlXHJE=;
        b=Cu+7o7u8Z+dirRbcCaIHmbZUXXphw11ubrL6mx3C+z0YABYUvz+5LJDUgB3Eamd33M
         3ZEIQwXuj0yXdUWut7gc9fbhVglih7Tykz2KeuODi12lnakyULynCh+ClJ8rmdKGSIp+
         bQPnw5SIyTvloLcK9YaOGROWCdi7dLisTxAeAiAsi2JPIG+b0b8oSbf8oyVGkHtYFr5i
         Xk9iWs5xyCUxsnE58Mp48g56Q86p5Qdjjq/4ZHsti3/v3Rrf6eQ/8zxf+v1+uw+wuzyI
         6gEChU/uxKNsn/tfKlAv1EQv2B4wN4DRhcrJ1l0Xt2MSe9aGPnHD89Wn0n3kfskIm9Bw
         60LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778403060; x=1779007860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZNF7ruP6zfWaL34BGu38nOIYnKqmgSGr7rjszlXHJE=;
        b=EGIGf3IC9PH0GJqlxQiVWAEUudkHysDQhl7Ibh/R35XnxjO2yseasUDI2KC9AJbVMY
         9DLylL/4a9QUFt+Wq6DuEiYxruVrUmD3E4wzjo6wWynuthhw8D63p5TGhae/1HDU6aN2
         T5WlnR5Leiy4cXAKn1q1w+SFNSH0l20kYeUZPJehpzzsIIpzpgQky87pKQxBsHnCgP/0
         I3tDbVhbgYzXVvHDVGEKuw44hoRLGxpp7SDMw5bvw6FRhhdUnqQp+eoNk1OiplFbOLsM
         cvzgk0iGcOHkOYaNJWEoWSSPIIbwOCzxHw/r4WgNzeI1O9JJUchpCI/mXumPBRUKVPwx
         PYOA==
X-Forwarded-Encrypted: i=1; AFNElJ9cW2X/+5LFCZ6TqVA2WCCN91mxl2agSJnSq8GAHvBi0Hez5kYyoTddP0Np1EkorErba5HcuzMV21SGDKcyKtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHSnoEvU5M127Tv+nv0hfPlkBFaLRuoBDpJSRSQ4qA/FClKNBU
	JLW4N50SLcghyPbet52awauQBx/sB7UJExttSQS3PzlluBOL9LKrFDa0
X-Gm-Gg: Acq92OGza+7dzKAgsjFls6ysrhgFrHoVlNwT2TI5TFUuvF/TLH4J3zTq3I47Y7rIggd
	VKO4eMCp+gkzVWWZPbHHPYILub8ZsBWMk+QcYnKeA2YPtozofFHcsWmVNcjDQ3v2vf2nKCzxtEl
	l1Ri9f/2f6PyLWgRBIt32GTQl1YAnt0/H+6hYugUTuOd97iYE8vh3Q8abXAmHCmTYqt6iCsuzxa
	mPuMlvEZaWNVRFX+fnup3mhewgPDIR+Xni5v7SVPDbfscAzKUnmO/vVlw4OkwWFMIG3i1Q9YVIH
	FwE9ZSVki6liQwkDRg8VaoMHpFDxjv6kfntyuOg1uE2yHdJcNeyOPDQzafMR2cY6gMwOvZ+9szK
	/bWg9/VKj8w9D6mR0iCu1IQSzpVjbhyWEKrFc84Mmneko5SAeDy/EQd8SI2ELuFMSfXy7xZx3li
	c+O4bmNzoey2DlegEc8fY7HRg7JjlfHdRNw1jfA0zY4eBk2EIqNLS9VX6/hSENOEYLch7q9YGKC
	fR3UIqfdmOfQvgu6VqCvqMwh8k63xUQvDdJOSOq4e5uBR7kyw==
X-Received: by 2002:a05:600c:8b8b:b0:489:1aed:1658 with SMTP id 5b1f17b1804b1-48e51f3fd03mr321073295e9.23.1778403060285;
        Sun, 10 May 2026 01:51:00 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d89af2esm39629535e9.0.2026.05.10.01.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 01:50:58 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Sun, 10 May 2026 09:50:51 +0100
To: David Lechner <dlechner@baylibre.com>, rodrigo.alencar@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH RFC v4 00/10] AD9910 Direct Digital Synthesizer
Message-ID: <jqsr6q32kqnehzyc25vo2owv7b4xvoppnlbhrjrevahptm6pbg@pvghdgt2w4wf>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
 <f3bb9f64-a0ef-4862-afdd-74ee39d7bfc1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3bb9f64-a0ef-4862-afdd-74ee39d7bfc1@baylibre.com>

On 26/05/09 05:31PM, David Lechner wrote:
> On 5/8/26 12:00 PM, Rodrigo Alencar via B4 Relay wrote:
> > This patch series adds support for the Analog Devices AD9910 DDS.
> > This is a RFC so that we can agree/discuss on the design that follows:
> > 
> > This is a follow-up of the V3 discussion. For V1, we reached into
> > this channel composition agreement where physical channels may have
> > sub-channels. That adds the flexibility necessary for this design.
> > During V2, some feedback indicated that the ABI is too device-specific,
> > so DRG/RAM destination and operating modes are configured through
> > alternate paths and profile channels are created. In V3, there was
> > further discussion on the ABI and on mode priority debug.
> > 
> What happened with the idea of adding a new attribute to show the
> relationship of the sub-channels to the actual physical output
> channels?

That's still to be done in iio core. I was still to think on how to do that,
and I am trying to get a mature ABI first.

I am not sure about the use case where a sub-channel is shared between
multiple channels, but I thought of a iio_chan_spec pointer to a parent
iio_chan_spec in the same struct. Similar to a device-tree, we have the
primary tree structure and then phandles can be used separately to create
more complex dependencies between channels. So a "channel ref" attribute
could be separate concept.

Then iio core would create the read-only attribute "subcomponent_of" or
"parent" when that is not NULL. The read function would just output the parent
channel label. Then labels would be important to create this logical dependency
between channels, and maybe that is bad, but in this context, I suppose labels
are going to be needed anyways.

-- 
Kind regards,

Rodrigo Alencar
