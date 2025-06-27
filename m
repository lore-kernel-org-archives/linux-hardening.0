Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2771C29898B
	for <linux-hardening@vger.kernel.org>; Fri, 27 Jun 2025 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041314; cv=none; b=kCVt4dU5xT7Tx6fYNjrfQZUHkzgF8s/V7+8+aVAmG/YB4GzcejJPmFe9XFN3NGOQcCzEilModFuL2eka9bkZ0vJ0YKTR9NHLCBLhGIXVUpz6BgLU3zph8Fb6CsaAMAkN73MraTBhSIfx4R3ERCBEIDU5mXKN/7hRmDJa3Y5Rd1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041314; c=relaxed/simple;
	bh=30vgKdy5n94b1DNeLRG5PLw2PPMa/I/W7Pqq9Wsa51w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KL1+1E6rS200xAmrDMAWpJsgbNxZTWWHi8VHZLjeiB8HZDr8l/2zxIjo/TKFcgeIZgq1fIDcG3zY/ZUDROROH3bD3sayYWVgRu7CsCNtKANVbIqozMHrbgFDlR0Bj8uXhd6iJaUad+v2qBkB4zVx0Mm0zMnwPkSsCbo3a6DCdbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TBC50qEi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TBC50qEi"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RCXtDN011216
	for <linux-hardening@vger.kernel.org>; Fri, 27 Jun 2025 16:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g8S/q69+hMXzlKm1t8hoFvS7fzscnXnzVXeG/Aysk4A=; b=TBC50qEikpNwSDDm
	cBrC48K85w4D7KXqQRgKZsP8yS5P+ij4btN1s5LjIA7iIGixJK+TmreJKYmAeXaG
	IGi7CrpzqKey8wweQalmj7GB7Ht6M4qMPx0CGiWFfhz7LHJmV1NqfDlk6zgIz5p+
	y+ZxXn68Pr02GC/PyLKaEcw7c7b7jYByvSzfB+b1rZvOb509kss3Kmv0KExAzFUV
	mhLa8JgaZ/e/zP957DD9sHeIeehrDk+Xz1a9Z1McSVT6e3FYCFPRroe4QpBu15Xr
	mOWCIbSF7mKXCUWjcIu6iUxA6l9MwPyx00idDae+RTMuTHjODgkZFwTUINcg4Y2M
	9mN1tQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f3bgqc8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 27 Jun 2025 16:21:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d21080c26fso35917185a.1
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jun 2025 09:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751041311; x=1751646111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8S/q69+hMXzlKm1t8hoFvS7fzscnXnzVXeG/Aysk4A=;
        b=MgOxIjMxod41Q2sMRMbFJbJUmwblEx9RPlWL53udb7M4v1T+esQy8bEVDF3eravd95
         PWnjWtJogJpmrkjVJx8BhIsIP87e4MKJQIZvrynqX3XJGuyR0zKi4NKN9PywA7XQo8rR
         5OI+EzXI9bHIQuP4PM7d0TXiD+EINPg18YTjmUq2G1AEWDwozC3uQSm5RulRWKvWjlMu
         zw6oswxVgPo+rqzy5clm1O/7AhNhQUa2VX6TJivxFw5GOBD1AZbEKjyO9CIY8w6XDOpR
         fkCE+bzy7AcZ3pBYiY+WIKFZSSCwcbM8BfHYVIUF1ERYn9idSVUy5F/3xjbHQG5xjIHr
         j0MA==
X-Forwarded-Encrypted: i=1; AJvYcCXu/cTRed3h5uRxnfDjAP+I0OEwr4cM05HK8q/9IPgXuFAIh3faj1+4EJPrP82gmM2Bvx3Xk53SJuM9La0KaWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YycgO7Vjtvl/Pt66o21/JjR5CnIy1F9gz8G7JxBLyzDFPO4GZDP
	TP04Oilq7PRxTQf06KuZXm4aMb4sxy86B28CC9nwLLur24aGyZFTnWxIh/4mVh0zzsbT+794lrY
	yShQKr/2tGylrC16GQQv9eVW798ezvCOKziIscGoqaM8Tys3UxZr3dyK3DxSTV3CnlVzIEvQ=
X-Gm-Gg: ASbGncu1vUzHLMPpJ3qA7w24bXjOPIXMmFLdEJRoaKdbVlWY6ND3SBuIcm0BERXrXGR
	TyZ6Vbw7Q5N3WW4tUcP58Wmb2suUfOfIG1EBpUEEwD8QIW+xKGfHyOFeymbNKUKsHxx3PAKoQ3b
	IvFV0kvoPQt4WpfGgFG7NCUrtgti8VtFF6yRQMAqLOPs9LwCqduJ4fOmEChxLlbuo+XY54ScMqt
	pCBzbV5l2ubYAE/LwdWp1zb9IIOwq+rQU2XSByShusAVVofAUgPEX8m9enW88Wh5grWSH0tqPd0
	UOG5qY+ArQ2R8AgeAk9UZ26HICZvjT/SH7FJOXcI6JvplnPkShnCN3bdRwVU28FuPswIDwCZdQk
	7WsU=
