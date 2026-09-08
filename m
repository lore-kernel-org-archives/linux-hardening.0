Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EA839CD18
	for <linux-hardening@vger.kernel.org>; Tue,  8 Sep 2026 07:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788853183; cv=none; b=MVbNLvqKfhUsdH70DC/qcH80bTfjzFbiuZKQJsk8qbWLFQv/kJ5o2t1S7Bv5LL4OJSQ/wpo8sL4AyTRaGZk9op866F4Wos8oyhFm2z5UAK7gGk9JvMoEp3tsO/sEYMHXRBuoYr4f/JXxLxtSDZiO0oeqy8LLORtIiYMLSKU+XCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788853183; c=relaxed/simple;
	bh=vL81cJgOvudKv5vx5g7F21SEULAc4ClndxDIMCUG2Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWbCZ0lE7BMH6Wb7zInuo1OMTUItrzyS8oTep/Dr1qmU8o331dkjQh8dWlhXmMrnIs3UyR4mL5Txngd4wHErgrP+TTqS/s5X4ZiveUG2wX3s5r3sL7LOk+Q1zjthQ1Zu3opshC5Qy9jliEa+rXLceZe2ktLsrv7h2+YfWoIDEws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HFifstF6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lf/cUTmc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HFifstF6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lf/cUTmc"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886LraQ2154237
	for <linux-hardening@vger.kernel.org>; Tue, 8 Sep 2026 07:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=731eDWp0YnMWLXrCZivqIdRg
	turWkNpesp1ykF83iW4=; b=HFifstF6B6fPLfEXAb5wmB4vBKuf+6i8xygebpmZ
	s1rIsZ/Clom1pKi8D8Et9vMJKXWuFVEfQC6Cq1K3tuG3zCz6H+A6H0nHzWAaKNTY
	KMml/gS0krD/4zbvT7zdvMXrwKdZ2OW78W0MslO67EK0rjneEeIx+LkaDnicVoE6
	mjOP49uzcyjWJm+DTIH47zveVRKlMa6NiTMw/SggPousd7BRAzVamA72jCZcpoDy
	/FbPRsROzuCMP/6bnoV80+u+3vrbA7AjAXby0qz2Hhqvbh/Rr62NwKRSl00PONJA
	UyLZSGxCGLM3T3hhXFTuBexOFvK+TNpErWIr1IDQj7UzBA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj1rwj9rx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 08 Sep 2026 07:39:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-939a00c45easo307825185a.2
        for <linux-hardening@vger.kernel.org>; Tue, 08 Sep 2026 00:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788853180; x=1789457980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=731eDWp0YnMWLXrCZivqIdRgturWkNpesp1ykF83iW4=;
        b=Lf/cUTmcfkP7+E7dgbqrg+capnc/Jq4lJSIdnb4/MQiTOqVEiFMUTPaxLQiCI+LSzl
         G2k3jo0WnNNuPqfPFVz8qZek95E26yRSz+BBkclBjZ/IgPJNRbOBpK3/y5BDibw+qTx7
         a17KUWKw+lvF0+Qh8g1e9MXb1SIbwFmRXoVVm373DY9anNVYMxh6STenMylW1QhGBMRJ
         /uvx7CCkvF7RdnrO7R8u8rOblk24a1ZA5fnH8n9szMNQv+LzrLLzIwSdsMBUfXvRnwCh
         dG+ldT99Zfq8XKIGKd55BzhmLX44BWi1xDedpyMEHESyfUpR8xzTwt+YQuWOSdd1UfWN
         B3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788853180; x=1789457980;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=731eDWp0YnMWLXrCZivqIdRgturWkNpesp1ykF83iW4=;
        b=NfTpnTXSrcadKi4xeQ25VTZLobb7Mltx9JTNDVdeyJvSYCsxEHO1wjZ7F7mWr+Lox/
         vkTY1uk1jqSkx16w53Tm1BJeLAdOy3UiOdkFh7IGCvYH+mH0eWbGHJVxOJLWwVDCrQtE
         OBgwhOxJgM8byRjWkNb25ZEns7GBS2Yd62uWuOs1oAEuB0J21EPzWk7e+LbQliqiqCHN
         agUnHZrXF/HeaRWBgYCZAtt2uRO++y9bt1tFej9eSQiBGz1UT0mfC2/QzInWQ7yRwJoI
         a/ReXsEFZdKdcUIhjCyn/aNJnlfj9SFvUzR+vCNXG+gIuZYQ0k/pItHII5yAGBPGza4t
         wPjA==
