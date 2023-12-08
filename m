Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D865234;
	Fri,  8 Dec 2023 02:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkVPEoYJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205CFC433CC;
	Fri,  8 Dec 2023 02:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702004017;
	bh=pYFZ54dCpPeECJaD3wMxCgf0DmpliLHsDQObtMICiuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QkVPEoYJhbfrfcA9fITBTLMBtrrtP7cbHRsvv75zVxLUvwgrIRO5Ofnx34lCv45B9
	 xBRiDisOWD6ZBS6Bfi963U03EmC3CPjS01Nfa0ub11snBoTiMN96u7MhVd4hLgCitN
	 WPzDyifm9Ex9SBCVhgnKP5Kf/t/qJE2A8G78om3+lBNUqTl44W8Gr3ky7ltBba1V3h
	 uoF4d7w2hG9Ro6hqj3e1K/hfeFx1AhieQdCz4fNptgUNLwdLzlqrvsJJij+ryVX8fn
	 M+fUVsP6MIdIsTUNtPp59C2JxXll4syL4zH9TFYbvTxsdRdkQcJpIfdEPOJcxHNpYN
	 Zz5nehN34Kw+w==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Luka Panio <lukapanio@gmail.com>
Cc: Conor Dooley <conor.dooley@microchip.com>
Subject: Re: (subset) [PATCH v11 1/2] dt-bindings: arm: qcom: Add Xiaomi Pad 6 (xiaomi-pipa)
Date: Thu,  7 Dec 2023 18:57:41 -0800
Message-ID: <170200426937.2871025.11513762361673782003.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231125220315.118922-1-lukapanio@gmail.com>
References: <20231125220315.118922-1-lukapanio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 25 Nov 2023 23:03:14 +0100, Luka Panio wrote:
> Add a compatible for Xiaomi Pad 6.
> 
> 

Applied, thanks!

[1/2] dt-bindings: arm: qcom: Add Xiaomi Pad 6 (xiaomi-pipa)
      commit: 25bb226508a1384723b201da8bd5c16ac57f34cd
[2/2] arm64: dts: qcom: sm8250-xiaomi-pipa: Add initial device tree
      commit: 264beb3cbd0dc6d78357aa382297d5c94ffb4a3e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
