Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3B92F2E;
	Mon, 21 Apr 2025 21:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745271067; cv=none; b=K5xWngRDfp+FSUID8Lm1Ak3ShzEmwjJJaHdyVEEazOkWas6CDNzbZG0hyjPAYD5jAkl13i47iKBMaIecVUN97BI2PbgtnGxrS6fkCVrvkOGnPY/TfpbGRUJd5ZlNCmRCVctfIjc3tG8u3XVLjnBPz+x9wGyobl4w25Rv8CxrKug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745271067; c=relaxed/simple;
	bh=HrJsLZzPcy1u/nryaNlMTL4gJ/L0bfB4RWyaJ0L81uo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XPijZbLLSEF79NvPDg2kqFZCrN8F9AyJU4tj+eEl3Y548nLPdXNAN72lXXU2U1Waytxt/Gi09LM3/JmyxsN8sbDWAFvrfCtTX0prDuLbbq/kagV5FhgjkpHdgKxNBEo87YTX3Dbkw3huXFnSV7S5LdgpVYbSxrvsuwMtw0WPM30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFZtg8Ly; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFZtg8Ly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31508C4CEE4;
	Mon, 21 Apr 2025 21:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745271067;
	bh=HrJsLZzPcy1u/nryaNlMTL4gJ/L0bfB4RWyaJ0L81uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fFZtg8Ly8xvRZpqD8Aj4AgOhzATCs2rOq2Rey1mRudPBUhe1bsXOQYWShbncV1mIN
	 wGlIE5xQEcXz7cgTiW3PIUnNXf6JdX4bnb8ERVxWE8XcfSD4YtPK+1n7FeCY0dG5s+
	 dE6DCoiCOVtoJP9mpYuWgY5uL2Wj/Muff+5TBRvUKzJ/9crfQJdrogZ5gO68YIVh+Q
	 fDjHdaPJQvHhXn+nC7mItgO4vuvq58o6rsUWGdDRJD4NSuTf+8102p6tXhG3kudp5b
	 Vgbxzf40B7bvAnBqwUin1noM+gsMAdhfgxpLntevB4wPWwc0bvGoDZbPpEENxB3vc7
	 RCCnWJhi8kH8g==
From: Kees Cook <kees@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>
Cc: Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Tony Luck <tony.luck@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mod_devicetable: Enlarge the maximum platform_device_id name length
Date: Mon, 21 Apr 2025 14:30:51 -0700
Message-Id: <174527104953.545387.8821005974012895763.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415231420.work.066-kees@kernel.org>
References: <20250415231420.work.066-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 15 Apr 2025 16:14:24 -0700, Kees Cook wrote:
> The 20 byte length of struct platform_device_id::name is not long enough
> for many devices (especially regulators), where the string initialization
> is getting truncated and missing the trailing NUL byte. This is seen
> with GCC 15's -Wunterminated-string-initialization option:
> 
> drivers/regulator/hi6421v530-regulator.c:189:19: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (21 chars into 20 available) [-Wunterminated-string-initialization]
>   189 |         { .name = "hi6421v530-regulator" },
>       |                   ^~~~~~~~~~~~~~~~~~~~~~
> drivers/regulator/hi6421v600-regulator.c:278:19: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (21 chars into 20 available) [-Wunterminated-string-initialization]
>   278 |         { .name = "hi6421v600-regulator" },
>       |                   ^~~~~~~~~~~~~~~~~~~~~~
> drivers/regulator/lp87565-regulator.c:233:11: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (21 chars into 20 available) [-Wunterminated-string-initialization]
>   233 |         { "lp87565-q1-regulator", },
>       |           ^~~~~~~~~~~~~~~~~~~~~~
> sound/soc/fsl/imx-pcm-rpmsg.c:818:19: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (21 chars into 20 available) [-Wunterminated-string-initialization]
>   818 |         { .name = "rpmsg-micfil-channel" },
>       |                   ^~~~~~~~~~~~~~~~~~~~~~
> drivers/iio/light/hid-sensor-als.c:457:25: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (21 chars into 20 available) [-Wunterminated-string-initialization]
>   457 |                 .name = "HID-SENSOR-LISS-0041",
>       |                         ^~~~~~~~~~~~~~~~~~~~~~
> drivers/iio/light/hid-sensor-prox.c:366:25: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (21 chars into 20 available) [-Wunterminated-string-initialization]
>   366 |                 .name = "HID-SENSOR-LISS-0226",
>       |                         ^~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] mod_devicetable: Enlarge the maximum platform_device_id name length
      https://git.kernel.org/kees/c/94a821d9355c

Take care,

-- 
Kees Cook

