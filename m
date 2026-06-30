Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0249426684
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824189; cv=none; b=SRRPfpDM5t7NUabrxEDfUQNig1p6atRWEPWdlV+JnycVDVCVsMuB5vlmNwNCeQ3PG4Hbx+dxaSfFomW1pouKkUeUZAJKsWctaOkRDWCOOtRbGmQoSx7ofNWQMEmC7u/sbZIg3VFinlniR9ab8YN6xIr4Zoszl0y8AetJVb3wz4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824189; c=relaxed/simple;
	bh=3F+8SDZsklC3nLXz2X/RShSvYjQzGV473ZoM0mdbbvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QiRMT457pYeWmwx/LJrJ/4kFsCDVWply/jlraS7R3JSPC2gsrCkrcEinca9690aurgrgQFBMdDctSW1V9e9SY0E0QhkJAc/1OAQ6j256XmSHAm/Q8px/LDdlU2e/jgax8S6ZSiLmQMPoeV+DuYeD9BTTlurxWM1Y3UBDmHPoE7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YancLoET; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aSV1N+HE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YancLoET";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aSV1N+HE"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mvWF1605003
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 12:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	87eEz/XRAjsptTgfnRt9issLsRCzcTh5AkZ60gdDDAM=; b=YancLoET95ViIOoq
	I/99vdkGYQlyCxpH5G8SeSnj7wp63gcW96xAaPjnW3WtYhF8JJ+4sjsqNsSOnIFK
	rMJ0v6dPwMsdXe9Mw8hd/PEMiM6d0k0RgJEvtQz5GJeTgrTYbaOAaTtDWxy4aVH+
	X+Jgnd3z7HCfZMgiktY4mBiGlDq5O+tVk4+zw1IlVLd+QVhZSd81L8AjJLVPL9C+
	MiUwfa/a8krvO3mk9Rb8A4eWbGvxcxoR9upcrHNwcWrP1nEmxhtIlRyCd5G6R4fx
	jwCpl9u6vNt5s92zaAmjl87nB5lCDiHo0UXL1dUdFJE8qOZmJkhky6SP5Xh4hzfY
	LuirkA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f43vfjr8g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 12:56:28 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1857417aso220341cf.1
        for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 05:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782824187; x=1783428987; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87eEz/XRAjsptTgfnRt9issLsRCzcTh5AkZ60gdDDAM=;
        b=aSV1N+HEp7PWNFMySDZsCqVqZquSf/2mSdlb7WGHMSz0mzoPwai7/L1HFz7/mxk5Eh
         jPXciBC1lAx9Wqd+Sa/9/A5mzeL9tX/O7JjBqtu6dnpi2BckDkmXKWGzYrmNqQwX9naR
         FkST7WOoTwb3p8y+wt4SvPHTrB+UxveCgo+CVshU7W2PcHRiN67oIPT0XOgdrOEFr+K9
         Ecw0XZ2OggABTGqlYeKf4rAuMCdmJbRgr4NseRm5OhX+h0g4R6YyuRz0gRkacd//dFHD
         +t//oblmCfk2HEW1/coC15GT8FSVv4+s5sOLRg0pM2qfXSjdIPjjbtP/TzEDvHbWoQIR
         4UVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782824187; x=1783428987;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=87eEz/XRAjsptTgfnRt9issLsRCzcTh5AkZ60gdDDAM=;
        b=ILwej0BPvCr4ay6mRv+9n3RN2gCQVgT9JdrhFGvprEbQtDgz+3RNDOX4AbAx+3BsX/
         W+LYGssxeCDHLdXt/346tb3asQJU3iujHrRCV0L1erprldqA/TZTBCpbdjO6kTfukXbl
         5bHdletiUNLIFqNLhCeavqPjwLqB6fh9tcGheWPrmkd6G0HJJFwwmxpANoXu8dp7EFa4
         YK2JTz8kyTTkZ7CDBvvnsG8/CcPfRLiWL0JorBa2iq5kPVi+NAzcxzDFpbQcGhCBAU0N
         MHjtq92gFAofz0MXImD/hAs2wFuEON4SW9eokElH0M+vk47gakLrcPHDH96VqYnYIe5G
         J8cw==
X-Forwarded-Encrypted: i=1; AFNElJ8ABXSE9hwa/ropj1KUi9cY9prMXTYg8GfCGZNAb8rt6tW+saSJ8KXxmNxg1Xz/vhebbx0ygoY8SLve144oPIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/UhnFTp/F5UsDa+d7Mdg2ALLpS5ORpKjp2XRjuh/pn/RRS7g5
	dDdSvBpMnty7BJyDjna8VOMzvQl64spyTaknpcSw//WSumajisxC4RaAP9l6Bo1ZW0OZIcxUp/q
	xo9qIjEOCphfUQyJkonNws3HJEHKmxUjg5uVptQldbciqtKbbXx9gb9hYiENo8tmdY3L/xa0=
