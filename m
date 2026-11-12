Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481563;
	b=S/i7jTSaPH3rNr7Ozn5SWpMkl1avk1OVhPOzQ1O8Jl2ccCHj3MKwbkcjSeY7/UfW44Xo
	 gp3XEeIIPYwoWEvaAeeca+8H9Zxr8PH3cOV4C4WgW0TvDGlBifm3CECtPU8PZX34KE5j/
	 Tj1wvS+/UNJQxTv0Sj9Yi9LWEKxwgVrWlk9KSxHzdD3t2Kej9R9mwRfraUvBmbxhBbTRh
	 8XuSAwwttVLsBy0unj7ZuEfllfTaiUOv5B8C5IBz/TrXmqjBCUxQLE3ukhDz11rLGoqa7
	 PF1eUyxDDrlluT2XOWbJvDAGLN/UP9oeX1lUnYT6hf0ARn06XsYP4PnXJ40rU9F52kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481563;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=fKrWjpYZqdQRIuPQ0j1cPkoi1b1sm7ely2cunlMR4gQ=;
	b=b9bROs6CsgQGdx+XOuYTjzzmUtK7gya2Cd1OBeyZae49Eg6Zc9r/FwwqwvvXS/kjsFwQ
	 pAZ9WdaUKLRqN7vYWfdBdp6YvAJbXimk/dOciMX/sZjGxhQsNMhXXIk1Vk9tuVZFCk+Aa
	 q130GiXEOObltutqORId5nqNPbOR/AKbi1Zy+E3W205YNllpNQ5/nXczfMTnPvqZDntGa
	 I4x2uAIINNgbA8e+Y234VI4jTFjecWVKS5+FwVuiRz0nl8ddGYS3USiWPgkUuMpWulYcl
	 +/07yI4LN9sLyUWGvhcxBy0POnUTZePm0YBs0lxGObXzhN7okFrXcGCdRsnk1dJZQoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KaPEPqDO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA44F606A31C;
	Thu, 12 Nov 2026 11:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KaPEPqDO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DAD1F00A09;
	Thu, 12 Nov 2026 11:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794481562;
	bh=fKrWjpYZqdQRIuPQ0j1cPkoi1b1sm7ely2cunlMR4gQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KaPEPqDOixAktqc7+kPJeflmA/co+JGai7US59qP8P8BekbbO0ubFyTObSkNJ7Xep
	 /L+uzpnK/+7ybHODD76TeulYnGFytmk+gLqm+KKPJKFn0eyah951nmtyx5hmvGhvMQ
	 guN8gzKwCBVTz4aAGu0zk65/lH4ZAwbofBEY1mrOB930BuGkGJLMHxxCilZegxOhML
	 33ilipQhJqh9YkPYfpqxAvDZgzZSQJdYafwzqTrOHYautS8HkQJ9k5WOGlr+We5Pd9
	 bcHXGyqM7jz0qrtqzD6ScRjtAM7mRagHd1N134sEyA/VDCm78btTYy5zvuRvZkClvM
	 UjCKNzyWrOlWQ==
Message-ID: <e1b93076-f837-401f-895c-bee6bf3c9504@kernel.org>
Date: Thu, 12 Nov 2026 11:05:57 +0000
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
Subject: Re: [PATCH v14 4/9] media: uapi: Add CAMSS ISP configuration
 definition
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-hardening@vger.kernel.org,
 Hans de Goede <johannes.goede@oss.qualcomm.com>
References: <20261106-camss-isp-ope-v14-0-49c426cd2715@oss.qualcomm.com>
 <20261106-camss-isp-ope-v14-4-49c426cd2715@oss.qualcomm.com>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-GB
Autocrypt: addr=bod@kernel.org; keydata=
 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
In-Reply-To: <20261106-camss-isp-ope-v14-4-49c426cd2715@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/11/2026 13:55, Loic Poulain wrote:
> +struct camss_params_wb_gain {

Per our discussion elsewhere documenting here, we've decided that these 
names should follow the module version i.e. camss_params_wb_gain_1.1.1 - 
with 1.1.1 as an example.

For many of these formats the module structure will be used again and 
again but for some it will not.

Example:

OPE wb gains are 16 bit but on IFE generally these are 24 bits. The 
pertinent information is the version of the format structure not the 
fact that it comes from IFE, OPE or ICP/BPS/IPE.

---
bod
