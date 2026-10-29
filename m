Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793296635;
	b=heCCxpjlqaMhIbHQIz+nfwPpxAXKa9y/HO6G/7vbhcvbo3y8upc7FgogBKc6VE1hBRto
	 ollbypdmR9yDjS/pLdo1GeU2Zgl8Ykd9ufQPHsRvUYbK0ciPqZoPcYrZg4aAQ6NAzge3B
	 4d6PdexNZpuKSXwdoX9T9+A+PydPO5ReZhkYG097UDSsTEEDlnyH0T3+WAO88ldbIHkDn
	 AXH+bBtuI5y40yzaucOu88yQzUqw2VbX2aUAW4gVU9q6Q6j6IIplDibjXM7TN+AE+PsPL
	 n3nFZX0GjW9i6TKuHNEqo7JuDthAp+I8SWtJ5kUDDjhAqrZoMmH5yx/7VhcHSzS2YKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=nDX2rRdVV3QP/6Ts1rsElxSn3+3Z1o4ammOugDPSu3s=;
	b=Zjzi82VyHIzzM4U/PNF6cIxXMqGowTP76hwb1oELR8FqXU8X5SYTOutNgfvswHPmbwUQ
	 SPq/LFjFVGhtq7aNTyiyYOv1kfqfxv/jBnkOzuHFq4+fdDrBweD/0RJr43kueQRI8mSpT
	 94BPrE9evUzwRdxKVAvnU4xmkkeaiybqiAR/7KD8H5opyBby+N8u5B2rtzgedWWSaSbod
	 Rxs7M3sPlXqMxk8r5I/tEOYk/EFZIw+daeE7zSQmVYA89zMRYKt54sVCKa4CEE7yjBMpl
	 +j9fCEfuSkp3JdWrcpwot7EsiuyqC/ilTZRPvlsh1uCffWYGmpPB2Nra3lTVzYS3y/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=riscstar.com;
	spf=pass smtp.mailfrom=riscstar.com;
	dkim=pass header.d=riscstar-com.20260707.gappssmtp.com header.i=@riscstar-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OuMj7yiH;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A99606A31C
	for <linux-hardening@vger.kernel.org>; Thu, 29 Oct 2026 17:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95A99606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=riscstar-com.20260707.gappssmtp.com header.i=@riscstar-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OuMj7yiH
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a4dc547987so12405985e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 29 Oct 2026 10:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20260707.gappssmtp.com; s=20260707; t=1793296628; x=1793901428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nDX2rRdVV3QP/6Ts1rsElxSn3+3Z1o4ammOugDPSu3s=;
        b=OuMj7yiH2IUcS/V2lonve3C2cgsJev9+d9Lw5c07BZ0N97vBRbsJ3mlh4k2Hsem+Qx
         p4dlaCcs+orJo59rVWBjRW5C2zlJ8GXCX/Kvlg0c7di8WixC+DOTwDPl3ohB7LF8xfNW
         uKlZ8HVgPSjsIqLCbAcufrbNKP146EJMzE+8O+CN/8MOKJR7hzceqXqLQwbkFE0muZzy
         G/nMTGRQ3gzTqfOWu0mUbNTzobadpkE3P9s1GVm7jeGxxFalFcaTJlSK3NnxvWZJu+f4
         2oxNnPst5u0+bLae1a6HqTxZ+oZerGvP2spqxEnnlxdcSnWymtgL6UR1GGR+yp9l+MBT
         H5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793296628; x=1793901428;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nDX2rRdVV3QP/6Ts1rsElxSn3+3Z1o4ammOugDPSu3s=;
        b=0yAGl0I3+FiHam/1WzZsXIBwT3sWL5VFQ98BswWvs33QFWmRhc1INRSNxS4CzYv1f6
         MIZjw5d5x0q3jHCbqVNyQajOiEnnCNibuk6bRVb3IQ0Ep1Hxhiu4EJWxuynD5jmFiLgF
         R98IWaX6Jfh+MaZ++iITOPB0tb/1waLuQ71Zixg2oOHmABuozDbAm+S0+OQFf2hAgRUx
         XOhPcdvq20X0jGcnLzkDSvu+Hs3zj1UcMP5ypdF0JSzX/e0Ha7xXiKePs9FDllMOTyoD
         zAxI7/MG0wnlVdqTBnxs5NO96n0C6T3JxRzCcAVlTderIIk1uhN04XXEKVycqTZTwrpZ
         HhoA==
