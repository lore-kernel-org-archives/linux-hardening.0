Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C12E4446EF
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 23:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784675587; cv=none; b=J8pcyNEYRFKFJS/c/0dwA507BMkFUJXW2KFSmu8f2kjcmLFcUNLyjyrQtOa1XRBd921W3u9NCafmmdNM+/1Cn6OjYgBnbp+iZmAb8SLRGYg6JFJw7v/luuCI43DKE2qEH4OiGCGuSEwniwMEcoWGDnf/hbPK7QEdsFfglg22X3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784675587; c=relaxed/simple;
	bh=KT1c1OAV9hEPRs7FDQcUUYsNQA8f+0N/BkDtmtYHSi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKILaAOEZeqFMHydGTnNF/9SqXQRdMu6ItlSZWKerbgEKq6wnTjW2u9SnRew7mmtA8H2WjbTAAjZlnYOTf6a3fARW19tbadSLYZHxBy1WHyL0Fns5QYyHrkf3deNSWPiNCI5GK39r9/rb0eCJnn4hJKWgY2aVUKwXJWe/ipED3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B6MO45X9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BoWygCq+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B6MO45X9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BoWygCq+"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LMZPA23026986
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 23:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3bwtoUeYIX4CQ5hBjVs0pHHQlacY1zcuJn2ZoJQM/Vs=; b=B6MO45X9aDbulSWW
	7/q+ylGeihUTzwBF8CN2C4+63wxaPWBizhjoE5sSH48ezWpil4Camqt+WO9dGXJe
	5uU/urb9sEMPKOh9T4Cz9xMLegVKTb3Vv8FuxdOvZJDzSbLE2mtPQ9T9mfbdK5q6
	W9W8QQTaMqx+sjPTJ+9XbYcHkmhhXVuicC5tjo0TUTvUh7JRm88T79U7lg318+2i
	Hzw/7rruMrTvR+3a5FpcLLpf9yNx7/Lr8sp+hV2M/9CuNTZTLEyACItzCXncWSw7
	m6uTkikgitoMxlDc+tgvdCceUkuntVz9TX9aOF4D4QaPzg0a367qUGFwoclEeKuM
	XMq05Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6pabb2w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 23:13:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bec738909so140183931cf.1
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 16:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784675583; x=1785280383; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3bwtoUeYIX4CQ5hBjVs0pHHQlacY1zcuJn2ZoJQM/Vs=;
        b=BoWygCq+qu2doOODZaRFCC4kF9dGYp/xRGArkGKUtXtqESHsO4wAkCz+JLl8hG8GoS
         6grxViJNSGFrg2vcRBaiNqPS5OaAO/5op42QFQh9VyIgvwp/yl5JTAFyNBT150C7vPuZ
         H01xuaVMufdM/m49zKsiQeek1HWIKXpNW+/d0OR3AfpjDju8VQMMVEYKV3ERgsEaOQ5I
         xxFhM33Fuf5m3qfWE9p+FC8EIhP9IypKOUph4KKIyF+MS8ZHjEdR8RI3Ki/bWlPAuW1s
         TEbEMihW4yH4qhSfy9nYzjju8w5YGv001d0UZReJTe9HralNVESPkEFw1XM4AhG19XNZ
         cv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784675583; x=1785280383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3bwtoUeYIX4CQ5hBjVs0pHHQlacY1zcuJn2ZoJQM/Vs=;
        b=Zh5b6jiLF5GfOgpsQbBGX0h1689IfpXHPi1OIKA+C/76O4CxbfJb5d1aWOZk1Dv2w4
         DWlVk0I5qjbBj8JgLKM7QMVh6iCY3zVSqT//S870n/vTDPyhWqn36mwz8Mucw315Gbt5
         JY5XHS/XdBEKH7y+BpPhk/bd6vrepwAA9sq+/6LUsCMXAWuHAfjv56iYHZYZETUfU2VR
         lWNdZ6oinqwiG7Igv3qLUUAuFQW6nUDt9+YrMEnrRzoLmqg4gK58f4QKgzjyhUiTIN91
         pv6ugCfimgyhew4citTCZr9Pvn3qkWkX1xDoVzoa2D8eXulYctdhamIupRLkRBsqyWkD
         OB8w==
X-Forwarded-Encrypted: i=1; AHgh+Rr9fEYxnRC03aDe3+fRjrYSP8i4THGZvVWuYfxj9npBhhSttHiWUGrxIGOHqvFQA97tZWRj5R9MLUDfvRYOTDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDcJP5DDITqD4nho70MytkLysi6GnV/F5veFGKkZnmJVBh9uV9
	mxAmwh33otPPY+rFO1EssfdEKRy1rcIz33Fl7xue5sIMwPiIULoTFhD+S76g0NCoC2taFohR+jR
	b1OX/BsRrSBJXrYJ7f6uVDeByJgu4Zu7Om3G4gbWcqHw9QyW9646n5BW48x8QwPwN53IVVHc=
