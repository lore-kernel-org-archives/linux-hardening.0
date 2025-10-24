Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A27B2DC352
	for <linux-hardening@vger.kernel.org>; Fri, 24 Oct 2025 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317455; cv=none; b=Z0IQFh6qBsMk+qwGSSwUrpjvStn1BvNOJy9tHFxQ3yCs18gf13n1QxrskEYdk62b9Ni+95V2U7udwm4600ECan/GceSZsNJWH18YGg9TErxd6/5W0djQ6AoJPlvrSTpsMDqX0SlKDbIjf/29Ie3/Uyj3999lduorPp7vEseNvAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317455; c=relaxed/simple;
	bh=ok+empPvfggiJJNrLD8vlCVS1DsP9wi2/cAjY5qk/vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKGmhewpNXc1y5kRrmkgtZWMW/fB90CAO6FLU/6nPUsV76xyez2K2qYnLLPv1pfFHQBsd84t/pbm+ZA7MaDfhhZG7Cx34EuDo4rDSOww981bri3G6SyQVaqXRty7Ql2XCvZTmPOyuuUJukAc00xaxk6f5rR1WDc5nlsl1yKqnvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GBaCH1M+; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GBaCH1M+"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-780fe76f457so22764307b3.0
        for <linux-hardening@vger.kernel.org>; Fri, 24 Oct 2025 07:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761317452; x=1761922252; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vlc1RWG4oS332LgnO2Nr16isvBMLz89JUCyBivsWBUk=;
        b=GBaCH1M+2Frj7e/RnwSEl/kZcqzzPYt5mrjRg87vSXNm8YCLTGWd+Hp2X3Gxb3GXuM
         LeLjEyynBxpAS6qQZ4sDtTFAH6giqfAwhVRyaEP1+hoUOLwWm6f3XCk2dEhvESldsY9x
         L+Bxw8FV+oVX1URm1zEIq6PwHKq05k/5264ISjJo7OWnlYPMBZ7cbrG+9uUyqvzxNCsD
         PchDEvWFnAbY0UYi79nQtNYWKPn/qxylXeVAs/T9VBfQOGiESKVb/aoMkHAXbUaYd/7t
         uQAkZv1TexDWzMnSusR6jIvMzcOKs6Af1A/cYUpfjY9FhK/j7wGFGQNVRwdvtG1s5Eiy
         ednA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761317452; x=1761922252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vlc1RWG4oS332LgnO2Nr16isvBMLz89JUCyBivsWBUk=;
        b=nSV14XeSlnT1v1R+tfI8SpWH1MsooBXQfpGtTm0SWUu+DzEhsnK2879pdRkKQ95fX5
         wtOugFkeqfWMSdQ7GjLMHvdGarK/v20Adt+pXSKn21pEc1ciVgWnS6X2hqFAp5+UH2w7
         1daoMtRqgeCzsQ5YY2OpBUEyCjgzMMbXagG2dY0XyR6TjhaZFGIRkURK8+GUS0aTiRQn
         Ah+rZKhLRjAbgCt99S9P4cg0cla6IgTbDr3h3ZDV6tMtBhGBgXsHqCiFMqzlYK4e/oPC
         8hta5VP4CJg4qKHbTHA+zuY3AUSPGwvqWChzTJN/rtONb5i308Rse8XNwfLdmwIJ2MGk
         7y4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVRGRzkwK0RG7cAOAiMcu0tjlCmDIOuoZY8JnXQxwmGgT/hUC7ywvINQ0wT7GHW2THQ63VGWa+LX2VZYLS/0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSq5u4NsslwvzphTOQ4YkZN2iyCLmibzNWFDvyAKFTRYBGqA4H
	oSKtiV1ftWCFzZcObuoQm6wQIdSRbMV2w/4D1puwO2hbVvWEhaAqmUbWLWxPOHDYM7/cQSz+Et/
	QP4bx4jZN0d3MDc1BtKmUNCdux7ZbuFZZInoHzHIGBg==
X-Gm-Gg: ASbGnct/q9s+p7puBQX4mOIZYGd2dv5QmbRU9BeSBKyz7Z2cMZeKQGXa0IDrZt1j6+3
	d3yP6KEwvEY8hJvayTTxrv9GbmcptpVgzJQDK9f+PZeWNNu8HY3MqySmdpHn0U84+0AiId3piCI
	FqIF/Yc3XaM3kX/Lmp9bXffgO2c4oqv6e1CR7FC2PigvkZ1Aj68hzyVSRQrtEITTsUVsAikPNkD
	9e0SQzsvHBm4mH2anN5pPpN3XI6YyiEpt2Z20NhMp6KBhBTzQkXI1glacgMmKlFUEA2oGun
