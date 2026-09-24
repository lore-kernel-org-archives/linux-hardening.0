Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E957536E460
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 19:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277787; cv=none; b=QInvyiDQbRRYnC61t+6dQGOySYiRGGFH/WLVKtupUP3fVgd0SHDPZtZaY33J8UYJe8CiWsrh9MQm47aAZLhUZUzGsv8ON7VaPMg9gRQqatQ3lo2iDqRiY9YTuAQ27f1IEQywrkL72pqaYJayvPmbiYK97SgVTzI4JMFilvUW8SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277787; c=relaxed/simple;
	bh=qrXIRZFdJBniWCU8VJvuUKRMxq4CJ7LwdmKsYq3i5G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fGKNw6f38PAHiw/0VxsajLIAg6lrHc4JN+97PFw7X2x7dt5Syzch99ges7hjseiNXRZpQCNmwIiPS/6hL7Zpqo3BmO5qIMO0AckbnLjtEv0Ru1Ji49ErXqAN+pu0j+L8E/MxhsdpuwLSBEm4tYO4/8+B7xlPqr1MhMZkqNb65NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BfAaCSYt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfAaCSYt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790277783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ut0W8EJcCupEWBHDQXwLOk3ZkvjvxuM4fNB2BlLxpCg=;
	b=BfAaCSYt+ypmEcDP6K7LFM9dDDoLgZxXilv2ATIqCQjF99rviIifvMH47T4vQSKXOxlyMS
	D+uWuTqt7x7nRJF3rCGH6Febkcr8U1mwTXhnkUHAoSeHQD9geI9CTYlxLGQdw71DM++hRX
	BcT0KwRO4rcLlpd2Bp9v3KrZnYVo8JI=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-7CwqdfM4Mzq3VhMM-G29iw-1; Thu, 24 Sep 2026 15:23:02 -0400
X-MC-Unique: 7CwqdfM4Mzq3VhMM-G29iw-1
X-Mimecast-MFC-AGG-ID: 7CwqdfM4Mzq3VhMM-G29iw_1790277782
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-673abd1ed0dso458968d50.1
        for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 12:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790277782; x=1790882582;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ut0W8EJcCupEWBHDQXwLOk3ZkvjvxuM4fNB2BlLxpCg=;
        b=JMCSM0dV/a6+NjfSt5hA+NprhCZE3umaBRjgPrVpwEwzpbkwz6xxN3iPBhyzkJ76dn
         TORZPb6ZGKsfwsxF/wBYXUbGHcNdWgFPpB9K3XvFznHr/fSBB8s4uejaJd/Juv0a+Q4D
         WsWEf40ttexdTann2NKpYUI4HSrsGafprmiQxHeq1s27+KmdP+QNJFD9g40364VX9vtF
         VQkNclUTtdz1DQqEYe1/g3q1Qf6+Pf+6yxQ3+Dq9/kQtiWZB0q2mgXcs+HL5oHhovWO+
         8OMbLVOo2o78b2E7pTlc2aUBpYD3ktkobHD6tPpPYxz17E+V2806WR8/QH8O9xPo4HTA
         tlNw==
X-Forwarded-Encrypted: i=1; AKwUvBwQUCJ5XfSTzmPmnXyeWf4ZEDMj2KOo/xH32WUX1eXHc/QYxlOyGp7djgEekxUZtkIvUptT6UPgtD0r263qTSs=@vger.kernel.org
X-Gm-Message-State: AFuF++nWttSzjCqVVHSPfJWGfymsxsc18Gnp7wIobw8KVyfP1Sse9i3c
	ttWrN9hXv60ousB98e4Tf6qgKUaU8MRGWjkJpgZQeAZqw47V+SCgB1ejIfDxLkhMzG47wlJglbq
	iOGn9h+CDydkXvsGddFuXAk8opl6gDeCsVewoJZB+J/cyZxb4P2JOdthtv8svzYVE+rn20Q==