X-Forwarded-Encrypted: i=1; AKwUvBxHY9NahEXl320Gvuo+We1hZTdd7qfZH2lsgbKEng6eVksdjwUAfhHX8naMhXtyro36tAj5ai7TkkIUL4LWNhY=@vger.kernel.org
X-Gm-Message-State: AFuF++mjaYJwhGCtAGkd+TYgLFPgzIeqTCCp7Emffq22IuK+KwvlSn8o
	wL2Rc7xYcE5msTVnOeEhkQGridgnfJh3UMTa+w90Cs26MJWO3Un7oYyo5V1q1q/bUj8hnhEW8TH
	yaztjE47Swmwq2m81mCfaRi7N+d+fo7HBCHrnbzmrzTIkXncv4ukszNdynkynjXTpxD6Eu0AgDv
	cQcwU=
X-Gm-Gg: AYBFou0GsQT3uY+SYJd8o8KQhlTtXywk2/WGGlUB1qY7pPJzfbCk/KwnF5oFtXYYTAD
	22UEZ5kizJtd6Pn9aBkqx6X/oji8U/GhK+oi4wwVO2LpsLb1LYB4RTXW9ymX+5HwZErVbUEzqDE
	nbj3ask40KSTGIVu8wpNBOfnIwd43qN4lTGhzXv5U73HDtrpr18DRItL7uggFw+DYNq9JzoVpnb
	r0eEgrrqRZ8xE9IdfgyIzpf57jdsAx8mQmXdC+r+X12Jog3sAAp0DdiXdnfsWYwCEKP0MWt2MN8
	/AWsAOrcxuWdSXmcAl+kuKP+t99glkbYlxX9J/LdfuKky95tkbi4hOqRdWG5mTR/d+si6skCI84
	egduLt2GwVhc=
X-Received: by 2002:a05:620a:460c:b0:930:a26a:fb2a with SMTP id af79cd13be357-9398031b58fmr2707865985a.2.1788853179513;
        Tue, 08 Sep 2026 00:39:39 -0700 (PDT)
X-Received: by 2002:a05:620a:460c:b0:930:a26a:fb2a with SMTP id af79cd13be357-9398031b58fmr2707863185a.2.1788853179035;
        Tue, 08 Sep 2026 00:39:39 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.7.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48594172546sm25535999f8f.15.2026.09.08.00.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 00:39:37 -0700 (PDT)
Date: Tue, 8 Sep 2026 10:39:36 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luo Jie <jie.luo@oss.qualcomm.com>,
        Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: ipq-cmn-pll: Assign .num before accessing .hws
Message-ID: <ahxoakctfkslfiybmxgbvqvarznrbiwohr3rnu5aonmyhkrfmb@cm6mm2azcqvl>
References: <AS8P251MB0001B905088748016A0965F1C8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P251MB0001B905088748016A0965F1C8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Authority-Analysis: v=2.4 cv=Ga8nWwXL c=1 sm=1 tr=0 ts=6a9fbbbc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=dePp4Gl7O00gmbwhyVsZwA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=Zo5euW2OAAAA:8 a=EUspDBNiAAAA:8 a=hKUfJe5KFNZvrTfkyfoA:9
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3OCBTYWx0ZWRfX0ZvcCpwORece
 YIs9G2L2htQtMG5IwMWkctGK/kLd0R/i8xEtKu27LFXIT36e+cy8odmbZfVvyvHxv+IH4Vyr2TS
 z5bzop+cCNjOtStlP8MJLoZhF5zODJ5tsiuWeXYOaQfI2Ta5nk9iwNM4RQEpybpbs/JmRNPne4D
 1OPwCICfu2UeAguRVzWBksSOO3RWCFe01asz8f7yrn9Zw9UwvQ9w1Prhf89V7YzIC5YTLix+Kbb
 Ryaig/YgYEoqDwvakqXT7kHnvrsvHHGFPSiQwKMSi8UsrTI7lEZLpgpzJx+REh1EfEzdsPQON9D
 2nsBLUf7IUzRdsmJZ8/7iD/n6Ads0/RA4AMW7f90oelgeG5aBxa5W+bESv2cB7/bKzAfDJAfdpW
 L24zZ8eWZOliJZqY4AAuBaaMteu8OFlpBoAVHNX909l/fh3erNiB3e5SHhte8RIAmY3GQs5DSFA
 ulRKIJiSsd5wCwTJQCA==
X-Proofpoint-ORIG-GUID: ijtIq7BTqekKUDBmxzQ4fo1hKyagmbhI
X-Proofpoint-GUID: ijtIq7BTqekKUDBmxzQ4fo1hKyagmbhI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3OCBTYWx0ZWRfX5Dk1yrhF3fAJ
 5Zc4VIDzv+7rsh/dLSkWco1eJNn+mL6Xxmmlysm2jjovKezJ3tOZCWLecK7mIR+KkFzDO7CvS+i
 zzYgYI2N8iYzcLDK4aU957kYjd2Z7QA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080078

On 26-09-05 21:48:25, Aamir Ahmed wrote:
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
> 
> Move the .num initialization to right after the allocation.
> 
> Cc: stable@vger.kernel.org
> Fixes: f81715a4c87c ("clk: qcom: Add CMN PLL clock controller driver for IPQ SoC")
> Assisted-by: LLM
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
