Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AD9411661
	for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787220944; cv=none; b=Djp54H7JFuGson2hVPb8DQu6CGq7G12m55Aht6BLOpmoh0mOQTDNQxb1nRmt8JbQ9fQK1qERwKa+CWnDRR4HF6VENAQzb7P2XUk7AD4V50H0d2JAfa0zd/PazNxMQCeng3zsW99hmlp4/c8PZ5kRwykito20MM7njUNZOGdnAQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787220944; c=relaxed/simple;
	bh=OlnvrzNLh/kIxcNt4tkPLpQC12mGSYwaj2c5jzrl3PM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJqiyM3uqL9fqaRMU5QN5ytNVuBvrjuZ7h5ZfK5V+0pg+Wb4uA9BKRqNj9MyLAUcUVJ2lXZ0n4LzoVdySYAJOy4MHwyYi6GXIcTnkffnPSQgFiZvCRupF/4cBOoZeuzY6CAKL8nJJkWbhRyWuH1tSSWzMrZ1mU0IRq9eqRb3sZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FSOheU5j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TeqTI5jI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FSOheU5j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TeqTI5jI"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8jfHP2529525
	for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 10:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	12Wlhblgscwo6MxaFB2wLLKER52RRfKna4iYTekNvv4=; b=FSOheU5j1WTG61vy
	fTJjG9UG9Qn9SZUOQQLbJo1e7CqQWro5SlChNuE1N28Z+tkbEuu9jdY9tQGHfBX2
	y8bULQ5ub+7vvsz3ZGM2PuZDR1ospfzKew80DEvYDHq5ykZP9Syy1FNHrLQwT1SO
	9lLHj7SHyQAKtgXpYj01fIAI1fy7m2AStLQJ0HCrkKeL6RftcHfW6kaLgoeb3mVU
	BRS6Tg/b244SAqXbus7AmPl8o3SVAEmmOfmlnPnpECHrbP9gs0PMoaYEMS4rmj8y
	SBzjKCH+bGHWUhR0mIyh8iBjCwnfKEKuOBKJSZapA2IPGFKynhn8SYzaMBYZWoSp
	tOvkRA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xbv8bbf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 10:15:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52d35a38fafso362901cf.3
        for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 03:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787220899; x=1787825699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=12Wlhblgscwo6MxaFB2wLLKER52RRfKna4iYTekNvv4=;
        b=TeqTI5jIQunRUA06FTm3hygsyvLLz92lhpYhRgyI450xrYv33UJ196VtrmjOTLu2QX
         fDqVF0/iYEuF1vutlLUqz43QtTVy5Z5grYJxwHUehaWxEPOOaRMaUBFWRr0XE2JrptYU
         pIjdbGPgzRGc7a0d2N8jWdyk9OeZ3JQX4fj95oiWu+7wWZOJZgO6UqMOecxQVoryI7nU
         Z/9QE/jzrrsuwiHo9TsnbujDY9sVh18nhYw0WrbJKwba6vUog/fjFV7rSOpmBn96mL6/
         zElM1uDbM88GaySAPb5/GE3S662DHCjaSRBkXlB7ODx+uTBakbSBaaUFw+gE2GBYDVuw
         WIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787220899; x=1787825699;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=12Wlhblgscwo6MxaFB2wLLKER52RRfKna4iYTekNvv4=;
        b=o+M5XksD8lo56iOXD89lANaXm8YztPrz8wFgMYarYl25dK1h9/vxBoafKhCnSHmwlB
         aaZCfSwl3iAUqcQyoAyBpqYgc6RIS6QVQXNKqiNXlWWbrT63AgPT7ZXupBjoDbARdQKq
         frTgwFX1X311+juSywgTrD8Pf6F5WekKhxMYKP232fN2M9PY52N2FQQVVsAhBZvAyZLl
         YxdR5K5IE6QGy2d+RzoDpeCumkPdvYAr4SPpu3Vplzo2Mb2kTi5FLaGDzxuRWyO0I2vH
         ckdTuTcCA5kreg7k0AzHL5nv/Atmd+8ZU1uFF/MY5TQ67nOdBiJQGyD7qr4HV/d6G9N3
         dC3w==
X-Forwarded-Encrypted: i=1; AHgh+RqEVXm6F9bcRjWQsYYhIGlD20LmD8cUaWYWAMEw+ONuBNnPSF3r7FmTpjCdLg07gNiDaKQFQderf5dcS0KP1YY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdi0JoKzSGT2j2OdZE8NtUlCmezEwVAIlKwRlhdO0hnVpvZrgG
	QTpf/yKzQbwV80WS5j5epPUMx6PCIA7UabF5e4/RBn56p+CvF9uAuAL8LNKs2MPDE3xeS+AEnK8
	30ZqbuTmcmd83tP24J5BExhzsvsXkGxlfcc5EPKybojAOtzEfOkr2S+pwuTuQqYjLfGRgZr8=
