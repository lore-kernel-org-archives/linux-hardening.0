Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5924C22A1D5
	for <linux-hardening@vger.kernel.org>; Thu, 17 Jul 2025 20:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752785348; cv=none; b=mfn7aK9KMgAO0erZfJQqAgRjQdm8wmPg3GSRxeh0elenax9wVlgjiOxTlbMt/T/zQOzoQPKWEqywecYIk70SPIEgkloUJ/hFDAzj2JXni1KsZTULg4CXJDqsH7DvhPa0DlgfiqUEZVl3F+KW05HO2MAgFRWB8/e7NrsbzrD2iLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752785348; c=relaxed/simple;
	bh=Lv5I/l69wbo8RENfJ/KSckfR2rUPD9dYes5xZ4X8ePk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l48nZCDS8kVRzoUcsriL8b57v7zgPmp8Bc4n6QxsJ2RWdNK4/fste+OfZzbZXFKCrIiKIjbG7mVCG9/0F2D3yb5fmbNShNweWbMutMDFZb2jUEmBDye5hEPW9BwZ8aBqSSy5aO9+WJwNLC8BB+NOe8Z8qOqCsTrmZgBvX5OAfCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZODzgaVF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZODzgaVF"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HC65ku025209
	for <linux-hardening@vger.kernel.org>; Thu, 17 Jul 2025 20:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9CmYaonQmugq/A4aPpsk6Yn5qRo2GpUcf9NGF+0jewo=; b=ZODzgaVFXqDSAbAX
	LfKxIzB6QdXDsZi4ImF0dwBp2TXCcsNhS6UED+aEZlPRNhtTx+6tQZOxmHlyQ0XJ
	86tClR2BvCALhvt9pu9tfPDf3zwmNgqvytEHRMKqmtgbWbLKHgVyoi2Vpq7U+Uzc
	mMcXIyQELPGgPM+V2jCUNQZVrluAeHsfIiJNfjNTr2Jkm9POmL2IatCpUImukDlO
	HQLhVpF0OAt0a5m42K7IRUhwjQCovePyH79Gg3MNkGsA05XbOIK8EwIjBqCyOHSh
	O2twmTg5nwKnFD6KIFiElguhTQtujDJFqbZbDtx/ylp2NW+CywH9U4iLLEe68oPp
	Mpg+1g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xbsqdawr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 17 Jul 2025 20:49:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab61b91608so3989621cf.3
        for <linux-hardening@vger.kernel.org>; Thu, 17 Jul 2025 13:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752785344; x=1753390144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9CmYaonQmugq/A4aPpsk6Yn5qRo2GpUcf9NGF+0jewo=;
        b=DpHPegerw5GvXRiwpDdOaIgYKanbMOGfVm6WmLCoehB7zgGtsGYV9yska2jEkcYeis
         8J71/OBjEEHF7fX0fR76sbIzpz4A1YQe+bBpzdMbXPfjjtBAyFbJ0DkhokmnJifmhSLH
         frzIlzYNqlhMmZYcMpx/5DQu9OCnhx8o1PhzTkhYD47AWTLWCo0CC5fS4UZTmtQFBrwX
         ZVGuJVc7+cIWfdVkG7IfOEuNZqd4yNZ5dLqHTDLP3JKQgC+zHveiXTydoUPAcVmd7iq3
         OXGaUZJECFjadzjut1/97Ez3gpFPB7RNhtPNaAUX1yL44Rde5REL21zsKD2NwQLx7Vuu
         HPZw==
X-Forwarded-Encrypted: i=1; AJvYcCXWXoVzKHJeaQxSDNMvGzPy3me8sFB8Wfx7q6O81cnFCL4gA/1tZKQtvFfxRrYIyGYsBT3yVUGa6ENYmRyncq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXQ2qg5VPmhqI0YzMsdrMnSw6LMwS2HFpQ/0EbCkg5ryk64HB5
	Ve8E9T0+oWc3md2R6ejUyL/MMuYf4YEAejsnIICHJrQzGGKfRqVK/3BP9/ZD6z0s3qMLmfmEqWI
	6X/FEN0DY7bEcGCKko4sVsMqw1CBy6x6O66azbCyiy7rFlmsHTGIoVosBBdYR4vgNC3sfTmE=
X-Gm-Gg: ASbGnctqpv5xu4JIb3VuVMPSblg+yEaThmPY4SlfXgLwG3zZqk84RXlMKekcd9OG18E
	o0kzoHSkI1vXGvSyVqRRUiayvR3bJi0aKJ+dFUMBES6eFdoUJFpgarnWMkpMY7saxSGteXbNjwm
	7BIvphJNccGOfpIQMhYRXDjj2CfsXHLRiNFLEEeAtTH3t2oI/hhWqhPEUp13GnSaGfi+b7GYmyu
	tSUJfhvezr3Sc1MzRCsek5TQJVqpaHH1CUXtHkds+bmILTP3f54GtGo7MARFF7dANEPaKj/tVpR
	b+3YeCLEe5vMF59TaieZ8Srwb4VKv5Judoy6L145koSYSUZ4RA1XM1Avcf2O2ksPfF21qOtka5p
	s8N44SQiEW40tO9EupgeR
