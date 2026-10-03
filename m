Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CFC38DC4A;
	Sat,  3 Oct 2026 20:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791060593; cv=none; b=qRdp2XqdPrzyTjNcWFLGwzlUg6cHuesq8FAwfYqWyO+R6VkMLx0jKEJ+5bsczPweyBLw30KcvKVq9a23RAf4SRuTOlAX7i26vNirP2lAtjWyI2lYvesEk3i5WEKwfgSrPmnEKoI1aqwEY2Sbg8cqEnbdp2pGQ6NIT4Pheogq0s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791060593; c=relaxed/simple;
	bh=dJGagNey16taasfvgVs/dUeFVS0v5h2w5upFkbsGjzs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jvsopElSAJJS7hMPghOFqYXufwbsjBWbFtPo/h3fjFY0y05tOoZrTJRJaKvnkxUXwZuu++QTJZZJkrA0PafpsRDa69dI7XgPRb7g60eAgUH2M7oiiSIgx6lpNqkDRuANnua1i8Kb3quSp1nVCYhIGbDUg+qqnogdTZPX1rf9BfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PW4DAp/D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PW4DAp/D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231D01F0089B;
	Sat,  3 Oct 2026 20:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791060592;
	bh=ECkI1b2uI92RNCBi2hVMJpjNQM8UXiOAvTSo1ulUUl4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=PW4DAp/DoyqbERernO8dLo7la+7yrUhhCXEGMMGBEHpnPHtnazeIStl7rxYTz6+7D
	 GUkDZIJz1u35HIg8C/vMxnltHM/OJGspeOuR/Eb1XFPzUga7EZ4UotsE26rwSMSCCY
	 YjkcVG+jvnV0j+iGCOzYlFcikGXQWhwQdXxAxO0ZG2F+Lkqg7caDUqUgRxl8jkMH/y
	 L9bIALywoVQg51/uyrzCjndxZalhQrfKATTX7UksDJzv50iGBCbRHsYN/gy91ITa7N
	 vqMyaxe1PNfqkOHNz425+wKI1bwan068ynFl38jvkqeYXoNknEVkZN4325g0SCbPdu
	 S1GFC8+At6vKA==
From: Vinod Koul <vkoul@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Kees Cook <kees+treewide@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Stanley Chang <stanley_chang@realtek.com>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Jinjie Ruan <ruanjinjie@huawei.com>, Rob Herring <robh@kernel.org>, 
 Charles Han <hanchunchao@inspur.com>, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20260917211303.i.538-kees@kernel.org>
References: <20260917211303.i.538-kees@kernel.org>
Subject: Re: [PATCH] phy: realtek: usb: Remove const from phy_cfg
 allocation type
Message-Id: <179106058877.240943.13071215640007818125.b4-ty@kernel.org>
Date: Sat, 03 Oct 2026 22:49:48 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 17 Sep 2026 14:13:04 -0700, Kees Cook wrote:
> In preparation for making the devm_kmalloc family of allocators type
> aware, we need to make sure that the returned type from the allocation
> matches the type of the variable being assigned. (Before, the allocator
> would always return "void *", which can be implicitly cast to any
> pointer type.)
> 
> In both the USB2 and USB3 PHY drivers, the assigned type is
> "struct phy_cfg *", but the converted allocation type would be
> "const struct phy_cfg *", as the size was taken from the local
> "phy_cfg", which points to const as it comes from
> of_device_get_match_data(). As there is no general way to remove const
> qualifiers, take the size from the assignment target instead. No change
> in allocation size results.
> 
> [...]

Applied, thanks!

[1/1] phy: realtek: usb: Remove const from phy_cfg allocation type
      commit: 88498cfc3ce6d8ccd3080ab4cc3f394eb2754b1b

Best regards,
-- 
~Vinod