X-Gm-Gg: AR+sD11YZstyxR+oLtjg8lqxRyNA0TCdfaHj3B6Xv8qk3WStsuo416EyvrTCxF3jJ72
	402UoV+PL8+BVjJmqEq7fQDv5eU4nwbGAAlq04mHMzI9LGWlRngPHNRAdUSN0Ez33mHI/eqNSi0
	Qz3qGRVj8aH567ucS1ENe0j6WflVkrbtvoLeqn6z59gXDsN5Jv2efi7z1D0u+3WEgrQDMD11zsN
	fvwTGaJbVAlqHh69WEmOBgPDuTTbtY8MkNlYxKz+4pnnTx4P6aLTYFXQSy/d6dIXf++b2xeq5/w
	448dL5aDMbi3NYvXzFZ/sSq91qbDEQqCO/B50K9r+uAKVuhZvf37csQxRe/pgL6SAIJMu+9EBvo
	xvrFpcucqQqHgiaTJuhUSNOwr
X-Received: by 2002:ac8:7f0f:0:b0:528:3722:a372 with SMTP id d75a77b69052e-52dd5dfdcf9mr78335951cf.4.1787220899345;
        Thu, 20 Aug 2026 03:14:59 -0700 (PDT)
X-Received: by 2002:ac8:7f0f:0:b0:528:3722:a372 with SMTP id d75a77b69052e-52dd5dfdcf9mr78335711cf.4.1787220898989;
        Thu, 20 Aug 2026 03:14:58 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2459222200sm49150866b.56.2026.08.20.03.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 03:14:58 -0700 (PDT)
Message-ID: <83d70e26-ed36-45a7-b457-e625ab68b8d9@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 12:14:56 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] arm64: dts: qcom: Add LeEco Le2
To: Adam Skladowski <a39.skl@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260820-next-patches-v2-0-7130d68183d9@gmail.com>
 <20260820-next-patches-v2-5-7130d68183d9@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260820-next-patches-v2-5-7130d68183d9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AMKAkK6n c=1 sm=1 tr=0 ts=6a86d3bb cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=L9omhr1Cf-tZUxP_opIA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA3NSBTYWx0ZWRfX5aaA6w095uMH
 oz76AGglYQGfzU6I8WrkWQjyTnIDFirEloG6cygQEwofmyI6e3QFAr6B6l4WTm0iNPhLjBMkINK
 iTGNJ82LcBIlKFqAxHqM5+JGvKDbxaiAsEUgjBF7sio+wgel/MH8aX4J4rloah545irZiLw+2Mu
 DAAocZQo4mXY7T4HqctMBu9R9gqVtXjvH4L4qzIgb0RGPAYi+tvFPvsWoFxfciJICEli1VEnr89
 /GiwgELcrFiApn5x0NIKfW5RoxEfeOdtNjUsejftxTAXy/9DmIw6x1Ce0SUbkSVcVVk7oxnCXXf
 bftpy5cpkPecCL6qPG9HbO+9RnqzLQ9UBY9g91gS7jpDef+jpBzeEDTGzJXHmoWlOvREQFginLh
 Rqw55Gt4+QdANBJ0cN6DpNcP0hqvLOYd6Mmmz72CIuH+JUlbwNCGAAvA4nVBNnIBxyqR87kVrLz
 IfYulIvTW/76gDDhjQQ==
X-Proofpoint-GUID: ZVeEjpq-p0fJEhBbRrE7RdrOuarSSO2h
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA3NSBTYWx0ZWRfX5jQYDyIbY9vN
 SGQRc3yBsnjuCvMq25GcYuhxXz22K9hfZMi6tbjBRuH80nAJfiVk2gAlIFNxp1BQMK7ouTmLmmF
 VON8Dkts8Sk6Ev1NW4bXzVExWvrgwJk=
X-Proofpoint-ORIG-GUID: ZVeEjpq-p0fJEhBbRrE7RdrOuarSSO2h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200075

On 8/20/26 11:42 AM, Adam Skladowski wrote:
> Add a devicetree for the LeEco Le2 smartphone, which is based
> on the Eldarion/MSM8976 SoC.
> 
> Supported functionality as of this initial submission:
> * I2C peripherals (Touchscreen,Audio amp, Haptics, Extcon, Led)
> * Power Button, Volume Keys
> * Regulators (PM8950)
> * WLED (PMI8950)
> * Remoteprocs (WCNSS)
> * GPU
> 
> Device tree also contains supply maps to other subsystems like MDSS
> but due to missing dependencies like panel those are disabled.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
