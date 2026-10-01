Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAAD395DAA;
	Thu,  1 Oct 2026 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865563; cv=none; b=VzckQHEwzskW7ymwSpaPMVkdZAoHjDK2j+LvYlS04Q3WCGan6ENQTU/hwc/Kx52cC8aF2/eYXdpHDI681GKf3V5urw7g1Ic7m8EEQYzECT/wlU3MSXfE5o6V3ZQ+UoBCWNonEZI0Yz+F2Z/IydRoO9O5ISDaEV4V4R1yWJNNoxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865563; c=relaxed/simple;
	bh=DJoIGeyxobBGuIlmWIySxC7RO/wC/ni1Y/UROMailfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUuTt6mBZ/jOMYUd5bgrvG/qS+5UeTf+D0IMibREhHa0rvqrsKIL1cXeYthyhd7r9M5CY7UyEK0Zf7NEIFKANn7FktOmDVk1bPgyiaZDthCRvzA6H6qAdlh0xu20f5AQz99BDeJVgSeEXYIw4XObdQ5Z1k9mt8uZ1/LPi4RklLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTPPC8g9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTPPC8g9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11E41F000FF;
	Thu,  1 Oct 2026 14:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790865556;
	bh=Ybk1Xis+LpwT/k2kTLipkYUSY35nd3DiPvV8woUxbvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cTPPC8g9OlpZvy/kyZaCvfZUHhQRTLZKlGgVRF0pftYKJgcUz5Zllvt7X9xTeV/OI
	 Y3PtdI57K7ZAhaeuhCXdcLQ18argu6mQ2sR9HH1qZVQNrGWewlGPtCEazLG35eNixw
	 33fdkLCtYtyxyCJVieYHZWDjwsVJ4ljU9V1jMU9N23rntGdEnzfR3oZ5M7Se8whjDP
	 lqEut1ndV80rg0k8cpn7GBzld8au5qy8WAGUJLzlo5QfJaYhY+2NQ2F3P4GQ5VGJyg
	 qbnCPeEsJph8pHjr+/72uEJi7kTgPJa7CUYEyvUftAQlit5YR2zbtePyZEdC4t7Brt
	 gtSxmJQtg2aUw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Adam Skladowski <a39.skl@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v5 0/7] arm64: dts: qcom: Add 3 new devices
Date: Thu,  1 Oct 2026 09:39:03 -0500
Message-ID: <179086552997.3495936.2903144550735593923.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821-next-patches-v5-0-ec81cee63e09@gmail.com>
References: <20260821-next-patches-v5-0-ec81cee63e09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 21 Aug 2026 14:26:59 +0200, Adam Skladowski wrote:
> Introduce support for 3 new devices:
> - Motorola Moto One based on MSM8953
> - LeEco Le2 based on MSM8976
> - Xiaomi Redmi 9T based on SM6115
> 
> Device trees besides enabling most of supported hardware also wires power to
> subsystems like MDSS even if those are not enabled to lower maintenance burden
> on out of tree forks.
> 
> [...]

Applied, thanks!

[3/7] arm64: dts: qcom: Add Motorola One
      commit: b62af30ebdb4ae4ec6230c5e39eea97f65b9f5ea
[5/7] arm64: dts: qcom: Add LeEco Le2
      commit: 88e66b7b609ea27e1ceddd1bd2c581a4a29f0574
[7/7] arm64: dts: qcom: Add Xiaomi Redmi 9T
      commit: 76fbf547548ccd1a650c096836d8cf01f3ce3ce6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
