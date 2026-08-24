Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D0F43991E
	for <linux-hardening@vger.kernel.org>; Mon, 24 Aug 2026 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581155; cv=none; b=F33crjRVvxKIkQwkBvoaAxjdmP+vi8zkY5wS1fHNtgjb26+N+ElCVw3/TfAfrXdwudFJ5PYSLzbtPg66hWGN3n+6kVdrnjKJO5M6zsFU9b5D2zjulHeVjkqEETXaBICaLaX7oi49qSLvyTbgGsJvFPNEeiPH/6tNB4nY1hoZ8BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581155; c=relaxed/simple;
	bh=uGBZvFe03XTRnDnScoiVwUfr6a/QNJgJCLL5rZ5Drhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q6ZR7t+DGmdwyc7ZFcqDvbP3qJYIa6w6Dh+UaWRuMm4qo94JdGfdyJQQfvoMeD/PIttAPMDSNxlPucgFgqCMiY56T/TtpbpK2iDBSsMrAwGefR+m1NGNPiG22I+ZbFgmwg3Yun3yi8zgzi2l4OfOzg59fETtG/S4Sc2P/TJfusw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fd6Iz2t0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GgJPAZ54; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fd6Iz2t0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GgJPAZ54"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OCvCwM2584273
	for <linux-hardening@vger.kernel.org>; Mon, 24 Aug 2026 14:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iUX2OhZfsVuqQtVDi60W0GQY3wPaJ8rUSyWA44gD5Mw=; b=fd6Iz2t0/BUeqbt5
	YJnb8iyeIepriOd/Rd0itaNS1YPq/EgRMZL86MRM38s/D/WwMm1aocnmW+UxSE2l
	RqAbm5oXG47xkLiyYiLziMgO9DYCgILYcWV7j++4qBQTB0k4DILM0ekAtuBGtic8
	Ucb2t3ncQzGy1N7y4ln4b+w87xTnyJyL6KJCsiebN6APXrUcRaJEazkKt1P030MA
	ss50uvN+YcGG0Zt4xKc7eMSqg3nlzsgwobg5tGCDwcR8TXmB3HKVyzcTsqqVof0i
	wPdiPC0LGm7k1Yc8bjjDT8YF+TLWfkLAaQRQmiHhxD/N9dDffStnPZ955QbECQt/
	mpTsvA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8hbthrsw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 24 Aug 2026 14:19:13 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7530aaa7212so108973137.3
        for <linux-hardening@vger.kernel.org>; Mon, 24 Aug 2026 07:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787581147; x=1788185947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iUX2OhZfsVuqQtVDi60W0GQY3wPaJ8rUSyWA44gD5Mw=;
        b=GgJPAZ54sjTxGh65zJKPsF4/XgYFij8qYF9CHRxi1vj2o60bHl8viKgGKAe7FDdyXA
         ycO8VgPF3SJ22ro16pQAGDp4mpGCZthgCA/crPEdZkr4Hlqu5RMEuVepDOCBTc+BP6Qw
         z4BS9bhuHrXiHEFlqEFzyHTOV0WlOQZfShyu6pawdMAash/b3Xe12oHNf1tUa1dePuGg
         JV/qfix0T5Cjmkn0gPyl4KrTgcweOqQt3tCo60ygnKMw9t3vbXCrnelbctSEXXY1sjwG
         DgOF+6UX3Z5rce9avCS/HcIyLrLsmXR7W/CXIWlzXiZYEvxcK+yJXVrbjfez0zwRgkQh
         Ob+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787581147; x=1788185947;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iUX2OhZfsVuqQtVDi60W0GQY3wPaJ8rUSyWA44gD5Mw=;
        b=nHwLsAvw+JOCb/tLXco0PjgRgmMMdlDGNaa673vTb7y3OmBOxexj8Nf/AYwVHvtPr0
         mtjNKA52OkWHCVbP6ekVwdE3BSivA0g19kDr4X40jkB60ZpXH5MgnM2WZbh3yoj1pwwm
         UhU6QMvsKDM/kW2rRM4R3B4roT3V+l/fVca8nUxeJYUDAXrGI+4Z84TQ6JOXYgw/9j0T
         c8JeKovA4wcpAEiboLAD8QozjkHryzQZpuudJYkmiLGzISN9hG3f4paOqwaFQzq3QvNo
         9zwacRTcNuYu5OESuWTXtf3nBAfD5zcMES/9u6bcBbRFKbubhXX5DeUP/humKW0QtIvo
         ozdA==