X-Forwarded-Encrypted: i=1; AKwUvBwNlcZXKY2yJpOq17OzDo+MCe5PhDJLd2uJ/Iw26iAvuPZXz+p1/3taqm0siPgEW9wdpZ9QcqvitJPQn/hP0HI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQxPex8E0RFIprPKeO9zweBO9H4j2KP0NCezrI8F0pstCW9+mN
	XDdO+MFOkSIBd0VtAFIzS2qmrw2lEzsQmkVOU+bvZoGfNhAjfmgsGeL06iI9wNRgPCY=
X-Gm-Gg: AYBFou0DqxgEyB6jZQBgwaSInNxFyiS337r0fKCYs+Cr++VuK0ttNWji3Lyh/bUZtiy
	R2Quc0qevMCcJW2ssWzHux1YMKgkYvZZRcUjJKdaCvxQTSpJveNZdP/Fzb7Cx+X0WOGvOktw9Nb
	zf4xY/5RYjPRYCwDRFW3bsSFNubkColpWcf0aUDStRh07R1C1VWOe3mKQMQbh6mb5ePwhR3A1wy
	FSS577VTBRTPnWf9BBL8FLKhUoj8m25nHIGw0fsc5LYGIgOtt+weZy7/51fZNhGA4vu18G52EPf
	sSQiweTz3I5qZ/NRle+7DhKdXP1wAa9KO1oy6ymfOTP1PozY7GTz0Re7BhcUa1PlLTIwslCnTCP
	zGUl+1U7JfQVBJHuHbWFxusg/PwrpUrKQJ3xkq1cTrGRifdw9KFjD9XvJR+1YcvICWfSnRfNpzj
	H2KRgFRI6aaDDpgh221aShlWgXzO1nNOsKPDl+WcIdP2PEqnkEGIhCJsl/4RPidc2vW6fSHXJxq
	g4l2Y8aPb5z/EFKe4JW8KWOz+cm+ZVoG8j6TbmEiYWnYmhZEpKBgvSlVFxKcHCFf2CyXNOTw+D9
	Es6BmwuKgdTTX4sSfa7VOnvM/0VtTQ0ThwyM8Kq2YhU1shDdZmZrwqVDEBQUzApIC5YMm1/w7PN
	poa3+moEVqOOYNOILqHiAhMdjdxRGBopM8vicVvECsptZ6RVpQhzN2JXiejkZFDFGHWqka0jEdA
	e+2MglHHsab250TA==
X-Received: by 2002:a05:600d:16:b0:4a7:669c:c988 with SMTP id 5b1f17b1804b1-4a9672f7512mr121511495e9.23.1793296627848;
        Thu, 29 Oct 2026 10:57:07 -0700 (PDT)
