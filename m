Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092546;
	b=nzZQz8vQczIZRBKVOzZeN31iFTXENj1FvCr3xTEdnz3fBV+WUJGc2ZDQcKGAwg+b9Kwd
	 Uw7nwzJVgHZ6sngKJ5Y85yj1wqO+ZlHW9BGRN4Mu8hKmw8wBK72NMX7ES8g8Sb0pbU7Fc
	 mLTTnKTUVWGdSVsAqAYsD7NZz++mGJXbwvgz4Z52lkWOdg5udKpH/MKh3DCCHrNTRgSsm
	 RSvPr6g6csVrOIocj+S+4OU18aldwPskjWqSY861WFLHrggOUFTq0oHCD9FMt1Qw6jNZP
	 YKwiiYsM4zU+YS1oNIVmvAHVpilMgrOtFqJ8GvkjphFXW/8IA0hY3QsH1hbW6wNMFvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092546;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=FrqcePVIbKpJOlr0CwwEXmHuYmHa3yUMeo1BTUrWcl0=;
	b=T8RC8nt83vxImBRdFJA4krPMGuOdjWdvyB6F+7+Ayt+kYMLX/F/HL/JhD0dSeTr0EXKM
	 VJyw6WqpY3bGGb9Ab62fn7XsT287XMwMcQFvZA2BBGfWXdCeuht8ls260ETG9Aaw/u4yg
	 yeK5f6ohUzPHd/DkanaMFXSmf/jZxnVZa1+BAlUlQjPr75RUnnCWEuqL1Q2JXZVpKiyNO
	 Q5IuTuqzKsiKcCpf7gDkT2cYkHNjj3p04q6afx/0g/VCul0wq345yG5e8Z5W4HPnkEteX
	 W3NJFGNMEqXkNmxyAgs+mwflSjXLr2UFZxQ2UlLrrosqgXeyS2BkrTz7OJk61dVllIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mteItAuJ;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E47606A324;
	Thu, 19 Nov 2026 12:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33E47606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mteItAuJ
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C2044C4CBF1;
	Thu, 19 Nov 2026 12:49:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5877D60271;
	Thu, 19 Nov 2026 12:49:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC49311BC0673;
	Thu, 19 Nov 2026 13:48:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795092535; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FrqcePVIbKpJOlr0CwwEXmHuYmHa3yUMeo1BTUrWcl0=;
	b=mteItAuJBxCXIm6o7Tz4CiCkaMG9jXhvMU2sSQLnSpwBcZpG8f2MBEvcJ1Bx2lQIvEFPHc
	cDtQgbCpT1F3jW229XoKlV3ReW5mnP/ABdent9sCr/5183826BqbllILfT90L05VaHMgtP
	dUJUiAyMuYUR1NhbdpZFwHZONdW4QU9si+WZSm1qV6DhZI6XlaK2xQVRCAOzwBKLP1wBFh
	3qw4wVp4q47Ts1Jsp/lIRy+UYxCPzeFEV89KDKzTVDondoVzVYjpyUCZKV/Oz4GxrsbGus
	YTBzHCONs5aDQShHm1+BnPAiQ9L4baKhNKmb68Cs/uKC0//BXan270Bf1Uz6BQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Srinivas Kandagatla <srini@kernel.org>,
  Tze Yee Ng <tze.yee.ng@altera.com>,  Richard Cochran
 <richardcochran@gmail.com>,  Jonathan Lemon <jonathan.lemon@gmail.com>,
  Vadim Fedorenko <vadim.fedorenko@linux.dev>,  Yuqiang Sun
 <izaiahsun@gmail.com>,  Amit Kumar Mahapatra
 <amit.kumar-mahapatra@amd.com>,  Luca Ceresoli
 <luca.ceresoli@bootlin.com>,  Bernhard Frauendienst
 <kernel@nospam.obeliks.de>,  "Gustavo A. R. Silva"
 <gustavoars@kernel.org>,  Kees Cook <kees@kernel.org>,
  linux-hardening@vger.kernel.org,  Arseniy Krasnov
 <AVKrasnov@sberdevices.ru>,  Boris Brezillon <bbrezillon@kernel.org>,
  Brian Norris <computersforpeace@gmail.com>,  Jernej Skrabec
 <jernej.skrabec@gmail.com>,  linux-arm-kernel@lists.infradead.org,
  linux-sunxi@lists.linux.dev,  Samuel Holland <samuel@sholland.org>,
  Chen-Yu Tsai <wens@kernel.org>,  David Woodhouse <dwmw2@infradead.org>,
  Thomas Gleixner <tglx@kernel.org>,  Vitaly Wool <vitalywool@gmail.com>,
  David Woodhouse <David.Woodhouse@intel.com>,  Russell King
 <rmk+kernel@arm.linux.org.uk>,  Mike Rapoport <rppt@kernel.org>,
  Alexandre Torgue <alexandre.torgue@foss.st.com>,  Christophe Kerello
 <christophe.kerello@st.com>,  Maxime Coquelin <mcoquelin.stm32@gmail.com>,
  Jason Roberts <jason.e.roberts@intel.com>,  Boris Brezillon
 <boris.brezillon@collabora.com>,  Michal Simek <michal.simek@amd.com>,
  Mason Yang <masonccyang@mxic.com.tw>,  Ramuthevar Vadivel Murugan
 <vadivel.muruganx.ramuthevar@linux.intel.com>,  Lucas Stach
 <dev@lynxeye.de>,  Dmitry Osipenko <digetx@gmail.com>,  Jonathan Hunter
 <jonathanh@nvidia.com>,  linux-tegra@vger.kernel.org,  Stefan Agner
 <stefan@agner.ch>,  Thierry Reding <thierry.reding@kernel.org>,
  AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
  Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
  linux-mediatek@lists.infradead.org,  Matthias Brugger
 <matthias.bgg@gmail.com>,  Heiko Stuebner <heiko@sntech.de>,
  linux-rockchip@lists.infradead.org,  Yifeng Zhao
 <yifeng.zhao@rock-chips.com>,  Alexandre Belloni
 <alexandre.belloni@bootlin.com>,  Claudiu Beznea
 <claudiu.beznea@tuxon.dev>,  Nicolas Ferre <nicolas.ferre@microchip.com>,
  Keguang Zhang <keguang.zhang@gmail.com>,  linux-mips@vger.kernel.org,
  Shan-Chun Hung <schung@nuvoton.com>,  Jacky Huang <ychuang3@nuvoton.com>,
  Fabio Estevam <festevam@gmail.com>,  Frank Li <Frank.Li@nxp.com>,
  imx@lists.linux.dev,  Pengutronix Kernel Team <kernel@pengutronix.de>,
  Sascha Hauer <s.hauer@pengutronix.de>,  Han Xu <han.xu@nxp.com>,
  linux-renesas-soc@vger.kernel.org,  Wolfram Sang
 <wsa+renesas@sang-engineering.com>,  Jerome Brunet <jbrunet@baylibre.com>,
  Kevin Hilman <khilman@baylibre.com>,  Liang Yang
 <liang.yang@amlogic.com>,  linux-amlogic@lists.infradead.org,  Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,  Neil Armstrong
 <neil.armstrong@linaro.org>,  linux-arm-msm@vger.kernel.org,  Manivannan
 Sadhasivam <mani@kernel.org>,  Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,  Kamal Dasu
 <kamal.dasu@broadcom.com>,  Piotr Wojtaszczyk
 <piotr.wojtaszczyk@timesys.com>,  Vladimir Zapolskiy <vz@mleia.com>,
  Harvey Hunt <harveyhuntnexus@gmail.com>,  Paul Cercueil
 <paul@crapouillou.net>,  Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH v5 00/58] mtd: rawnand: retain chip and controller state
 across removal
