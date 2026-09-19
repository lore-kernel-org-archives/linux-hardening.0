Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3DA2F3C07
	for <linux-hardening@vger.kernel.org>; Sat, 19 Sep 2026 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789836487; cv=none; b=Hk7g4KMF50ZsDAYXLwv9r5kgk0UbsXmacJm8sp+Fu8I+RonE2c65uUi2MoNnhIBmjECgt9D1kqwKHEX6Qdbr2LRx/O53T0fLFjtZn78q2k/FtG/a40583FmKKvA8RQYvR0mGT0N5zGrIYnXRNe7HUMs9M/HCDKEoAvMJldIWF4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789836487; c=relaxed/simple;
	bh=fnl3dUkFs7+q+6V0hzx11cv+IRpZStzDEBWzl1dyy5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdK1HKZxyX1lFrgrVgdjJ7LxsUlms0aFF66k++/WyKrpK27Nn4HRI1i0rZens02aApPIyM5nNfV7o8Vc7BeLcoi9APoDo9gkEm0Me8ABRPmVrrygfe7U5x+sKDIKXahVhVlU+jHga+c2uMF5Gr39le0RsE1A3Rp4hPcTnxYk4+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E1EWFl7Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BXQyoA4n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E1EWFl7Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BXQyoA4n"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68JGKK75563982
	for <linux-hardening@vger.kernel.org>; Sat, 19 Sep 2026 16:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fnl3dUkFs7+q+6V0hzx11cv+IRpZStzDEBWzl1dyy5I=; b=E1EWFl7Q6/J2VyWq
	DV7F1RuXslQyuP4A1UIyYVpQNh9R+kSVKDustTRYbeWCAcdz+K9P14RIvyqUbkVZ
	ObrAS/PEWVs2kVZ13x6bJ3Ce+q1d6mleR34YUgdRQ016lR+Rwep9UzQ2BAmLOsDD
	yYtnFaa24c4z2iM0+vu28m6QPB/IfmzMn/pfPT/Oup3y4LKkZ9kLPvyckn3SJDvB
	5TfdktayQyjFJ/JsyJr2bFdpg8iI7BYVLTsUxZjO//O9QmbeBUgu0RHcyqaXN+ve
	oSjqlRsL9pzAfFfC3quP1ZrTbUiYfLnSWOf6GIxfk2ZRPAH2rdLHqHbp1AOJL/Yv
	x0GQ8w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gshyxsbfv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sat, 19 Sep 2026 16:48:04 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-877ef1457aeso640159b3a.1
        for <linux-hardening@vger.kernel.org>; Sat, 19 Sep 2026 09:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789836483; x=1790441283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fnl3dUkFs7+q+6V0hzx11cv+IRpZStzDEBWzl1dyy5I=;
        b=BXQyoA4n7hZn+Ack72QoXEcB50EkG0KeXsDww5HwjtLLeEMoubMN/oQtvT9dZPzF24
         aK9yZs2+0GfhHSVNIV87fv/g0EDCo4CMZifVya5kZepBGZJUfbirWwgPGzjesLwlXdcK
         Os8ywcV1u5bM/qfkZlLX9E9JM+4o+1QH8dMV/OiK1bQaguOWOWmMDheSn3T2KSi2K9eG
         AgFMoAiGpi0km6ws0c18B3YtnUMZIKUNwkhb/QhjWz5XY89KT6RUel0DsUat5keIvGiI
         SItUxg22g2SzV8zFEEngpn9mr8G5T4ce5lp1PLQHdpVMcRaJhf718w7XGhPVRqUpJIIr
         SoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789836483; x=1790441283;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fnl3dUkFs7+q+6V0hzx11cv+IRpZStzDEBWzl1dyy5I=;
        b=YI1U+pZ6XEpyBhu17xuvejkixjHpBpUJ5nFVts9fOQsd25oZ827QmTpccM9EoDo5cM
         EPXHcKaEX5kQ5WetEiahYyiLl0OOxVI6ktb00WURinBCRC1rvhZaIsOOoK0JRl80t2KX
         NDGebABfsTKfivJ8QJxIJz/H7iLsITayWsg+Ak00dKms8rpGYmND3b0ENAZ7Fh2Uwujj
         85cO7zI8KR9Lllq+Vcc82MPg0h2lAMjVKKko17GyFDyRoH2IGOQwzVfM1yhPcJqQqHAs
         34xgHT+KFACeGqqMUlrf7+87oB7vw17juV3ww5Ge4bW2NXJ1H5tS83dAz+oEQCeEZ1b+
         6Aog==
X-Forwarded-Encrypted: i=1; AKwUvBy3sYgE1k7mA+mHPiqORVKSSWMXIQ4Vuk1Y0u1cx6BEbf+sGVztNZqvoD6TtCgBQ4w/2ZCqBcEUgXGqyv+2JIQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lxzSpMdmzGMQE7C+5zD95fmXtU4gz4SlbxqjB8GcNZ84IA4MNr
	bnUIHuplb8Jvda+z/PNXtHtZ8OH2uWSx6IcaHnFGgRp0YP4MkNd86XKQ0CQvWqQX5wNZeV3wl+4
	eXPt35yR06DofZw9eMmX6xS86lQ1dSzL7gKvPTJ//EXcWdKiXKMA8DGbZianiz1aRNCNsiO0=