X-Forwarded-Encrypted: i=1; AHgh+RpuacEgMIu2rqGl2Z0fJY4NvQlHpXznD1nZQA0H1pd4751UZjFjW2j+4wJc40Uh4jWUMUlSyF47c2vkdG7ocpg=@vger.kernel.org
X-Gm-Message-State: AFuF++nStRm/NSmdxLCGVsSOxkHJJmoJOO7lmUu8CgvIHCe/00awaO77
	SlpOcKAuJF6/lvURmk2hTcScYjUKFTu0jcAKKsx5B82AsXLL7B1l4JuOqlyjV8GaOxrUqno4T0v
	172dgQg3uGjBv/4PhA6MKs8Enx/NXJNKq1iS4Uk8KHiePf1LXZ7z85IpAAEySAPJlWe7n+Fo=
X-Gm-Gg: AR+sD131dtQMW/nMSQUHRLXm04tunHH6fuztJ6yuSpmiahVIVbH+KolW5I+O3j/gy6p
	aJPHMF9Pm+4hyMb5Rug2BPi6+L67JvcozEdo0oheJAmSxrtcEVwZPYGHFosSOHd3bgkRheXntfs
	fsPZC3/S2i+0GrgHuo69oajTGnL3myvBlTNvFMYZ/s7QTXeHgmK67rZ2TTgyxagEbKEOA670wjX
	a0CcGREjQWll5SgVTF3lsDwVdRfMXwXTJMB13WZcqqXaM9EfV0MpUgrw4kDzOY8++c3YkDG4Sh/
	YAEjAJhFvG/sP7xcYU7shW7j7C2LFeuGJDd2ssU/Vi6yJflII+LW2cH0Rphx7cWrhjPHRNQGJnI
	2TNqQhbLvACdXX6uIx+TKvzsC
X-Received: by 2002:a67:fa03:0:b0:77f:76f:2c58 with SMTP id ada2fe7eead31-77f076f3cb0mr479089137.1.1787581147661;
        Mon, 24 Aug 2026 07:19:07 -0700 (PDT)
X-Received: by 2002:a67:fa03:0:b0:77f:76f:2c58 with SMTP id ada2fe7eead31-77f076f3cb0mr479073137.1.1787581147092;
        Mon, 24 Aug 2026 07:19:07 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a1c2fab2f9sm14278301fa.27.2026.08.24.07.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 07:19:06 -0700 (PDT)
Message-ID: <01cd0d90-2908-42cb-9ae8-29828d4c03a0@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 16:19:02 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/9] arm64: dts: qcom: monaco: Enable CDSP cooling
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
 <20260809-b4-qmi-tmd-v8-8-b15d47adc379@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260809-b4-qmi-tmd-v8-8-b15d47adc379@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMCBTYWx0ZWRfX6rnXwPWL9p4h
 QgyKawNPKFanUaOmqB0shsLpV/7O04jlER0dui++zJnBgbVEled69/4scnQv5U5/6QX2M+F5aHm
 Ne5rDoIQJyi/Hm0GRwaOS4saAgEglQYlJncGrq8B+8rYGUz/HR8wiX/JM5KcZhWRSd+3gkqnnpk
 u/v2bIjaMCfjQiyNjdY2J51C4CB/OvGQXK7XqvmukVADxoJrxXPnBdIXkLaPYcczAYJkkqT/AjI
 7tmQ1fDhQb7Mc7oQDpOcqpqke4j5/PSeSSRu3OvqUftb/1CUNv0hAfueYMNSnFQdSG2OJjwHIFE
 l9D79bqC3ayElRgyzA2FQhWw95JZkmQxTCINa4JxZmCX9f864nZye/hyS8R3ih4UytqRjHMuJCF
 o63aSFfEsjxg8xVVSJ00wFVY0AMOGJkM3N/2RqdWHOfkpKkqmNWo01slQHBWgkp9HY9dFJmZT7E
 CN5yh3K8IsnfEKwXU2A==
X-Authority-Analysis: v=2.4 cv=JL0LdcKb c=1 sm=1 tr=0 ts=6a8c52e1 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=lpwU2ilW0SqlNkBhVkYA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMCBTYWx0ZWRfXxlFhaMirBRNh
 OJjcto0wyPc2Cbq3KyTNcQAPUWHSeuHwDoZ35K5U6x5cmFq63ahDhDtCpCwe1ZV1WA9VvV92uCG
 29N+NquUXmUN5NrfLMR/ZQTsP4ropBQ=
X-Proofpoint-GUID: g-sIslE890O_beDv_XFgJeT27Ac9y1h8
X-Proofpoint-ORIG-GUID: g-sIslE890O_beDv_XFgJeT27Ac9y1h8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240120

On 8/9/26 2:29 PM, Gaurav Kohli wrote:
> Unlike the CPU, the CDSP does not throttle its speed automatically
> when it reaches high temperatures in monaco.

[...]

>  		nsp-0-0-0-thermal {
> +			polling-delay-passive = <200>;

..and here it's 200 - I really think there should be a single value
that makes sense, this seems no less than random

Konrad
