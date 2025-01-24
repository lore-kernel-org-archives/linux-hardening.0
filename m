Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3530166F32;
	Fri, 24 Jan 2025 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737707815; cv=none; b=KnklZQMp5PTNvLJdWKntk5z8zDNEvxwaLx88UKTzCvhdvERRzpqlJ3fvPEVO12HsNzPQAl7pA/xRcV2JOJdpUXvdfNOItlqSc7hRTMqnDOuBvh11zG/2Xzl/0hHZ9gecTeqONiCdYh5T69S2Ks+yspIGnBgwib2Z3pmPmC2Wh9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737707815; c=relaxed/simple;
	bh=7PocYP06gYB5s4GBXtZIom2srut+GbONZRftd77UgHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+0QE7kV97SVjX+Wa4cCQ5onaYM4L7eMPsBYP44pfksHjpR7GTbB1oLEP5beSyp77ByZN0EeAUWsDvVH32uKZSuoOmjxjo27KZl7u58Dxaou9Opsbd5aNw04MtfkvhZKFsF/sCLuzMYA4fbANqxddNrUU8f9Vzwtdg6f5vO/QjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuHkpp1X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuHkpp1X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40535C4CED2;
	Fri, 24 Jan 2025 08:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737707815;
	bh=7PocYP06gYB5s4GBXtZIom2srut+GbONZRftd77UgHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fuHkpp1Xtxj6zF6kglVoC/edfTVWsbpzIRUa/NELq+BZiJ/w9xKUZPLQbcrb4RXjH
	 OU205SBskgjqrhK365LIEE6AIYj5fTdEzvILJVvlg9C4bfsLztpZY/rTp0EovTiN3x
	 ze6udOlmcf9TlE38qVFQk3L9LlyB/AwSzgQO019DLZG7HWUNUT05mDLfaaKzX+pOhN
	 z2t8ljaxzAK59++j/zFCsdUJZYpmwICHMS3W8FqhCdZIu/czuBKZOwVQAjGa8EWAuK
	 eNFs2VvJ4wqWNWs0IeNsVMPM6SvTek0iOAf7X5x7sJKjXVrPgAGRc6/NnJYw0FgGtc
	 ZV6XKqe7/dCkQ==
Date: Fri, 24 Jan 2025 09:36:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Willie Thai <wthai@nvidia.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, kees@kernel.org, 
	tony.luck@intel.com, gpiccoli@igalia.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, openbmc@lists.ozlabs.org, leohu@nvidia.com, tingkaic@nvidia.com, 
	dkodihalli@nvidia.com, wthai <wthai@willie-obmc-builder.nvidia.com>
Subject: Re: [PATCH] ARM: dts: aspeed: Add device tree for Nvidia's GB200NVL
 BMC
Message-ID: <20250124-rebel-stimulating-galago-bfa0e5@krzk-bin>
References: <20250124051819.7714-1-wthai@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250124051819.7714-1-wthai@nvidia.com>

On Fri, Jan 24, 2025 at 05:18:19AM +0000, Willie Thai wrote:
> From: wthai <wthai@willie-obmc-builder.nvidia.com>


This does not match SoB.

> 
> The GB200NVL BMC is an Aspeed Ast2600 based BMC
> for Nvidia Blackwell GB200NVL platform.
> 
> Signed-off-by: wthai <wthai@nvidia.com>

Full name.



> ---
>  .../bindings/arm/aspeed/aspeed.yaml           |    1 +

Please run scripts/checkpatch.pl and fix reported warnings. After that,
run also 'scripts/checkpatch.pl --strict' and (probably) fix more
warnings. Some warnings can be ignored, especially from --strict run,
but the code here looks like it needs a fix. Feel free to get in touch
if the warning is not clear.


