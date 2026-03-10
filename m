Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E2A28504D
	for <linux-hardening@vger.kernel.org>; Tue, 10 Mar 2026 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149946; cv=none; b=t24aahg0QiCrrlc0EcAUA3L14uzIwmSKePtop2UjYP+9n98WTdLjFAsTexCxXnckd7eXv4cv1pplHwpyIZFmaCpoGW2qT8SNTsFjjE8lgn1XiwhIbaGyiBa6iUJSFnr1t0TBiQ3aL8B4BmbgAEkbYWwlWj3uJcxurqBNbiFtmSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149946; c=relaxed/simple;
	bh=U5+C4XzzSEp1A0Qa6KbgTHyEJkguOrx7+aMNl6kFp14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HLufAKNJvgrSJsYouj52fdK7i6MP7VaUY/vzAsOIJNRidiqVfYQxzJK+CGVV7abD+J5riZzqVsHBW0AArT0lM534UsrQY94O7U+vg0j/vs4QN89Fwf8BXhv674vuVs/baAvbsBHzblDx1jjKmYmacZ0iT8D9YqC3OiwcdSr9bIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SQ7XflP+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WNM0ItMK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SQ7XflP+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WNM0ItMK"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ACakgs3760404
	for <linux-hardening@vger.kernel.org>; Tue, 10 Mar 2026 13:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mU6kQQov9ZoFh1/gT9EyHRCBhTtwnZxhMmWTUAb64bE=; b=SQ7XflP+VwtbkNjy
	fI82Md6zPhf2NeT+NSsi2xpZvmZsH+quF5rSztiiNGHu3E1Ipvsi3undAYyxvP0y
	40EZnMaPW+2QPJhhw6Ygh9Cb2eHdmjfUFMdNlBGroLpntGJJQFI91Te0mYNx+TDI
	dVVKYsw0dPUaTh7IkePIzUf1X9WRqZE+OQjls0ClomqcbOZo3OoO2O1By2Q+Q56F
	Q9ZkJhpdtNAPJhpDymbNOUyxVJBaSNP6WTb9PZhZwReTvkymsHrx4KWQysj1xlvX
	UM+6QiDhgkuTl7zXH87hQQjpM2DUD1v4gjfsdaVcRoMBLTzzO2rpC/1461SnS7O6
	OxCqZw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctk8ug8nf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 10 Mar 2026 13:39:05 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd8e89d19bso114575285a.2
        for <linux-hardening@vger.kernel.org>; Tue, 10 Mar 2026 06:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773149944; x=1773754744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mU6kQQov9ZoFh1/gT9EyHRCBhTtwnZxhMmWTUAb64bE=;
        b=WNM0ItMKZI0OgZTLChmOpbEFmdgsCN/ny2SJrodWvZ5fIMMfYZmqa23zhynqCa68xK
         M1V4JtSX4lHn6ro82aqbL7hKDv1Xsmc+KFPfv2x3TVddRxK4p2Zk9CmRj07atY1EBro+
         adA2W9a93AJwxi0k4xnpUcRZorV1qOa7jSTe904+soa5lTPfqKZPVZEJF7qzMuKebk7G
         d6ZjPvjZXunEYBcPOJ4JR6ceQZ0q87OTZA9IzLGfT8x6PZ2sKlFgtuerkQYjo7AIku9t
         kIwMe6QZBET8DH6YlrRYhciFj7G+gX6bcNe/ck2wMgMs+CvaFOVmBx2yflYGOtuP2n11
         PmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773149944; x=1773754744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mU6kQQov9ZoFh1/gT9EyHRCBhTtwnZxhMmWTUAb64bE=;
        b=PxF/VR/N8+7aO71NWe76W/1T7aDFPgfxnnau/Aq61Ck2NroZtlL9j7Qbz82FKEMZ1t
         TAJat1KLux1kakBM68jrFy+5/LYgL0KKmoMpR6a/3Pzacrr4573KuJ/kgVukWUPhL4S2
         u/IYS2s4BR6QwcTG2QRs5HBGXUvWylfidWxnWANANaY/rTkgQvi23jNF857YIoz94eyV
         uP+GQmXWQVz0z0QEq10e/1jvDGLAe5Cz4Y+Y3UaQ9uULAmd6RSS6IpMfXgoXb28SugOn
         BPaRIssttmef89C7Ad9+nf+KX+DfgLgTS6yzHWG6xVmSf13KzrN59tO3nzVR8CuEFywL
         zyBw==
X-Forwarded-Encrypted: i=1; AJvYcCWq2cwTvCOro/WnMNoH2KkBgJwJ6Wr+xSQfvxU2yEoLnweN3/gqtcXVRxfLa0G+vkSmm4DWJW2G1RQR4mNnT/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbAh0yRCSfFzrh9vEXaZ3LEYxgqtFxQDdUex3gH5zBe0r5hLY7
	1g2h94/PWyyvZydZwetL5C8NwRdx8vj1RO1AK0ewcKk8ptAZglaTk38LpQ4YSYCZdRtzbq/0HCn
	9n/ylqveMOT2ZIqHYUqYMR4Az5X4zPSc7eyUD8VW3YzKbGdas5LWPU+iSBwlaACiIOva9Q4A=
