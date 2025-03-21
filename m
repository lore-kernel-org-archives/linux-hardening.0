Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A754D1EB9F7;
	Fri, 21 Mar 2025 07:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742543072; cv=none; b=hYzIAslPk58VQhIa9tp05H+zjtMDcKTVvvfsQM1leohhiCH7tH9M7tcnt3GbGgHMDmyqb698J1zaLkbgp+6JRpISp8jjRx7fzPG842VH7VhzW6TcaJ095S4v/plNeegicKZh2hzYKFveE9Z9q1rMCY7xLLffj/kCoxO+7Shyzjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742543072; c=relaxed/simple;
	bh=/YmjxGbakqtnak0HA4K/vKGsWFbKueiINUncr9XTSzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBmYvLDytX3zsPntGOUXY/ZHD6Xlx90qbjJ5x73vAJX0QFSGqdN1zTiOlPKHvR8ajI4nz6KuV7P+pfYZBC1N+h+sqcH0DssGW/iKtTsz9IHbbo6qdNYXiF+NXzpAsXaqvDJuzH6zhMX074rAib7VqqvT150K8BKcwEeVbpqHdeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxtOttO2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxtOttO2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DE8C4CEE3;
	Fri, 21 Mar 2025 07:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742543072;
	bh=/YmjxGbakqtnak0HA4K/vKGsWFbKueiINUncr9XTSzw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uxtOttO2F7v89LlJgh70CQiu5tLI6RaIemI9Z0u8HLRIqerUioGSSYZrDpkcA3sPv
	 /3KXrgvNsfcYBjgOdatbfruVTVSwl1+thHkX/4svLdGjdAGPxr1R56cev/osRg9N+E
	 XQOySpa5W7nDLmt3gtA6T85KBMttBU4UT2JX4NAwoUC2ZjQH/NEstb50hKeD5MTUe+
	 o2/4Y4f8v+vaGHApik+dNWVxLFpmvynZOa2PbQRTfGBGihAx3Hj69aLPViPfRYMQh+
	 ZzfXaT758lgC2uoV+MGwjGcfQoysEVl+q9Cn33/sVgS8DSNBPQrpI+MCfoi87U9CqV
	 busQicYEiHfTA==
Message-ID: <5127f2e7-cb38-4103-8799-551fdedd8152@kernel.org>
Date: Fri, 21 Mar 2025 08:44:21 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] ARM: dts: aspeed: Add device tree for Nvidia's
 GB200NVL BMC
To: Willie Thai <wthai@nvidia.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
 kees@kernel.org, tony.luck@intel.com, gpiccoli@igalia.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, openbmc@lists.ozlabs.org
Cc: leohu@nvidia.com, tingkaic@nvidia.com, dkodihalli@nvidia.com,
 Mars Yang <maryang@nvidia.com>, Andrew Lunn <andrew@lunn.ch>,
 Paul Menzel <pmenzel@molgen.mpg.de>
References: <20250320164633.101331-1-wthai@nvidia.com>
 <20250320164633.101331-2-wthai@nvidia.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250320164633.101331-2-wthai@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/03/2025 17:46, Willie Thai wrote:
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		led-0 {
> +			label = "uid_led";
> +			gpios = <&sgpiom0 27 GPIO_ACTIVE_LOW>;
> +		};
> +		led-1 {
> +			label = "fault_led";
> +			gpios = <&sgpiom0 29 GPIO_ACTIVE_LOW>;
> +		};
> +		led-2 {
> +			label = "power_led";
> +			gpios = <&sgpiom0 31 GPIO_ACTIVE_LOW>;
> +		};
> +

You still have stray blank lines in few places.

