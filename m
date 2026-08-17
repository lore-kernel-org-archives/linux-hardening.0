Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0DA42EEA1
	for <linux-hardening@vger.kernel.org>; Mon, 17 Aug 2026 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982357; cv=none; b=EHbd945LVdzHr7A9tq4GHj+mLZQzWn6oCVpKNnLqTLREwdaVG2axlCwq8AHSLYbMGD+DgtlFYjwLniCcTRdLOSb9sAaCmz0He42niCTCrqIEPOSD06SbbfDCNNaWsTHwZPiRDfJv9hZSgnpzK92jpLYxA2OP8h+jg5t8LQyG4Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982357; c=relaxed/simple;
	bh=aaH9lbVuJj0q9BWXv+5Hkwn1QmGhneskXi8mbAoYU5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PrrextmEDlkPjBs9uqyB+9SpFRJ6588VLGu/1Nx1RVU8DGNOqdCm+J38vUwt0DSafvCf71WSsF4nLgvf4xk01Khod8ojeQv4Rc7/zs8hQfhLvhMQuqETvkHsyG5uc1dkZE54z1nfdEHYCti5giZDTFAQIH/WNvh/SQmzq+tJgss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IrcC47oC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RtJc7pAo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IrcC47oC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RtJc7pAo"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HFYk903082133
	for <linux-hardening@vger.kernel.org>; Mon, 17 Aug 2026 15:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ACldy0aiVSHL8k6IBZhXMiInAvqs3SiE9+icRfANvIU=; b=IrcC47oCgczwrEfb
	ooUgjXIwljq4P96rWO2Noz1JZFvdyV1g5px+AImCT9D0glgVslNnjj3KAl7eBeoH
	RCEWKameg6JQF+lUJE/31LASyusw9zGQOcAH4o1JM4BmWu0pSM8XOajJpu0KnvZ3
	VJa/jjzjWUBBinjWXOevcpau47jXXHQh35AyMMJPWANFnGOkezLRIgKBX+1qm6h5
	7V6vsNHbS5W8fInJ7oM9kAWZQ4ilQF9wd4N6ZZNcrj6I5CS2d+oWq+9YAJ32PCxH
	+nTxibx6e8geu8a+tVK68JzQYpmHlF6AK+hTZshyQUnDa6aRGwKIF5a4i5yZxfIY
	iWDezw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3y779p8s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 17 Aug 2026 15:59:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51e9d892f0dso10473081cf.2
        for <linux-hardening@vger.kernel.org>; Mon, 17 Aug 2026 08:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786982354; x=1787587154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ACldy0aiVSHL8k6IBZhXMiInAvqs3SiE9+icRfANvIU=;
        b=RtJc7pAok8/kblbs2+zKYDshMELhhdXS+lUDe16yI/VItG5N1/bcAE4aHvBtrenjVE
         LoiStEnnnf1qITin/HpBiO3B830ccgUa410qRyuGCza2l8+Nbqn/QLFbcP7oNdbz2k2Y
         6VOs+5nXQjl6ce/oLry/e9csQm232DZPpxw4XKrka2rqxPLYSpMi53ywinaFBUdg9jjS
         txm1MxQG8JKBaXSINrgz13RGm82gDN8PIwm3lXegsVNxQ14bHVkJB7WF4Uzc9WRkINPF
         1SBckfsLZipaLUzrckGcJdh+NdEbmkeJWLuuSYpl4nb55f/f/PdbmA7AE9SdgjDKt7WN
         x5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786982354; x=1787587154;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ACldy0aiVSHL8k6IBZhXMiInAvqs3SiE9+icRfANvIU=;
        b=mjJvKVAOLdeVLH4N3LTEBAsblp1pnqS9faFj//2m0I7sk1N0McFEaGSqxU1rJu9B6R
         8tbBMGuKRUKPOGXnx9qZ9jI886sgUg0zPH5o3Q3eAttcc1lsTPXluMxMN6rbUgf0rmO/
         x+mW4oTPpOAE1pnfKv+0wjW5XgBu3EFjVFfe0hgUvfUeLajLSjyNqtJMvKModiArLdqy
         YnJPgQjtQ5bkk0UOgvtgEABVIlhIxtBqVdBa7188bX76WyxE4d38TbNmU2ohP/8uqm+J
         NdVEB82yoo8bO7d0KFNK0zCbew+XzR+PK4jBPaaToIj5oR4RQmUhRWsFwqE9t4E389IA
         ytRw==
X-Forwarded-Encrypted: i=1; AHgh+Rr2MBAx0VIICrt0V876LvXAL34bXHvuOfd52PRpFrp0kHNmTdGVHfNGkWqsf9FIi6VVejXqCbcZlEHiY52ViEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjAtq8LrLxrvbjINxST2KNsqdNb2zWyrWNlgTDf07SQBlEmZIW
	Dp1Cdns9egP/bbMhXlau3iwOpvWkfqAXua3xO1oTHNWNGfYvaBguM4LDIP9b7/hE+NFKvC1/0tD
	6lVaHYJdK/CPX4RKj9LpuR98xhRvqHj6emU/Ujdz1IFOiBMlwaB4r3wqj+SDKIVJ4hHnV78I=