X-Gm-Gg: AfdE7cnK4rR+7b0z2qLn27VqnbRPqy+sxxIp0bNHH4NWEVgOAB3XnbUt6fyco5lcen7
	f0XPLMfRCojyBvV33qhs4vpytBsKQaLbD/bHPHCltacIuEUH8SJpbzNJagRAD8Krmc3dD8tO/Fv
	ND3bWxD6aJf+L3B++g00SD3XqcK3ZzjdJNLwBUh2Jq/z7eVSDu5TcKFfavVMinAWxn5+Jw/WCrX
	72EyaicjlpYWBK+UylrO0kTOdG4w3LZ3Dysv6UmlizOggwwMmvJdUjsy61icZnz1mhyngTLGcAh
	aU+lyDXU6+pPGyZiE/gJhjLdg/6GxoR2SvK8WCVQjv85WI8K1Hu9pEtietFRAZmSvmT5dUmygOz
	JRwcze1LjRcLkrQhtyoXH9jV6vIn3OD5LrtQ=
X-Received: by 2002:ac8:7e8e:0:b0:51c:d8f:d77a with SMTP id d75a77b69052e-51c1070ea79mr30011521cf.1.1782824186949;
        Tue, 30 Jun 2026 05:56:26 -0700 (PDT)
X-Received: by 2002:ac8:7e8e:0:b0:51c:d8f:d77a with SMTP id d75a77b69052e-51c1070ea79mr30011191cf.1.1782824186413;
        Tue, 30 Jun 2026 05:56:26 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288f0cb7csm119984566b.37.2026.06.30.05.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:56:25 -0700 (PDT)
Message-ID: <ae5d0817-5187-41df-89c5-0acded391fb4@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:56:22 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/15] arm64: dts: qcom: agatti: Assigned clock rate
 for CAMSS AXI
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        kieran.bingham@ideasonboard.com, johannes.goede@oss.qualcomm.com
References: <20260508-camss-isp-ope-v3-0-bb1055274603@oss.qualcomm.com>
 <20260508-camss-isp-ope-v3-14-bb1055274603@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260508-camss-isp-ope-v3-14-bb1055274603@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0noGN30n5bvsI7-2ji6Z5KNIw00yqMDR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEyMCBTYWx0ZWRfX6/wI2zP9n7mf
 dfUDugbg8RVG2od3Ox4VIdFibWv6vguYii/1l3lyRSp2t8t0L3N0FUjmEntV/pEDLK8ukNggjdk
 uDCDulYrwY6LJQJllrmsha9yXMVu0DWB31Iy9ncf4qYhD2W+rzOAPih1u1F1DqISJyltS9jgn2R
 eV/ssuG0ySm9ZPZSGhuEstvaFPJIvYIcZZL0ayQL6RO//OX9Vv4aDkIcNnysINAPqh0IpZ/s9zg
 AUz9M7y/DrvZC7102AQAEtbgnx4yB7keTlZ8TUVJU0os2oISW0q6q8Va3zg/Bsyqn40PHo+Zx/F
 ZVnt2zDehP69955kgK/RuMrYtd6sANnBB/iWHkD2HW3QKpXaC3UQD11VgzaJDhApPOGlRQ6aDO1
 NblnZUOOi6csnTyaRSFvCqbiSovCqwiq1W7wl2cTDMfLhUn3U4MPMzMhGB+Wv0HWHT9K+LXmT4a
 qsIP6BJS/ckezR3juQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEyMCBTYWx0ZWRfX5mhTFlkknCei
 wL16cieA23Eva+kwn7R6Fyvj+zk/qXdEEZvNc4mqv10vBXIby/8e8RL2OhWpcuJbhB3yqISYCnD
 HIyfNqLD+GOqqtXPYtChURuzNiHLrRo=
X-Proofpoint-GUID: 0noGN30n5bvsI7-2ji6Z5KNIw00yqMDR
X-Authority-Analysis: v=2.4 cv=PcXPQChd c=1 sm=1 tr=0 ts=6a43bcfc cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=J8mUrxzbJwspoeTAiOAA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300120

On 5/8/26 12:49 AM, Loic Poulain wrote:
> On Agatti, the CAMSS AXI clock is not managed by the interconnect
> and defaults to its lowest rate (19.2 MHz), which is insufficient
> and leads to throttling of CAMSS-related traffic.
> 
> Set the CAMSS AXI clock to a suitable operating point by assigning
> it to its nominal frequency (300 MHz) as defined by the specification.
> This ensures correct and stable operation while leaving room for
> future dynamic scaling support in the driver.

Now that I think about it, since the clock is already consumed by
the driver, can we just put a set_rate in there?

This will avoid introducing a point in time where the DT has a
suboptimal (power-wise) floor mandated regardless of what the driver
does

Konrad
