Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794854412;
	b=OtIWn9UXaMx3a282qz0kTT+YggQ53f4F1sZrMTFAICSK2zHMo+VAwW/9tjsH7Xs5vy8Q
	 8NesysWtYGUuFKrkwMokFXp4Nwpun2aEIiDfh4Dk6nQXKm0iW/+i2dET11otz4Jv7nvEv
	 weJAOuYRz5Cb9Hls4BaKKJd3Gj39CE1zI1q6aUCVV87TgTqBhAJaw/LCigxSINwt95gED
	 M1IxxnR22HPTh4XIrf/jHbjyX62sTax7SQ+xE2jURctkZ+wtaEq4Eknx00C2Z+Xz5x1C6
	 WF8MMTdrN2BMhJeWOC7wEq+IFHMrGSrTTUF/bpA12JjiX3K/C94RL+KTbn+g6o0jl1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/Wfo4XPULnebZxDQKGgawMBq41Rv1aopAmpn/6ecL8I=;
	b=5Ym6/NNd+P2yHjBWCwLwZKa4fkIz3vkXosLyi4Zlyy/CDEBBSDp72xCuJnNcYEYxavSk
	 WzfW4TIHNX3qfjQ+/GXWaF6S9kOB+rk5KyIRV+veWP7prf3o80g/CQRR6wZpyfV7fLmYU
	 fswFZYRUtSOv5x2F3Syys3KpwWkOMFst88j+tDJcaWTUATsrrxVtc6ia1XAkOUhm6L19Y
	 JwBelNBGZTgA776rrLUfjJ9z9IgUPhCbUAw4VMSPaHgRYQZCUDCuJCcbl6aW5t57vU0Th
	 U1bfxRItzCROX4Ts72aab+XnQTRjMZVbN8Tab6BrLPg7ntm9LMMP1vOL9Xj6AQH5/BQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LVcESP75;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA02606A31C
	for <linux-hardening@vger.kernel.org>; Mon, 16 Nov 2026 18:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BA02606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LVcESP75
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7777fa8f1ccso1142703137.3
        for <linux-hardening@vger.kernel.org>; Mon, 16 Nov 2026 10:40:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794854409; cv=none;
        d=google.com; s=arc-20260327;
        b=lBIH8Z3U7QkyIIxn8Y2VZ7T3c8FcNIgFDPjzse+BbH2GsSO4J6qT6DrMEQ4SuyKxc3
         +X747IMAw0hMZVuypLeW3CNaLaLqyRlHqTiV/pcf3PI1+D9mZ6mVbOQ8ytK99qrZy0AY
         wpmwwzmbDDIwbWhamIUogCI2R5ATAw0/Q3bQwyc9lDriEvzMvY74rzj3pg8Kg6UxhCIS
         fGPvhebNJyJDwwZhSuQMbhxdbF+bbuVQjwy/yLD0U+8X6lRa1jBpn2SYgkC4HnID0Skl
         LdLu5W7U3Oryziio90XBPg1FnaYHP/oAhIUvKg6T8P+00DxBK/j7duHWQYMFc5npBzWi
         Q3PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/Wfo4XPULnebZxDQKGgawMBq41Rv1aopAmpn/6ecL8I=;
        fh=ktVWCgo/p8mmRY5/WNMio9x5R+GTvF8MyYmBIzhfXSo=;
        b=lItygel/43rCEHuuhGrt5tg8LogpmgYKvfKrP90S0bfuT6D+cg4odgnTmlDGQfy1sd
         lRoV37bsa2rhE1420O+2ivukEyPzGvZa9V3wJCroeGcFNOkrF9LqAn4pftHgHiQdxX2n
         pmbx3iu56q5rVCMEaT+DvH7hZDGmX2U+CeiTbvYXbwzqUxtvCJMKYS5xkxncmh4/f5CD
         JV3KIxIr8L3xFmS6jxXPenFnU1SD2drn6nfVGixTir8HsyYjZPgnUnhdwTCUjQYoT2Wd
         q1j6zrUHgu7bwSpVkHrrV+BDM6/G6BEgxT3v82aUqpn9Pz6os841Kw7CCY+MiCrbFLPI
         nqHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794854409; x=1795459209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Wfo4XPULnebZxDQKGgawMBq41Rv1aopAmpn/6ecL8I=;
        b=LVcESP75ejW4NvIey/ViFvKgttKmwuxuE0KziJ+eYq5uPQwYY+swkIaXnoD9ir2RdJ
         WkI3uNbO06v6oF4aGlRFH6kyrQNwkDqchhtb8di2WhYv9dwBgf/vZrow6k0EfPIGaG6P
         JY7b+OfYMysG7cZo4q0AWI8iJunknow38LLobd9XYDvc93/zUnIINTid242xciMVwrN/
         JHIQnhsMPIiklRcFQbhe872gWQ03IucrailA31Ai/D6f2M3LYGU3v3JmWf7Ng/0MafyO
         aOrhEFyFof50HIeTo57nkjhn8yvkkM/g5yu+dKDGguqVvTUW2m2R/nvXlqepC4AC685c
         NkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794854409; x=1795459209;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Wfo4XPULnebZxDQKGgawMBq41Rv1aopAmpn/6ecL8I=;
        b=jUo53/23A98YOH7n5x8fwBYlJFaQbV1wjQeReVrKxbehhn8+XR5jdsX11d4MDcVqYd
         HDgiDjibSBrjEQzMJOhNS+ktd/T6bx6tgUCDV19E7Z61t7S7vcsikoLSrudKw6lzhdfK
         DIm+5p6sNlsJDMuEb/ISk4HHqmMb2anzTj3M0YZIDH1S+xD1fHMotWzluM5CYwazyZOf
         zosr/ZSjuTZza1n/NnLprO2WtL+FEW6e2+7UK4bsmtiUqxSm9tp7tXtmouaRYnNGoMYk
         xKdLriflGbkd0T2cKmfainXzPQVgleJgBcIV4+DwMdOtMVOEu2CNNJs1xvuKneTQaVMq
         1Shw==