X-Gm-Gg: AfdE7cn7/KaX2vhCsZS9wK89THOo4ajpZwQWcV1T6CzLJgjfj1N5/+RP90HMlDDb+Vr
	TsH41DZRd8mkjNFkepOdvTn5fQEWraQJQw5cZuwuuVAFk1ck95oWsy3tx0smzKJj05WMPdJvCVs
	OwIxuWg6gty/ioeSXV4gpssjoKV6uQDuizJWFEXBd2DDc8Qj2uFpUjavoPv/24lYojJzX0+fqVI
	a0HdScjZXS1G57xJWvlLD7vreCHvXqDIqpff0apypZXLgJcEQP3zUkpYN4Y1WGkbOjYfoevAMJc
	XiwLixx05oSV8zSdW/ihC6ujscFQTyufkLvN4xMLJOyInPCOhWLkoBoVEnnPVwleXH170/efI2W
	fbLLDs9I5AV1r5g4S00HipSyqPWO/HIvVckdNhgH7oQxccrhhB1WwiDAHJvpgZmPXRRDKhtmSfX
	KcQjcPMGGvts47DA==
X-Received: by 2002:a05:622a:4d90:b0:519:e91a:f4bb with SMTP id d75a77b69052e-5213c9dfbf3mr195128641cf.31.1784675582850;
        Tue, 21 Jul 2026 16:13:02 -0700 (PDT)
X-Received: by 2002:a05:622a:4d90:b0:519:e91a:f4bb with SMTP id d75a77b69052e-5213c9dfbf3mr195128411cf.31.1784675582389;
        Tue, 21 Jul 2026 16:13:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9b8bfa3sm157071e87.12.2026.07.21.16.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 16:13:00 -0700 (PDT)
Date: Wed, 22 Jul 2026 02:12:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
Subject: Re: [PATCH v5 8/9] arm64: dts: qcom: monaco: Enable CDSP cooling
Message-ID: <bp3rrxycikefsoxeve7gzrattjpbzlzxfiw7vacr26e4kf2z2s@gto4byj5sxcs>
References: <20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com>
 <20260721-b4-qmi-tmd-v5-8-99620e07f505@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260721-b4-qmi-tmd-v5-8-99620e07f505@oss.qualcomm.com>
X-Proofpoint-GUID: GQHQg3eTmh5yBGVbsN-UuaXmofQN5bXO
X-Proofpoint-ORIG-GUID: GQHQg3eTmh5yBGVbsN-UuaXmofQN5bXO
X-Authority-Analysis: v=2.4 cv=eYYNubEH c=1 sm=1 tr=0 ts=6a5ffcff cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=_nN_CDt7C_a4776dohAA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIzOSBTYWx0ZWRfXwF75vRG/imxF
 McoU0waNbgmNul9fw7ccRP8uel9hiE4S1p2iUBkWSIoHn3/oNh2uQYE4gN110t3dQUW7bvkINe+
 lUQmVxpDnlAhhQEO436RWGcFjF3O7MnuYfalFN5EV9fway6VyQikOVeZgiQlr6FMysWijhYedme
 eJA6HQuauoJWwzSJFvwXGTi3oprZ8Dza1QYTG3vofT9yKXxanWQQJ3ymsn50GYMGf7GEKOBVA6X
 ow4NJhPDNPWLk+AZXAwb3UbiSJWZavzunXzVz1K0fGMT9/TEe+qN97VZQkrJnrd9bp/KABOHPVd
 AdnybZXf9Xe7Tb3/HyvzAvqAVBcsaGNheWXl3PdeoRv/w9BVPcrwBFprL4+WQIk1GcG8OXCPFgm
 RgIMUWnf8lIEa/pumJN5qbolNKqgc8lmPm1T8YqrKJqf5voVVH7d+0aYZr+XqGoS7ppeaDcSoMe
 SqdBeXOdwsQDfOxMajA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIzOSBTYWx0ZWRfX1wYB7DYRnijC
 QzLGo01yiWCHQLmLKY1uqvWaz+Pz2StXR9cO+wUc9+CFOUpWGxyLEd9/Mp+TSJE+byAZQhWiX1Y
 qSI5Lp1xdyOWJwBlioSU3Hu+2ORQIm0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_04,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210239

On Tue, Jul 21, 2026 at 11:59:05AM +0530, Gaurav Kohli wrote:
> Unlike the CPU, the CDSP does not throttle its speed automatically
> when it reaches high temperatures in monaco.
> 
> Set up CDSP cooling for both instances by throttling the cdsp, when
> it reaches 115°C.
> 
> Add polling-delay-passive so the governor periodically evaluates
> the zone during passive cooling and steps up cooling levels when
> temperature stabilizes below the next trip.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/monaco.dtsi | 99 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
