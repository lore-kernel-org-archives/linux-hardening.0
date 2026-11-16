Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844578;
	b=KoUkHE4hPCUtUyOweudpmB71A5eeMO9ahZx/stU5yYGTW2Bh+oFxyY3V3b7/TVjzF0fP
	 DAT3Dh+PRY0wweEjwpbzCDeTXJDmk+Suf01XVMl2lUmC4CJozV5PNkVz2sVaAC0/NzdKV
	 Hp6X40DzPUxvAMtzAolP7J+Ya9m7FiJNBPYKg/5rl4OE0slyVQ/wHAnwv3iatIiRTv328
	 Nte+F8XHOX6qKQGgwbnBtrE7AgX/7NY7LkpULhXEEpEa0pwqf8RuDiJV2Cg7QNDYfAets
	 rZ3KwSmccL2QgxOCodUClraWE510WSJatqOoyr+uCHCN++OjA5+dQilYv7BRHg/OhRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844578;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=LnSeRb4dN96wBhv6QjPTulpHgT7xgStRTwFnLWmVaVA=;
	b=pyVLUNLTs8sAmiplWhGOvr7VDQBQAgYsLiOIqJHEuPdUCzqsq/eKWH9OIMo/eEJOidL3
	 vQZNkfrag2qKFUaBRvj2j5IrbnrILVoZVB5TNW6qZLXBEQriQ7iPpUmePccnTVCwl5hue
	 3S/BL7NuSb+5a5pEfRNUr/p2u4oIWc6zbJWrQVYy/tH9i5ax0bQyHHpjxRTvR1rsGE+TO
	 skypsqMcJqTxTsmPiroMtmhmB97fk5Rr8LchId97Hcveu/AundaZyFOlfVKq+RrHFTsQr
	 d+3KFQSyjw3a2OeGWK9HQuSH+iHBdH6G1c8dAdXsXbC01GDEvcnkC7nglQMnlC5o8cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k1TPALyE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38DC606A322;
	Mon, 16 Nov 2026 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k1TPALyE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E491F000C4;
	Mon, 16 Nov 2026 15:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794844577;
	bh=LnSeRb4dN96wBhv6QjPTulpHgT7xgStRTwFnLWmVaVA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=k1TPALyEzGuGelskzZPMTDhNwa0mXOqc58ZHlyZE4oQ0ZM5EJquOYbdtrBcKo1dW0
	 GubBjMxi0pQxAEgamTiNkRPpHViVVBQSur2/ZQ5tP+jEmhqQrglbadj6Vfe3KGK0fc
	 Wper3e3fVo7kOJNoCFBYEt9ZQTn0Ev/C0ZxiEpQ7T6poCTp83gMsU+Dpa5WRhEZXhP
	 AQmraknEk5wW3+eEG6JqdtinEvAGRPGQodVJnIOfdazJsLTxM2GtTCdt96h51hrR+p
	 +GpKDVhPOUVE/PTuucFiWQn6WWkUCOeBBqPKrXKCZlPyg9B6hl0lOHmwFPEslor1sK
	 ucIgmRGENHK4w==
Message-ID: <336dc797-2406-4d81-b322-61b85ac52bdd@kernel.org>
Date: Mon, 16 Nov 2026 15:56:06 +0000
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/12] nvmem: Add Raspberry Pi OTP nvmem driver
To: Gregor Herburger <gregor.herburger@linutronix.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <wahrenst@gmx.net>, Srinivas Kandagatla <srini@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <20261110-rpi-otp-driver-v8-0-797e0577d414@linutronix.de>
From: Srinivas Kandagatla <srini@kernel.org>
Content-Language: en-US
In-Reply-To: <20261110-rpi-otp-driver-v8-0-797e0577d414@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/10/26 4:33 PM, Gregor Herburger wrote:
> Hi,
> 
> This series adds support for the Raspberry Pis OTP registers. The
> Raspberry Pi has one or more OTP regions. These registers are accessible
> through the firmware. Add a driver for it and add updates the devicetree
> for the Raspberry Pi 5.

What is the merge strategy for this series?
Am happy to pick up non-dt patches 1-6/12 and 12/12.
let me know other wise.


--srini


