Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3173D34BF
	for <linux-hardening@vger.kernel.org>; Sat, 28 Feb 2026 22:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772317017; cv=none; b=NyJdBgX9ivpDF1y40w5YO99BNZgthahvpw9ZOLYgVGjPBd0dSQv7rSloXcRBhYmpYYbUW5OTA/O1Ms3QVFN/0icNEXcYp5CMwuVYmlJoMJY1Va6z3vOMHPh/2XR9zatixA/62A7mFPLEus9NnXxiyZ1hJ1TGjawamk+5kUPb604=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772317017; c=relaxed/simple;
	bh=po1GJ5OL+l37vGYwOeXHbTRrLbPHVWf6bedwzCyotzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rb58+PoCBU9FlRKdiAx5+ZHrkfKtErYfIm6eWjsQ7SXjCvNAIucX35JQRdc36iPUFQ7cyXlXhBhELeKNqy+PfU9gUtz6LWY7vRuJvvVGqdj8Bw999m4DN98wqPynwtKmmI6RY6ZGnAoO1ESPd3jOfJ5lFb4jvJGgiThdiNJ/Cpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=VrQEcZTl; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="VrQEcZTl"
Message-ID: <c4e93e78-427a-45a6-9560-399b578e9260@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1772317013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mo8hhAD0T4w5u4cZDhtfyEdn8aaXHkZHMK1H62Gbpmw=;
	b=VrQEcZTlYvv3IkuNXllFn7cX8Ffj/S6Whqymcl4G5uECvZvknPoJnTjyWRxRoANd5EMbTG
	NfNaaASUoO2EhE5q9lq5zh9Uui+6r0H1IswxdEFvJWolIbxjk23zZUQVxvN37XsvRaECfh
	BcMfr39l9XpcXZll4VNUYcZGAURwkcSOyAgEckX9s3ImA+WDgV1miMo/kyvqAiM7SIMU6X
	BogSeBCDPcrGTpeiuU2jPr8omPStiFtiCTtZ11nNWCCgQwJr5Ltfklm3wrTQHQCW9FWdJy
	mjAgwaU8n/qoaMIGIlSxL7mqo74jwsE3R2o0gqwymjTunXurXtCzK0irezHRHg==
Date: Sat, 28 Feb 2026 19:16:44 -0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/3] drm/msm/adreno: Trust the SSoT UBWC config
To: Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260108-topic-smem_dramc-v3-0-6b64df58a017@oss.qualcomm.com>
 <20260108-topic-smem_dramc-v3-3-6b64df58a017@oss.qualcomm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <20260108-topic-smem_dramc-v3-3-6b64df58a017@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/8/26 11:21 AM, Konrad Dybcio wrote:

> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Now that the highest_bank_bit value is retrieved from the running
> system and the global config has been part of the tree for a couple
> of releases, there is no reason to keep any hardcoded values inside
> the GPU driver.
[…]
> -	if (adreno_is_a610(gpu)) {
> -		cfg->highest_bank_bit = 13;
> -		cfg->ubwc_swizzle = 0x7;
> -	}


Just noticed that the SoCs with A610 (SM6115/SM6125) have 
.highest_bank_bit = 14 in drivers/soc/qcom/ubwc_config.c unlike this 13 
value here.

Could this have been the cause of the corruption I saw on SM6115 
initially? [1]

What's really strange though is that I wanted to test this now, but I 
removed the FD_MESA_DEBUG=noubwc workaround that solved it initially…

and the corruption *did not* come back so I can't even repro it to 
confirm that this would fix it o.0


[1]: 
https://cache.treehouse.systems/media_attachments/files/116/083/578/070/293/038/original/9b8e73e15bed644f.jpg 