> +	};
> +
> +	buttons {
> +		button-power {
> +			label = "power-btn";
> +			gpio = <&sgpiom0 156 GPIO_ACTIVE_LOW>;
> +		};
> +		button-uid {
> +			label = "uid-btn";
> +			gpio = <&sgpiom0 154 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +};
> +

...

> +/*
> + * Enable USB port A as device (via the virtual hub) to host
> + */
> +&vhub {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	/*
> +	 * Uncomment below line to enable internal EHCI controller
> +	 * Current config uses xHCI Port1
> +	 */

Comment makes no sense.

> +};
> +
> +&video {
> +	status = "okay";
> +	memory-region = <&video_engine_memory>;
> +};
> +

...

> +&gpio0 {
> +	gpio-line-names =
> +		/*A0-A7*/ "", "", "", "", "", "", "", "",
> +		/*B0-B7*/ "", "", "", "", "", "", "", "",
> +		/*C0-C7*/ "SGPIO_I2C_MUX_SEL-O", "", "", "", "", "", "", "",
> +		/*D0-D7*/ "", "", "", "UART1_MUX_SEL-O", "", "FPGA_PEX_RST_L-O", "", "",
> +		/*E0-E7*/ "RTL8221_PHY_RST_L-O", "RTL8211_PHY_INT_L-I",	"", "UART3_MUX_SEL-O",
> +					"", "", "", "SGPIO_BMC_EN-O",
> +		/*F0-F7*/ "", "", "", "", "", "", "", "",
> +		/*G0-G7*/ "", "", "", "", "", "", "", "",
> +		/*H0-H7*/ "", "", "", "", "", "", "", "",
> +		/*I0-I7*/ "", "", "", "", "", "QSPI2_RST_L-O", "GLOBAL_WP_BMC-O", "BMC_DDR4_TEN-O",
> +		/*J0-J7*/ "", "", "", "", "", "", "", "",
> +		/*K0-K7*/ "", "", "", "", "", "", "", "",
> +		/*L0-L7*/ "", "", "", "", "", "", "", "",
> +		/*M0-M7*/ "PCIE_EP_RST_EN-O", "BMC_FRU_WP-O", "HMC_RESET_L-O", "STBY_POWER_EN-O",
> +					"STBY_POWER_PG-I", "PCIE_EP_RST_L-O", "", "",
> +		/*N0-N7*/ "", "", "", "", "", "", "", "",
> +		/*O0-O7*/ "", "", "", "", "", "", "", "",
> +		/*P0-P7*/ "", "", "", "", "", "", "", "",
> +		/*Q0-Q7*/ "", "", "", "", "", "", "", "",
> +		/*R0-R7*/ "", "", "", "", "", "", "", "",
> +		/*S0-S7*/ "", "", "", "", "", "", "", "",
> +		/*T0-T7*/ "", "", "", "", "", "", "", "",
> +		/*U0-U7*/ "", "", "", "", "", "", "", "",
> +		/*V0-V7*/ "AP_EROT_REQ-O", "EROT_AP_GNT-I", "", "","PCB_TEMP_ALERT-I", "","", "",
> +		/*W0-W7*/ "", "", "", "", "", "", "", "",
> +		/*X0-X7*/ "", "", "TPM_MUX_SEL-O", "", "", "", "", "",
> +		/*Y0-Y7*/ "", "", "", "EMMC_RST-O", "","", "", "",
> +		/*Z0-Z7*/ "BMC_READY-O","", "", "", "", "", "", "";
> +};
> +
> +&gpio1 {
> +	/* 36 1.8V GPIOs */
> +	gpio-line-names =
> +		/*A0-A7*/ "", "", "", "", "", "", "", "",
> +		/*B0-B7*/ "", "", "", "", "", "", "IO_EXPANDER_INT_L-I","",
> +		/*C0-C7*/ "", "", "", "", "", "", "", "",
> +		/*D0-D7*/ "", "", "", "", "", "", "SPI_HOST_TPM_RST_L-O", "SPI_BMC_FPGA_INT_L-I",
> +		/*E0-E7*/ "", "", "", "", "", "", "", "";
> +};
> +
> +// EMMC group that excludes WP pin
> +&pinctrl {
> +	pinctrl_emmcg5_default: emmcg5_default {

No underscores in node names.

> +		function = "EMMC";
> +		groups = "EMMCG5";
> +	};
> +};


Best regards,
Krzysztof
