Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF892441B8
	for <linux-hardening@vger.kernel.org>; Fri,  3 Jul 2026 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783102195; cv=none; b=M7lNzTKhnhv49t31Wn2045Tky3HdK8atHFw4Y8x/pBRK2YzNGOjYEaimxSAOdoBLGaVWTLdrYgAJIpo0FKn0lrS1MMqfKmyQsfflNaogKgt6mC+ZqnpQU2hnER8xF3P4Qgw2zlwRGARwUeq7CrkKT11S9mgriSNPbQZvZpRMNH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783102195; c=relaxed/simple;
	bh=tgraSq/9gwcx1TlvQJClsEB9nYR8gJqZ8hIiRgK1PwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBhIy2D29MHIWGYCgmY6vO4QvChXlfQlObXa1A69/OKqo8Ig7TtYCElNXtP3I8Sf3tvBobx1BkcHWMGVAwxW9CMzb3dKoXIQPmYYD0isPaK0MbV1qhrTgzZXOVtpumDdRrvmpoxdPCS7G4UntpZYsLlJE8Dbpxx/e30CSbEAyDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ra4xy5wv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ra4xy5wv"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493c733f15aso7877515e9.0
        for <linux-hardening@vger.kernel.org>; Fri, 03 Jul 2026 11:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783102190; x=1783706990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=v0DdjgoNvkE0UKI8hOQQ2MWCAbcQBGlfDeboRpCm0gA=;
        b=ra4xy5wvOi/TPR2Z34MK32O/ruNxzV+1v6h5iMDy1P1Fn3UGUdPZM2687Pony5MH/s
         WLLI7YRHTn4SPDcZsIu7rwolyAPhKocKplLXYQIeCbqypXDo9Bgn9zyBZg+AYgdPS3c1
         aC0uv6QHm9h7b6sKySLAA0Ho1VbwhCEAwnI9dTQ4gsjtlUt+MTijdQasxwuPvJmyQaOV
         k9IObRwH0OUTZ17q3WKTOsLRgxAQMxGvzdvs/u9wU4so5i/GhP1eYPxkJggBq5exxNCC
         umrd9HSyTHQypGHWdLak08XO0Qr3hi3XOCH5195z4JS1UN6UInIl2mW0V978DqbgDTOT
         D3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783102190; x=1783706990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0DdjgoNvkE0UKI8hOQQ2MWCAbcQBGlfDeboRpCm0gA=;
        b=sHlMJYD4hcLt1t5Kov36vWuZKZXxSCAUp1DH6oSvGzoRnCV87JavktAphOcKNqSV3+
         beYh1xHRivRrUbGyxknoWG+EkgRTnB9uH/QwlfsxcQE3hYG8FKcSqpZ3uWAAu0oY7n8k
         NCZsBWrfW0SUv+mFGfw4cNdlaXoyad7967zvzVOvi/xiSST2MHzbTpceEYpelVydhM+N
         yUl6+/AuSSK/rql3dC/CEGxO2Tm6WnmhkSd6O+xNnOYfH1iz7mhmxvJZGIJVCU743UUk
         GDQjMAOZffdh1OQCNcZaV/NAQHt1WEHBFV8Y8Mib1+I17yzLKsZzIA1uHjUBgV5AdYx3
         c2MQ==
X-Forwarded-Encrypted: i=1; AFNElJ/yYg3TM6kVOpnkdGiqXXlY3iXIoB34mSWdTglWknjFldsXmea9ThzlyHhHG9gOHgaxkRGyfONo210z4C1m0ts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyws4zKpCFQbsGaSEty/Xq7DcVfORLXMuBNyvVK8dx6PNl4iuZN
	3wVezaqByABfNAX7h24K1WyuISo88aq23siBfD259UXFtVM4PS2Pys83
X-Gm-Gg: AfdE7cl+YzGFVWhHbX1kiBnvU372/aDgMq7vuGpPn4kCHGCVNQuLp4jXAkh4zos5WBr
	641tUGHfh3/CY4F1Y0fe8S/VuiWhUy2HYWLxeV80v+J+ugOJMUwZcgeJLoGtCHRjvi4pLSIEUNs
	m7IPheCBv4OEyE0Y7Dj5v7BT+6/PzkvP5q83f8xwiA2XoWRtUjfAXWX4b6Ocw+A1+a07ZCFY/Zy
	L40UzfWoBju8tP2A5+dCP3385+M7COI4TUkmiIlY3BpP9Qy+ZnqXoF0l8qrMpGh2FcmXf/Dex8F
	69fEKRYKOZ5mrK5Lf+C7SaDxFwAULi3Ca7iReLD78sGboHFbPlWyQ6jBbLIOd/WyJ8S+FMJ+9pV
	pAA0ekflYzGyY02x4prMTTw7prUQGcZ4WtWxKCtUPXwVh4hVI90Q67XlFkYYRKZgZrjTQDCy73f
	NwZe/8of8OvpX6YNM94VD58Vpmnqoq0NYFfw8Pwzxp4qbEFvHIdJQY1yYI8U6ZQ+cE53wC344Jg
	ddO8Y8Y
X-Received: by 2002:a05:600c:314f:b0:493:b2c1:b2f9 with SMTP id 5b1f17b1804b1-493d11cf274mr4122605e9.8.1783102190297;
        Fri, 03 Jul 2026 11:09:50 -0700 (PDT)
Received: from [10.128.11.240] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm1044214f8f.33.2026.07.03.11.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 11:09:49 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <8a418031-4bfc-4212-a7e7-0d88aa4621c7@gmail.com>
Date: Fri, 3 Jul 2026 19:09:48 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] soc: qcom: Add QMI TMD support for remote
 thermal mitigation
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
 Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
 Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
 <20260703-qmi-tmd-v4-3-3882189c1f83@oss.qualcomm.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260703-qmi-tmd-v4-3-3882189c1f83@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

On 7/3/26 06:03, Gaurav Kohli wrote:
> +config QCOM_QMI_TMD
> +	bool "Qualcomm remote subsystem TMD" if COMPILE_TEST
> +	depends on ARCH_QCOM
> +	select QCOM_QMI_HELPERS
> +	help
> +	  This enables Qualcomm Messaging Interface (QMI) based Thermal Mitigation
> +	  Device (TMD) support for Qualcomm remote subsystems. It manages
> +	  TMD messaging and handles QMI communication with remote processors
> +	  to exchange mitigation state and apply thermal mitigation requests.
> +

QCOM_QMI_TMD can trigger an unmet dependency and build failure due to
selecting QCOM_QMI_HELPERS, without ensuring NET is enabled:

WARNING: unmet direct dependencies detected for QCOM_QMI_HELPERS
  Depends on [n]: NET [=n]
  Selected by [y]:
  - QCOM_QMI_TMD [=y] && ARCH_QCOM [=y]

- Julian Braha