X-Forwarded-Encrypted: i=1; AL+hErHUtZz9a/ZgxMBv08iKFz4+S2IPLr48dzOa7rn5ehJqruldiiMMm1M6cOsLlBUSK1nD0SGJfuGCTJoU4SNTweY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZwoqHPw/d52OAA6dg3i3Ai/tvHBR2Gi7q49Ng/Hf3g4AvZLY7
	bXBPHjV23K4napbgvsGGPpl2nRbtO+EGbu+U/0BI4lEyVOer/IX39Ai856tmFPfdkoYz7YLzkhY
	vrYk15gckYWE6UrKkcQU6t6GR2KCwNYY=
X-Gm-Gg: AYBFou3aIaVQTWSat94k2J72lzuu0K7+arlJP7yYmM/PSTnaHFiPFz9ow1KkIR3b8Ab
	O/cV7vezSFydR1My0ZC0yxHmAp7q20YOI6Z3Ek0gc8ogrTnRgX7HfG7o19fk3gmd4wHVD8yK0Up
	s7yW9q9yw+q0Pd5VVI69s5hutxapvnCg7t1mfvmvU5JixRhCN6PHxctz01KR8rQ8D8JyMSoYKcm
	95DIur6CVN+LjGQjHPaq6YNALzZHeRuzse8xZAe35M/G1RP1BVO6KL6pBGsN6wiPxe3TlokjYc8
	CRISm1sx44yrrXDTcX+DSTYV7ZdyBhdgcjCS29kyGrL2LdbpO4MW/7MHZGPzx42oez5Zbs1XE0d
	Oi46CwHYYLmWOMdw2XtuSUa9mQbnr4PtDE+1dXypmlffrxsI5eMBTJ1jOyf0gkT3sYkVABmyknM
	wxIJ9Zja3PUB/sZmXZPvAqUcs23sWMErCgiYMI20+VfB7S5OH1BgOXSS65JbwkMP+npPRK/dT8U
	qpEWDnilmi6hgS3IlMDw0p8GxlYsuY=
X-Received: by 2002:a05:6102:3fa3:b0:7a8:2a34:432e with SMTP id
 ada2fe7eead31-7d64d6d6b49mr3145463137.9.1794854409349; Mon, 16 Nov 2026
 10:40:09 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115-submit-rawnand-retained-handle-lifetime-v1-v5-0-cbc49c5c5e74@gmail.com>
 <87fqx0rdzx.fsf@bootlin.com>