X-Google-Smtp-Source: AGHT+IHFv05LD9ky3ncqZ/uyFhBdaCG4aTVcjsQd1NuGsD6MZ7rOvSdiVTBEM3enKMrxVRZcNFJLLBzh7EZrpPgiQXI=
X-Received: by 2002:a05:690c:a0ad:10b0:785:bb26:1644 with SMTP id
 00721157ae682-785bb2619aamr162440697b3.21.1761317452252; Fri, 24 Oct 2025
 07:50:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017-mt8196-gpufreq-v8-0-98fc1cc566a1@collabora.com>
 <CAPDyKFodsAR5bOAST3mPLvSVbe653QS6SdSwHr6kyraQ1cwbhQ@mail.gmail.com> <76b35848-8f5e-49a2-ac4a-318945448b9a@arm.com>
In-Reply-To: <76b35848-8f5e-49a2-ac4a-318945448b9a@arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 24 Oct 2025 16:50:15 +0200
X-Gm-Features: AS18NWBNsLgu8W-2ocvk9kd1OZoR8WNmp4mWHWOY4wHYr_BHae8YuVzfiG3Jrzo
Message-ID: <CAPDyKFpkCivtsV1kuTOp_QG2Ci6HajBAAxQ=0GGoN6VAnaAJrg@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] MT8196 GPU Frequency/Power Control Support
To: Steven Price <steven.price@arm.com>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Oct 2025 at 15:09, Steven Price <steven.price@arm.com> wrote:
>
> On 22/10/2025 14:52, Ulf Hansson wrote:
> > On Fri, 17 Oct 2025 at 17:32, Nicolas Frattaroli
> > <nicolas.frattaroli@collabora.com> wrote:
> >>
> >> This series introduces two new drivers to accomplish controlling the
> >> frequency and power of the Mali GPU on MediaTek MT8196 SoCs.
> >>
> >> The reason why it's not as straightforward as with other SoCs is that
> >> the MT8196 has quite complex glue logic in order to squeeze the maximum
> >> amount of performance possible out of the silicon. There's an additional
> >> MCU running a specialised firmware, which communicates with the
> >> application processor through a mailbox and some reserved memory, and is
> >> in charge of controlling the regulators, the PLL clocks, and the power
> >> gating of the GPU, all while also being in charge of any DVFS control.
> >>
> >> This set of drivers is enough to communicate desired OPP index limits to
> >> the aforementioned MCU, referred to as "GPUEB" from here on out. The
> >> GPUEB is still free to lower the effective frequency if the GPU has no
> >> jobs going on at all, even when a higher OPP is set.
> >>
> >> The power- and frequency control driver, mtk-mfg-pmdomain, is now
> >> implemented as a power domain driver, with a set_performance_state
> >> operation. It also exposes itself as a clock provider, so that panthor
> >> can read the actual achieved DVFS clock rate as per the GPUEB firmware.
> >>
> >> This power domain approach means that panthor does not need to know
> >> about how the frequency control works on this SoC, as the OPP core
> >> framework already takes care of it. The only exception is that panthor
> >> needs to not register OPPs from DT itself if there already is an OPP
> >> table present.
> >>
> >> The mailbox driver is a fairly bog-standard common mailbox framework
> >> driver, just specific to the firmware that runs on the GPUEB. It was
> >> merged in v6.18 already.
> >>
> >> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> >
> > This looks good to me!
> >
> > I can certainly pick up patch2 and patch5, but before I go ahead I
> > just wanted to check what is the preferred merging strategy?
> >
> > The drm/gpu patches can go independently from the pmdomain patches
> > others, right? In either case, I can pick this complete series too via
> > my pmdomain tree, if that makes sense for everyone. Please let me
> > know.
>
> I'm about to go on holiday, so I'm not about to merge and run ;)
> But I'm happy if you want to take the complete series through your tree.

Unfortunately the panthor specific changes didn't apply cleanly on my
side. Looks like you have some patches queued already for the panther
driver and I guess Nicolas may have based the changes on top of them.

That said, I decided to pick the pmdomain patches, patch 2 and patch 5, thanks!

Kind regards
Uffe


