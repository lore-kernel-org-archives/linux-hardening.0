Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32752234994
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777298698; cv=none; b=n6SD+pFf/ttvQOikYA5Xc7Nexe6B8DCEL61YZ2qeCK91PfIOfpZRiLswUjiTDlNHchfnIS3pR93U5S/hSzBOWrb8EDpWSEzFrUzn38JQkeKFo9YCszEKIexiP+d4E99djNhBXjhfszTpLv9azUsd0GXv0CXCIMt7onRX4VMAMjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777298698; c=relaxed/simple;
	bh=rnKDWblutbaVRN4OQavnvyRCkTcs5zBrEO+FDHjzCm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPj4HlkRUMIocKpMlQK45znGum5zKbD/Ropa6ZfSPOjtPptKiDw9n1iYwMvDBMiP80gnLdM9EENkgV9+oFpBXBNfjyCXtN3Kz4ArmHiWfV5TfhxqJGH4Gm9dHsQqgJAOLel5UErQwTOz+eykS7KQPoUyeZ/zzM16IRber6EUJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nNo9xzCH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zsx4jes+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nNo9xzCH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zsx4jes+"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RDt8Jj3639704
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 14:04:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HYPywVIvWOIbB3aINxx79NXY4+7xYBKmkbz1uIIb2OY=; b=nNo9xzCHqOdmO6+E
	9k18vL8QVbVC7uMwRJ1zadVdJisrlU51Bq7lDBs5BNKi79grrpoYv2u3kMzlAePD
	pGSJ/Rhhz7U28HdYMmJDu3EkqZTpmDhkkpFGDTVi4I9vrIxmWZyT7OVhFI78ZC1r
	Sulv5KAoVNw+VwYLTSIC8e8ANVG9clEiWp8Ss2Mpb0gb7plySfi+/EpINXk5P8eZ
	0Alkd5fQXExM61QxvvwIjKQuiCIIQhyo+68K0TsgmNIQpK00+A7WIQbJrCMpMor9
	6gFJG9OO2vaQLDQlJi0KL4jK5DcHU56yxTRq7s9sEIsHxMdH42lwMNWi4e+lN2wT
	QeTTUw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dsya02c7u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 14:04:56 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5ff9e60dd65so498176137.3
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 07:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777298695; x=1777903495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HYPywVIvWOIbB3aINxx79NXY4+7xYBKmkbz1uIIb2OY=;
        b=Zsx4jes+XmdRcPrYtFp4SLds5op6Og0jppqsmmG4fTY8FUnKS9WIqbTSdOKvqp4mwO
         Sji7f0pUn4PGG5P808eTsexh8gsuFGwga/oAKvAfWehN0i4zbaQgj73VHpEj7naIzUB4
         HbRtxwSJbm8bfOlOhN8qVLffXdF8cbVJzEb9g+dnBOMKRffArI21rFGMAcmvw07wByji
         472EJ5ZOxq/s+FqVQ4SyfB1gpp0kkC3vn9+YhimGnn+gD1eBWGIBDpIC7Q5odJoDUg7b
         wRjwYbvZMnTPVx2NGUM+NLMlFXUiMHb6dr0crCxHBmi9lN+HJ7YsgDsOEg5r1wQK+OaZ
         7OFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777298695; x=1777903495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYPywVIvWOIbB3aINxx79NXY4+7xYBKmkbz1uIIb2OY=;
        b=d+/ctVIj/H6SG8GkJvAPuIY3T6qIDVO2GgqLBm+TgAlZZ+0SIdY+jtdXfCFJ5MQwY2
         sMLeZdTYLQcl+MA0WfzPqndQ0ZRCSx7IyU92IZXQNRKqaJvxL1hWPeQ3VAZvhaFpYfnF
         O/mSPk7T909sqvoVvmA/vHtGl/ygXsSEzzlX1Ol3vqW0zja9Qkr1BTMDH7XjACyEfwhh
         byMYQASgoSLh4upcTKKDwb88jnibeMsGV4PnFtg47Im8AdPkM09mbw/NWWCQOCsvt3jW
         XOTUTyMe1/Y2TNZeUzR5O7EBUQLdkoszqkA9mPxXabcva1xemvjMD6seTCYg+Lj4MFyR
         o5DA==
X-Forwarded-Encrypted: i=1; AFNElJ9REiL9AaOnNTxEOn+Ztebqnpxkw16hhe46szKnimYP4lnVUg7ZUr/Vaz557/nczP2LLTDKQpoJ9PiWO38k444=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWkhpUrb+/XlFsRgyj0kKsug1dqBbHXe2dnf57kLuciTumQ6TI
	lE/2NJYX4DLmrsdPaf1q3nPGtYQypb4Ytxt/Ib2alJ1z8Jm5V1P3PiENt5kOOKJuGzLjrGX2X43
	iX4Wb58GQbDey8cmlFWtV45wU4F/LvGmVvuFNAbJD1NVOIbgG/p5AiJmK7zwJUJO5SSTsIl8=