In-Reply-To: <20261115-submit-rawnand-retained-handle-lifetime-v1-v5-0-cbc49c5c5e74@gmail.com>
	(James Hilliard's message of "Sun, 15 Nov 2026 23:29:15 -0700")
References: <20261115-submit-rawnand-retained-handle-lifetime-v1-v5-0-cbc49c5c5e74@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 19 Nov 2026 13:48:02 +0100
Message-ID: <87v75tc7i5.fsf@bootlin.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi James,

On 15/11/2026 at 23:29:15 -07, James Hilliard <james.hilliard1@gmail.com> w=
rote:

> An MTD handle can outlive controller unbind. Its metadata and NAND locks
> must remain valid, including when a writable file closes and calls sync,
> while further hardware access must be rejected after disconnection.
>
> This builds on earlier MTD removal-lifetime work. Commit 19bfa9ebebb5
> ("mtd: use refcount to prevent corruption") added MTD reference counting
> [0], but retaining an MTD reference does not by itself retain the
> driver-owned allocation containing the master. The read/unbind discussion
> also covered raw NAND [1] and draining active operations [2]. Tze Yee Ng's
> SPI-NOR series addresses the corresponding SPI-NOR paths [3].
>
> Following Greg's review [7], separate class-device data from the MTD
> backing allocation. Delete the device's interfaces and drain NVMEM and
> class PM callbacks before releasing backing data. Bare device references
> retain an independently allocated device, whose type, PM dispatch and
> final release are built in even when MTD is modular. NVMEM similarly
> disconnects and drains provider and layout callbacks before unregister
> returns; retained consumers keep core-owned metadata and receive -ENODEV
> on subsequent access.
>
> Introduce opt-in backing-object ownership for MTD masters. Registered
> nodes and acquired MTD handles retain the chip, while nested partitions
> also retain their parent metadata. Unregister first so removal notifiers
> can finish I/O, then disconnect raw NAND and drain admitted operations.
> Hardware resources can be released without waiting for open files to clos=
e.
>
> Virtual concatenations serialize publication and removal across physical
> controllers. Disconnect and drain a published concatenation before any
> component can disappear, then release its component references. An old
> handle keeps the disconnected virtual device, independently of a later
> replacement.
>
> Run NAND and controller-specific cleanup during disconnection, while
> the controller driver is still bound. Snapshot the OOB layout in core-own=
ed
> data before publication so metadata queries remain valid without driver
> callbacks. The NAND core frees retained chip and controller allocations;
> the final MTD put never calls back into the controller module. Ordinary
> MTD and NVMEM handles retain the NAND core that implements their
> operations, rather than the hardware driver.
>
> Share allocation ownership across the raw-NAND drivers, including
> partially published probes. Shared controllers remain allocated until
> their last retained chip is released. R852 allocates a new chip for each
> card, and NDFC allocates controller state per binding.
>
> Based on NAND next at 30daaf3e7897, with Tze Yee Ng's module-reference
> ordering fix [4], Karl Mehltretter's OTP cleanup fix [6], and the separat=
ely
> posted registration, operation-locking and controller probe/teardown fixes
> identified by the prerequisite metadata. TLA+ models and their assumptions
> and coverage limits are available in [5].

While lifetime issues are a real concern in the kernel, please note that
in general, removing or unbinding the flash controller driver is not a
practical operation. While highly unlikely, this is possible though. But
I am not going to sacrifice all the devm_ calls in favor of reinstating
manual error handling just for that. If there is a way, it must be
different.

Also, this kind of contribution can only be done if you *understand*
what you are doing. Getting the big picture here is not optional.

Maybe the problem is MTD refcounting? Maybe the problem is the devm_
orderging? I don't know, I haven't looked in depth at all the
patches. But the current approach is clearly not acceptable.

Thanks,
MIqu=C3=A8l