X-Gm-Gg: ATEYQzwsjIXuTBpMCYeRwL2nJxth9FThR3qKbNt72e5A0dgzrsGgxWQD5etd7zF0Mxd
	T/lalFupUuPaUqAXkIHEX1LMNVlT9mSAVagLp+m1mlOtECinGCgy/Q/51K4rn3HbgqlvL8MZeFX
	Y+WLrhXUYHgQsUKGvwPhQfwIEhkfcKMSm/V9pBN4NLwpLLS66XWcJeZbG7zwszUqfSwxme6DfpX
	EZPGzb9323Vp4Hp1fUNq2TM3mPG7caSwExbhF6sZ8Hh6BtPaFaTiF2t+RvnDZZIrxZyb/d5HKeC
	IAns4odTOeabs0Pw96qSIlvsU+ybTTFMxkq+m3l0DZPpk8l1aGT3yMQhm90lqcOknrdiVxdKwlt
	/TLLlpMBbe07RwH68cCJomrgTDTmhIR/83T/6igdLzmY8HS9K6SEd+Ft1q64i46UuGXD2TsPrqg
	Qp/RM=
X-Received: by 2002:a05:620a:454d:b0:8cd:8ee7:4473 with SMTP id af79cd13be357-8cd8ee7483emr512454785a.4.1773149944391;
        Tue, 10 Mar 2026 06:39:04 -0700 (PDT)
X-Received: by 2002:a05:620a:454d:b0:8cd:8ee7:4473 with SMTP id af79cd13be357-8cd8ee7483emr512451285a.4.1773149943836;
        Tue, 10 Mar 2026 06:39:03 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942f13a3afsm488250266b.40.2026.03.10.06.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 06:39:02 -0700 (PDT)
Message-ID: <f677e96f-2d7f-44b9-b06e-3d184777b50f@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 14:39:01 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: qualcomm: usb-hs-28nm: use flex array
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Rosen Penev <rosenp@gmail.com>, linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260304230636.27808-1-rosenp@gmail.com>
 <8d7a25e8-3af6-4adf-bcec-394895519bea@oss.qualcomm.com>
 <5bcef6ea-e83b-47c3-b75a-cfd13e4073c7@embeddedor.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <5bcef6ea-e83b-47c3-b75a-cfd13e4073c7@embeddedor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0Z8ety_wXMnp_J_lWQQXiWWDThlMWL-K
X-Proofpoint-GUID: 0Z8ety_wXMnp_J_lWQQXiWWDThlMWL-K
X-Authority-Analysis: v=2.4 cv=YcmwJgRf c=1 sm=1 tr=0 ts=69b01ef9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=VKeVQuaD_P8mbeh0caAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDExOSBTYWx0ZWRfX79NL77aXVvoy
 wdylz4lXzVlzS77+rSfwGqmLcRH3hLg+lWHKfui99EpM8Kmy8nLHcjM0nHWTqBomdQU4CPMCT9P
 R7dZ4t72jHps/IgbY5++ACv5JRiE+nuS8xMNUbyThP35JiGuYzUgwWprOtICOWliHAPkEtXm5f7
 AJL3VDT700OzwAsDYzNdlRaUpnJYQ0938Jpi88Pgd0fg1EDumQ5Jzmv0YDU082032g7oLF/ell7
 c50LG7eHemHAhUvUzF/tCZIij4JRn8K1666RXodYp4PZBVEEguRbYRwySPKzOnMlUSwv9RQ3waV
 QnOtj/I9Bi0HXEqdYoIaEobxDijxsxlhPixWP6BislwlhTHgBzE8Wuo59amve0ZbjK1nvPZB6+f
 OTlxVE1YOd0G01n0d10CpXPymaY6m7MEZCG7va/7tl4paRXOewfpYZw3PGDCwmXmyTdCDtKzKv3
 805wvBFR2bmMk0+MmyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603100119

On 3/5/26 5:52 AM, Gustavo A. R. Silva wrote:
> Hi!
> 
> On 3/5/26 19:06, Konrad Dybcio wrote:
>> On 3/5/26 12:06 AM, Rosen Penev wrote:
>>> Allows simplifying allocation to a single kzalloc call.
>>>
>>> Also allows using __counted_by for extra runtime analysis.
>>>
>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>> ---
>>
>> I don't see how this is an improvement - __counted_by() is useful for
>> cases where we don't know how many entries there are, but in this
>> case it's fully deterministic (as priv->num_clks is a compile-time
>> constant)
> 
> Will this always be the case in the future (entries being a compile-time
> constant)?

While I'm not high up enough to make those decisions, and if I were, I
would very much not be allowed to disclose them, my personal prediction
is that we are probably not going to make many more 28nm chips, if any
(see filename)

Konrad