X-Gm-Gg: AYBFou1ok60HarBVjvmdrPPGY5cvJ/HrLc5eataT1gHPnL/Item/zaNlN85yZH480DS
	kJgpBQQy1Afz4VbjSF+bwSWGq5u+YiXA+tODyTJ1MhtP7IvPEoL2YJ1edFCDL3A4a5RA8wsZBev
	2+f/xZ/Y6XGI6JDM05P2uTRILJ6GvhhNg1sj3AZfV0b7/JUg/zdvMfGd9qZECeSm4173qnQMKki
	EAWz5BkIdUVE7yldWFN5Ro+YtBngB5WCPQSqHXEuvaF9abwSogsQTAW68PD7fPYpjKWjCLa2MGC
	uCRuQpII8nan2ahPCxFEjYs7EHKJxqJxBWexb4hc5D0rPIdJLPmZZG9hLXqEm6Dotxwy8JZNyw=
	=
X-Received: by 2002:a05:690e:bc2:b0:66f:c1bc:87db with SMTP id 956f58d0204a3-672ed2b90a5mr1641068d50.52.1790277781891;
        Thu, 24 Sep 2026 12:23:01 -0700 (PDT)
X-Received: by 2002:a05:690e:bc2:b0:66f:c1bc:87db with SMTP id 956f58d0204a3-672ed2b90a5mr1641049d50.52.1790277781356;
        Thu, 24 Sep 2026 12:23:01 -0700 (PDT)
Received: from redhat.com ([2600:382:8501:4f43:e566:7498:c7c8:a7ec])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6740ef31df6sm26520d50.13.2026.09.24.12.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 12:23:00 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:22:57 -0400
From: Brian Masney <bmasney@redhat.com>
To: Alex Elder <elder@riscstar.com>
Cc: sboyd@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	lee@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	abelvesa@kernel.org, kees@kernel.org, gustavoars@kernel.org,
	p.zabel@pengutronix.de, daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com, lorenzo.bianconi@oss.qualcomm.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	mfd@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] clk: toshiba: introduce a TC9564 SoC clock and reset
 driver
Message-ID: <arV4kYRFHM0rW8Km@redhat.com>
References: <20260918165234.687224-1-elder@riscstar.com>
 <20260918165234.687224-4-elder@riscstar.com>
 <arG238GS8bMB6DkW@redhat.com>
 <0785235b-de06-44d4-9068-ec706eeba848@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0785235b-de06-44d4-9068-ec706eeba848@riscstar.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IExJeNVALjdADt1JZMEwu4PCdzvpapMJ-jfROnSWRX0_1790277782
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alex,