X-Received: by 2002:a05:620a:1925:b0:7d4:2901:2b3c with SMTP id af79cd13be357-7d4439b51a3mr212886485a.9.1751041310902;
        Fri, 27 Jun 2025 09:21:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1SPxuQsD4kZcYVOTyATUEwOXLUOsQYA3SYR1WoncAoVYNaaL5puLHJyjBBdfcBGSK7mKW7w==
X-Received: by 2002:a05:620a:1925:b0:7d4:2901:2b3c with SMTP id af79cd13be357-7d4439b51a3mr212884385a.9.1751041310357;
        Fri, 27 Jun 2025 09:21:50 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35365a016sm153479966b.57.2025.06.27.09.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 09:21:49 -0700 (PDT)
Message-ID: <4556893f-982b-435d-aed1-d661ee31f862@oss.qualcomm.com>
Date: Fri, 27 Jun 2025 18:21:47 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 03/14] net: ethernet: qualcomm: Add PPE driver
 for IPQ9574 SoC
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
 <20250626-qcom_ipq_ppe-v5-3-95bdc6b8f6ff@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250626-qcom_ipq_ppe-v5-3-95bdc6b8f6ff@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GbAJBdJPGtzAkF7ShopuNJU7m3YZCc89
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEzMyBTYWx0ZWRfX6hNVdPn83zGt
 vPMUS6ASWXOR3FmNwlxfotmOh7q4vbYzVFdT+NHRtr1hlE71iu5n5woaeolLw1uSrgnLbdF6vzp
 vMlMp8XluWhlC7e1Lz9BxL99pGaVinI7lNaQZBm+07qJARbR5p6QHJlb2050lBMnsZ0Is2BHvlu
 j/cRM0ExN5gWU0DtJUwY2+MngOwxm+0UpSflP3z09h8bbbsncm5kD4OlllI9PGbhPBFCqi6iL/V
 Xzx9VgLimS4q/6tLRnihrSVq3kQz3YdCvf2b6y5w6nn4SSqWtPCJOJDLeGB4hK8+FMMeB8hh/kV
 zYCfCsktMJxyGov5R5cxc7hl5cKOi/CRDxu1Wt1ocDBm7i5p/mrQ0IUSJPin3VcOgsJ8YGBtE/b
 wKw/ef56Xc6WxIUB7dqD1rSEXCog/Nif9vaIfhBiamSA93FeWxILHwlbrHIAmH2SWpwQvHfG
X-Authority-Analysis: v=2.4 cv=L4kdQ/T8 c=1 sm=1 tr=0 ts=685ec51f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=JRFc35xCpNCPHeNcAxQA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: GbAJBdJPGtzAkF7ShopuNJU7m3YZCc89
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506270133

On 6/26/25 4:31 PM, Luo Jie wrote:
> The PPE (Packet Process Engine) hardware block is available on Qualcomm
> IPQ SoC that support PPE architecture, such as IPQ9574.
> 
> The PPE in IPQ9574 includes six integrated ethernet MAC for 6 PPE ports,
> buffer management, queue management and scheduler functions. The MACs
> can connect with the external PHY or switch devices using the UNIPHY PCS
> block available in the SoC.
> 
> The PPE also includes various packet processing offload capabilities
> such as L3 routing and L2 bridging, VLAN and tunnel processing offload.
> It also includes Ethernet DMA function for transferring packets between
> ARM cores and PPE ethernet ports.
> 
> This patch adds the base source files and Makefiles for the PPE driver
> such as platform driver registration, clock initialization, and PPE
> reset routines.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---

[...]

> +static int ppe_clock_init_and_reset(struct ppe_device *ppe_dev)
> +{
> +	unsigned long ppe_rate = ppe_dev->clk_rate;
> +	struct device *dev = ppe_dev->dev;
> +	struct reset_control *rstc;
> +	struct clk_bulk_data *clks;
> +	struct clk *clk;
> +	int ret, i;
> +
> +	for (i = 0; i < ppe_dev->num_icc_paths; i++) {
> +		ppe_dev->icc_paths[i].name = ppe_icc_data[i].name;
> +		ppe_dev->icc_paths[i].avg_bw = ppe_icc_data[i].avg_bw ? :
> +					       Bps_to_icc(ppe_rate);
> +		ppe_dev->icc_paths[i].peak_bw = ppe_icc_data[i].peak_bw ? :
> +						Bps_to_icc(ppe_rate);
> +	}

Can you not just set ppe_dev->icc_paths to ppe_icc_data?

Konrad
