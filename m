Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B546468C13
	for <linux-hardening@vger.kernel.org>; Fri, 28 Aug 2026 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787924540; cv=none; b=KQ2p/mYAZZXS+piK7QgmWRmM43W3akrvoHjO67AHcphL+g9SY3dkVrY7AUZ69u8gtaw49YMU9qz77I+Qwv1q1DMCpsNjOHzvGx00/L2dqhKVMiMnps0cNlrRUiyv6DLTQEo+03h5q99+4dAzhQ6sqA5JfZqnnXAiWMs7UXQ580s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787924540; c=relaxed/simple;
	bh=P9sorK3EnMx+N0zFoDx2cEg7M+adcYf81VKFyiOOUD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsYr79gb9LsLBCNVLsiVqQBd4i6ySTvTQfQ1/VPFRaGlDyPG/oSpfQjgkexbThqkDmXHCGRDRTOio66IDBppGYMoMQo874MJf/nEx6/fqGolcy1Z/qEvKwZHrbyyireU3MUOQJoyuzyXVsG7Qif5kEV95BxIHBFn+iC4WAPORzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bjIR71BW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IADM//rv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bjIR71BW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IADM//rv"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDRenR4188241
	for <linux-hardening@vger.kernel.org>; Fri, 28 Aug 2026 13:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XjGRFZVnlfyLY74MHaSAHoyZFlwEBuWlJGFGGTbqtQc=; b=bjIR71BWu2jN0L1Q
	2i1gfAGclNEsmVZpWx+0aiEhHYb9x/QB5EWLrbxWoFON+2lCOntlsTL/rSliU5yu
	x+Korga1ywAKdsrK8/zcWWS3oqiTJnOG9Fxt89CsBUFH2AHI28RuU94b2lmmqwRr
	nyI/HQ7VfSAcUrmi1utj+zZPy48ylesDJganpz+8VulcjavQZXiN8SBeDjG1Rnre
	sS20ww6ZH7cHmhdrl8pHlvSnrDSqlWRwcOiq9xJlt9vK1kzM0PNMYDTPZwS5jesX
	RBREj9ovoo2DAzAghwSwF0RJ5GlUZRRUM8zH9Tl4CRReb4UgCZf3Cty533TqPbIb
	GSvtrQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb8afgr0v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 28 Aug 2026 13:42:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52d7ef17031so1103441cf.1
        for <linux-hardening@vger.kernel.org>; Fri, 28 Aug 2026 06:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787924536; x=1788529336; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XjGRFZVnlfyLY74MHaSAHoyZFlwEBuWlJGFGGTbqtQc=;
        b=IADM//rvKfcRaoNn2sfe+8vB471X/+EVnQrwV+HHlGffb93wlMhD5j3oSmFI2jwzQq
         H/b3Ju+6H4YhTHq8NyGanpq1VzXKKFlgB+/kVoz+qMSsbB2Rq8k1H3PC6lYzjIY3scfo
         bnb1JmH1vBUQDQuyz6P08rBjViy5EdfIARUEpGuYnbwwsR67xtB3hJ1YpClB/KVh9IT8
         1GVQcUZbP8Eg69ZgiDZepE6bb3BIPoUyn2X/NaI9eRG+fy+6yMClprjIjsXK7kQIu/tS
         ymvm+FqsipFeLdDfNZSXf69RudXhJPo9Jp/TNk4ojtHQU+ou5d86M1i9f3szj1kpNGZZ
         PmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787924536; x=1788529336;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XjGRFZVnlfyLY74MHaSAHoyZFlwEBuWlJGFGGTbqtQc=;
        b=SBLrSJqdZqI4fiD0MQ6HRmZlpc96VVLVM7YhNK8quCXfOGQneg8XdMH7sI37JnBeqi
         KLmncXiLsPormnYsbKGG6odjbnVXL4F0v040JVU7nsS9mwcvwR9GNMTkM7gvfiEqxmuy
         ZaKZfdHpP9X6gzCz0e8eCuq3/yh+1AQv31OMpMRESM/Tam+rD8YrZK6r1Rp3wCskJ4Ls
         M98xZWtVCiImoDfWFntNulwQCVooUubhYPjSOVboSOmOeZkWk5mYlGaPnZrFtZFR7flH
         tnE3qJ7tO66bs+DCKHNzxa6NdYsQ7kQ4v4wDiAsxrT+8eYBotmFsFkpkjij+ReurAX7s
         2nqg==
X-Forwarded-Encrypted: i=1; AHgh+Rrx7Boec8axlft3MgeviYOazmjwai9rSMu6kjF3thJfnijGXBzWHxMuodyHFzh89ipk2So/4vgkiAd9vWaqrWE=@vger.kernel.org
X-Gm-Message-State: AFuF++kGMLfylciPzFx2k+n+yhLdeqGnoS/YdA8xNSvMHSlB3aa5QWCp
	9qMzZn8bsc9/b/6ijxKOJc0flhanutQxmvLwqqg7SZDVrZqZCWPIb9eQum3iKmjrHxER7Ienvjd
	nFeQLK8x6rXvzn2oRoLopkbJ7t/Pt+gfhPLYNCW97rCrTYepyMa+ftg8SPvOPHHWH3GL6JA4=
