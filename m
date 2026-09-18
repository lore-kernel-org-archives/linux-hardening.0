Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C414499F07
	for <linux-hardening@vger.kernel.org>; Fri, 18 Sep 2026 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718466; cv=none; b=Le6dQYnuNKNHnw7LdnjU5FBD7KlDEgl+c4NBBPfUrCiadgtXKLsys/2XHqj/9w3NagK01/HpZnEXKRZR1aayizhU+zV/S2efYh6PtY0QbXMMoLW/8aar5cb2MeI/yR1CnU3apQJCuLMMi1rHX/p9DFkRTw4qvDxfk0qQosTKLA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718466; c=relaxed/simple;
	bh=8+ZoiSE0QUXpLLvwBa7Gs5wfMdhLA1mfwYrQghFEgkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tKDHySEmuOyrERMQw/xdPHvW/GQ3CLJaQ0+0Grf0jcx8lHrqE8Jbm0CaXCYSdnIi7RVAkrbzdXJpVTHfMDZvLp0Ux8tkFZ7ZvaOlrWO9F9pkk1zInBLgexQkJiUMAdrDrFWIniwEThXuZUTBXj8MnpnhkLuTxntN6Jt6NNtQYBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ks9JTybr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eDsY1U9E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ks9JTybr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eDsY1U9E"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I60WkW021456
	for <linux-hardening@vger.kernel.org>; Fri, 18 Sep 2026 08:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QYCS+iH2jYyOJrRu1AhW0y/AISLrS+T3SnQPYRrrt3Q=; b=Ks9JTybrqc2lnucs
	y3ziplJwm7iDeWksqUsdq7pqq2FOoWFjLLJoUv0RogJDMf+Wy3lx7lec+DZERuFn
	vgMQX1b8LruQnv8O9dSG0MZRwv+LGG2tHazMqz+UnDy/y3chb6w91uRx+LuoPhWU
	jDKS7p1J5XO/1vTBGvtIYDmU79pzl6GAeZmVAqUhp1MshHYkroltMTPY3mWG7wEr
	s5e2fw79mMyDLXhfTBQ/7funrJyBNIdj/p2RCBjOCeX8A9ZBbFp07Wu7MXt8z34H
	Ey3k2tDtB7My/UwydZCa5NdF0XehRVqI8XsPKtV/LwNneeAIvFYM+xeJmBD2PPNf
	hKEJzg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grnqeauge-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 18 Sep 2026 08:01:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e661ce1dcso10457785a.0
        for <linux-hardening@vger.kernel.org>; Fri, 18 Sep 2026 01:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789718461; x=1790323261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QYCS+iH2jYyOJrRu1AhW0y/AISLrS+T3SnQPYRrrt3Q=;
        b=eDsY1U9ElvBRL7ngUZrvhZ59ZerneF9ku6KKoi+ooVRcaYy2f6lf63UEEi223ZHQCM
         8HXJBfsQYcnfoPtqY5cdO54M4ivUFYI+zE4blqtdt8j/brCbmmmsbFhAJiUP+397vwEv
         h7qWo/iwr06sBx5LJhRdwXEw2lCFFE6DGfw1JkPlcgiPWMVDitnKsBlXimxV6vv559rm
         XdDusqioWIKn1PPdAxGnUNbf8qE5dsEzxV1pJqRtP4qj9lQ15y4F46hGucMRFUcDweQm
         ZSnd7j7//T7o0BUU2BmKdKaDcOrKepkxihfk8hDQZQ1gyCHoxwqATz55GAy9i5LDaon5
         NrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789718461; x=1790323261;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QYCS+iH2jYyOJrRu1AhW0y/AISLrS+T3SnQPYRrrt3Q=;
        b=GgfjePcVTAnXxCwKxp9qvJPTOIW0s9/FWSuBmDtYaebz4akcqwmNfTnW3TDkFDpNl3
         JOVaP3kdeOZzy/z5doD9rRKtkiqAJMapVb8Ks809qoDkAsPRWUKijkEqIPRwNqkolvIG
         hsfmZygxMY8TqxTr7Zn9xVH5k7yIhyEsnQHZo8IXbOluSawUZxu4St4PzCUdOIeXUgUz
         d1zuXOb/+CEpl/B6G44e1OBj3TOv9JoQ9dFx0r9AerGYkI974QRXHUGyJLgz0bHr8hhD
         K0LnqpgPOppBozbe2AL6Q127T5dMKEMTWLXT+ch+gmKnR5OeeLqf3qg51mwet4eto8Cm
         P0Yw==
X-Forwarded-Encrypted: i=1; AKwUvByL97cQdHbiE7Ny2vxSdXwg0DxdFaeWnwBp4HErimmchRGsnCaJ/rBvxZR2voyr2PbA3e0loqqscwJEDttNCLE=@vger.kernel.org
X-Gm-Message-State: AFuF++kyqTVkamfmx3xOL2RARtcMM89AsYWwHwi4bq/Rs5sMSqKmTVcE
	4N4j35InAH0gmoQXR6rNAW6W0F52MmxA2SRm+gbEEPCO1IHUepw964ZKYS+dNSpdqaMUyAYaSvM
	NPdcTEJPgY8ykXh655c09vdq2LNKX5Kym7jJwZkcgK28aDj2OYUC2sP9U+q3gYwC3tzDeYmE=