On Tue, Sep 22, 2026 at 08:33:37AM -0500, Alex Elder wrote:
> On 9/21/26 5:59 PM, Brian Masney wrote:
> > On Fri, Sep 18, 2026 at 11:52:32AM -0500, Alex Elder wrote:
> > > Define a new platform driver that manages clock and reset signals
> > > within the TC9564 SoC.  There are 21 clocks, which can only be
> > > enabled and disabled, as well as 13 reset signals.
> > > 
> > > Two registers manage the state of the clocks and two others manage
> > > the state of the resets.  The registers are accessed via a regmap
> > > supplied by a system controller, which coordinates access to a
> > > region of memory that will be shared with another driver.
> > > 
> > > Access to the memory region is provided via a BAR on a PCIe endpoint
> > > function embedded in the TC9564 SoC.  For that reason, neither the
> > > PCIe clock nor PCIe reset can be manipulated by this driver (they
> > > are assumed always on and deasserted, respectively).
> > > 
> > > Similarly, control is not available for the I2C clock and reset,
> > > because the PCIe subsystem on the TC9564 relies on I2C
> > > 
> > > Co-developed-by: Daniel Thompson <daniel@riscstar.com>
> > > Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> > > Signed-off-by: Alex Elder <elder@riscstar.com>
> > > ---
> > >   MAINTAINERS              |   1 +
> > >   drivers/clk/Kconfig      |  11 ++
> > >   drivers/clk/Makefile     |   1 +
> > >   drivers/clk/clk-tc9564.c | 366 +++++++++++++++++++++++++++++++++++++++
> > >   4 files changed, 379 insertions(+)
> > >   create mode 100644 drivers/clk/clk-tc9564.c
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 66d0e7e65adcb..39346a5cd9a7f 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -27675,6 +27675,7 @@ M:	Alex Elder <elder@kernel.org>
> > >   M:	Daniel Thompson <danielt@kernel.org>
> > >   S:	Maintained
> > >   F:	Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml
> > > +F:	drivers/clk/clk-tc9564.c
> > >   F:	include/dt-bindings/clock/toshiba,tc9564.h
> > >   TOSHIBA TC9564 PCI DRIVER
> > > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > > index f9592fd9ec2bb..50efa10d48450 100644
> > > --- a/drivers/clk/Kconfig
> > > +++ b/drivers/clk/Kconfig
> > > @@ -292,6 +292,17 @@ config COMMON_CLK_S2MPS11
> > >   	  clock. These multi-function devices have two (S2MPS14) or three
> > >   	  (S2MPS11, S5M8767) fixed-rate oscillators, clocked at 32KHz each.
> > > +config COMMON_CLK_TC9564
> > > +	tristate "Toshiba TC9564 clock support"
> > > +	depends on TC9564_PCI
> > 
> > select RESET_CONTROLLER
> 
> Thank you.  The reset and clock drivers were previously separate
> and the reset only became available if RESET_CONTROLLER was enabled.
> Combining them means I need this.  I will add it.
> 
> I also need to select MFD_SYSCON to get syscon_node_to_regmap()
> (or perhaps something similar, depending on the answers to my
> questions about the proper way to define the syscon).
> > 
> > > +	default m
> > 
> > default n
> 
> This depends on TC9564_PCI, and if TC9564_PCI is enabled I would
> like this to (automatically) be available (at least as a module).
> 
> Why do you recommend "n"?

There is no existing 'default m' or 'default y' in the toplevel clk Kconfig.
How about this instead?

    depends on TC9564_PCI || COMPILE_TEST
    default TC9564_PCI

> > > +	help
> > > +	  This enables support for the clock and reset controller embedded
> > > +	  in the Toshiba TC9564 (and Qualcomm QPS615) SoC.  The state of
> > > +	  clock and reset lines is controlled by MMIO to a region managed
> > > +	  by a system controller; this ensures access to the region is
> > > +	  coordinated between this and other drivers.
> > 
> > Rather than 'other drivers', outline specifically which other drivers.
> 
> I was intentionally vague at this point because the one other driver
> has not yet gone out for upstream review for this iteration of the
> code.  But I do agree with you, so I'll change this to say:
> 
>    ... between this and the XGMAC (stmmac) driver.
> 
> Then it will be correct without modification once that driver goes
> out for review.  Is that better, or do you suggest something else?

Yes that sounds good.

> > > +static const struct tc9564_clock_init tc9564_clock_init[] = {
> > > +	TC9564_CLOCK_INIT0(MCU, 0),
> > > +	TC9564_CLOCK_INIT0(INTC, 4),
> > > +	/* TC9564_CLOCK_INIT0(PCIE, 9), */
> > > +	/* TC9564_CLOCK_INIT0(I2C, 12), */
> > 
> > A comment would be useful here to outline why these are commented out.
> > Is the PCIE one comment out because of what's outlined in the commit
> > message?
> 
> Yes, that is why.  We are downstream of PCIe, and PCIe in this
> case depends on I2C.  So we don't want to mess with these two
> clocks or their reset counterparts.
> 
> I only provide this for the benefit of documentation.  If someone
> happens to see bit 9 set in this register, it means the PCIe clock
> is enabled.
> 
> Anyway, others have suggested simply removing these comments.
> So I'll do what you suggest, but I'm interested to know whether
> you would favor just deleting them instead.

I also think to delete these comments. Would it make sense to include
the comment in just include/dt-bindings/clock/toshiba,tc9564.h ?

Brian