>
> Thanks,
> Steve
>
> > Kind regards
> > Uffe
> >
> >> ---
> >> Changes in v8:
> >> - mtk-mfg-pmdomain: remove unused shmem variable that caused a warning
> >>   on GCC, but not clang
> >> - Link to v7: https://lore.kernel.org/r/20251015-mt8196-gpufreq-v7-0-0a6435da2080@collabora.com
> >>
> >> Changes in v7:
> >> - panthor: rename "t" to "table"
> >> - panthor: add code comment explaining why an existing OPP table is
> >>   being checked for
> >> - mtk-mfg-pmdomain: use GF_REG_MAGIC offset for sake of consistency
> >> - mtk-mfg-pmdomain: remove redundant semicolon after mtk_mfg_mt8196_init
> >> - mtk-mfg-pmdomain: fix resource leaks on probe failure
> >> - mtk-mfg-pmdomain: enable/disable EB clock during MT8196 init, which is
> >>   needed for the register read
> >> - Rebase onto next-20251014, which drops already merged patches, namely
> >>   mailbox driver+bindings, and drops the ASN_HASH patch series
> >>   dependency, which was also merged
> >> - Link to v6: https://lore.kernel.org/r/20251003-mt8196-gpufreq-v6-0-76498ad61d9e@collabora.com
> >>
> >> Changes in v6:
> >> - mailbox: move buf definition into if condition, as per Chia-I Wu
> >> - panthor: remove the redundant NULL checks in panthor_devfreq_get_freq
> >> - mtk-mfg-pmdomain: adjust return style consistency
> >> - mtk-mfg-pmdomain: add docstring for mtk_mfg_send_ipi to explain it's
> >>   blocking
> >> - mtk-mfg-pmdomain: use CMD_FIX_DUAL_TARGET_OPPIDX instead of
> >>   CMD_FIX_TARGET_OPPIDX.
> >> - mtk-mfg-pmdomain: reword code comments to not be in the "we" style
> >> - mtk-mfg-pmdomain: shuffle around mbox allocations as per Angelo
> >> - mtk-mfg-pmdomain: don't pointlessly turn on EB clock in probe,
> >>   reducing the need for a comment explaining the bookkeeping
> >> - mtk-mfg-pmdomain: consistently use dev_err_probe and Capitalise first
> >>   letter of error string
> >> - mtk-mfg-pmdomain: get rid of redundant ret = dev_err_probe assignment
> >> - mtk-mfg-pmdomain: reintroduce stack OPP table, choose min(gpu, stack)
> >>   when adding frequencies. Fixes gaps in OPP levels where only stack
> >>   changed, but gpu had duplicates, which resulted in choosing a too slow
> >>   OPP
> >> - mtk-mfg-pmdomain: stub round_rate clk op to opt out of CCF always
> >>   "rounding" a devfreq rate request to the current rate
> >> - Link to v5: https://lore.kernel.org/r/20250929-mt8196-gpufreq-v5-0-3056e5ecf765@collabora.com
> >>
> >> Changes in v5:
> >> - mtk-mfg-pmdomain binding: add memory-regions property, remove shmem
> >>   property, as we now correctly describe the shared memory as a regular
> >>   memory region
> >> - mtk-mfg-pmdomain binding: get rid of redundant |
> >> - drop "dt-bindings: sram: Add compatible for
> >>   mediatek,mt8196-gpufreq-sram" as part of the move to reserved memory
> >> - mtk-mfg-pmdomain: move to using reserved-memory for GPUEB shared
> >>   memory
> >> - mtk-mfg-pmdomain: demote some types to smaller sizes in struct
> >>   mtk_mfg, as per Angelo's suggestions
> >> - mtk-mfg-pmdomain: use units.h for Hz-to-KHz
> >> - mtk-mfg-pmdomain: change for loop in attach_dev to reduce indentation
> >> - mtk-mfg-pmdomain: simplify return in mtk_mfg_power_off
> >> - mtk-mfg-pmdomain: move of_device_id after probe
> >> - mtk_mfg_pmdomain: map mmio by index
> >> - mtk_mfg_pmdomain: add error checking to pm_genpd_init()
> >> - mtk_mfg_pmdomain: add remove function
> >> - mtk_mfg_pmdomain: remove last_opp member and logic, since OPP core
> >>   already does that for us
> >> - mtk_mfg_pmdomain: adjust comment in mtk_mfg_set_performance to explain
> >>   why we're doing what we're doing
> >> - mtk_mfg_pmdomain: call mtk_mfg_set_oppidx in mtk_mfg_power_on with
> >>   the performance_state we deferred setting while it was powered off
> >> - mtk_mfg_pmdomain: add inline function for PWR_ACK checking, as it's
> >>   now used twice with the added remove function
> >> - mtk-mfg-pmdomain: add suppress_bind_attrs so people don't play with
> >>   that
> >> - mtk-mfg-pmdomain: change KConfig from tristate to bool, as module
> >>   unloading results in strange likely firmware-induced hardware state
> >>   woes in the mali GPU
> >> - mtk-mfg-pmdomain: read IPI magic in power_on, don't zero it after
> >>   confirming that seemingly had no purpose
> >> - mtk-mfg-pmdomain: misc style changes
> >> - Link to v4: https://lore.kernel.org/r/20250923-mt8196-gpufreq-v4-0-6cd63ade73d6@collabora.com
> >>
> >> Changes in v4:
> >> - rebase onto next-20250922, which includes Laura Nao's clock patches
> >> - refactor mediatek_mfg into a pmdomain driver called "mtk-mfg-pmdomain"
> >> - move mt8196-gpufreq binding to the power subdirectory
> >> - mali-valhall-csf binding: adjust for power-domains usage
> >> - mali-valhall-csf binding: use clocks on mt8196
> >> - mailbox: prefix defines with "GPUEB_"
> >> - mailbox: get rid of custom of_xlate
> >> - mailbox: rename "CLOGGED" to "BLOCKED"
> >> - mailbox: adjust send_data comment to include more technical info
> >> - mailbox: misc style improvements
> >> - panthor: drop "drm/panthor: devfreq: make get_dev_status use
> >>   get_cur_freq", as it is now not necessary and makes the code worse
> >> - panthor: drop "drm/panthor: devfreq: add pluggable devfreq providers"
> >> - panthor: drop "drm/panthor: add no_clocks soc_data member for MT8196",
> >>   as we now have clocks courtesy of gpufreq
> >> - panthor: check for existing opp table before registering a new one
> >> - mtk-mfg-pmdomain: add turbo_below variant data, which marks OPPs below
> >>   a certain index as turbo for the OPP subsystem
> >> - mtk-mfg-pmdomain: no longer read stack OPPs, as they weren't used
> >> - mtk-mfg-pmdomain: get rid of num gpu opp != num stack opp check.
> >>   That's the firmware's problem should it ever happen, not ours
> >> - mtk-mfg-pmdomain: some small name and whitespace changes on the defines
> >> - Link to v3: https://lore.kernel.org/r/20250917-mt8196-gpufreq-v3-0-c4ede4b4399e@collabora.com
> >>
> >> Changes in v3:
> >> - mali-valhall-csf binding: get rid of clocks for MT8196, rebase onto
> >>   Chia-I Wu's patch
> >> - mt8196-gpufreq binding: rename hw_revision to hw-revision
> >> - mt8196-gpufreq binding: rename clocks
> >> - mt8196-gpufreq binding: drop pointless label in example
> >> - mailbox binding: drop pointless label in example
> >> - mailbox: whitespace changes on defines
> >> - mailbox: remove rx_buf member from channel struct, use stack buffer
> >> - mailbox: check in probe that no rx_len exceeds MBOX_MAX_RX_SIZE
> >> - panthor: add no_clocks SoC data patch, also rebase onto Chia-I Wu's
> >>   series
> >> - panthor: refactor devfreq provider functionality to do allocation and
> >>   initialisation of panthor_devfreq struct in panthor in all cases
> >> - panthor: drop the patch that moves struct panthor_devfreq to a header
> >>   file, as it no longer needs to be exposed to devfreq providers
> >> - mediatek_mfg: refactor devfreq provider functionality to decouple it
> >>   more from panthor itself
> >> - mediatek_mfg: move SRAM magic to a #define
> >> - mediatek_mfg: begrudgingly rename member "padding_lol" to "reserved"
> >> - mediatek_mfg: use local struct device pointer var in more places
> >> - mediatek_mfg: change wording of sleep command failure error message,
> >>   but keep the format specifier because I don't want to throw bare
> >>   errnos at users
> >> - mediatek_mfg: remove unnecessary braces around dev_err EB power off
> >>   timeout message
> >> - mediatek_mfg: allocate rx_data for channels that expect a response
> >> - mediatek_mfg: memcpy the rx buffer from the common mailbox framework
> >>   in the rx callback to rx_data, as mssg now points to stack memory
> >> - mediatek_mfg: make SRAM clearing message dev_dbg
> >> - mediatek_mfg: no longer print physical address of SRAM
> >> - mediatek_mfg: expand on the GF_REG_OPP_TABLE_STK comment, toning down
> >>   its defeatist attitude in the process
> >> - mediatek_mfg: style fixes in mtk_mfg_get_closest_opp_idx
> >> - mediatek_mfg: rename clocks and hw-revision reg as per binding
> >> - Link to v2: https://lore.kernel.org/r/20250912-mt8196-gpufreq-v2-0-779a8a3729d9@collabora.com
> >>
> >> Changes in v2:
> >> - mali-valhall-csf binding: move from performance-controller to
> >>   performance-domains property
> >> - mali-valhall-csf binding: fix vendor name oopsie in compatible of if
> >>   condition
> >> - mt8196-gpufreq binding: move from performance-controller to
> >>   performance-domains by adding the cells property
> >> - mt8196-gpufreq binding: rename e2_id to hw_revision
> >> - mt8196-gpufreq binding: add description that mentions "MediaTek
> >>   Flexible Graphics"
> >> - mt8196-gpufreq binding: get rid of mailbox channels we're unlikely to
> >>   use any time soon, if ever
> >> - mt8196-gpufreq binding: change name of mailbox channels to use -
> >>   instead of _
> >> - mailbox binding: change reg-names to "data" and "ctl"
> >> - drm/panthor: mediatek_mfg: rename e2_id to hw_revision
> >> - drm/panthor: devfreq: switch from performance-controller to
> >>   performance-domains
> >> - drm/panthor: devfreq: get rid of the accidental get_cur_freq function
> >>   move
> >> - mailbox: rename mtk_gpueb_mbox_ch to mtk_gpueb_mbox_chan_desc
> >> - mailbox: use smaller types in mtk_gpueb_mbox_chan_desc where possible
> >> - mailbox: add per-channel runtime data struct
> >> - mailbox: request one threaded IRQ per channel, pass channel struct as
> >>   data
> >> - mailbox: make num_channels in variant struct u8
> >> - mailbox: get rid of no_response, as it was redundant
> >> - mailbox: enable and disable clock in mailbox startup/shutdown
> >> - mailbox: point con_priv of mailbox framework channel struct to this
> >>   driver's channel struct
> >> - mailbox: request and free the threaded IRQ in startup/shutdown
> >> - mailbox: only clear IRQ bit flag once RX data has been read from MMIO
> >> - mailbox: reduce needlessly large receive buffer size
> >> - mailbox: handle allocation errors wherever they could pop up
> >> - mailbox: style cleanups in mtk_gpueb_mbox_read_rx
> >> - mailbox: call platform_get_irq earlier on in probe
> >> - mailbox: set drvdata later on in probe
> >> - mailbox: ioremap resources by index, not name
> >> - mailbox: handle devm_mbox_controller_register errors
> >> - mailbox: rename channels to correspond to bindings
> >> - mailbox: document a few of the private driver structs to be kind to
> >>   the next person who will look at this code
> >> - Link to v1: https://lore.kernel.org/r/20250905-mt8196-gpufreq-v1-0-7b6c2d6be221@collabora.com
> >>
> >> ---
> >> Nicolas Frattaroli (5):
> >>       dt-bindings: gpu: mali-valhall-csf: add mediatek,mt8196-mali variant
> >>       dt-bindings: power: Add MT8196 GPU frequency control binding
> >>       drm/panthor: call into devfreq for current frequency
> >>       drm/panthor: Use existing OPP table if present
> >>       pmdomain: mediatek: Add support for MFlexGraphics
> >>
> >>  .../bindings/gpu/arm,mali-valhall-csf.yaml         |   37 +-
> >>  .../bindings/power/mediatek,mt8196-gpufreq.yaml    |  117 +++
> >>  drivers/gpu/drm/panthor/panthor_devfreq.c          |   62 +-
> >>  drivers/gpu/drm/panthor/panthor_devfreq.h          |    2 +
> >>  drivers/gpu/drm/panthor/panthor_device.h           |    3 -
> >>  drivers/gpu/drm/panthor/panthor_drv.c              |    4 +-
> >>  drivers/pmdomain/mediatek/Kconfig                  |   16 +
> >>  drivers/pmdomain/mediatek/Makefile                 |    1 +
> >>  drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c       | 1044 ++++++++++++++++++++
> >>  9 files changed, 1268 insertions(+), 18 deletions(-)
> >> ---
> >> base-commit: 3477f49ff0433a241da12ec9cecf6c9b2bd1c6f8
> >> change-id: 20250829-mt8196-gpufreq-a7645670d182
> >>
> >> Best regards,
> >> --
> >> Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> >>
>