In-Reply-To: <87fqx0rdzx.fsf@bootlin.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 16 Nov 2026 11:39:58 -0700
X-Gm-Features: AclHuK80Js2d1O-1lEpkwJYgyZ2cXRLts_QMhx0f_IppjgEhxt6Wg6mnBuiXRf8
Message-ID: <CADvTj4pe5BLcsZg3WYCywTi91jiHMFVg26SPhP3Lk=8KQ=gbtw@mail.gmail.com>
Subject: Re: [PATCH v5 00/58] mtd: rawnand: retain chip and controller state
 across removal
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Tze Yee Ng <tze.yee.ng@altera.com>, 
	Richard Cochran <richardcochran@gmail.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Yuqiang Sun <izaiahsun@gmail.com>, 
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Bernhard Frauendienst <kernel@nospam.obeliks.de>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Boris Brezillon <bbrezillon@kernel.org>, 
	Brian Norris <computersforpeace@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Vitaly Wool <vitalywool@gmail.com>, David Woodhouse <David.Woodhouse@intel.com>, 
	Russell King <rmk+kernel@arm.linux.org.uk>, Mike Rapoport <rppt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Christophe Kerello <christophe.kerello@st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Jason Roberts <jason.e.roberts@intel.com>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Michal Simek <michal.simek@amd.com>, Mason Yang <masonccyang@mxic.com.tw>, 
	Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>, Lucas Stach <dev@lynxeye.de>, 
	Dmitry Osipenko <digetx@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, 
	Stefan Agner <stefan@agner.ch>, Thierry Reding <thierry.reding@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, linux-mediatek@lists.infradead.org, 
	Matthias Brugger <matthias.bgg@gmail.com>, Heiko Stuebner <heiko@sntech.de>, 
	linux-rockchip@lists.infradead.org, Yifeng Zhao <yifeng.zhao@rock-chips.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Keguang Zhang <keguang.zhang@gmail.com>, 
	linux-mips@vger.kernel.org, Shan-Chun Hung <schung@nuvoton.com>, 
	Jacky Huang <ychuang3@nuvoton.com>, Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	imx@lists.linux.dev, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Han Xu <han.xu@nxp.com>, 
	linux-renesas-soc@vger.kernel.org, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Kevin Hilman <khilman@baylibre.com>, Liang Yang <liang.yang@amlogic.com>, 
	linux-amlogic@lists.infradead.org, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Kamal Dasu <kamal.dasu@broadcom.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
	Vladimir Zapolskiy <vz@mleia.com>, Harvey Hunt <harveyhuntnexus@gmail.com>, 
	Paul Cercueil <paul@crapouillou.net>, Maxim Levitsky <maximlevitsky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 8:30=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> James,
>
> If I may, I already told you how hard, difficult and painful it was to
> review your 100% LLM generated patches.

I'm having a lot of trouble figuring out what specifically is making
these so difficult/painful to review, this can't possibly be an issue
with all of my patches right?

These should essentially all be fixing high confidence correctness
issues, is this an issue with the commit messages or the code or
both? Is there an issue with how I'm organizing/submitting fixes?

I use similar LLM agent driven workflows elsewhere and have
not had any categorical reviewability complaints like these from
other maintainers.

Many of the patches I sent are simple correctness fixes, are even
these difficult to review? I can't possibly see how simple patches
like these could be unusually/excessively difficult to review.:
https://lore.kernel.org/r/20261108-submit-mtd-devname-retry-v1-v2-1-09f576b=
cc51f@gmail.com/
https://lore.kernel.org/r/20261106-submit-mtdchar-read-stats-v1-v1-1-173ac5=
c3ceb0@gmail.com/
https://lore.kernel.org/r/20261104-submit-mtd-empty-io-v1-v1-1-3f6bcf474e2a=
@gmail.com/
https://lore.kernel.org/r/20261104-submit-mtd-oob-bounds-v1-v1-1-05209fce5a=
3e@gmail.com/
https://lore.kernel.org/r/20261103-submit-rawnand-timing-recovery-v1-v1-1-1=
cc33723e052@gmail.com/
https://lore.kernel.org/r/20261103-submit-rawnand-bbt-read-error-v1-v1-1-2f=
f0abffaf2e@gmail.com/
https://lore.kernel.org/r/20261103-submit-rawnand-bbt-scan-error-v1-v1-1-0b=
ef8334198c@gmail.com/
https://lore.kernel.org/r/20261108-submit-r852-smartmedia-attach-v1-v1-1-56=
d08c0571a2@gmail.com/
https://lore.kernel.org/r/20261108-submit-r852-registration-unwind-v1-v1-1-=
e54be2c652c2@gmail.com/
https://lore.kernel.org/r/20261108-submit-qcom-nand-child-probe-errors-v1-v=
2-1-4a8704cbf7b4@gmail.com/
https://lore.kernel.org/r/20261108-submit-nandsim-page-count-v1-v1-1-63e961=
cc1dcf@gmail.com/
https://lore.kernel.org/r/20261108-submit-nandsim-overridesize-bound-v1-v1-=
1-9cde7657a69b@gmail.com/
https://lore.kernel.org/r/20261108-submit-macronix-otp-errors-v1-v1-1-8f64a=
2ad5a10@gmail.com/
https://lore.kernel.org/r/20261108-submit-intel-nand-probe-disable-v1-v1-1-=
eb0471429e09@gmail.com/
https://lore.kernel.org/r/20261108-submit-au1550nd-resource-claim-v1-v1-1-8=
f4c694fdd39@gmail.com/

> The past 2 weeks, while I was off, you litteraly bombed me with not less
> than 379 patches.

I think it's around 129 posted Linux NAND/MTD patches if you exclude
stale revisions. About half of those are this one series however.

I agree it's a lot...but I didn't want to lose track of bugs so I figured i=
t
made sense to just send out fixes for issues as they were being
discovered most of the time, especially for small isolated issues.

I actually have more fixes locally that I held off on sending due to
being too dependent on the fixes I sent.

> Please, stop.

So what should I do when I find a bug? Should I just ignore it?
What should I be doing instead?

It's often difficult to fix specific driver issues when generic
subsystem code has too many correctness bugs with potential
implications for the more specific driver issues, a large amount
of correctness issues seem to be in error handling logic that
manual testing can easily miss.

