Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F934657E0
	for <linux-hardening@vger.kernel.org>; Fri, 28 Aug 2026 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787924506; cv=none; b=WMEBvNhacFlHzsdpblKAm02gWzKczWHH2z5dVxzxNJsdwQ6mZVatE+PCzMzezS0CRFYTJ+YwbaluW5E6JRFizFHLxeyGCyzxkypVMH9zxIVDPA7+OTPl/PdDhGptlgfsGLyo1yIHOEXYOjnYOMUCla3sPOXCmfi9jbkfDS+fI5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787924506; c=relaxed/simple;
	bh=Tb3pJwHKGH06SZSLA9DSDf2HFo5zXpd3gB1lmiQQeaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3C8P68Bjfn8S8DVbc6A8bUAzromHw/T9OZjRgYAx22PqsVz7jP1GsjeHGl199e8myKGNDD1SonG/q8tzNzopp8x7FsLHSyy0S9tJZK/D8cFSfqnfFmqMxI8Qu5y9RJ1XJb1SMFC9BlZBo1gBVztbvITlPiiQ5uL7yBX6TMwr8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QU5jOah0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gSy8kC3w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QU5jOah0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gSy8kC3w"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDS9gG2604407
	for <linux-hardening@vger.kernel.org>; Fri, 28 Aug 2026 13:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Av2GI0kKVGDvUdYvVPRtWjATg8du110aFsEraqsTjQc=; b=QU5jOah0tIbDRAh9
	uKMO7sI2LGk/1nA6KVynwGLUfLa89QdMeivfuF5PAOLNEUU7m2QBcRD+a9vPeKKz
	PIoC3D0Qp2iRBvAk367XPFf2D/YgbkjOtntPv4OuKeMNvO2CSDV+D7Nk94wURLdj
	owAzcgLxB7hrK28/LwFB3U6TndPnrbLOXFCQB47yXPbJxbr8xmKvz8yQ02VKYMVi
	xVtfh4Ww2H1TApkZlTdZsiezi+GV0eBgYFNl2u8JX/J96kB+bp6WNrAs9OIVJxLO
	tmdRm3iQXokwsntg9kfBr82NQQgrHRQwG51jxe6UiyiUvwupzTHxu/R8b0cF8ez7
	qzv+CQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb6h017b6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 28 Aug 2026 13:41:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93495488976so29327985a.3
        for <linux-hardening@vger.kernel.org>; Fri, 28 Aug 2026 06:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787924502; x=1788529302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Av2GI0kKVGDvUdYvVPRtWjATg8du110aFsEraqsTjQc=;
        b=gSy8kC3wdFqqrAT4hVE+gu9rlUPISFtn5r1mqLsSpfpv6K4e17uLglE82ot7PWoU/K
         E+Wvcs9kcNxpTZS9EIkUsyXp1ByGSXdpr1mDwvcg0TyOGtjxVwXg/zdkCBEXoKfwLtBq
         OFRg9zg538znw26nxQ0+OdP6mG5E7WfOEw4L9lFQSEJ+yFNxetnI3WyFzHKSzj9eibWl
         ba6e6bRgDO0aOJek9fXi7OB1K1Ag5VYKErfTkdwowXLXeVGV6BctXdTf5dz0LpAk4PBJ
         UAUYaS84L0Q+eXGGqMZMQZUdUrmqP6aOZd6xluqYxHYZALc34Xf+0hB9Mm5OBvUbVm1N
         /6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787924502; x=1788529302;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Av2GI0kKVGDvUdYvVPRtWjATg8du110aFsEraqsTjQc=;
        b=ccdAfzy4/nClHZuzinM9BvLmFD+hjFCLM6vYIzN9gLyvd9SkZEThQKaN8dC00zeYRC
         s/3UFVYkoQ1JHh+mGnTbs9rOM7w4upM6VAJyrIYnYbcXHFNntm1ZotNrwDTfSI+spEGl
         Lj3fm1jhKKBeeVWAG1sA0qTJiKpGmKoSbduUPSKSQTA8a3ommYgfICoUY1pXyER3swzI
         fJQooOaWy0fL3kRez5oLuOHYshnP5lu6QMmbU0nKglotQ9I3LQF6yKR8zsILWItNCAwk
         2lv/PgKTd/Qvhu5FnyY9/e7RS91JzvuOou1NsKteljbu/FgI+gEXHXcVsVM5D8FPHtF7
         yXtQ==
