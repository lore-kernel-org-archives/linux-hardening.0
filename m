Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927793BE17E
	for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787241426; cv=none; b=qhb5e2F2iXPDWfNUKfikrL6NB02p60kMQAOp8hqSyZxFXdK12Mmg2LESnq0l4hJZybmD1Ze7+qRQg9AESbQUkzEHEEfTmO8Rrn03qlowPaK8mXlSheHVeVW0JU8wrc5dBnHJLqQY8FrR2CNGA/duZDgDt7Er5mi9jK8zHfX6o/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787241426; c=relaxed/simple;
	bh=7T1SNsXABIr/TslXRUK91zgK6ZZ+Ty3K/mALZ/ehqLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mVpuMifUkrvCPlB6/1QmU1/b/Wd7IyaKLcQ6gB9dYe9JdU7pqcKVajFWv731sOQ8N5Ak3CpPLNDvj5cYt730ZrasNSVHVuHGYAZk+bX4gHRjO0VaCDLoX6LtuJW/fxt5dXQPR1DE6VnXKzu/gS+NvcMHRx4wadPKgK8bYWjfygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ihL5n1wC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HjBbdisS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ihL5n1wC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HjBbdisS"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KE7fqZ3987826
	for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 15:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JCz+dM7qKYk2PsVuuQxpoJUCi0kAaSw2IR3+A2ZzRD0=; b=ihL5n1wCZv+1KsgD
	6lbJsRIaqaNuiggeHfNCY9TfBCTiGbm5wrUu9AoLmxHp8bXt+vn5cbWyJzDk4Q6b
	yQwsdqpRCW2hTi/rDvLZw5dxUCj6+Z8Mc6nJj8SArtIVmHWicZabpZCLeJ6HQe/6
	R1XqK3MVZ30BhPH0Ty47fSh5KrVY2QQtzbs0EV+nTN+wDiDER4L9JGa1VReMTxU7
	kDpLpj5jCdHyelft/LH4st8KK3Fybxhnw9ahzVyv9qIULdd/ygoHotb+Kbt4CJCd
	9v3TUK97WTw1rvrETTk36Ox5WivsJFMGgXz7BNfk9Fy83stlW0aMsu9LuYDbhZgg
	OqzxQQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg89f01-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 15:57:04 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c9d953b71so1264721cf.0
        for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 08:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787241424; x=1787846224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JCz+dM7qKYk2PsVuuQxpoJUCi0kAaSw2IR3+A2ZzRD0=;
        b=HjBbdisSClcR9ebCcux0XTAkDXtKyzRz7DCJPj5kEpB0cQUc9ouzj9R2VSoRS6inVx
         5qp49/TNDoMMmqwoy5sw9L1fJfzaePHo7KonMJXwnKfDqs35pHxuoQNh45jQ94cno9A6
         g6bMC1/4QLRQ81MYD8RYhnjWHBGBqhfYz5glsHNUdCMZ46SGV32E4A6X9ah+D344Qq64
         DPfMPJyAEKFl40gYhgu4wQNg7+whVJWz4EJTFmTiQcV6uvTXn1gwREEmyrfqRstW+kHl
         fIJ19bVzKlJkHMnECjmj1yiKGpIcJu/RHnsVbm9qjSZVn3XwG3eCoTqWH5bIGIIEepOl
         jjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787241424; x=1787846224;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JCz+dM7qKYk2PsVuuQxpoJUCi0kAaSw2IR3+A2ZzRD0=;
        b=kktJN0gXHRfASk+9zqoT84M74fbY+JKlgsJB/+a83UnTlOM5W+SjgsuhvPCb+dwVTf
         vCo5C+l7KmwvmGspuKeEoytH17N/qXK8YrYxs3JU0CP9SOJB8yZ2zSU9EtO/sE3Z+3MR
         5QTls0TyGJs4v1Z0bKtvM6+VSdJSRQqGWH6xNtL0T+UDRiMDttgQ7bRFzmvkZ04lFATM
         HUHaSzJxAOsGc6apoIRPRzCpPKB3O1AGT8sXHwJg4mUKR3RV5d8t1c5ZfioYO+iNm6rL
         p5bvq9Le38qQK7nS0FbqqbUyZkrR5Bwixn09c7lM1ptltbLEp7FqZTT52xiBmfa0U1qv
         Kyng==
X-Forwarded-Encrypted: i=1; AHgh+RpnjXXU4PeOaVG5ypg/m2n0ZPKpGWZWKiQDuMHDXtdi4ymSanXk3PkeBLbGs6xpBOZc46ejbYZ9uPxWT3X4x1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyodFonhrat4Y9vLrx3jDQVgmCfB+uEOd9QfkqSgDBf1ZwoZgPx
	NtpniMbB4arIe7rrL0j458LDSCgwp00kCBR3kplHXnbWUz9oukTRYJX3Py3RZm+LjEXqk4zV88y
	XqflOmxCnlpLFqqrn2CgVzu7rQCU1Klzyqf0p6fGU9q8oy853q8yyuRLJdH4Uibj2pPQyxFI=
