Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EF63537FF
	for <linux-hardening@vger.kernel.org>; Fri,  2 Oct 2026 21:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790977668; cv=none; b=LdHxeCf9QIF99LCwWyqT7xU7vf3EhtlCgSwZnH/3tk/hfkTT41f+dceC8soKE12OCr+PbgUBlArF0lJZpkblt+lkAfFVYAluxrM1c/D2SA36lOguhnvcV6GD0sz1/VrOUqCoWKc4VtRjrpRTV/IN7t1Cr6OeR37+kfqpBQd0c/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790977668; c=relaxed/simple;
	bh=xeDv0Ie3avteIVWsPN2r7WYBC3lpTV89mwbd7+lu07I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=k3YTmWaAmpd1YicHdA8G+BK+sDREmZh+zrjAAXm2yHzD8hQM4lDaGukYQ5lEb0jRktkYog9PwZNJQcWjs5uGwen3aoZTGcVMEo9k4MefZcr0HfJP7XR/IDLk0az3yxl/9ACz+7CtV5BFb369QXbldOiCpAjCcieTPfMyrV4sJ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wt2GedY0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wt2GedY0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790977664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G9GZFvY+OivcXtxJyc9Ua27iVVl5yXvMnk0Q8270BFo=;
	b=Wt2GedY0mNvaegwdUOefcjVptXLbWQ7C8t/y8yWlAUWeT60olCQYibcQsceSgTn2gCOMoB
	LPzyPRLOKUWg9cLJMHhhnovdWnGZcCxgVlMni7Bhg1w1iKUh3lGjTJUuOk5YzXEdfCvGU1
	/lQKTpxXLbeUvaj6ZzXR/nCbK6DFnRQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-jd6M26PwP0CyU85LrKFP3g-1; Fri, 02 Oct 2026 17:47:43 -0400
X-MC-Unique: jd6M26PwP0CyU85LrKFP3g-1
X-Mimecast-MFC-AGG-ID: jd6M26PwP0CyU85LrKFP3g_1790977663
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93e46c120dfso2207385a.1
        for <linux-hardening@vger.kernel.org>; Fri, 02 Oct 2026 14:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790977663; x=1791582463;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G9GZFvY+OivcXtxJyc9Ua27iVVl5yXvMnk0Q8270BFo=;
        b=rzER9oyJT2+vogKtDuzyqJUIJu+Z0OBiMnLp3cCK3Nl/Aa0BBH4RCCn4eQt8VAC1gv
         ywAaHziA5W5hjJefy+Wp/LeNtn1fp9QjzsugTWq/EZ5X1Q2J0D7L1fS1O/z6Yv5rtJv/
         CEDeCHjYlX2zZaoP0TgH1nWs2uj6v6N9YdtoQhIfVYMS0TIiD2ik+TEq+EGxASPC5xO5
         e3Kmubzv04j1x9l9/082JLgVux2kLj+MMSMmkxU+NwCeKOb6qCL60v/UUSIRmkWxY2ev
         CZ4V18vz8yLaocRPzmHmOYSdurVAGgt8M0J3UpN3JzwJOyNoNGWfS84zjaHaDG4hee39
         BtmQ==
X-Forwarded-Encrypted: i=1; AKwUvBwi45O0ccvxbNeCOZkLbn7retgtMKjefCilND2FM2mKyWRy9jj2LsSKTSMBgJdCBpsR3Ox557VC+XYHKenZoXw=@vger.kernel.org
X-Gm-Message-State: AFuF++kE3B2tGgaIOlPtseBzZdoilHuJ2+3za8t29W+yuGJlcenXjT40
	jgrvw88+wiA3l+SbMYV1vevrsh9xae5PkL28QdcuS0ImQewiHCWuy2QI/+96S8PdR9AS38qbmnE
	KP4MXkweu/sdhdGTHlwvReFrdgo+wyQmKGFxq02cMH9n3oUytM8GF4PFYgEWVlOo4PNH2SA==