X-Received: by 2002:ac8:5a50:0:b0:4a9:9695:64c0 with SMTP id d75a77b69052e-4ab90a8b01cmr59189871cf.8.1752785344083;
        Thu, 17 Jul 2025 13:49:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsdUOD63AuogKrskTaxBSHWwDEDfZBOoSuBlZWtt3hsMXZqbmo6AUjQ6EHFno6axLzFcjgbQ==
X-Received: by 2002:ac8:5a50:0:b0:4a9:9695:64c0 with SMTP id d75a77b69052e-4ab90a8b01cmr59189571cf.8.1752785343480;
        Thu, 17 Jul 2025 13:49:03 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c95246e2sm10463988a12.17.2025.07.17.13.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 13:49:02 -0700 (PDT)
Message-ID: <793434f9-7cdc-409f-b855-380be7a2b0db@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 22:48:59 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 10/14] net: ethernet: qualcomm: Initialize PPE
 RSS hash settings
To: Luo Jie <quic_luoj@quicinc.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Lei Wei <quic_leiwei@quicinc.com>,
        Suruchi Agarwal <quic_suruchia@quicinc.com>,
        Pavithra R <quic_pavir@quicinc.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com
References: <20250626-qcom_ipq_ppe-v5-0-95bdc6b8f6ff@quicinc.com>
 <20250626-qcom_ipq_ppe-v5-10-95bdc6b8f6ff@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250626-qcom_ipq_ppe-v5-10-95bdc6b8f6ff@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ad1hnQot c=1 sm=1 tr=0 ts=687961c1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=afnzvhLNFvO1QOecfk8A:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: GLPVlzjxtBDIsV_aNN0f47jf5B3OEdRb
X-Proofpoint-GUID: GLPVlzjxtBDIsV_aNN0f47jf5B3OEdRb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE4MyBTYWx0ZWRfX+Y34sWQzv+iB
 J1cX9YgnqfPq14qyCYuHpRKRo1wz1mcMz/c1PGxjM10oyFVvAd/R/NTcF/bwEyQjio4oGpSZEdB
 ZtFL4gVMBC5Nh+VsvauR9YBBSUsJkoNm5ErjyQ1K7PgiHwEiVrd36jHBTkJjlVDkNpmPzNNhNpe
 niAvplmKaprphqYGy55T9t0NvINq6MdjWwP7lYXPN5e3yFzN/niCc5kjF62RXqGmpoHM7P6/1cI
 6TaeRzRLEB07qMI+91KjyCPyroe7CEvHvInCX0AXeENZPwx7D4djBhp4tQlW8umqBV9dC+HUG18
 9p5clVwIaSsCNjH0FYQj7ktBgVrQ2tZg/AOW4idMoHeC6MgYD8uDi6NGnmbLn0eCALhzUa0nDql
 XWBtVAmDix9RwCxyWjWA+0o+CIQ2ed5nMOb1ZN9RuaPA2+4xFmBw6Ot3ActubQoSf4+JKwT3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170183

On 6/26/25 4:31 PM, Luo Jie wrote:
> The PPE RSS hash is generated during PPE receive, based on the packet
> content (3 tuples or 5 tuples) and as per the configured RSS seed. The
> hash is then used to select the queue to transmit the packet to the
> ARM CPU.
> 
> This patch initializes the RSS hash settings that are used to generate
> the hash for the packet during PPE packet receive.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  drivers/net/ethernet/qualcomm/ppe/ppe_config.c | 194 ++++++++++++++++++++++++-
>  drivers/net/ethernet/qualcomm/ppe/ppe_config.h |  39 +++++
>  drivers/net/ethernet/qualcomm/ppe/ppe_regs.h   |  40 +++++
>  3 files changed, 272 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
> index dd7a4949f049..3b290eda7633 100644
> --- a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
> +++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
> @@ -1216,6 +1216,143 @@ int ppe_counter_enable_set(struct ppe_device *ppe_dev, int port)
>  	return regmap_set_bits(ppe_dev->regmap, reg, PPE_PORT_EG_VLAN_TBL_TX_COUNTING_EN);
>  }
>  
> +static int ppe_rss_hash_ipv4_config(struct ppe_device *ppe_dev, int index,
> +				    struct ppe_rss_hash_cfg cfg)
> +{
> +	u32 reg, val;
> +
> +	switch (index) {
> +	case 0:
> +		val = FIELD_PREP(PPE_RSS_HASH_MIX_IPV4_VAL, cfg.hash_sip_mix[0]);
> +		break;
> +	case 1:
> +		val = FIELD_PREP(PPE_RSS_HASH_MIX_IPV4_VAL, cfg.hash_dip_mix[0]);
> +		break;
> +	case 2:
> +		val = FIELD_PREP(PPE_RSS_HASH_MIX_IPV4_VAL, cfg.hash_protocol_mix);
> +		break;
> +	case 3:
> +		val = FIELD_PREP(PPE_RSS_HASH_MIX_IPV4_VAL, cfg.hash_dport_mix);
> +		break;
> +	case 4:
> +		val = FIELD_PREP(PPE_RSS_HASH_MIX_IPV4_VAL, cfg.hash_sport_mix);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	reg = PPE_RSS_HASH_MIX_IPV4_ADDR + index * PPE_RSS_HASH_MIX_IPV4_INC;
> +
> +	return regmap_write(ppe_dev->regmap, reg, val);

FWIW you can assign the value in the switch statement and only FIELD_PREP
it in the regmap_write, since the bitfield is the same

Konrad