>  arch/arm/boot/dts/aspeed/Makefile             |    1 +
>  .../aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts | 1352 +++++++++++++++++
>  3 files changed, 1354 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 2f92b8ab08fa..0a6f3654dcb5 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -96,6 +96,7 @@ properties:
>                - inventec,starscream-bmc
>                - inventec,transformer-bmc
>                - jabil,rbp-bmc
> +              - nvidia,gb200nvl-bmc
>                - qcom,dc-scm-v1-bmc
>                - quanta,s6q-bmc
>                - ufispace,ncplite-bmc
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index c4f064e4b073..0dc5240866f3 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -48,6 +48,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-lenovo-hr630.dtb \
>  	aspeed-bmc-lenovo-hr855xg2.dtb \
>  	aspeed-bmc-microsoft-olympus.dtb \
> +	aspeed-bmc-nvidia-gb200nvl-bmc.dtb \
>  	aspeed-bmc-opp-lanyang.dtb \
>  	aspeed-bmc-opp-mowgli.dtb \
>  	aspeed-bmc-opp-nicole.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
> new file mode 100644
> index 000000000000..91d025229aba
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
> @@ -0,0 +1,1352 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/leds/common.h>
> +
> +&gpio0 {
> +	gpio-line-names =
> +
> +	/* gpio-line-names are the combination of <signal>-<I/O> , "" is the placeholder for the unused pins
> +	*/

Odd wrapping and alignment. See DTS coding style.

> +
> +	/* 208 (26*8) 3.3V GPIOs */
> +
> +	/*A0-A7*/
> +	"", "", "", "", "", "", "", "",

All these are misaligned.

...

> +
> +// EMMC group that excludes WP pin
> +&pinctrl {
> +	pinctrl_emmcg5_default: emmcg5_default {
> +		function = "EMMC";
> +		groups = "EMMCG5";
> +	};
> +};
> +
> +/ {

No, look at other DTS. You never start with overrides, this is
completely wrong coding style, completely odd and unacceptable code.


> +	model = "AST2600 GB200NVL BMC";
> +	compatible = "nvidia,gb200nvl-bmc", "aspeed,ast2600";
> +
> +	aliases {
> +		serial2 = &uart3;
> +		serial4 = &uart5;
> +		i2c16   = &imux16;
> +		i2c17   = &imux17;
> +		i2c18   = &imux18;
> +		i2c19   = &imux19;
> +		i2c20   = &imux20;
> +		i2c21   = &imux21;
> +		i2c22   = &imux22;
> +		i2c23   = &imux23;
> +		i2c24   = &imux24;
> +		i2c25   = &imux25;
> +		i2c26   = &imux26;
> +		i2c27   = &imux27;
> +		i2c28   = &imux28;
> +		i2c29   = &imux29;
> +		i2c30   = &imux30;
> +		i2c31   = &imux31;
> +		i2c32   = &imux32;
> +		i2c33   = &imux33;
> +		i2c34   = &imux34;
> +		i2c35   = &imux35;
> +		i2c36   = &imux36;
> +		i2c37   = &imux37;
> +		i2c38   = &imux38;
> +		i2c39   = &imux39;
> +		i2c40	= &e1si2c0;
> +		i2c41	= &e1si2c1;
> +		i2c42	= &e1si2c2;
> +		i2c43	= &e1si2c3;
> +		i2c44	= &e1si2c4;
> +		i2c45	= &e1si2c5;
> +		i2c46	= &e1si2c6;
> +		i2c47	= &e1si2c7;
> +		i2c48	= &i2c5mux0;
> +		i2c49   = &m2riser;
> +		i2c50	= &i2c5mux2;
> +		i2c51	= &i2c5mux3;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=tty0 console=ttyS4,115200n8 earlyprintk";

Drop entire bootargs. Use proper stdout-path instead. earlyprintk is
debugging, not mainline-wide use.

> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x80000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		vga_memory: framebuffer@9f000000 {
> +			no-map;
> +			reg = <0x9f000000 0x01000000>; /* 16M */
> +		};
> +
> +		ramoops@a0000000 {
> +			compatible = "ramoops";
> +			reg = <0xa0000000 0x100000>; /* 1MB */
> +			record-size = <0x10000>; /* 64KB */
> +			max-reason = <2>; /* KMSG_DUMP_OOPS */
> +		};
> +
> +		gfx_memory: framebuffer {
> +			size = <0x01000000>;
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +
> +		video_engine_memory: jpegbuffer {
> +			size = <0x02000000>;	/* 32M */
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +	};
> +
> +	power-gpios{
> +		n2-gpios = <&gpio0 ASPEED_GPIO(N, 2) (GPIO_ACTIVE_HIGH|GPIO_PULL_UP)>;
> +		n3-gpios = <&gpio0 ASPEED_GPIO(N, 3) (GPIO_ACTIVE_HIGH|GPIO_PULL_UP)>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		uid_led {


No, sorry, you send us crappy downstream code asking us to comment on
exactly the same issues we fixed long time ago.

Drop your entire code and start from scratch from most recently reviewed
upstream code, so you will not duplicate all of the known and fixed
issues.

The exact issue here: Follow DTS coding style for naming.

> +			gpios = <&sgpiom0 27 GPIO_ACTIVE_LOW>;
> +		};
> +		fault_led {
> +			gpios = <&sgpiom0 29 GPIO_ACTIVE_LOW>;
> +		};
> +		power_led {
> +			gpios = <&sgpiom0 31 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		// Non-LEDs:
> +		//   BMC_READY-O GPIO pin (not an LED) is being bound to the GPIO LED driver.
> +		// Notes:
> +		// * This is a workaround and leverages the GPIO LED driver to enable control of
> +		//   reset tolerance and still allow the GPIO to be controlled from user space.
> +		// * The standard Linux GPIO driver allows control of reset tolerance, however
> +		//   does not expose user space APIs for user space control of the GPIO pin.
> +		// * GPIO_TRANSITORY = reset tolerance is disabled
> +		// * Any non-leds should be added below this line.
> +		bmc_ready_noled {
> +			gpios = <&gpio0 ASPEED_GPIO(Z, 0) (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
> +		};
> +	};
> +
> +	buttons {
> +		power-btn {
> +			gpio = <&sgpiom0 156 GPIO_ACTIVE_LOW>;
> +		};
> +		uid-btn {
> +			gpio = <&sgpiom0 154 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> +
> +// Enabled Primary flash on FMC for bring up activity
> +&fmc {
> +	status = "okay";
> +	flash@0 {
> +		status = "okay";
> +		compatible = "jedec,spi-nor";
> +		label = "bmc";
> +		spi-max-frequency = <50000000>;
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			u-boot@0 {
> +				reg = <0x0 0xe0000>; // 896KB
> +				label = "u-boot";
> +			};
> +
> +			kernel@100000 {
> +				reg = <0x100000 0x900000>; // 9MB
> +				label = "kernel";
> +			};
> +
> +			rofs@a00000 {
> +				reg = <0xa00000 0x35FF000>; // 55292KB (extends to end of 64MB SPI - 4KB)
> +				label = "rofs";
> +			};
> +		};
> +	};
> +};
> +
> +&fmcraw {
> +	status = "okay";
> +	spidev@0 {
> +		compatible = "hgx,glacier";
> +		status = "okay";
> +	};
> +};
> +
> +&spi1raw {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi1_default>;
> +	spidev@0 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		spi-max-frequency = <25000000>;
> +		compatible = "hgx,glacier";


NAK, does not exist.

> +		status = "okay";

Where was it disabled?

Please run scripts/checkpatch.pl and fix reported warnings. After that,
run also 'scripts/checkpatch.pl --strict' and (probably) fix more
warnings. Some warnings can be ignored, especially from --strict run,
but the code here looks like it needs a fix. Feel free to get in touch
if the warning is not clear.


It does not look like you tested the DTS against bindings. Please run
'make dtbs_check W=1' (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).
Maybe you need to update your dtschema and yamllint. Don't rely on
distro packages for dtschema and be sure you are using the latest
released dtschema.

> +	};
> +};
> +
> +&spi2 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi2_default>;
> +
> +	// Data SPI is 64MB in size
> +	flash@0 {
> +		status = "okay";

Where did you disabled it?

I finished review here, because you have way too many trivial issues
which would be pointed out by tools if you run them.

And you are supposed to run the tools first, before you use community.

Best regards,
Krzysztof