X-Gm-Gg: AYBFou3wMVgq6zo9XaC4mu11FUNF3aFsQjZ+ZWt5sc2zHmkcEpoHz0K5xY1ozXPPgGH
	MBIt/sGyGBd/BdzMACNYrGlvC3K67TJeDYUgM1GE52qgtfx/BHrM6WHVJ0xV+Obu6ERV9mgLGUJ
	lA4t7p4RezFefb4PZunb5xJ63Q5lxxjWRLDZnudNn5n+4OMzX7vuO+qv4bsfaRVRh1BRU8Fp6F4
	eIv8c/XXSIXAooGTtQA5giYMNoFKGzs35qwNn2/dh9ljoGLXDMJg0CK2tZcaiJCr5e+Z7T3p4yu
	5oFBABMVdIWs9rFZnDKaaLgwFjjM4mLK/zB4HMbuXWRhhQ3ffk6zlF66FDFi5dg5dKCJP0fI5wr
	g8O/WK7CDwoGZe8pc97aIiQ==
X-Received: by 2002:a05:620a:6888:b0:939:94c4:b799 with SMTP id af79cd13be357-93be074c4efmr151696185a.5.1789718461088;
        Fri, 18 Sep 2026 01:01:01 -0700 (PDT)
X-Received: by 2002:a05:620a:6888:b0:939:94c4:b799 with SMTP id af79cd13be357-93be074c4efmr151692185a.5.1789718460747;
        Fri, 18 Sep 2026 01:01:00 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a1bb45b0fsm30000666b.35.2026.09.18.01.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 01:00:59 -0700 (PDT)
Message-ID: <8d32cbea-fd17-4f3a-aac1-6f44a50205e7@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 10:00:57 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: qcom: tlmm-test: Add const to reg_names
 allocation type
To: Kees Cook <kees@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: Kees Cook <kees+treewide@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linusw@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20260917211009.i.312-kees@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260917211009.i.312-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: djCS0h3MMKkVHYeeaHwvohFAXRbz3_2E
X-Authority-Analysis: v=2.4 cv=FfiiV5+6 c=1 sm=1 tr=0 ts=6aacefbd cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xPH-2WeAMKhyT3qgJ8UA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: djCS0h3MMKkVHYeeaHwvohFAXRbz3_2E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEwOSBTYWx0ZWRfX07ixYtvdofjA
 HFHtOVVWxc2lKGvFEa+5t9g3zxm06zTvxNO5n1d2Lp5YvGesL+kJMncEoBTN798fMYnZ0GMyXsg
 jCKjYSaow46qjO/TThBIpEhFY947Fo2Rilv5YZi2SMcjwaRqFsduiT9O3yGOVoao+uu1vpNSoIa
 j/N39P8Vy8S1wmXutPztLxpAoYDl3YzswW6Vgn+u3/MZoqJyIiMpYO3uEMHzHFwZcs1zDdm/+jR
 BiitCxlHuYCdEP/8H9sVdWP0tDcslEbC+2ffY/wDohzTZNFHdVGcjUBZ5MgWQMn7RR57bpYCNKd
 tnLtOvpg29ShqtVhyX2njwU4EN4BnGB7q2eF4o6oM6N5puJU+ohw6KeWOzu3lUSMTeaTg3w78zu
 2GZ7Gv1TNBnaQNWlOLQhzC7vXA7dwjv76OfzUCe+AiKIHJwgml/vG2kBE+3NZaDdwndBuFXBTcL
 /RqjbQuMyD5nOKg7P1A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEwOSBTYWx0ZWRfX8kmzfxAmzo6F
 y8LgD8rDST95QZoxRBN+UeACzFTN31KGsHXbsZ5Zx1dina+4vVLni9JoDryT5jtMc0ZpgQV9KRg
 9Et1KDQ4CrsefSb9la7C1H7KbpnFfQk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180109

On 9/17/26 11:10 PM, Kees Cook wrote:
> From: Kees Cook <kees+treewide@kernel.org>
> 
> In preparation for converting the kmalloc family of allocators to the
> type-aware kmalloc_obj family, we need to make sure that the returned
> type from the allocation matches the type of the variable being
> assigned. (The kmalloc family returns "void *", which can be implicitly
> cast to any pointer type.)
> 
> The assigned type is "const char **", but the converted allocation type
> would be "char **", which is the same type without the const qualifier.
> As there is no general way to safely add const qualifiers, take the size
> from the assignment target instead. No change in allocation size
> results.
> 
> Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
> drivers/pinctrl/qcom/tlmm-test.o
> 
> Assisted-by: LLM coccinelle
> Signed-off-by: Kees Cook <kees+treewide@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
