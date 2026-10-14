Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270254A4EEF
	for <linux-hardening@vger.kernel.org>; Wed, 14 Oct 2026 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791967117; cv=none; b=aDUPufdjbukr0vVAsSKt2+a/Q19KmQSWECU4s7oKBRHNYSwfRBtMp4j2dAL4k+cMdj1jSFN7M2FnX5DBA+xzDvrj5Ayh9rJvUa/tJdBzi5nEFe2q6PNYsI/RCje5FAJjwV/uGGADW6UHPKabl4ilVoQEhGFtBHvlsNPlBw17pAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791967117; c=relaxed/simple;
	bh=vFkUvNtpdQcabmgAkroImBy/gEE75d6PH35V9Ktd4aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4PVIPxcTMyhLNk7m8+i8yK5NTXyFipSx6MtcHj81LWkPNN9YbRhB2xfZM3fcgiRT3Vo/TQ09tEdcSMYi+pE8B/IN22YwQJyOQ3Tfs917FUm+0beT3vq+f7gFANKdmMhjjKucS50sGcrLmD2fHQkFaRH5eiwWJ2v4JUV6+lh9Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ouDeDj3B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gdh5/PJX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ouDeDj3B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gdh5/PJX"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E7mon91592415
	for <linux-hardening@vger.kernel.org>; Wed, 14 Oct 2026 08:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qd7vTo+EqGkYJvBcWwrHERRc
	H3xIdn95LuV1P6oCFuY=; b=ouDeDj3BW84QlyjGtamLIrXioL4/bWrdkzLfeWgc
	rHXtLz83CvQwVcoSe7CcGcCLoeIrAUpHyiL+Js8RRmGVpZWgGzymRUHkhZQNrfyA
	cYdlRf+NZGqnQLwI8Lw7St4/Lx9R89TkO47RMLnlWcRxuNwwD2nkUtChE+juRuNs
	B19LnKLGJnu2fWQYMRxPYfgvMGI1FQvGEJa2zT9fh2LW36fhSyO65AXAAKP12axJ
	DytlBUx4SBeGN042W9HxvrqPlrtkqd5A5mjWGoqvBfQxl5YvQJ/piRpBFteM8JF5
	FDfk+ZkjKKkCYhdjDRO6CYWG4T6WpJBbuI87wHYodBcNWg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9s1tk8w5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 14 Oct 2026 08:38:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93c5ab5c136so667055785a.3
        for <linux-hardening@vger.kernel.org>; Wed, 14 Oct 2026 01:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791967113; x=1792571913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qd7vTo+EqGkYJvBcWwrHERRcH3xIdn95LuV1P6oCFuY=;
        b=gdh5/PJXP8+o/Z+lqFrQXDbBJ4gWSK57xM/XehGDTfigeRY7KrvdE6zAJ8nRtWYe5m
         9R5jLUikyY9X/joakVtIuQppb6kGgbL4cvI153rkj260KBEkEkWZOaty/t001pXL2ndR
         Wa4lEq0tbwIW76baUcYu3n/b3/EQkbrH37UORp05WBeNVeg+Lv54taTB4gO4A4LgRUOO
         VucrtCX81YpQxC8FADzGcpNJ9oTU4jQNjPnEeV0+mYj10R5z9BgyfgTNkOCve3lR/lqi
         /p9vtH4PXgvUt3p8Zckid6Eq+XpgGME50PAQOatfLC1uJXIJXAhXLOS6TOYPPqEnLMdP
         emiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791967113; x=1792571913;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qd7vTo+EqGkYJvBcWwrHERRcH3xIdn95LuV1P6oCFuY=;
        b=GVsYOqZyO1IyfNkqMmnjsrM5GKQaKrYcy8q+dWlOtGhtmvf/TY6QMAWpqydvVOwwLY
         4gA3D4jOSYZbsviUiG9D9Kahm2BzfTmAZOhbR2+V6fnPYZXl1UZ9FTUh9oxwIxmIaGoP
         tfT3twJcw7HpFfOabX2CqLOgd7da0DnJiXsBjXg4FYQXQlEbdQ/xXxySf4YEIk4fzJy9
         0mTeUS3oLbqD6ffNIeOYmurvmhbNg9Vipg8UkQ7AD6OmBMaTeY60Ikh9K/NqFsSUMgAD
         qd3GdFs/Z6Iab0lK38AhLF5goUr8xy6xtTtHq0coQwM6A+GfDLWljplRn67/EZkxtPt4
         XvxQ==
X-Forwarded-Encrypted: i=1; AKwUvBy//fxtDov3wZmNzz0kJSSD4H5BTFJ7NWdEwswgx0fKHUL5/+ZjS0+XzT0+3Sic5bDX7GGgALku0M1kQ3A5j2k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJiLzLXHwP46gXMYAVElj/IdJ0vRY4VzD5VP7ZwDymXyQFATLo+
	w6dmLbXKX0hCsFAmu1GcW7lRXVpN1SRvhsqtgjuqZjEgF7udk7UfPmDdzdB3QNQ9ErRJCdkoBwm
	lgj/EUsma+CISEa2kqirdapxgYJxvzsLUxDB+REekVm4Is7cJH8nrYgN9AsdcjrXq44CTG20=