> 
> ---
> Changes in v8:
> - Really rebase to v7.4-rc2
> - Add a patch to reorder rpi_firmware_property_tag enum
> - Link to v7: https://patch.msgid.link/20261110-rpi-otp-driver-v7-0-2345d0ee65f0@linutronix.de
> 
> Changes in v7:
> - Rebase to v7.4-rc2
> - Added Patch to register rtc driver by soc enum from drvdata
> - Link to v6: https://patch.msgid.link/20260522-rpi-otp-driver-v6-0-b0eac97d1428@linutronix.de
> 
> Changes in v6:
> - Use %pe in dev_err
> - Include <linux/slab.h> to fix build on arm
> - Add arm defconfigs: multi_v7_defconfig and bcm2835_defconfig
> - Reword commit messages
> - Link to v5: https://patch.msgid.link/20260520-rpi-otp-driver-v5-0-b26e5908eeac@linutronix.de
> 
> Changes in v5:
> - Move alignment check to nvmem core
> - Use IS_REACHABLE to simplify Kconfig
> - use root_only for private driver
> - Add driver as module to arch64 defconfig
> - Use MODULE_DEVICE_TABLE
> - Remove some unused attributes, fix typos, minor fixups
> - Link to v4: https://patch.msgid.link/20260508-rpi-otp-driver-v4-0-cf8d725d8821@linutronix.de
> 
> Changes in v4:
> - Additional patch to drop unnecessary select schema
> - fix dt-bindings
> - use __counted_by_le
> - additional alignment check in read/write callbacks
> - Link to v3: https://patch.msgid.link/20260506-rpi-otp-driver-v3-0-294602663695@linutronix.de
> 
> Changes in v3:
> - dts: add "raspberrypi,bcm2835-firmware" as fallback and fix dt-bindings
> - Fix Kconfig depends
> - Changed firmware data fields to __le32
> - Add MODULE_ALIAS
> - Link to v2: https://patch.msgid.link/20260505-rpi-otp-driver-v2-0-e9176ec72837@linutronix.de
> 
> Changes in v2:
> - register nvmem driver from firmware driver and drop firmware sub nodes
> - Use struct_size and __counted_by for dynamic array
> - Drop unneeded comment in Kconfig
> - Use NVMEM_DEVID_NONE
> - Use kzalloc
> - Update module description
> - Link to v1: https://patch.msgid.link/20260408-rpi-otp-driver-v1-0-e02d1dbe6008@linutronix.de
> 
> ---
> Gregor Herburger (12):
>       firmware: raspberrypi: reorder rpi_firmware_property_tag enum
>       soc: bcm2835: Use IS_REACHABLE for function declaration
>       nvmem: core: Enforce stride and alignment checks for nvmem_device functions
>       dt-bindings: raspberrypi,bcm2835-firmware: Add bcm2712-firmware compatible
>       nvmem: Add the Raspberry Pi OTP driver
>       firmware: raspberrypi: register nvmem driver
>       arm64: dts: broadcom: bcm2712: add raspberrypi,bcm2712-firmware compatible
>       dt-bindings: raspberrypi,bcm2835-firmware: Drop unnecessary select
>       arm64: defconfig: Enable the raspberrypi otp driver as module
>       ARM: bcm2835_defconfig: Enable the raspberrypi otp driver as module
>       ARM: multi_v7_defconfig: Enable the raspberrypi otp driver as module
>       firmware: raspberrypi: use drvdata to register rtc driver
> 
>  .../arm/bcm/raspberrypi,bcm2835-firmware.yaml      |  20 ++--
>  arch/arm/configs/bcm2835_defconfig                 |   2 +
>  arch/arm/configs/multi_v7_defconfig                |   1 +
>  .../boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi    |   4 +-
>  arch/arm64/configs/defconfig                       |   1 +
>  drivers/firmware/raspberrypi.c                     |  62 +++++++++-
>  drivers/nvmem/Kconfig                              |  11 ++
>  drivers/nvmem/Makefile                             |   1 +
>  drivers/nvmem/core.c                               |  12 ++
>  drivers/nvmem/raspberrypi-otp.c                    | 131 +++++++++++++++++++++
>  include/soc/bcm2835/raspberrypi-firmware.h         |  37 ++++--
>  11 files changed, 256 insertions(+), 26 deletions(-)
> ---
> base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
> change-id: 20260408-rpi-otp-driver-75fce1dcff7d
> 
> Best regards,
> --  
> Gregor Herburger <gregor.herburger@linutronix.de>
> 

