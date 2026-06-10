Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D65A26A1A7
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781100928; cv=none; b=UhMdGBpPGD45yEfZ35y788e4Aa6gthzLZoNxN8XnFSUSrLB96eXoRndApjCbZDrSaIljExIXikJ3lYWjdQlytfbNO6HdapY5ri0NiQtT93Qge6ZEhEjV/n2OWbD6fm8J1eJZjvJYiH9vzdAoEvZQYq31EaaA0/EFrfAHaX53Sz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781100928; c=relaxed/simple;
	bh=MFXOZCdPBc0TVsd4Y2UVkvn+uoJb2263Pchu6fl3G0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqDBEU2AXMHi0C8pQ1SaR92vrX8+5t4oCQTGqU2jod0wBB2D7xdWFuupCYhYrne7tUPCEw6+DwQzTmD7ss2Mm/JiSwft1LUCyB/Cd8/1KCUL6IbV2DM/0MqofD+f3Q9pSOL1ANK08EDRdJor7ELspYJHFm2jiaQdcsMJhOQrNK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a6qg9sbM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FT2hiE7I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a6qg9sbM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FT2hiE7I"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ACC99N1600600
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 14:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UzmvbhO3ccLAFDnidWjn0AfYFzvf4Vav9+7SbxX5aQg=; b=a6qg9sbM49qI90pw
	IajAfxYbrHXzoHWl05FBcfEy0O9Fj/r8+2r7WxjlzP7v6A8EVsmAy2oMZ5pUuSf+
	p4OFEywRpVdVGc3oE7w0Wl4IEzl5ys5cSJtsm6Vo7rL/t2tNc8pPQj4c5VQEEqnk
	7YU7pSOLi7y4fxGC0Hyb5MkWIzktHIl8MQWJMmAedKs5xRVDuoXaLLx5ptRpregt
	nZLGKzwQabtpKgusyZD16C53Azom27trOWeETj+zoOVTkYL6jY4iUX7wmAL3S5NI
	Efbvq301aWIo67blgCfb0NXVAFgUEPeQS/WBWXFylwhZgGAdaOXgVe+CnDUeIJ8A
	ok78wA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq1tg20j5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 14:15:26 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-963b744b61cso6283341241.1
        for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 07:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781100926; x=1781705726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UzmvbhO3ccLAFDnidWjn0AfYFzvf4Vav9+7SbxX5aQg=;
        b=FT2hiE7IHhLq74SM4xmI6jQGSWHAphb3tueGkwRXNEDYmVB6MiBQVWcQWYivuDD8GZ
         bk4pyimS135eTAvjvkmpJGz4hHt/WA8ZwKQ4cNJGk3OxjLmZxnoysdrY9RC4bl3bf8Sc
         ZNGEqfAcK+hEpnlxrkwZGMcXPhhnyZXF4r5X5Dbzfq1CS6eXapqehAg6YvgMrHmz34uN
         3NvzPb4xkVwNOh1wSSngKxOZBfQ7YxJMi5RfLRDZYOabaX0Vq/4G3RHyBksS/wYPnxxR
         LtDw9Sq5W5U4Uit/7CbGcLVt7HxFLz5xyEOP/DjFWNtuU543MdTdh2WXoAItd7s7kzTO
         NTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781100926; x=1781705726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UzmvbhO3ccLAFDnidWjn0AfYFzvf4Vav9+7SbxX5aQg=;
        b=c5KFyOmfm0lRoLa070MpIhV8tg1gE2qOLzMD6xHehc8Pqng2AdyUe4kxasx+jkeBrv
         FazOgTRUQu7fSCoFmR/vugtvcJIQvLWrhe8aWgWnMSBgcwhS07tYR3aAThe2SlusBXK8
         trGGUi1xgTAsbymTlrJPG2sfcEC2H/WY3M9qOw0OrdT4M76Qkm02BFXhVhCTLNJwfl1T
         OsPE5Dn+qqd+Nayw5EVNP/sToe0xmGtt9X6l4ZncGOIisOgKfLeJUktk+JGLH+Rjc5x5
         SQ3M7x8yOhyoG+LYbnJZoMKWhg0m9eiVvfzasYtdT+U9hKOTX7XNCD4iX2zbBYv6P51W
         s1PA==
X-Forwarded-Encrypted: i=1; AFNElJ9plnUzuDf+rX6hFmG7VP7ELly1S7EjwZsTIBt9UAE5zhDd3CinAqng40/C0OwtJIP+KMwDKvpCqFcxl8m43BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBE2G0e0PvnTsRvcDQrd0U1ryiDjg8R/Rmc9JWcDDi60XxSlrb
	tB55rVKF1o7UnE4oYjl1zMC+l5ysWK4J00XJPGm1IH38Kfj7x7MTAfFQr7T92Dn/l2GLYu1Oywj
	e9m1i4l0zRTCljpMPPzem2foySm8A37WntzbYq2PcWGMpdFQF98kPBIMPHhj4Z1xPWkjBxOg=