X-Gm-Gg: AR+sD11k4JWTDPTJ2JZjmX6amCJ+nUn5FK1XFBhan1lbjKsBFDw5DtBaB+osa4Yv8mg
	BV3yvqBqfZSyaVImMHVsWOZ/7uls1GxnshtARE3j9C0cL8qF2mJ7/mjoDnv1QSHtWXhOVbCAaov
	hvHGFrHXMyhE8wYVjjb8yuZJIWZBHL3gxiYjfGOp8EXQH088zqfpXm1cM3C53OAEtHvpS1BZL3d
	i6IOR2SNz7eRMI2QElG2Z6bWWma/Rxrk2kcdtRI/wCMW8VmLfZaRqAwuth0n6FKywNKyWbxtBI/
	/ZtDjS60x37A0tAfHNf3aECzetYprfaowNOCFgdgTK48PEUiPqudgLBTqnKpIALDM8TebgE6SEB
	8swLS81bLIMK4Fd6Yb6NJCdw=
X-Received: by 2002:a05:622a:1348:b0:51c:845b:ac4 with SMTP id d75a77b69052e-52fb961b8a4mr52111511cf.3.1787924536475;
        Fri, 28 Aug 2026 06:42:16 -0700 (PDT)
X-Received: by 2002:a05:622a:1348:b0:51c:845b:ac4 with SMTP id d75a77b69052e-52fb961b8a4mr52110911cf.3.1787924535956;
        Fri, 28 Aug 2026 06:42:15 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a611b5c572sm555948a12.4.2026.08.28.06.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 06:42:14 -0700 (PDT)
Message-ID: <b76cbc5f-fa84-4eef-a4de-c95ded152cc9@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 15:42:07 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 9/9] arm64: dts: qcom: hamoa: Enable CDSP cooling
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
        Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
 <20260809-b4-qmi-tmd-v8-9-b15d47adc379@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260809-b4-qmi-tmd-v8-9-b15d47adc379@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UGqj4L2g3oMtBBTGpQra7Gf5s8U3dPG7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDExOCBTYWx0ZWRfX40HtTWZ7g4Mw
 LODqEEJZEr+v46jwOeKz2+mFl8V/v/a1hURnlUNvQfV8eEg3yuRxP8U7DI7pNoy8lNRku4D7qLU
 NYEAfU60hn4i0lPHzWXojfelT9sYEaA=
X-Authority-Analysis: v=2.4 cv=IPoyzAvG c=1 sm=1 tr=0 ts=6a919039 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=_nN_CDt7C_a4776dohAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDExOCBTYWx0ZWRfX4EB/jwnlKq3v
 y1SNoSLsBh19w6wZQ/Ia8tbsRRvsNuYwuJD41mjDRDGZt3lzhN+epTUpbXMQ8KXRbRMdS6RlOV/
 pjkwzLFrb1k8rH3TPH2cE54uOrHaeCdTF6oE1b48QPt+3LrrMX8zoyJMTTnhKXWEOWhcqnaS9fs
 iI4PlODfcNXHLYtKmCfHtP/biXebCd6nzzBRPSfC+KVOU0LpVT7IUQLmffKS0OuUTbEOQeSiHCS
 mApJ/fyFml7ArrV3vGyF4J5l8reXJY/b/Qykrd0OagSP529hjeXNCW1RnTp8UX8IM3hniqi0RsB
 RhqkSTmd5QBYlOoIuh7ehkSUPxQKpYmQhOFXuzjwRXhBz7FhLdCOz94pAfLeWdt834X0Hwgdw6d
 mkfUobqtNN+vM0TK2xRiF3WlaHeBQEkg1/n6PtJu5D7U9fDYONIr9R6xcT59UWFHNzKg7odZDkv
 48uAphjm/CQe7qCR82Q==
X-Proofpoint-ORIG-GUID: UGqj4L2g3oMtBBTGpQra7Gf5s8U3dPG7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280118

On 8/9/26 2:29 PM, Gaurav Kohli wrote:
> From: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
> 
> Unlike the CPU, the CDSP does not throttle its speed automatically
> when it reaches high temperatures in hamoa.
> 
> Set up CDSP cooling by throttling the cdsp, when it reaches 95°C.
> 
> Add polling-delay-passive so the governor periodically evaluates
> the zone during passive cooling and steps up cooling levels when
> temperature stabilizes below the next trip.
> 
> Update the NSP passive trip thresholds to 105°C to align with the
> higher temperature specification for Hamoa IOT.
> 
> Signed-off-by: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