X-Gm-Gg: AR+sD10v0OB4AxnW0PdcE0fRYfaMPdWq0fI8KICmo1+DNRJgzUN8ecL2HUSnQ3OgKmD
	/EK93uJNBPb9kSWSH8SJEbkXn0IF3vBvekLoIiP7H5BQNjso0VAKHMvhG4x9D4N/dOhRqduieI+
	YscAmZDxTZALRKS8mzUroK7BymV7LipEjPMGK9WOAT2AKRDtJQrd0RVAMQtanuqAGTmLATmMADa
	ryTv91aL0pJ4VH6xsA4pL5caT7wk1HBqnXec7uGessAROHND2vh06Zm96HMq97AEILeHHCRZ1I9
	W+/l642PmFtKvYE+t3PCe0yvI8AGwAFmnpyzICbP9HXimTrEX4FZua/yGyZuiIxagXnouImrDzr
	2MyGOh4Joza3LDgISdqxf+4Dt
X-Received: by 2002:a05:622a:588:b0:50f:a53b:9d5 with SMTP id d75a77b69052e-52dd5771811mr92703921cf.2.1787241423832;
        Thu, 20 Aug 2026 08:57:03 -0700 (PDT)
X-Received: by 2002:a05:622a:588:b0:50f:a53b:9d5 with SMTP id d75a77b69052e-52dd5771811mr92702361cf.2.1787241422053;
        Thu, 20 Aug 2026 08:57:02 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2458b09448sm95493766b.17.2026.08.20.08.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 08:57:01 -0700 (PDT)
Message-ID: <7ae2860b-aa9e-49f6-9856-e7e56290e8f6@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 17:56:58 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] arm64: dts: qcom: Add Motorola One
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
 <20260820-next-patches-v2-3-7130d68183d9@gmail.com>
 <e16a7122-18c3-4bc5-80c5-1cda458fa2c6@oss.qualcomm.com>
 <4dc461a9-68f8-407d-b458-695ac263ca37@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <4dc461a9-68f8-407d-b458-695ac263ca37@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEyMCBTYWx0ZWRfXz5OgnIlkV5Dl
 8wxmQrfgVo6JmOIrbppMnSv3i2OhWcFYcsbT1tZQHgYtJlOpFRxJY/3x/n6DOczj+gKLyq+G4SR
 qsWJJRX3pD7Ffsw9jJlL/iYcyUWjsh0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEyMCBTYWx0ZWRfX+mG3jgNO5wSW
 OdV515RJ7SW8ePn82r/oKmE9EyHyEPd6fBtkWBX8WyiY5s2Nz25/Ht58MXkd8hLvo80TtVtGI2P
 eDM4z3Ls0SdpAtY4cI2Wq9Ax4zr5UYIWTslbYck3yrDaBZTJLf6QOQERYXaWll4HHlYik1Pf8n3
 /UiZVjUNThi6gqKsulSrHB2ZtAL+s4JSkxYHUK1unYP9BDYuyMZOZUW0TN2KO4EDTUhLLNee31N
 ZzYEbBtNgNebk4s2lFIFiDb/p1ltmgc3lpesK854oQdou2FYRZnUbXCt1yMb3obni1zKdtlKVos
 QozxCm8iYvAsn6oZbPHVs5qopgHAHh/UqBn5Cw/3qqz16SZSPFVTwFVNfLSnS9SiAHhm3QTLGme
 qZgSaf8NjnSYM/qFEYPFzpE0mJ8jQBWA9m/7HOM248SrIYzQD6NlHHGSfprH7p62MvpJT0Z0ADH
 euYYSKCzRQHdCyRlhnA==
X-Authority-Analysis: v=2.4 cv=Y7/IdBeN c=1 sm=1 tr=0 ts=6a8723d0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=DZjxxVxIHy9KTFeGu2oA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: RyXmUtAT-yZfSn4PwMqj58sfZy1P9gY1
X-Proofpoint-ORIG-GUID: RyXmUtAT-yZfSn4PwMqj58sfZy1P9gY1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200120

On 8/20/26 5:24 PM, Adam Skladowski wrote:
> 
> On 8/20/26 12:17, Konrad Dybcio wrote:
>> On 8/20/26 11:42 AM, Adam Skladowski wrote:
>>> Add a devicetree for the Motorola One smartphone, which is based
>>> on the Jacala/MSM8953 SoC.

[...]

>>> +			source-pdos = <PDO_FIXED(5000, 500,
>>> +						 PDO_FIXED_DUAL_ROLE |
>>> +						 PDO_FIXED_DATA_SWAP |
>>> +						 PDO_FIXED_USB_COMM)>;
>>> +			sink-pdos = <PDO_FIXED(5000, 3000,
>>> +					       PDO_FIXED_DUAL_ROLE |
>>> +					       PDO_FIXED_DATA_SWAP |
>>> +					       PDO_FIXED_USB_COMM)>;
>>> +			op-sink-microwatt = <2000000>;
>> This is inconsistent with the sink-PDOs you defined (5 V 3 A vs 2 W)
>>
>> Konrad
> To be honest i don't get what's this about.
> Based on docs it says its minimal W value taken by port
> and based on PMI8950 Charger it should be about 100mA@5V
> while SMB1351 can also take as low as 70mA@5V
> I could see it being higher when port is used to power SBC or something.

Ah sorry, I didn't read the docs and just guessed what this property
did.. 

Konrad
