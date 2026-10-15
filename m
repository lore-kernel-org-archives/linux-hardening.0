Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9950248880;
	Thu, 15 Oct 2026 03:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792033640; cv=none; b=DEFsDB1Aa7uaATgNFTrfoV6PTC34mgkBp4p5XXkHHLj50mZlcAiJmL96ebd5rBgD5gDaspazt/yq9difajq1bDUf52WboeK5JyYqwzl5AJxIOjx660pIdLP+uAN89/E5MDHvFoGCLAy2BPCeXXSCiXrQGNAFJzQ+gMRaUsIjouA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792033640; c=relaxed/simple;
	bh=rAK7HgXGowqUeKif+VnYn5zrmeAh8fwhzBCSu3eGP1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0T+GCPVNpoP1ev11BA+iWt9LkPji65QdmizzQMRn5nqkk/rgL97ngWE2FnKBdlX2NSQkdGSnHR4H6cujW8T9DeXHoTFuvb01IA9wDRyUQDQrf9P2uPES+lreVQye8eMmPSA8h4mgUvJ+BZhNmuENWtgGEd7wKzNnL+Dfmkl3KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sa4+G5Eu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sa4+G5Eu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD4D1F000C4;
	Thu, 15 Oct 2026 03:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792033639;
	bh=EGVRFfnMsw6nPB9r/fY5gkO5XIAOgbWc0egL3oNP6dI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sa4+G5EuIrxVH9xf2sM2cRKlUOeN7qGt4kq6w3FK6ugEXrEmtekX3sN2uxrKVaFTO
	 tN1IwhLHd67+tNPo0XmyxWFidOlOo3aipPngense/qRIi8/MTYTq/rDVE4jyJTutQn
	 Ai6LxJrEj7qwR6TZQDRTIanQmEMy32nwzFK7zbCRJ4fnxKm/bUokieAblRW7dWmGdv
	 8rOqNDPZyBsAHp10FrRovDRGKYdPVyYxz4YqcccgkM3AhRRPd0X+YpQZNxmaGko0eR
	 2py8Rp5FOOLKscGPXp/uy1bmc7KTkTzRrWlA2bc345pp7sO21MSVw/+QrwPVY0nveu
	 iUEYBkYbPC1JA==
Date: Wed, 14 Oct 2026 22:07:17 -0500
From: Rob Herring <robh@kernel.org>
To: Aleksandrs Vinarskis <alex@vinarskis.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Liviu Nicoara <lnicoara@thinkoid.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Tobias Heider <tobias.heider@canonical.com>,
	Val Packett <val@packett.cool>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	linux-hardening@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: platform: introduce EC for Dell XPS
 13 9345
Message-ID: <20261015030717.GA295784-robh@kernel.org>
References: <20261011-dell-xps-9345-ec-v6-0-2a66a364fe70@vinarskis.com>
 <20261011-dell-xps-9345-ec-v6-1-2a66a364fe70@vinarskis.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011-dell-xps-9345-ec-v6-1-2a66a364fe70@vinarskis.com>

On Sun, Oct 11, 2026 at 07:50:08PM +0200, Aleksandrs Vinarskis wrote:
> Add bindings for Embedded Controller (EC) in Dell XPS 13 9345 (platform
> codename 'tributo'). It may be partially or fully compatible with EC
> found in Snapdragon-based Dell Latitude, Inspiron ('thena').
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>
> ---
>  .../embedded-controller/dell,xps13-9345-ec.yaml    | 91 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 96 insertions(+)

Please address sashiko comment.