X-Forwarded-Encrypted: i=1; AHgh+RqGUjXOsjuvAGxLWCwIWasCJT5G4pyLt85/8QElTBH5WQ1vR8GORTP1JgZ8t2HThDsQEZOBUcOx3EMlExRqiJA=@vger.kernel.org
X-Gm-Message-State: AFuF++mkQms+5AIlrOYrbaj8Ac+mTvncZlsOFTghj/jg2BkZI82meb68
	eQiTgsanPqG3MGzCrHmAJUW8H01E+aiHav+iXmVVgAMia9s9ek/CgQgll9znGPPELw2weKTsKJg
	QuOpPlubqKRAWC9avMSRTLJRUFVsWI1SjowtE6wtbJw386+0UvmotvFNJG+JukHOQ1fzzur8=
X-Gm-Gg: AR+sD11+tNZ5E4ejO6rNu+bKYhtQgto9gj8NHWSXUTaZ4aeru74/FnUbLuzuFq5Rh2j
	CosTdDlacVzI0A/s67ZtcOyhobZpo7WKl3hVkJ9jUtwfOxJfcx0IzFH4VnToyafp0/w/Q4fs4u7
	6BgrazBB6PUK30ScGMcKWuInLbvFSAZji6QKd2z+6wEzw6tebglC3Ei10BA+Rx9IqgZWPClPAKW
	nRmVO3rfFgHnb8Gcy14L7MflI3dYC+hLy26ptrDxcWZrnbHuNkGptebi324XyITjYchVF9bj0AO
	RVq6Yb/6kexYP5qsTgWtBlY3czjM0R2wQyArrP3NRXBg7DN7KL9mSdhLO9X53JcLA/YQjQlv8Y6
	2Rr3UeaZrRKtDbSn8m8EwHm4=
X-Received: by 2002:a05:620a:2950:b0:92e:601b:8d43 with SMTP id af79cd13be357-939137aa4f3mr479998885a.1.1787924502370;
        Fri, 28 Aug 2026 06:41:42 -0700 (PDT)
X-Received: by 2002:a05:620a:2950:b0:92e:601b:8d43 with SMTP id af79cd13be357-939137aa4f3mr479992085a.1.1787924501825;
        Fri, 28 Aug 2026 06:41:41 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1fa3ddsm81168766b.45.2026.08.28.06.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 06:41:41 -0700 (PDT)
Message-ID: <c27beaef-05aa-4963-bf6e-ff6df08c6110@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 15:41:37 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/9] arm64: dts: qcom: monaco: Enable CDSP cooling
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
 <20260809-b4-qmi-tmd-v8-8-b15d47adc379@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260809-b4-qmi-tmd-v8-8-b15d47adc379@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Wi0wnmKJZkcpY_Bh6Uq1Mb3r2Ci6E3x9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDExOCBTYWx0ZWRfXypqdLdOp1tS2
 OjUCBExs/MDg25fIsXN3z88iJ6DJ3JZK2y/D3c2FXM6bolv6zgPCFGQc5kWz7unZzZ8pTRKpqr3
 ZsEZly0lhnbNjHjxhgozbPyyqltXaDg=
X-Authority-Analysis: v=2.4 cv=KPpqylFo c=1 sm=1 tr=0 ts=6a919017 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=_nN_CDt7C_a4776dohAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: Wi0wnmKJZkcpY_Bh6Uq1Mb3r2Ci6E3x9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDExOCBTYWx0ZWRfX8kMOhamYkM/e
 lzcKIoRGDKfvlNbxClGs0OBrxYv3iGCBVKNMwhR7+PvgmfRKiwnUhy0NZSeoimpbr33syEgZ1rZ
 xKt08rjKzAeJUY9rsKxr1P1DfFgME7jOsVQ+PMXklJp6EgrXpeMNfzP91/U1rrXWk26f8WVcs+x
 AUGdf7jcGsQ6dAig1IzyRT3PoDXgJGX8yrJJ/NJgCSGPqm8iJXLiC5XdkZJGsQMDyY2AOJ6/Eit
 OnSGf7iKbcdXdBTTPNrjzH3q7alOU/rU6uN+/m/q55YwXRCiHtnQ0VaIq09vSpg40uDznJxGYhl
 LGNX61M3pR7oJxYe/ERZDXFI7nvqWEdMJLyD9pA3OEWJN7lGt3WNpS1p/JC5QZ8Vd43gZAkWknN
 CSUZPw5CJ3yKlPjych7NMnkcM/X2z8D1N6zSenxDwI9OcEOtrTQqqgrz9jzsTHF8tgnkypCfh7U
 HiP2cikEVJdOcgh068Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280118

On 8/9/26 2:29 PM, Gaurav Kohli wrote:
> Unlike the CPU, the CDSP does not throttle its speed automatically
> when it reaches high temperatures in monaco.
> 
> Set up CDSP cooling by throttling the cdsp, when it reaches 115°C.
> 
> Add polling-delay-passive so the governor periodically evaluates
> the zone during passive cooling and steps up cooling levels when
> temperature stabilizes below the next trip.
> 
> Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