Received: from aspen.lan (aztw-33-b2-v4wan-169864-cust3247.vm26.cable.virginm.net. [92.239.204.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa8213ead6sm80168055e9.14.2026.10.29.10.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 10:57:06 -0700 (PDT)
Date: Thu, 29 Oct 2026 17:57:04 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alex Elder <elder@riscstar.com>, robh@kernel.org, sboyd@kernel.org,
	bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
	kees@kernel.org, gustavoars@kernel.org, p.zabel@pengutronix.de,
	mohd.anwar@oss.qualcomm.com, lorenzo.bianconi@oss.qualcomm.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	mfd@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: mfd: introduce the TC9564 config syscon
Message-ID: <auOI8LbZNWbNGJuN@aspen.lan>
References: <20260918165234.687224-1-elder@riscstar.com>
 <20260918165234.687224-2-elder@riscstar.com>
 <20260920-fiery-fanatic-manticore-6abf0a@quoll>
 <85b0e7de-e4a8-4e08-b801-a9664d366e1a@riscstar.com>
 <7e32063f-f1a4-4259-96c9-fcbdd25c7f2f@riscstar.com>
 <fbeac5ba-a28d-4d34-8d23-4946aef515ea@kernel.org>
 <4bb9c85e-f991-484e-861f-1940b8263890@riscstar.com>
 <e3c9087e-fea5-4ec6-852a-a0e0e33ce461@kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3c9087e-fea5-4ec6-852a-a0e0e33ce461@kernel.org>

On Thu, Oct 29, 2026 at 02:54:35PM +0100, Krzysztof Kozlowski wrote:
> On 28/09/2026 16:52, Alex Elder wrote:
> > On 9/23/26 2:25 AM, Krzysztof Kozlowski wrote:
> > I believe the TC9564 *is* such a "complex" SoC.  And in any case,
> > anywhere pci-ep-bus is used, it implies that some chip internals
> > would be described using devicetree.
> >
> > Would incorporating the chip internals in a devicetree *overlay*
> > have any effect on your opinion on this?  I.e., the "main"
> > devicetree nodes would simply define the PCI device hierarchy,
> > but anything behind an endpoint would be described in an overlay.
> > This way, pci-ep-bus on a PCI endpoint just provides an external
> > interface onto which a very complex device could be "mounted"
> > (and described in an overlay).
> >
> > I'd like to continue to move ahead with upstreaming support for
> > this SoC, but to me it seems you have basic doubts about
> > pci-ep-bus and I'd like to get past that.
>
> Well, Rob might understand this better, so maybe review from him will
> solve these questions.

To aid whichever of the DT maintainers can help with review, I'd
like to offer a little more background on the "TC9564 is a complex
device" thread.

Hopefully it doesn't contradict what you've been discussing with Alex,
but it will perhaps give a different perspective.

My thoughts neatly divide into three parts:

1. The TC956x-series form a complex enough family of multi-function
   devices. We will need some way to describe it's structure (both
   external *and* internal).

2. There are multiple ways to describe a device's connectivity but
   devicetree is great for this job making it an excellent technical
   solution.

3. We have done sufficient thought experiments (and real-world
   experiments) to be confident that our solution is not in conflict
   with treating the QPS615 as a regular PCIe card.

Having offered the summary above because I now need to spend a lot of
words to back up the above. I'm afraid I have to go a long way past
the syscon bindings perimeter!

## Why I think the QPS615 is "complex"

I hope I don't have to rehash the multi-function part too much. The TC9564
included comms peripherals (UART, I2C, SPI, GPIO), some very common SoC-ish
management peripherals (reset, clock, interrupt controller), a Cortex-M3
controller (with access to pretty much everything) and some licensed
peripherals with well established devicetree bindings (2x Designware XGMAC).

It should be noted that TC9564 does also include a PCIe switch. However the
switch is *upstream* of the PCIe endpoint we use to control most of the other
TC9564 peripherals so you won't see it any any bindings that have come from
Alex and me.

Another factor that makes describing TC9564 complex is the presence or
absence of side channels that give the host SoC mechanisms to communicate with
the TC9564 without using PCIe.

 * On RB3gen2 there are host GPIOs that control TC9564 peripherals such as the
   ethernet phys (used for power control). Additionally there is an I2C side
   channel that is used to control the TC9564 GPIOs. This is needed
   to solve a chicken-and-egg problem related to the PCIe #PERST signals
   in the PCIe switch but also ends up being used to reset the ethernet phys.

 * On a real PCIe card there will be no side channels, which means the TC9564
   GPIO peripheral would suddenly become `status = "okay"` on the PCIe bus
   instead of the I2C bus (in this case we know that there is no
   chicken-and-egg... if there were then the card won't work electrically).

Thus, even with one part number, we already have some fairly significant
connectivity difference depending on the board design.

Finally, the TC956x is a family and we'd like to reuse as much as possible
across the part numbers that will come. Having a convenient way to
reuse common subsystems is is very valuable.

## Why devicetree is a great technical solution

Clearly we *could* rely on a big pile of what is essentially platform
bus code in the PCIe driver to describe the connectivity and familial
difference. Renaming it to auxiliary bus code doesn't stop the results
from feeling like fifteen-year old platform bus code.

For that reason we view devicetree as a better solution to model the
hardware. DT already has idiomatic ways to describe the connectivity of
the device.

Most of the non-discoverable baseboard <-> TC9564 connections are for the
MAC and using devicetree simplifies the binding there since we add only a
few essentials over the existing stmmac bindings (there are existing
stmmac PCIe cards but I believe many are for MACs with a smaller
feature set than TC9564 which makes things easier).

You are correct that for several other peripherals we only describe
internal connectivity. Ultimately we are copying prior art from the
Raspberry Pi RP1. RP1 is also a complex MFD that exposes its functions
in a similar way to what we propose for TC9564 (and on Raspberry Pi 5
is it soldered down just like it is on RB3gen2). FWIW I'd note that I
think the RP1 bindings describe peripherals with no external
connectivity.

So, it's not that the card can't come alive if we use open-coded C to
describe the connectivity. It can. We've been there and done it. Instead
the argument is that *not* using DT to describe TC956x family parts in
their various baseboards is a missed opportunity!

## Using TC9564 as a PCIe card

Currently our work only supports QPS615 soldered onto an RB3gen2 with all it's
sidebands. Here we settled on a static devicetree (no overlay) similar to
Raspberry Pi RP1. We tried overlays, the resulting DTs were fragmented and hard
to read. Ultimately we felt embedded developers would find working with a static
DT easier.

If you feel super strongly that the syscon bindings (which is what this
thread is about) should not appear in a static device tree, we maybe we
could discuss overlaying the discoverable-from-PID-VID parts as an
"embedded TC9564" overlay. Personally I really dislike this approach
because it's hard to read. Also it wouldn't actually impact the DT
bindings so perhaps isn't in scope yet anyway!

For real PCIe cards I definitely think DT overlay is the answer. Here
there are no sidebands meaning there will be no phandles linking the
overlay to the base DT (if there is one). That resolved the concerns
about readability of the overlay. If we actually had a PCIe card today
then I'm confident we'd be able to reuse almost all the driver work
Alex has posted so far and that we'd be able to run it on a system
using ACPI as its primary hardware model.

There are still some warts related to PCIe card identification but they are
unrelated to the DT bindings. TC9564 has a fixed VID/PID so, when there
is no static DT to help us, we must dynamically interrogate the card
from the pcie driver to discover what it actually is and figure out *which*
overlay to load. This is another reason I view devicetree as
an excellent technical solution. Having an easy way to describe each PCIe
card form its schematic is a great property to have.

In short, the TC9564 on a real removable PCIe card has been an
important thought experiment for me throughout this work. It's also
been a real experiment: we did implement dynamic overlay for RB3gen2
and have it working. The thing that moved us back to static DT
for this board was the sidebands and these don't exist for a real PCIe
card.

## That's all folks!

In short, for zany embedded designs with nasty (and mandatory) side
channels, we'd like to use the DT bindings we have proposed from static DT.
This should be comfortable and ergonomic for embedded developers who
are accustomed to slinging DTs around.

For sensible grown up designs that need to cooperate with both DT and
ACPI, we'd like to use DT overlay. This essentially makes the use of DT
an implementation detail that reduces maintenance by avoiding reinvention.



Daniel.