X-Gm-Gg: AYBFou1Duw1sSHdiElrVMNn1FWbdfs3rvQZaujm/MypF0uiKI+5QEuGx/EHY3pRvA3V
	a5SbSLs/UZLoT0Z1K1wZ4ofZ37tkPLgPHIoyQ00dedUFuBITapKSrIwsEmu4wZMIhq80uMNNF5u
	NJnPAqymDyNfuydtljTSz+npvoX8hQC7ki+JTWHtqigUQGlGpA8vrvtjk8B8P6YWy4YhAvQuo5I
	gSZvVOhUznjw/Sw6t3ZkFcUI9/07ewrTW6RdiswWhEpkl7XVrW5LA+8rOgZ3WqEgap+LhWVscWk
	xqImMQoRKIRYnawJXcDWAJtNaNRhk7f7+MlgVcH9bml8rN3abbd+eFunsYqG6HIPL0N8a8ftT3S
	TZLwaKd4PhmuhwyVfZS8DuHsSqupt/cI=
X-Received: by 2002:a05:6a20:6a28:b0:3d3:adbf:7782 with SMTP id adf61e73a8af0-3dd8c41a46cmr9475628637.23.1789836483411;
        Sat, 19 Sep 2026 09:48:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a28:b0:3d3:adbf:7782 with SMTP id adf61e73a8af0-3dd8c41a46cmr9475613637.23.1789836483017;
        Sat, 19 Sep 2026 09:48:03 -0700 (PDT)
Received: from [192.168.29.115] ([49.43.227.249])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55bf843sm11231739c88.8.2026.09.19.09.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 09:48:02 -0700 (PDT)
Message-ID: <2ef85ab0-0efd-4a4c-bca2-370bedb36f8c@oss.qualcomm.com>
Date: Sat, 19 Sep 2026 22:17:55 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 9/9] arm64: defconfig: Enable CAMSS OPE driver
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260915-camss-isp-ope-v7-0-77b13d131d3d@oss.qualcomm.com>
 <20260915-camss-isp-ope-v7-9-77b13d131d3d@oss.qualcomm.com>
 <20260917-modern-corgi-of-memory-6d9082@quoll>
Content-Language: en-US
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
In-Reply-To: <20260917-modern-corgi-of-memory-6d9082@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PaRqFShd c=1 sm=1 tr=0 ts=6aaebcc4 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ISK6p04Y8w1qFYbiysbuaQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=AGB_TLOESQuI93QLNYYA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDI0NCBTYWx0ZWRfX5dDNpd6ya73F
 h9YLMJqmQ/LR1Wti1/YAHun+HB8JIOoowikCbDWQQNuRxUN4N+Fw3DTbT+w1OPp5MHXwUDq8Uo+
 B0tQqJmb+9sJy3jFI3Y0HuDN68PCNhQ=
X-Proofpoint-GUID: -63jGKeZX68kxDNPVopRlTaKjUdskACu
X-Proofpoint-ORIG-GUID: -63jGKeZX68kxDNPVopRlTaKjUdskACu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDI0NCBTYWx0ZWRfX0mmvfDAkq+LT
 ZE3+qxCIndPAKgV6bticH+DmmvFurP2TYrct7/rKdFEH49ywROY2soVX69/Z5aWr1mz4SBO4v8D
 mzlB/8Ti48E6ljEY1Qni5l3JR4qA4McYdRKxKdDkk16Nd9mjBE1HDj59bZt8R6JXLrBGfGXW/mh
 RDN+vKb5C51l8DCCihHYCUTo9E77X/CKKiG4DsKNv4sM+QjFlx83xHRSIbVRSP1y+g+HqqMPjKA
 v/T4w9bMGsqb3XkbZGPGcClsUYMFjVMh8PYG+rawZ8xcK34SKoow4MJGxOykeE02ZFV8bBKQQwb
 aOCZC0hlCR9fZxoUbUQTWF+lJd40UzeQtcd6sO761a/4r9Rg5UEH2QRYgJ8hxcOOwA5e9x8qnzn
 EYVMZSZN3zMft33z5VX7uETcIjadFBogUIFwpXMi7xyHtK451n498h3UMnTjT5cEH048WZlZKSS
 rruymvwJxgFHTpEKRuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-19_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609190244



On 17-09-2026 15:30, Krzysztof Kozlowski wrote:
>> Add CONFIG_VIDEO_QCOM_CAMSS_OPE=m to enable the Offline Processing Engine
>> driver for Agatti and Shikra platforms (e.g. Arduino UNO Q).
> Unfortunately same comment as usually... Samsung Agatti? How anyone
> outside Qualcomm can figure that out?

Ack, will address in next ver.

---
Regards,
Nihal Kumar Gupta