X-Gm-Gg: AR+sD13DT0t9lx9nzCRkgm5sXAdOoo/SDIutcdNjXjC7O0X8mhrBePywefpJpzP0f0L
	FT0vrw/HDjivZRTg3A1zVhwgSPogphT40iKoARrQstGXiaSWQfnQd+FoZ7Q6anLkhLx383vfGIZ
	BzD+KWhd2Ejx5QW+jJxaztpdmoathenJrOpqGkhDu7J6k3oi2+sGQIbPMG1HtENDSE4Naah2hFL
	ga4wHLgbfwVWSkQ2waO1vmmP8eT3KT+Yu1n9uDH7Vjw534QS3b+RT0LJA3JQnYM8fDv1ewyM2kQ
	7G3Wya2/+qCzqrXlQICCLYJLr/gawpbzGCrFD1Oy5Yq4roQew61Y5K6A/exNG1ceGA3ML9LUAnV
	YYC8YJCrCBrbFlIIBwq9f2mLL
X-Received: by 2002:ac8:5fd1:0:b0:51b:f40b:2fa2 with SMTP id d75a77b69052e-52d852d4f3dmr190512711cf.1.1786982354416;
        Mon, 17 Aug 2026 08:59:14 -0700 (PDT)
X-Received: by 2002:ac8:5fd1:0:b0:51b:f40b:2fa2 with SMTP id d75a77b69052e-52d852d4f3dmr190512041cf.1.1786982353825;
        Mon, 17 Aug 2026 08:59:13 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2185b74059sm45883166b.38.2026.08.17.08.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 08:59:13 -0700 (PDT)
Message-ID: <db394200-2a29-4f17-a2d9-61d5ab15df60@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 17:59:10 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] arm64: dts: qcom: Add Motorola One
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
References: <20260810-next-patches-v1-0-79a779d76173@gmail.com>
 <20260810-next-patches-v1-3-79a779d76173@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260810-next-patches-v1-3-79a779d76173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEyMiBTYWx0ZWRfX33by3tlJxpqi
 HhWwJI9Dnt6hKUU1g/v2jHGwBuTIfPM74gjW18vPYir4vDmKacjsw+bc5aAVjezuMdX84aoQmoq
 wS9dLBnTW3+aJgtX5P/PxWLOzCXDtr7+vHKeb0wtG2645M9XxQi8cM51Yhh9sVz2XzgfJLS3lQW
 NcQVXy8csk3LUEo+xsrTkEUhMevzur00ct5w87IHDSb042po6U8ryQXo+PQjiUq6W6BgQAYueRO
 2an0r7SSm+EYmB5yreh+dg/47HWN0xDVQ2GZMGzbmZTjq1258estgt8kYlFqeAXS/epExf1NgEH
 vJ6J8Ja4V5NkAKgjmkKwKJH2ug0OaLQ5uUNJcja84GQ8TQDdTWlVUQdQdGiqCwbKyzcmTt7xnPK
 B0VxKeFRvzaoPyExZIsZYABxnDKTjOlfjGxNteUyLmitWvWIWEPvLVKOwvL7cde+Rr33ESTG38n
 S5FhI7Hu2sQgMwaVExw==
X-Proofpoint-ORIG-GUID: DLIgjePt-y2PmtlpzMZmO_R4LSkyTLUP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEyMiBTYWx0ZWRfX06NPmzIxRxe/
 CTc8VqHuN8ZtP6QN6Cr3pQT4EgLE4EQnqeFGGFHr6IlxM95hI2CAQnWK/RXAeNhj9MasC8aXPLd
 IYfcVmuZ9PGyPJ3UDKnpa74PXfbOUFM=
X-Proofpoint-GUID: DLIgjePt-y2PmtlpzMZmO_R4LSkyTLUP
X-Authority-Analysis: v=2.4 cv=WNhPmHsR c=1 sm=1 tr=0 ts=6a832fd3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=kDiaLF9t6-FkB4tI0JsA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170122

On 8/10/26 6:55 PM, Adam Skladowski wrote:
> Add a devicetree for the Motorola One smartphone, which is based
> on the Jacala/MSM8953 SoC.

[...]

> +&i2c_1 {
> +	status = "disabled";
> +
> +	typec-portc@22 {
> +		compatible = "fcs,fusb302";
> +		reg = <0x22>;
> +		interrupts-extended = <&tlmm 9 IRQ_TYPE_EDGE_RISING>;
> +
> +		status = "disabled";

Why are the bus and this chip disabled?

[...]

> +&tlmm {
> +	gpio-reserved-ranges = <96 4>, <111 1>, <126 1>;

Preferably one a line with a best-effort set of comments describing
what these pins correspond to (see glymur-crd.dtsi)


> +
> +	disp_reset_n_active: disp-reset-n-active-state {
> +		pins = "gpio61";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-disable;
> +		output-high;

Drop output-foo from TLMM pins, the consumer driver should set the output
state via the GPIO APIs

Konrad
