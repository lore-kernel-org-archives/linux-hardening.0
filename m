Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384F6345751;
	Tue, 28 Apr 2026 06:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777359378; cv=none; b=VGzbAcYTpfid0VEWV+K+l35uP6AjXPStLOw9rFt+FBwRr1HfpiN+I6Wetw3sfo/pcfwZzEq+IC7G8zstxIjeSoU5MXdQSu50f3Wo6o8oaXMVoT50tD7gIteR24KNxXykwB/jbduWUAgLIbm/85YsufkxTrvJ20IwLnlbLAhvdvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777359378; c=relaxed/simple;
	bh=7+SAl/k9DPllFv+iTtdbtfjy2bQ9LA6XKa6rnbMRh3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jeSk1oGLwced/03mfpg4tsNIemeT2HJLv3xvn9Ot/43E072mJzu0dyJS2U99Rbn+HOjI/hyYoAIrE77bpyByFuH7Wx/mAxU34VuOq+kgxuCzMo++uSKl93agNo6+y03YzAT2OA7B+emEiksdOIWMKeptREAbji1jl4IEC2F1ZEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDEoPrkX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDEoPrkX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26740C2BCB6;
	Tue, 28 Apr 2026 06:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777359377;
	bh=7+SAl/k9DPllFv+iTtdbtfjy2bQ9LA6XKa6rnbMRh3w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gDEoPrkXa94mbIE4hZClYTiJ4Z0hMfIHuCqdz8vXSYh6Rs7sxLhJny0cVZ2MN5vqB
	 aeKExetSf/pLkeXYGI+q8fW/h4qZRoskXiqac+ZejVpFwc61eG9jAwFzKZlbwWBl69
	 sZrBgKzTohjfSc+CGPZZnjAchYrsK1QcAB4nrjxCW/DJhDU8sDjOaC02eKLnR/Dmfy
	 ak5iwf7pyUU7oAtMNXSvvmLJHuE8YjqS82LEDVcglW7WrOelGMpb86oDzUYjzDK0s1
	 A2lRoHB8z6OoHluw8Z1Yaa8eaIAhzWyFaeALmeBPEQOU+xY+TbmSnz8oTRx25EOj2Q
	 vsPEAiXo2Qy4A==
Message-ID: <d4f786a9-3cd0-40ec-b499-8185e867af44@kernel.org>
Date: Tue, 28 Apr 2026 07:56:12 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] media: qcom: camss: Add camss-isp-bufq helper
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 devicetree@vger.kernel.org, laurent.pinchart@ideasonboard.com,
 kieran.bingham@ideasonboard.com
References: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
 <Ptwba7JmobZufdkgayhAhPOOjZhv-yUkZSIMcQYJbKrrBFOdsdG_QI2uUof0EibbexBxSGC4drfA8J1zV2zDRQ==@protonmail.internalid>
 <20260427-camss-isp-ope-v2-5-f430e7485009@oss.qualcomm.com>
Content-Language: en-US
From: Bryan O'Donoghue <bod@kernel.org>
In-Reply-To: <20260427-camss-isp-ope-v2-5-f430e7485009@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/04/2026 13:43, Loic Poulain wrote:
> Add a per-queue ready-buffer FIFO helper for CAMSS offline ISP drivers.
> camss_isp_bufq provides N spinlock-protected FIFO lists of ready vb2
> buffers, one per queue index. This can help multi-queues management
> and synchronization in ISP context.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/camss/Kconfig          |  14 +++
>   drivers/media/platform/qcom/camss/Makefile         |   5 +
>   drivers/media/platform/qcom/camss/camss-isp-bufq.c | 101 +++++++++++++++++++++
>   drivers/media/platform/qcom/camss/camss-isp-bufq.h |  85 +++++++++++++++++
What is the purpose of this and the next three patches - why not just do 
it inside the OPE ?

---
bod