X-Gm-Gg: AYBFou3wfvvAa7VJP3O6x2Shx9XVhVpNyqcECiz6JT0zmF7uOJU7+ZzgPYH5kHIEkOz
	rxT9H6Nci1NUlCKg24Ml9loO/AVKCp2en7BJ4LcfMPZcHcm8MTE3XTWlcNzb/kWnmTiCQPbhdjf
	CTZBMAMXEJWSx9nrdqAU4SHp9vyOCtdK2CqXtvjDrDNOBzj/CGqNfUk/FGAelLYS6djMzkGBKo4
	ZHJEOFpZHxWImZT6YMiqdNyNcyioigheS3C5qPEzkou02d3q00qm6yzzebBYQhQYrC+0S8KYsHZ
	7f5/d3/KuuuFYLEQNLHwnfyJ9kxETVmQo7AnZeNdS3MTaR9vRbRwZhHtZFGA+N70mMDPHFIMJWd
	QBDScVg==
X-Received: by 2002:a05:620a:700c:b0:939:fd0e:9fd7 with SMTP id af79cd13be357-93e510819ccmr112759685a.43.1790977662674;
        Fri, 02 Oct 2026 14:47:42 -0700 (PDT)
X-Received: by 2002:a05:620a:700c:b0:939:fd0e:9fd7 with SMTP id af79cd13be357-93e510819ccmr112754785a.43.1790977661924;
        Fri, 02 Oct 2026 14:47:41 -0700 (PDT)
Received: from redhat.com ([69.43.42.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e4e96acebsm97276885a.21.2026.10.02.14.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 14:47:40 -0700 (PDT)
Date: Fri, 2 Oct 2026 17:47:38 -0400
From: Brian Masney <bmasney@redhat.com>
To: Conor Dooley <conor@kernel.org>
Cc: Changhuang Liang <changhuang.liang@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>, Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
	Hal Feng <hal.feng@starfivetech.com>
Subject: Re: [PATCH v5 00/23] Add basic clocks and resets for JHB100 SoC
Message-ID: <asAmejPowNLKnmto@redhat.com>
References: <20260930124317.5648-1-changhuang.liang@starfivetech.com>
 <20260930-grafting-undertake-ff3e01060284@spud>
 <ar_4NBLHrq2W7_vc@redhat.com>
 <20261002-amigo-joyfully-6894bdfa17e3@spud>
 <20261002-doorbell-recycler-f386e3b8d5a4@spud>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261002-doorbell-recycler-f386e3b8d5a4@spud>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WyBY6n03B27zy2Q3Vux09zCfVWDZPDVBP_wbq9DRZzA_1790977663
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Conor,

On Fri, Oct 02, 2026 at 09:26:34PM +0100, Conor Dooley wrote:
> > btw, will you be at LPC or OSSEU?

Yes, I'll be at LPC. I'm giving a clk talk the second day, so you can
find me there if we don't cross paths before then.

> ... As I went about aligning more ducks, I recalled that the syscon/pll
> series also depends on some of the binding header files in this series.
> 
> I've made another tag with an additional binding that you'll need to
> apply the clock patches in this series:
> https://lore.kernel.org/all/20260828095608.19955-2-changhuang.liang@starfivetech.com/
> 
> This tag will actually appear in linux-next as of the next iteration,
> because the socinfo driver I will definitely submit as 7.4 material.
> 
> Thanks,
> Conor.
> 
> The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:
> 
>   Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/ clk-starfive-jhb100-plus-soc-header
> 
> for you to fetch changes up to c4a545d3e428e9600d670fa8a08098b7bc82d5ec:
> 
>   dt-bindings: soc: starfive: Add StarFive JHB100 syscon modules (2026-10-02 21:17:31 +0100)
> 
> ----------------------------------------------------------------
> jhb100 clock binding + syscon binding shared tag
> 
> This is a second shared tag for the Starfive jhb100 clock bindings, between
> the riscv soc tree and clock tree.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> 
> ----------------------------------------------------------------
> Changhuang Liang (8):
>       dt-bindings: clock: Add StarFive JHB100 System-0 clock and reset generator
>       dt-bindings: clock: Add StarFive JHB100 System-1 clock and reset generator
>       dt-bindings: clock: Add StarFive JHB100 System-2 clock and reset generator
>       dt-bindings: clock: Add StarFive JHB100 Peripheral-0 clock and reset generator
>       dt-bindings: clock: Add StarFive JHB100 Peripheral-1 clock and reset generator
>       dt-bindings: clock: Add StarFive JHB100 Peripheral-2 clock and reset generator
>       dt-bindings: clock: Add StarFive JHB100 Peripheral-3 clock and reset generator
>       dt-bindings: soc: starfive: Add StarFive JHB100 syscon modules

Pulled into clk-next.

Brian