X-Gm-Gg: AYBFou3vWErUtbUykyJwqY5XcOwpGXi4ER1LlWwvDRoaeOE50UXPPdFRFo1aV7Qx+fG
	silc9kTMoZgEAa04/MYV4GW6K3ga3Mlwlccr9bdTE5OG9yZV+JT73jWf9J3Lb/d9YKdbwz266jk
	aN55Kgs5voyNbsp2IVvTVhEowjFtP5zgKb/iByBxuFg/+zV7WsK1n3qQyThKrD7UldaPOZyylwd
	AbiumuvEKElFrmo6OAh2HGbiAj68yBTGYhQEwCLL6YUzgwDQ1tYdSJLYKiCUhaE/1SzpXUgRgxe
	Vsq0r9uLt71FF3G9ytNh2scBT8+/9h+h/Lz2dXQtNn9CIUvHoTGO+ZEIH6MnbMgdAHnXsvbilQj
	LO3fvkBpELNknRDtC
X-Received: by 2002:a05:620a:31a5:b0:93e:920c:bfcd with SMTP id af79cd13be357-93ebd23d1a8mr2495231385a.57.1791967113368;
        Wed, 14 Oct 2026 01:38:33 -0700 (PDT)
X-Received: by 2002:a05:620a:31a5:b0:93e:920c:bfcd with SMTP id af79cd13be357-93ebd23d1a8mr2495227085a.57.1791967112714;
        Wed, 14 Oct 2026 01:38:32 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de77606fbsm4193764f8f.53.2026.10.14.01.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 01:38:31 -0700 (PDT)
Date: Wed, 14 Oct 2026 11:38:29 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Aleksandrs Vinarskis <alex@vinarskis.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Liviu Nicoara <lnicoara@thinkoid.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Tobias Heider <tobias.heider@canonical.com>,
        Val Packett <val@packett.cool>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        linux-hardening@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: qcom: x1e80100-dell-xps13-9345:
 introduce EC
Message-ID: <po34sdy26aqq5ze2bmbufqcbwwcmzdyhmpyyude2e6thtn6evv@rwulmq43yljd>
References: <20261011-dell-xps-9345-ec-v6-0-2a66a364fe70@vinarskis.com>
 <20261011-dell-xps-9345-ec-v6-3-2a66a364fe70@vinarskis.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011-dell-xps-9345-ec-v6-3-2a66a364fe70@vinarskis.com>
X-Authority-Analysis: v=2.4 cv=IpOL47/g c=1 sm=1 tr=0 ts=6acf3f8a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Rt3kCFFBWhWisHNmluDamg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=I76Qk8w-AAAA:8 a=BDX-M9UYCxStvK4FQfUA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=vUPM0Wvl0xcrLs4nqPIT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAzNCBTYWx0ZWRfXyBXw84OCcvet
 xGD+56B2PB3gzR1A4mpk3WRhxCsQ/8DxcGd94xmN+wRytmGU0S0jwvv5BjTN7nsdea1ubEaq35E
 1FZ8+VEOtdLxNRLauG9zhGj93Vbh94p0qIdmZ7qF1Kt/agkTFd3M34ZnzaRGPJxj3hWuVmWIwuu
 +cedfsLADOAA+xmExF89EqABmFmGgFw4Bt7sBK8kx2JiFaxZFiBl1AAo/B3MLFLvxcWVA4GE/iV
 GpAHY9mDuPC0Zo0iCQt9cnvraYkUYiigu6htpgYLZczdgIL5q7fLXDumWGvjYKce8ue9N0l5DZo
 aExc9SX5Ew1MEJsPrqnXFLEDaZ6Hh14P48E6wOs+noCQUfvYkr1zbCEHCEtZq/YbnGQ27YLwrE0
 Dtzee5cIQbNXr117lT/pd4IGQoOGDuKGseXUycgvlbIvMu8nKEFPTNtr4vqUXfhTjChiy8gko+O
 cGUthuqdNq5xieJHg8Q==
X-Proofpoint-ORIG-GUID: pdTV0d8BgdgOl7xVDh5NpiMBGrYflNGO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAzNCBTYWx0ZWRfX6dMLnvobQIlN
 66Uuso9+lLgydh5VNOqhBxs5BiotDTXV145N1/f2eO7eZTF0DsgvvgZp6TuIC88G638xQHHk0ha
 j0nIHhxLhk88Z9HzKMutBh43w4ZmoqI=
X-Proofpoint-GUID: pdTV0d8BgdgOl7xVDh5NpiMBGrYflNGO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140034

On 26-10-11 19:50:10, Aleksandrs Vinarskis wrote:
> Describe embedded controller, its interrupt and required thermal zones.
> Add EC's reset GPIO to reserved range, as triggering it during device
> operation leads to unrecoverable and unusable state.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