>
> Thanks,
> Miqu=C3=A8l
>
> On 15/11/2026 at 23:29:15 -07, James Hilliard <james.hilliard1@gmail.com>=
 wrote:
>
> > An MTD handle can outlive controller unbind. Its metadata and NAND lock=
s
> > must remain valid, including when a writable file closes and calls sync=
,
> > while further hardware access must be rejected after disconnection.
> >
> > This builds on earlier MTD removal-lifetime work. Commit 19bfa9ebebb5
> > ("mtd: use refcount to prevent corruption") added MTD reference countin=
g
> > [0], but retaining an MTD reference does not by itself retain the
> > driver-owned allocation containing the master. The read/unbind discussi=
on
> > also covered raw NAND [1] and draining active operations [2]. Tze Yee N=
g's
> > SPI-NOR series addresses the corresponding SPI-NOR paths [3].
> >
> > Following Greg's review [7], separate class-device data from the MTD
> > backing allocation. Delete the device's interfaces and drain NVMEM and
> > class PM callbacks before releasing backing data. Bare device reference=
s
> > retain an independently allocated device, whose type, PM dispatch and
> > final release are built in even when MTD is modular. NVMEM similarly
> > disconnects and drains provider and layout callbacks before unregister
> > returns; retained consumers keep core-owned metadata and receive -ENODE=
V
> > on subsequent access.
> >
> > Introduce opt-in backing-object ownership for MTD masters. Registered
> > nodes and acquired MTD handles retain the chip, while nested partitions
> > also retain their parent metadata. Unregister first so removal notifier=
s
> > can finish I/O, then disconnect raw NAND and drain admitted operations.
> > Hardware resources can be released without waiting for open files to cl=
ose.
> >
> > Virtual concatenations serialize publication and removal across physica=
l
> > controllers. Disconnect and drain a published concatenation before any
> > component can disappear, then release its component references. An old
> > handle keeps the disconnected virtual device, independently of a later
> > replacement.
> >
> > Run NAND and controller-specific cleanup during disconnection, while
> > the controller driver is still bound. Snapshot the OOB layout in core-o=
wned
> > data before publication so metadata queries remain valid without driver
> > callbacks. The NAND core frees retained chip and controller allocations=
;
> > the final MTD put never calls back into the controller module. Ordinary
> > MTD and NVMEM handles retain the NAND core that implements their
> > operations, rather than the hardware driver.
> >
> > Share allocation ownership across the raw-NAND drivers, including
> > partially published probes. Shared controllers remain allocated until
> > their last retained chip is released. R852 allocates a new chip for eac=
h
> > card, and NDFC allocates controller state per binding.
> >
> > Based on NAND next at 30daaf3e7897, with Tze Yee Ng's module-reference
> > ordering fix [4], Karl Mehltretter's OTP cleanup fix [6], and the separ=
ately
> > posted registration, operation-locking and controller probe/teardown fi=
xes
> > identified by the prerequisite metadata. TLA+ models and their assumpti=
ons
> > and coverage limits are available in [5].
> >
> > [0] https://lore.kernel.org/r/20230620131905.648089-2-alexander.usyskin=
@intel.com
> > [1] https://lore.kernel.org/r/CAND4H7dz94Gsi_tXSQmLNme9uROnouOUwuCX9BW_=
+RCc2ZFDqA@mail.gmail.com
> > [2] https://lore.kernel.org/r/mafs0bjs73tbq.fsf@kernel.org
> > [3] https://lore.kernel.org/r/20261022035352.52129-1-tze.yee.ng@altera.=
com
> > [4] https://lore.kernel.org/r/20261022035352.52129-2-tze.yee.ng@altera.=
com
> > [5] https://github.com/jameshilliard/linux-h616-nand-tla
> > [6] https://lore.kernel.org/r/20260816163027.10044-1-kmehltretter@gmail=
.com
> > [7] https://lore.kernel.org/r/2026111037-stir-hermit-cb21@gregkh
> >
> > Assisted-by: Codex:gpt-6-astra
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> > Changes in v5:
> > - Use logical MTD registration state during unregister and failed
> >   registration cleanup, independently of retained class devices.
> > - Pass the master to provider get hooks, matching the put hooks.
> > - Preserve sibling partitions when a child is removed during parsing,
> >   and limit subpartition rollback to its parent.
> > - Add the introducing Fixes tag for the Technologic node ownership
> >   correction and collect Wolfram's Renesas Acked-by.
> > - Link to v4: https://patch.msgid.link/20261113-submit-rawnand-retained=
-handle-lifetime-v1-v4-0-556b1d7c6221@gmail.com
> >
> > Changes in v4:
> > - Keep MTD subdirectories behind CONFIG_MTD so boolean child options
> >   do not become built-in users of a modular MTD core.
> > - Serialize partition publication with deletion and retain a handle
> >   while parsing subpartitions. Reject children of removed partitions.
> > - Distinguish explicit NULL NVMEM owners from the parent-module
> >   fallback, including OTP providers backed by built-in NAND code.
> > - Register layout-owned cells explicitly, preserving provider cells
> >   added before or after a layout binds.
> > - Rebuild cell attributes across layout bind/unbind, free partial
> >   allocations on failure and remove attributes before device deletion.
> > - Pair NVMEM_REMOVE notifications only with successful NVMEM_ADD
> >   notifications and remove the redundant disconnected-device check.
> > - Resolve concatenation OOB layouts through the first component's
> >   master, including partition-backed components.
> > - Link to v3: https://patch.msgid.link/20261111-submit-rawnand-retained=
-handle-lifetime-v1-v3-0-ce537999741d@gmail.com
> >
> > Changes in v3:
> > - Finish NAND and driver cleanup during disconnection, leaving final
> >   allocation release in the NAND core, following Greg's networking exam=
ple.
> > - Snapshot OOB layouts before publication and drain complete BBM/BBT
> >   updates before releasing their working state.
> > - Separate MTD class-device allocation and final release from backing-o=
bject
> >   ownership, following Greg's review.
> > - Drain class PM callbacks under the device lock before detaching backi=
ng
> >   data; keep device-type and PM dispatch storage with the built-in devi=
ce.
> > - Drain NVMEM provider and layout callbacks during unregister, retainin=
g
> >   core-owned metadata for old consumers and retiring cells across rebin=
d.
> > - Keep NVMEM consumer-owner references, with converted raw NAND
> >   providers naming the NAND core instead of the controller module.
> >   Release write-protect GPIOs once provider callbacks are drained.
> > - Acquire an MTD handle for PTP OCP firmware updates through a class de=
vice.
> > - Drain concatenation operations before releasing components, including
> >   concurrent removal of masters without opt-in lifetime ownership.
> > - Use scoped cleanup consistently in Tegra probe and add the introducin=
g
> >   commits for Socrates and FSL UPM, following Sashiko's review.
> > - Link to v2: https://patch.msgid.link/20261110-submit-rawnand-retained=
-handle-lifetime-v1-v2-0-9137d08f05df@gmail.com
> >
> > Changes in v2:
> > - Keep the MTD device callback owner pinned through callback return,
> >   with the final module put performed by the device core.
> > - Retain virtual-concat components across removal and rebind, serialize
> >   staging/publication and unwind incomplete partition registrations.
> > - Balance Tegra's probe-time child-node reference separately from the
> >   reference retained for the chip lifetime.
> > - Refresh the prerequisite stack to the separately posted fixes, using
> >   the latest QCOM child-probe revision.
> > - Keep the lifetime changes on top of those fixes: preserve QCOM scan
> >   before publication, R852 per-card initialization and Intel probe
> >   hardware shutdown.
> > - Fold Macronix disconnection handling into the NAND disconnect patch;
> >   its operation locking is supplied by the posted prerequisite.
> > - Use Karl Mehltretter's posted OTP cleanup fix as a prerequisite in
> >   place of the duplicate preparatory patch.
> > - Keep the NVMEM context callback module pinned until its final callbac=
k
> >   returns, independently of the provider's consumer owner.
> > - Use the posted fixes for dynamic partition publication and partition-=
node
> >   ownership. Keep master get/put accounting independent of
> >   later master registration in the MTD ownership patch.
> > - Propagate disconnection through BBT error recovery without marking
> >   the eraseblock bad.
> > - Make suspend of a disconnected, retained NAND device a no-op.
> > - Handle R852 card events during removal while preventing new work from
> >   being queued.
> > - Initialize Denali and Atmel cleanup variables at allocation and add
> >   the introducing-commit trailers for Orion and MPC5121.
> > - Link to v1: https://patch.msgid.link/20261107-submit-rawnand-retained=
-handle-lifetime-v1-v1-0-0181ef0cc4c8@gmail.com
> >
> > To: Miquel Raynal <miquel.raynal@bootlin.com>
> > To: Richard Weinberger <richard@nod.at>
> > To: Vignesh Raghavendra <vigneshr@ti.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-mtd@lists.infradead.org
> >
> > ---
> > James Hilliard (58):
> >       nvmem: disconnect provider callbacks before unregister returns
> >       mtd: acquire an MTD handle from a referenced class device
> >       mtd: separate class devices from retained backing objects
> >       mtd: retain virtual concatenations across component removal
> >       mtd: rawnand: separate hardware disconnection from cleanup
> >       mtd: rawnand: share retained chip and controller ownership
> >       mtd: rawnand: sunxi: retain chip state until the final MTD put
> >       mtd: rawnand: plat_nand: retain open-handle state on removal
> >       mtd: rawnand: gpio: retain open-handle state on removal
> >       mtd: rawnand: stm32_fmc2: retain open-handle state on removal
> >       mtd: rawnand: denali: retain chips across controller removal
> >       mtd: rawnand: arasan: retain chips across controller removal
> >       mtd: rawnand: mxic: retain open-handle state on removal
> >       mtd: rawnand: intel: retain open-handle state on removal
> >       mtd: rawnand: tegra: retain open-handle state on removal
> >       mtd: rawnand: mtk: retain chips across controller removal
> >       mtd: rawnand: rockchip: retain chips across controller removal
> >       mtd: rawnand: atmel: retain chips across controller removal
> >       mtd: rawnand: orion: retain open-handle state on removal
> >       mtd: rawnand: socrates: retain open-handle state on removal
> >       mtd: rawnand: fsl_upm: retain open-handle state on removal
> >       mtd: rawnand: pasemi: retain open-handle state on removal
> >       mtd: rawnand: ams-delta: retain open-handle state on removal
> >       mtd: rawnand: xway: retain open-handle state on removal
> >       mtd: rawnand: hisi504: retain open-handle state on removal
> >       mtd: rawnand: vf610: retain open-handle state on removal
> >       mtd: rawnand: technologic: retain open-handle state on removal
> >       mtd: rawnand: loongson: retain open-handle state on removal
> >       mtd: rawnand: ma35d1: retain open-handle state on removal
> >       mtd: rawnand: pl35x: retain open-handle state on removal
> >       mtd: rawnand: mxc: retain open-handle state on removal
> >       mtd: rawnand: fsmc: retain open-handle state on removal
> >       mtd: rawnand: gpmi: retain open-handle state on removal
> >       mtd: rawnand: omap2: retain open-handle state on removal
> >       mtd: rawnand: marvell: retain open-handle state on removal
> >       mtd: rawnand: renesas: retain open-handle state on removal
> >       mtd: rawnand: meson: retain open-handle state on removal
> >       mtd: rawnand: cadence: retain open-handle state on removal
> >       mtd: rawnand: qcom: retain open-handle state on removal
> >       mtd: rawnand: cafe: retain open-handle state on removal
> >       mtd: rawnand: brcmnand: retain open-handle state on removal
> >       mtd: rawnand: au1550nd: retain chip state across removal
> >       mtd: rawnand: sharpsl: retain chip state across removal
> >       mtd: rawnand: davinci: retain chip state across removal
> >       mtd: rawnand: sh_flctl: retain chip state across removal
> >       mtd: rawnand: lpc32xx_slc: retain chip state across removal
> >       mtd: rawnand: lpc32xx_mlc: retain chip state across removal
> >       mtd: rawnand: ndfc: retain chip state across removal
> >       mtd: rawnand: txx9ndfmc: retain chip state across removal
> >       mtd: rawnand: ingenic: retain chip state across removal
> >       mtd: rawnand: mpc5121: retain chip state across removal
> >       mtd: rawnand: bcm47xxnflash: retain chip state across removal
> >       mtd: rawnand: fsl_elbc: retain chip state across removal
> >       mtd: rawnand: fsl_ifc: retain chip state across removal
> >       mtd: rawnand: r852: retain chip state across removal
> >       mtd: rawnand: nandsim: retain chip state across removal
> >       mtd: rawnand: cs553x: retain chip state across removal
> >       mtd: rawnand: diskonchip: retain chip state across removal
> >
> >  drivers/Makefile                                   |   2 +-
> >  drivers/media/pci/cobalt/cobalt-flash.c            |   2 +-
> >  drivers/mtd/Kconfig                                |   5 +
> >  drivers/mtd/Makefile                               |   5 +-
> >  drivers/mtd/devices/bcm47xxsflash.c                |   2 +-
> >  drivers/mtd/devices/docg3.c                        |   4 +-
> >  drivers/mtd/devices/mchp23k256.c                   |   2 +-
> >  drivers/mtd/devices/mchp48l640.c                   |   2 +-
> >  drivers/mtd/devices/mtd_dataflash.c                |   2 +-
> >  drivers/mtd/devices/mtd_intel_dg.c                 |  30 +-
> >  drivers/mtd/devices/powernv_flash.c                |   4 +-
> >  drivers/mtd/devices/spear_smi.c                    |   2 +-
> >  drivers/mtd/devices/sst25l.c                       |   2 +-
> >  drivers/mtd/devices/st_spi_fsm.c                   |   8 +-
> >  drivers/mtd/hyperbus/hyperbus-core.c               |   2 +-
> >  drivers/mtd/lpddr/lpddr2_nvm.c                     |   2 +-
> >  drivers/mtd/maps/lantiq-flash.c                    |   2 +-
> >  drivers/mtd/maps/physmap-core.c                    |   2 +-
> >  drivers/mtd/maps/plat-ram.c                        |   2 +-
> >  drivers/mtd/maps/pxa2xx-flash.c                    |   2 +-
> >  drivers/mtd/maps/sa1100-flash.c                    |   2 +-
> >  drivers/mtd/maps/vmu-flash.c                       |   2 +-
> >  drivers/mtd/mtd_blkdevs.c                          |   2 +-
> >  drivers/mtd/mtd_virt_concat.c                      | 526 +++++++++++--=
--------
> >  drivers/mtd/mtdconcat.c                            | 103 +++-
> >  drivers/mtd/mtdcore.c                              | 308 +++++++-----
> >  drivers/mtd/mtdcore.h                              |   5 +
> >  drivers/mtd/mtddevice.c                            |  59 +++
> >  drivers/mtd/mtddevice.h                            |  12 +
> >  drivers/mtd/mtdpart.c                              |  68 ++-
> >  drivers/mtd/mtdpstore.c                            |  50 +-
> >  drivers/mtd/nand/ecc.c                             |   3 +-
> >  drivers/mtd/nand/onenand/generic.c                 |   2 +-
> >  drivers/mtd/nand/onenand/onenand_omap2.c           |   2 +-
> >  drivers/mtd/nand/onenand/onenand_samsung.c         |   2 +-
> >  drivers/mtd/nand/raw/Makefile                      |   1 +
> >  drivers/mtd/nand/raw/ams-delta.c                   |  28 +-
> >  drivers/mtd/nand/raw/arasan-nand-controller.c      |  49 +-
> >  drivers/mtd/nand/raw/atmel/nand-controller.c       |  44 +-
> >  drivers/mtd/nand/raw/au1550nd.c                    |  23 +-
> >  drivers/mtd/nand/raw/bcm47xxnflash/main.c          |  18 +-
> >  drivers/mtd/nand/raw/brcmnand/brcmnand.c           |  65 ++-
> >  drivers/mtd/nand/raw/cadence-nand-controller.c     |  51 +-
> >  drivers/mtd/nand/raw/cafe_nand.c                   |  27 +-
> >  drivers/mtd/nand/raw/cs553x_nand.c                 |  44 +-
> >  drivers/mtd/nand/raw/davinci_nand.c                |  26 +-
> >  drivers/mtd/nand/raw/denali.c                      |  28 +-
> >  drivers/mtd/nand/raw/denali_dt.c                   |  13 +-
> >  drivers/mtd/nand/raw/denali_pci.c                  |   9 +-
> >  drivers/mtd/nand/raw/diskonchip.c                  |  17 +-
> >  drivers/mtd/nand/raw/fsl_elbc_nand.c               |  56 ++-
> >  drivers/mtd/nand/raw/fsl_ifc_nand.c                |  48 +-
> >  drivers/mtd/nand/raw/fsl_upm.c                     |  20 +-
> >  drivers/mtd/nand/raw/fsmc_nand.c                   |  19 +-
> >  drivers/mtd/nand/raw/gpio.c                        |  18 +-
> >  drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c         |  19 +-
> >  drivers/mtd/nand/raw/hisi504_nand.c                |  20 +-
> >  drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c    |  41 +-
> >  drivers/mtd/nand/raw/intel-nand-controller.c       |  20 +-
> >  drivers/mtd/nand/raw/internals.h                   |   2 +-
> >  drivers/mtd/nand/raw/loongson-nand-controller.c    |  21 +-
> >  drivers/mtd/nand/raw/lpc32xx_mlc.c                 |  38 +-
> >  drivers/mtd/nand/raw/lpc32xx_slc.c                 |  40 +-
> >  drivers/mtd/nand/raw/marvell_nand.c                |  46 +-
> >  drivers/mtd/nand/raw/meson_nand.c                  |  49 +-
> >  drivers/mtd/nand/raw/mpc5121_nfc.c                 |  26 +-
> >  drivers/mtd/nand/raw/mtk_nand.c                    |  40 +-
> >  drivers/mtd/nand/raw/mxc_nand.c                    |  23 +-
> >  drivers/mtd/nand/raw/mxic_nand.c                   |  23 +-
> >  drivers/mtd/nand/raw/nand_base.c                   | 103 +++-
> >  drivers/mtd/nand/raw/nand_bbt.c                    |  24 +-
> >  drivers/mtd/nand/raw/nand_lifetime.c               | 246 ++++++++++
> >  drivers/mtd/nand/raw/nand_macronix.c               |   8 +-
> >  drivers/mtd/nand/raw/nand_onfi.c                   |   4 +-
> >  drivers/mtd/nand/raw/nandsim.c                     |  21 +-
> >  drivers/mtd/nand/raw/ndfc.c                        |  34 +-
> >  .../mtd/nand/raw/nuvoton-ma35d1-nand-controller.c  |  42 +-
> >  drivers/mtd/nand/raw/omap2.c                       |  27 +-
> >  drivers/mtd/nand/raw/orion_nand.c                  |  24 +-
> >  drivers/mtd/nand/raw/pasemi_nand.c                 |  22 +-
> >  drivers/mtd/nand/raw/pl35x-nand-controller.c       |  38 +-
> >  drivers/mtd/nand/raw/plat_nand.c                   |  20 +-
> >  drivers/mtd/nand/raw/qcom_nandc.c                  |  39 +-
> >  drivers/mtd/nand/raw/r852.c                        | 111 +++--
> >  drivers/mtd/nand/raw/r852.h                        |   1 +
> >  drivers/mtd/nand/raw/renesas-nand-controller.c     |  37 +-
> >  drivers/mtd/nand/raw/rockchip-nand-controller.c    |  45 +-
> >  drivers/mtd/nand/raw/sh_flctl.c                    |  22 +-
> >  drivers/mtd/nand/raw/sharpsl.c                     |  22 +-
> >  drivers/mtd/nand/raw/sm_common.c                   |  15 +-
> >  drivers/mtd/nand/raw/sm_common.h                   |   2 +-
> >  drivers/mtd/nand/raw/socrates_nand.c               |  19 +-
> >  drivers/mtd/nand/raw/stm32_fmc2_nand.c             |  19 +-
> >  drivers/mtd/nand/raw/sunxi_nand.c                  |  46 +-
> >  drivers/mtd/nand/raw/technologic-nand-controller.c |  22 +-
> >  drivers/mtd/nand/raw/tegra_nand.c                  |  27 +-
> >  drivers/mtd/nand/raw/txx9ndfmc.c                   |  41 +-
> >  drivers/mtd/nand/raw/vf610_nfc.c                   |  20 +-
> >  drivers/mtd/nand/raw/xway_nand.c                   |  24 +-
> >  drivers/mtd/nand/spi/core.c                        |   2 +-
> >  drivers/mtd/nand/spi/esmt.c                        |   2 +-
> >  drivers/mtd/nand/spi/micron.c                      |   4 +-
> >  drivers/mtd/nand/spi/otp.c                         |   2 +-
> >  drivers/mtd/spi-nor/core.c                         |   2 +-
> >  drivers/mtd/ubi/build.c                            |   2 +-
> >  drivers/nvmem/Kconfig                              |   1 +
> >  drivers/nvmem/core.c                               | 463 ++++++++++++-=
-----
> >  drivers/nvmem/internals.h                          |  16 +-
> >  drivers/nvmem/layouts.c                            |   2 +
> >  drivers/nvmem/layouts/fixed-layout.c               |   2 +-
> >  drivers/nvmem/layouts/onie-tlv.c                   |  20 +-
> >  drivers/nvmem/layouts/sl28vpd.c                    |   3 +-
> >  drivers/nvmem/layouts/u-boot-env.c                 |  25 +-
> >  drivers/ptp/ptp_ocp.c                              |   7 +-
> >  include/linux/mtd/concat.h                         |  22 +-
> >  include/linux/mtd/mtd.h                            |  21 +-
> >  include/linux/mtd/rawnand.h                        |  37 +-
> >  include/linux/nvmem-provider.h                     |  16 +-
> >  118 files changed, 2751 insertions(+), 1265 deletions(-)
> > ---
> > base-commit: 30daaf3e7897b4a8d9b72e5b0c86dd6e2a4d7d85
> > base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git =
nand/next
> > change-id: 20261104-submit-rawnand-retained-handle-lifetime-v1-0b4225e5=
ce0b
> > prerequisite-patch-id: a51b9cb4077105499133c413d58c7ad21d973b38
> > prerequisite-patch-id: b3679cda4dcb45ce7712bffe2dd0576b254df44d
> > prerequisite-patch-id: 07b5c70e44ad951d20eea9478c98fda35ec765c0
> > prerequisite-patch-id: abea50275922fe359d72ca4de5cbc211b04bbd57
> > prerequisite-patch-id: 57776b214ffb0331319f024412f21d35e4ca9056
> > prerequisite-patch-id: 09be2baaffe1f053704263cc4b0d39f2faa4f49c
> > prerequisite-patch-id: c3ad85600dc897ac310be450d8daa2275fb91ee6
> > prerequisite-patch-id: 4a85600553ddcc7db5a9537efd905a71cd623f65
> > prerequisite-patch-id: 579990ee4a49297efc5a593b00efb9cd73fa15e8
> > prerequisite-patch-id: 2ee61a8a32fd147d52e0f9d03758634912d8bfef
> > prerequisite-patch-id: 1487df8ce8e6c48471fd77c7470ce9de582dfe3c
> > prerequisite-patch-id: 5ecbe86f928d9c5c0bf2cb6065c5672708511fc4
> > prerequisite-patch-id: ac68e9b65d3aa5661bd7ac0f2e77dcf5c75fcfe0
> > prerequisite-patch-id: e70f0f0c4d430d416a3ad848b37ffad16bd7df07
> > prerequisite-patch-id: 05adcddbc50f745ee2640b8c21f3bf76a217f249
> > prerequisite-patch-id: 0b60b7ab6196076f327c919be5e7b8bb2051ee12
> >
> > Best regards,