X-Gm-Gg: AeBDiesBSlQEp4WknL6og0wkkGMlZcvx2T5f0M1gJuRYHhlNG5KrmtFKsAKaEQsxSU0
	qOmdFKE/R18h9ju9B+sJOKPyPEP5tED26TEbfMgmF+VBIof9XjWt77NevB6geKDT7rN15m653eU
	596dq/ZuxoWVF93vT8IBWtjIvLafNa6+tZFzMh6VAZKaYFvM4Eca1Iqw46elR7VPBw0wC6jOM05
	WEGtajfZ/4hJcNUy6pTjc0j3gPT4/OgaboZzZ4wVZ59XWewLpbtwKRRlTOv2GjzJ+cC3GMMkF3n
	RGLsZrYR9e94Aod9f4PUeQ1bTctj5NPskPZxffbhoisBbsipQ1oirYJ1tvJ69F1muWQCQRyRhKI
	JAgAQKBVSPwDRVzZrel9FYredZo+DKHd4N1r51YcT0lS3ZLOiRzGcYEU3GioH4lePN2/q05Ylcy
	HT9PBxIBZJsqaZYQ==
X-Received: by 2002:a05:6102:8501:20b0:623:52cd:4cb7 with SMTP id ada2fe7eead31-62352cd5657mr1167789137.1.1777298695384;
        Mon, 27 Apr 2026 07:04:55 -0700 (PDT)
X-Received: by 2002:a05:6102:8501:20b0:623:52cd:4cb7 with SMTP id ada2fe7eead31-62352cd5657mr1167625137.1.1777298693398;
        Mon, 27 Apr 2026 07:04:53 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba455926c61sm1100136866b.63.2026.04.27.07.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 07:04:52 -0700 (PDT)
Message-ID: <c145efc2-9285-4e2f-a9e9-73c4faadf15e@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 16:04:49 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] media: qcom: camss: Add PM clock support and
 integrate with runtime PM
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
        kieran.bingham@ideasonboard.com
References: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
 <20260427-camss-isp-ope-v2-2-f430e7485009@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260427-camss-isp-ope-v2-2-f430e7485009@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: uIpAl2KvhUha1RC5gAnzt49zvHouJc88
X-Proofpoint-ORIG-GUID: uIpAl2KvhUha1RC5gAnzt49zvHouJc88
X-Authority-Analysis: v=2.4 cv=DZEnbPtW c=1 sm=1 tr=0 ts=69ef6d08 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=s_dpPsJcIKQ2JMW1VggA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE0OSBTYWx0ZWRfX7h8D960aCy2h
 3vNm2m+XRMCKEi+Cfuy+mlSB9zdLGVrF1BBEirxqCce6yY9irxp3Nxf3ff1ggrc6NOEgooH05h5
 l6ZzfbumP1AZZwPugzPBIBb9ydHMeldP2IhTCJfPQ/xUFs1rVIAm8sszBZQANa36WiCIOichAVF
 gKwZWwuBLQCWecBEwvl/y9CYcXhp53hPDRhoJ3g4oCGmDXaBkPHhYOmfFJ9Cjs3opwVnqg4oqqy
 lFTZApSZvIKMSC6Rqj9NU60pUDB3Bpzj5QFGxSq5HhR2CeEf1ggDQU3LuxH9PlnXQe7hPJ7QeL+
 81lrptde1oXDjqpOg1vbZV57u/o+Huw6rUo+BXOoIrwCdyHLdl0T9dBbBWNeS8dFJzNxw17KL6Z
 tuX+zS7ytqIb06F971D6CVPTPXZsn2o/uz7f8vq7H/zcxxY82FA/bChV4/XZd2tGt2yFXbF54Dw
 HdSR5mk9f32ogecFNlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270149

On 4/27/26 2:43 PM, Loic Poulain wrote:
> Add optional PM clock support to the CAMSS driver using the PM clock
> framework. This allows CAMSS clocks to be registered once and
> automatically managed during runtime suspend and resume.
> 
> This is especially useful for global CAMSS clocks that are shared across
> multiple CAMSS subnodes. Now that CAMSS is modeled as a simple-bus,
> these clocks are automatically enabled whenever a child node becomes
> active.
> 
> This avoids the need for each subdevice to reference and manage the
> shared clocks individually. A typical example is the set of clocks in
> the top_group, which may be used by CSID, PHY, CCI, OPE, and other
> CAMSS blocks.
> 
> Introduce a small PM clock descriptor table in the CAMSS resources
> structure to describe clocks and their optional rates. Initialize
> these clocks at probe time and delegate clock ownership to the PM
> core.
> 
> Hook PM clock handling into the runtime PM callbacks to ensure clocks
> are properly suspended and resumed alongside power domains and ICC
> paths.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

[...]

> +	for (i = 0; i < CAMSS_RES_MAX && camss->res->pm_clks[i].name; i++) {
> +		const struct camss_pm_clk *entry = &camss->res->pm_clks[i];
> +		struct clk *clk;
> +
> +		clk = clk_get(dev, entry->name);
> +		if (IS_ERR(clk)) {
> +			dev_warn(dev, "failed to get pm_clk %s: %pe\n",
> +				 entry->name, clk);
> +			continue;
> +		}
> +
> +		if (entry->rate) {
> +			ret = clk_set_rate(clk, entry->rate);
> +			if (ret)
> +				dev_warn(dev, "failed to set rate for pm_clk %s: %d\n",
> +					 entry->name, ret);
> +		}

So this makes a couple fragile assumptions:

* there's only one "on/operational" rate
* no OPP votes

I would imagine that in the camss-is-the-bus model, the top-level
device would house an OPP table.. but we have two somewhat independent
clocks that may possibly have separate RPMH requirements for their M/N
number of rates, which could result in M*N-long opp table

Konrad
