Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E6F48C8CD
	for <linux-hardening@vger.kernel.org>; Mon,  7 Sep 2026 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788783814; cv=none; b=dABu4z5uMOZDMHqu3aXIdq0SDLG/i8T1dc8ATeWMPMOq8uNVEPB6LTvOyA0HdUBjE8PCLlB5wyw7AQdiYHlLw2uemd8bHtesz7aGse/NXwKcG7ouMz6SVDtrwdc1U3LU3q+lFyz5/hBOGS3Pq4jAdKSQyScS7iWOOMScZewOv0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788783814; c=relaxed/simple;
	bh=YgPQAqGAhvGod4elCi6c9RafBPUF1Jnx4Tkb+xELDMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vy25Nx07F6ElmiqYmewRfYVoR1DxR3O0IOM1uzLzb8M1aPJ2vf6UrUTXqilLur+qQWgJGHpxftQb6ylvuEuW4u6u/HrOahvH8vW6OwN6PRbFch1VfK83Cgo0ZFVy/G0xDPFIXiqddm8pYQ7rySUDej4SHeAxRfsGWvbMtuRjJF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Umpnsa+A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U+YhLcUY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Umpnsa+A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U+YhLcUY"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687AvLSH496177
	for <linux-hardening@vger.kernel.org>; Mon, 7 Sep 2026 12:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YgPQAqGAhvGod4elCi6c9RafBPUF1Jnx4Tkb+xELDMU=; b=Umpnsa+At5I+OcpJ
	HrJY1EphneNQ5Wdy1LKbaES1bD0Y3xLT4pF9/G/d5pme8whAsiw7gaAZqhaWI4c9
	ffg7Pn6I/pMCnupSohA5hB8DLQt3W+6VXAQ8P/3VpAcPY1gwxu55MQKiqOcSaWvo
	jDhRoCDiDgBxzGsiRo/VQyyNU32Et2Lc4QHoX2PPCvxh/uqNyDZvdRdr6Kq9WLrj
	nYduZWBPYj7SwhfUJcy343oVXpPkALdqAVWqkooPaCLhEC4iFO+VvxzltJiSb0kb
	WqkrDYxbQCg1AvlxjYafSoGNOrRkB9t8E8vX60DA3ieSmAV0oQer5eEuWoYautil
	0+b1vA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghuyk893c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 07 Sep 2026 12:23:32 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93102454272so49545985a.1
        for <linux-hardening@vger.kernel.org>; Mon, 07 Sep 2026 05:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788783805; x=1789388605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YgPQAqGAhvGod4elCi6c9RafBPUF1Jnx4Tkb+xELDMU=;
        b=U+YhLcUY2bBPHMfwir0yol0Pv6Kg0+cXfhKPz68vBRZxaAUZDpxLQJZNZtwiGZm0bu
         owyLT2/k/ea9dCzjD4aLNYDEvvuenEjT0osS6AG59dUaPOwmJuKGkqfLW9qbrvSA5Kmk
         WI+hl5peZgUKBNkdmw/qs9hyTGJ75YPOJja35RxM7ZawgBauIm4zliYEMRQZLnhUUqQn
         t2T3ON9h5CCVZ1eSVQKiNdxbGFhDBAmfHhFEYLLKxwSoJS0PXRebgY/1rcmVNMeeZRLe
         YlExGaz3x97kPo3fUCcAYA9lx3Pl20Owq9MSKQXY9CN9gWEIxQeGJAV5rvS0ukg3hBJx
         Tr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788783805; x=1789388605;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YgPQAqGAhvGod4elCi6c9RafBPUF1Jnx4Tkb+xELDMU=;
        b=rw8X1jFh2ugem648kGtx0bh1YiGiKbuaUzAT92c8qwO9lEPZpuyRWg53segEIcAjr1
         2AqgunH6bB44efHPVRBX3QuwnyVPW/lOSNktxidQ9iHPG0Nk/jVygl/B0ZSoDwyUghxn
         dvHRVBGHmcXub70VfV3cjJKnQUKhWdOqXzg+dLLD6avcT6V/Isr3lHSfxinIinKCfN0h
         EVumNHoqr1eMRGQMgNLUfP808g0vu3OYOx+ExQ7HIsGgyS4G8z981XfCkRmK9/rw8AV0
         jS+AOKjb+xyAIpn/wAsuPE3fDXj8H1toR5Bsl5dJBbdPAHMXCTMFQu6YEg62idDRcbEV
         SjoA==
X-Forwarded-Encrypted: i=1; AKwUvBzefortAboMw6MHg+SCKne8hzBdZ3qsZiZfU6eIl06UTYxGb+TmDXzFqZy8WN1+Z696/bUhzkGrKUYUkwLrIUw=@vger.kernel.org
X-Gm-Message-State: AFuF++meVPiWRbet/lR8sAv0ZGhFqQzemAsztzSCiuvq1050+p7plvl1
	zlXVJCpx8Tl9lZOYUoExfnO24A9yC8XnpB6cZIJY6OtCjBUt3gRafGemo2NCDb4lL/Rcv0WRT3K
	7M+ZdbmxP25xFO1FTVchXicy438qCvyn1/KLrgUjE3XizXZhnYLiUqqATb7VaBKmVGaFseT4=