X-Gm-Gg: Acq92OFAbyrcAVi27R4PaE87LQ3jgPStJUAbylh6Zus9NxSqmnYYyqw1SIKJi1sT1ES
	f57Gr0QRgnWdB1MMpvlVWdyhj9TGjaItnpLXsb02+67K2cYr/AihVk2UtEOAAF2hY56rIwhvaWR
	ILJA/91QozKYgoiSgdTCd/SgEV9sZ7/oKOYVCfJXbKfvbe1dsqCnFjQWXxG9V4MmYANSmszK08T
	UBK4hSTFrwhAhSj9J8iXRyzdJcBrC+IsrUmJPzDeH3C+axE2FCnLkbv5OqEm2+sm2L0X0ZRS1XZ
	ojTYvakyQhZ21yZvYr3847l65Pf0Ls+Z7lf+9670gqpizh9cTZytLhPX+O5f/p2O2iry+vaQLi5
	hskCsGRFtbhVfY7aAVeiIvmGSlsb9jq7kzWBcJR4hyRBy4W/nP6RwbqYIdyqoi0vIw3gxmzJFs2
	UG5O5y6zwp9/q4B9McKPY=
X-Received: by 2002:a05:6102:6890:b0:631:ff40:22b2 with SMTP id ada2fe7eead31-6fefa60e40emr15357927137.2.1781100925765;
        Wed, 10 Jun 2026 07:15:25 -0700 (PDT)
X-Received: by 2002:a05:6102:6890:b0:631:ff40:22b2 with SMTP id ada2fe7eead31-6fefa60e40emr15357838137.2.1781100925377;
        Wed, 10 Jun 2026 07:15:25 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7f50:81e3:bfef:b418? ([2a05:6e02:1041:c10:7f50:81e3:bfef:b418])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcbe3sm67240484f8f.8.2026.06.10.07.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 07:15:24 -0700 (PDT)
Message-ID: <5105b5d0-16d2-44d7-9c9b-b6e982d7d53c@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 16:15:23 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] soc: qcom: Add support for QMI TMD cooling devices
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Casey Connolly <casey.connolly@linaro.org>
References: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
 <20260609-qmi-tmd-v3-2-291a2ff4c634@oss.qualcomm.com>
 <pyt62qpa75nzdatp5xl7vcqrdzmrzsf5ethw6wq62bzg6b7qtv@ts2v53im4bos>
 <33fe758a-a733-4f27-8824-3dff398e1cd3@oss.qualcomm.com>
 <awmoxzmrgqzot5yfwpoml2olntpultuguuvdfvk5mt2lxqjxqj@n3tsmix64fdb>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <awmoxzmrgqzot5yfwpoml2olntpultuguuvdfvk5mt2lxqjxqj@n3tsmix64fdb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SRm2diR-kHf0vM1arlp7VtQVfNxF09tL
X-Authority-Analysis: v=2.4 cv=dLmWXuZb c=1 sm=1 tr=0 ts=6a29717e cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=duYTza_KgoU2j0Zg4FYA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEzNSBTYWx0ZWRfX6HWxPrEfdQIV
 EktFbaZO6MxML821eVNv1RxzOBfC4+TTkna/Yqs/Rrs96WQSTU17t1bRzxudWeJMhG1c3cof4jd
 xQ2JCDmhwgseVkXRd0AjlJkNXKHbI1lSpRo6DSbnoinefTPngjEANxn7KxNS3QZLGvCV4XSpgbj
 v7gg+cx7egX55SEG6Nt9y9KGOZypPqeIyJW2eASX9FJtOcUDg70B/A0m3irCZ1Ld8tROacXqE0C
 kvDr37iPT9FJV04kPNBEvLtAyvow5+WgXwjxZlxTJEClJmgmOWcIjwEuzRBKUExTpIiv3Cr/w58
 LrpfNzujKpw7oVXzYTrOPH0IwLVnTDJhyc0031gfDKqOCOH4/z91KVOVgWdLdP5hZo7kvjg+tZ0
 yCG2Vdgk8nQMhaLgD4u4bdVieJonLM6XRBC0bawzYXQspGxfYIKS4lYAvAkrMjEu6kPDsu1ENTX
 cb6cGpMXGGDiOZoCz2A==
X-Proofpoint-ORIG-GUID: SRm2diR-kHf0vM1arlp7VtQVfNxF09tL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100135

On 6/10/26 15:42, Dmitry Baryshkov wrote:
> On Tue, Jun 09, 2026 at 02:08:57PM +0200, Daniel Lezcano wrote:
>> On 6/9/26 13:30, Dmitry Baryshkov wrote:
>>> On Tue, Jun 09, 2026 at 03:52:57PM +0530, Gaurav Kohli wrote:
>>>> From: Casey Connolly <casey.connolly@linaro.org>
>>>>
>>>> Add a Qualcomm QMI Thermal Mitigation Device (TMD) to support thermal
>>>> cooling devices backed by remote subsystems.
>>>>
>>>> On several Qualcomm platforms, remote processors (for example modem and
>>>> CDSP) expose thermal mitigation controls through the TMD QMI service.
>>>> Client drivers need a way to discover that service, map DT thermal
>>>> mitigation endpoints to cooling devices, and forward cooling state
>>>> updates to the remote subsystem.
>>>>
>>>> Co-developed-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
>>>
>>> Wrong SoB chain.
>>
>> I think Gaurav wanted to reflect the changes did a back and forth between
>> us, so I ended up in the delivery path somehow. I guess adding
>> Co-developped-by should fix the SoB but won't reflect Gaurav and Casey did
>> actually most of the work. So I'm fine if we remove my SoB to fix the chain
> 
> Anyway, Gaurav's SoB should be the last one (and it should be preceeded
> by the CdB tag)

Ah yes, right :)
