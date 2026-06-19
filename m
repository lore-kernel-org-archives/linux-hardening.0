Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA023B95E3
	for <linux-hardening@vger.kernel.org>; Fri, 19 Jun 2026 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781885869; cv=none; b=FedLLgYm2tSDLT3aaZkFDU+m6QvaWpc5q6OOf4jPYeL8QrU81wSIH2st7Mgn+XUutCGzo5OZKst3RGRY1zP9zgBX2yzo88Q6BJDc13NM7e4MRdYVDNZz3iaKJmuFi/VpmDt4pwF2CDpnB6pZiqQRuoFRbHvjTeP7kE0+o39wNbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781885869; c=relaxed/simple;
	bh=juKFP4M3ulZMZvtYnJO+EyGKkoHe95cLoiQ9GeTdJzw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kdzgr68vgFCtqUntKfwPZm2IuSejC5QG/wuWOeKrGYkQhX5LTzp88iG2GcrhqIDKv8O8PFstobfiUxgue75XnAFxYyD79RaDzSO9r8P/gSp+mV8ssqsKTidOK7UKWsNLS33+dUwkMlrpK2TlXvSPugLDHUAKrvkmbD6YZFAvG4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKx0kjzu; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKx0kjzu"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4627adcf4d6so1526936f8f.3
        for <linux-hardening@vger.kernel.org>; Fri, 19 Jun 2026 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781885864; x=1782490664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NHhY6r7tYGyh00foyp4fyhhHDc2Zg99GnNa/YDtNxNU=;
        b=JKx0kjzuaL5MgQCNxoqYE+gI3UeRXYeWKa7Y9C1Fih8uARcV1fyU17AnN4MVGkDryu
         d27V19+qTwpY0pMFWBgFPq3u9xtqFIdl+6WtsnUL68ELEpcyPXoP8+4Izdg1hbC1TpiR
         qRUvkNK+VHWDx/eei9sruZw2eJ0NMkQ2Hi80wFreEDd493iW5SsRjvOLAMdB4sJTxC6d
         E1I8Ty2GHIB7aOqMoxMngskkTYv5yvFP2ld5elA3GzYh7dsK32W0jajVVau4JQDlz+bh
         /f++z4iUNqBR8h5SRMBLAiBEtbwlSDolkA87DIHsUko6otg+itAIywwX0TQemzskcdBA
         TfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781885864; x=1782490664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHhY6r7tYGyh00foyp4fyhhHDc2Zg99GnNa/YDtNxNU=;
        b=PuSs9dvEKREecxDaugsw6H5Dm/vX3lYjWqJ2oS77ukjCucC4h0JHAJeBuK+pMc16s8
         UF4q2tiQ9j1Pl9QsN7tW78o509VrxM5xvAw9NgzCKplpJCpkjsJocGLLeP6lXdw+gLqj
         Fz3R7xuujlX3DiFCf4H3x5TibO6CumcJoiqdej7bV5Ux/U83cdDTkVgsORRvd3PUdl1d
         E0UyPrYlhZbDjHSJCuLOWWuk1OQTS1vzvIZAgJ/PRtG9AYFyboqpgQhjSSJdeiJ6rU33
         UTpNCTfA31hWADtfOkfwCN7n4t8WTM89sNDW7XpecCkRpvGSxjrrdz1VFnE+b2AjWvwi
         CdJg==
X-Forwarded-Encrypted: i=1; AFNElJ/qWiTepVqXJTzTXzIs+RM4VorkQP6RZn0TyLK7uZ0WPw8/qmf/MzXQm7MEbVwFaVKUlrr47TaF2RW6fdB8HzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWlHQAm4nOc+XZHoC0GA2lbkGwykyhXjZCTsvs4XfJDwfmryII
	b6MxiUO3VR2or+A1XQ60Vzu+6lR7unOGI726eEZ22GpMaIQxthFOIQzI
X-Gm-Gg: AfdE7clpAYZauHV8PYFwoQQXgOW3hVwHoH2DnH6tPE64UdfnGOWrUAgnViQcdgWyB76
	8aSGJy38S9gzx74icE+BhIuF+UJMQ74uiTOoJRY1Mj2VCU1FlRnZ04ezH/yBnF79Li0r3leGYcW
	qSvKNo54bGHmOC6UzKr9WCX98I2v/eKeLwrtkMMW/ZqLgxOoap39ywezowtBvSmwch/JU1ZGV19
	B+TohUnysjQHpqOO77Sqx8InpIA+k5vDuB+gwiD+yFeCQkxCCDPn/ZCWzRamg7JZBFXkUJAXf8+
	/zETKGh4tGG+oiDeCyCXrgWu3Zddi0M5jLIZhiw0pM2/bhHwMrLcsSLZ/86Dg3MOBDcTNvTfX7T
	CURh9lgYX0jAmpBvg7GUBnJG+aqF2DZ0thWpLvldoLr2HiF/lNoAnJc2YJ1kq4QV053FlnIQ0//
	HGomMoKd4eEvHUknLbcK66YMqZ5WcHablXAqqdwv/LmhW0vFo7/ddMj8sbrPV2gspK2qTp2O5fa
	YkB3b5IBGA0RDBah5J0dZjg/1R3
X-Received: by 2002:a05:600c:1f92:b0:492:3670:85a7 with SMTP id 5b1f17b1804b1-49240eb1347mr71855945e9.35.1781885864196;
        Fri, 19 Jun 2026 09:17:44 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c57b8asm131866f8f.26.2026.06.19.09.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 09:17:43 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Fri, 19 Jun 2026 17:17:37 +0100
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v3 12/12] iio: dac: ad5686: add gain control support
Message-ID: <jcn5gqsjezxrnk74hrsujp56e2iqlr2iw3nwvtwd26zvexri5p@a25egmpppagh>
References: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
 <20260616-ad5686-new-features-v3-12-f829fb7e9262@analog.com>
 <ajEppnu-AWSbbihS@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajEppnu-AWSbbihS@ashevche-desk.local>

On 16/06/26 13:47, Andy Shevchenko wrote:
> On Tue, Jun 16, 2026 at 09:21:18AM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> > Most of the supported devices rely on a GAIN pin to control a 2x
> > multiplier applied to the output voltage. Other devices, e.g. the
> > single-channel ones, provides a gain control through a bit field in
> > the control register. Some designs might have the GAIN pin hardwired
> > to VDD/VLOGIC or GND, which would have no "gain-gpios" device property,
> > being able to set "adi,range-double" if it is hardwired to VDD. The
> > vref_mv field is moved down in the struct ad5686_state, so that the
> > overall size increase is reduced.
> 
> ...
> 
> > +static void ad5686_init_scale_avail(struct ad5686_state *st)
> > +{
> > +	int realbits = st->chip_info->channels[0].scan_type.realbits;
> > +	s64 tmp = 2ULL * st->vref_mv * NANO >> realbits;
> 
> As Nuno noticed in other patch review, this can probably use mul_u64_u32_shr().

This would be need in case the multiplication overflows, which is not the case
here.
 
> > +	st->scale_avail[2] = div_s64_rem(tmp, NANO, &st->scale_avail[3]);
> > +	st->scale_avail[0] = div_s64_rem(tmp >> 1, NANO, &st->scale_avail[1]);
> > +}

-- 
Kind regards,

Rodrigo Alencar