X-Gm-Gg: AYBFou1qSxBw3wODZdl8j+zxptLOMaJsj1opFDwGVwwCF5MEm0E02tZITZrGJ85JIWC
	GLkjNCirI4J7Gza8O3+yfla0QBGPPlklcSfpmx9RMTB4u2ot4ZeKGauSveiWpqHdzLTyvbo7+Vl
	W30se6dbWjyVPnqjSfh4whSpsE5xJAXIJvDOnNhu0PdDd7ywMxznPkfZcl2IK1cGVDlrh9KKrs1
	IYd1pEQT3cgEnqem8mLt8tZBapJOzp3+tS1W9OMfUzMf+0q9K0m7WA7op5bUqiwCO0ocW0fzuLb
	wboeJPk9LK8yYyPdTf1XFq2GiBDMkkJA2rzc6rEiS4pwV2GMOxncimQ38Q+oZdb+6bHJrRxEDcp
	K+vHHAC2YWjzQCBdQOB+wsw==
X-Received: by 2002:a05:620a:9c4:b0:939:9205:4d78 with SMTP id af79cd13be357-93992054effmr865311385a.3.1788783805436;
        Mon, 07 Sep 2026 05:23:25 -0700 (PDT)
X-Received: by 2002:a05:620a:9c4:b0:939:9205:4d78 with SMTP id af79cd13be357-93992054effmr865307685a.3.1788783804918;
        Mon, 07 Sep 2026 05:23:24 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c26263cb042sm330890766b.47.2026.09.07.05.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 05:23:24 -0700 (PDT)
Message-ID: <ac8d6fd6-8bc1-45a1-8b3e-a57b437b77b6@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 14:23:21 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: ipq-cmn-pll: Assign .num before accessing .hws
To: Aamir Ahmed <elb12345@hotmail.co.uk>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luo Jie <jie.luo@oss.qualcomm.com>,
        Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
        stable@vger.kernel.org
References: <AS8P251MB0001B905088748016A0965F1C8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <AS8P251MB0001B905088748016A0965F1C8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEzNyBTYWx0ZWRfX77P1UsLoXsru
 VeIsAr1PVKfq6418PkNcL0XKTDvMcYmHqtp7i16tHnq/3IUv9HsvW4EFxnvInVwCYUNEagazETb
 L4nn3EBQTXWx+1SSKPmNd0qSLBIpNQA=
X-Proofpoint-GUID: NgwQYYExPOn4M0kKu_ngY-Ws56pDwAtV
X-Authority-Analysis: v=2.4 cv=ObSoyBTY c=1 sm=1 tr=0 ts=6a9eacc4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=y7GlcLeVpO5nAozT490A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: NgwQYYExPOn4M0kKu_ngY-Ws56pDwAtV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEzNyBTYWx0ZWRfX92yyH3EdbS9j
 exp9kSKa5pliegCyRX1ryejIWa8V8tzbf/Mr6Ut6yVlaiMUoDJdjJvYfQ4Q++G8R3+GMbz+46oy
 syEaSqSuosEgZukrebsVVx5UChRXqizCreSnj78LIus6/DayVg53bGjBajDTuPv14dqEcyKYblS
 R69ocvyiDthZjTwEBD4ij9WysBMCVWh185BR+ncvBAz8TWz5V2TbFi0eDBrtxAtSh6eZDdbTaEb
 6IlCSbGCX8bb0ZlL8l85PhHKqXhp/kaWs4C3q8X+9+fFTdch3qsS1s2br9zeuAIIKbSVA6Tfc3i
 Id1wafhKSsqFsuSdeTK8Jh3gX3ZNEXhQnHhEwtyo+SpXtEaT0iPCKG5IwJAvUFzJ+0MazV2FWuK
 PiVhkkgBUNfePdCwgqJFGrcFCXml0/xP6hP6QsmD1Gb3dY9I9++1f6qKaqU40CYPW2mYuueNIh5
 sTg4Homp7+k2vR6mqMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070137

On 9/5/26 10:48 PM, Aamir Ahmed wrote:
> Commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
> __counted_by") annotated the hws member of 'struct clk_hw_onecell_data'
> with __counted_by, which informs the bounds sanitizer (UBSAN_BOUNDS)
> about the number of elements in .hws[], so that it can warn when .hws[]
> is accessed out of bounds. As noted in that change, the __counted_by
> member must be initialized with the number of elements before the first
> array access happens, otherwise there will be a warning from each access
> prior to the initialization because the number of elements is zero.
> This occurs in ipq_cmn_pll_register_clks() due to .num being assigned
> only after the fixed rate output clocks and the CMN PLL clock have been
> stored in .hws[]. If registering one of the fixed rate clocks fails, the
> unwind loop under unregister_fixed_clk reads .hws[] while .num is still
> zero as well. With CONFIG_UBSAN_BOUNDS and a compiler that implements
> __counted_by (GCC 15.1+ or Clang 20.1+), this triggers an
> array-index-out-of-bounds report during probe, and with
> CONFIG_UBSAN_TRAP the first store traps so the CMN PLL clocks are never
> provided.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
