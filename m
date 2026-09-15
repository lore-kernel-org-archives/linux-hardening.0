Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678B047F2F9
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467891; cv=none; b=IwyvtJoBQCH/wr9m9cB3Z2bi0P2bcQxd3FSi+1/Zz/J43eTrv8jCf3Gh5pqh/966oDLgyraxI/TYsSfqYV6DC3atD/Ph9hNb44vH78soD0wW9nqyzj9uqK66tVVQfecb7hTVliZfa5M6XSm91tKoWS/lRPdvfzs/BgelYqTvTe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467891; c=relaxed/simple;
	bh=JZppL24vMve7PF81iMLaVhYGDa0udYqAp8Y3dpIqKJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkziW4bc3dY0+t+dIW2aBAdvrqFfcyaFOKXLZdnqkOREavvxBDHBMyppTnQZJxOHcr4Q+a7aAjnq3MraPkXNiyPQOXe02Ai/XQlz6bQ6GKp4izFVdT/qMq940LGLdTMkzZWE+fy4e4ZEQhztL+IvlDGQInqcVE61wf8GR2/crS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QGZI/e2y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KQXS/OBA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QGZI/e2y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KQXS/OBA"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FA4WY93611178
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 10:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gK9LDColQdblweoq+gLQFgbxSyv9eulcJndaBLpP7Ms=; b=QGZI/e2yag16kuW5
	e4FuF5bqSV248C+2dkK8P+ekGmVTIS19NtIjcNST1N3Vw9R0F87/uBRRASHsOX82
	KSVdcZ+VubMoMUmUOGTkF9zwyvc0jhf2NQ5LhrAtLOVXOO76PO8dMPiR3R0jtPzv
	NBea3IsdXyT3sxG3B1dkOsY/+N0lgs5nZhrDm/vbqhpgxQMVmQ8MHf4WcAj/EKgW
	Rv/u44Vv/aVNffwfh9x0k0LvML1a2u0rt91L4i5G47mYXjwSlBISSPlLgmnxqOCS
	bT6qX/vAE9u4bBtXkTaJ0tI3+k4rBUg++wT1VBW4nO64VYUrWdxKl0Tzwm/ejTs3
	BeTGuw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq3xtr2x9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 10:24:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-936aa34873bso761890985a.3
        for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 03:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789467888; x=1790072688; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gK9LDColQdblweoq+gLQFgbxSyv9eulcJndaBLpP7Ms=;
        b=KQXS/OBAdBsXJU7mozyw3DP2y0pyj4QmL2SkaWy/3HCLGCKPwIspH/45HHQgf9qo3F
         iarUkFN5s499XNTmYfII/MRgB9J2wVxm1GugFyTo5HdaBHssFeAmQGjlO79UWy4ZY08h
         hDS0tFXKE3oLm1akPN8Ls9Fp28oGzIRmSlqYJgboCaWH/xUcgXJe/cnCPhjXI8p6tHSe
         mMNrKRTMnku0fasA5vxDp8RtoHhCZasPEzaLIFAYo7l8F7yB54XaL6Dv2pCffcNGX4+D
         JXUB/rYhp/FvvayA1ohpVM63Iyu2SfUa3ci5NIQDXYe0JHY2EU2tYQ5Mms3K5LzZlj0A
         hwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789467888; x=1790072688;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gK9LDColQdblweoq+gLQFgbxSyv9eulcJndaBLpP7Ms=;
        b=rmTgh9MPovjlQA0Oll5We18ZEzxXHlBSZOyYrgq4XRWzCb3meA+zGsAcWkYJ/M97QF
         h26rrc1NBedFbxwuCm33INoHWlnpB7SZsCBNmQJg5aSSb2gPWcZSN/0ROdpbSBzPXzGZ
         sm9dVuQBmmSWIoVKF03Yw+fVmrBBQWTFj5WE1HgAPs7RXa8WDvwMyMPjvHzwFwYYTsqJ
         RCY6RgRD1VsRHUjjtS9on6xfwngJgI0oWJxPxSUD8FJ0gJy/xj/jRJL099ryQAcbZDse
         ens0SvCCWLf4VjpkdBWt0fgIFBU1ddjTkECHo3IgAo4kmKo2Sos8V8exNcLmvFzevj32
         wZCA==
X-Forwarded-Encrypted: i=1; AKwUvBwldoz/vRNhYebkxYesoxNA21CI+/AwGNx9kd/o9c7Gx+n1aHGWehwc6LcPRHmP3VN/a1VeH7bSszmT9p+ZGe8=@vger.kernel.org
X-Gm-Message-State: AFuF++nfVlq29KkBmVZsC+f1MYCbqHkVlIorP62ghqW7YNDa6nhNxaBa
	1jwoNSyEwxjJUgLSE4BTSi/buxnWz3DfjlBscg3S58NE6OQlL2euYRNa2P10csXkJNUBNqlxbPu
	PkY+TxniE4vCXng2gT3FjgrBgw8tIdw24bz0Rgb/YMC4O9su5Q3kfjzuCqzB5C8zgihne6Dw=
X-Gm-Gg: AYBFou0JTdSy9IX8tyOmIyijARikT12EGLba70Vrjxwybv/ZALT+hXiqVdB9fwlmK31
	P0XPfMxhNCOSd41YLRURG5xjiRqrk8L7FdY2FSMo04FdWbzsbph/vZZP3tDzNx6hOgV2xrejESy
	3peCsJA76et32C5S3yQDeZspB2wD9bmc2/o43SlZ8bQGSu5jJCR5voaeZIpzru9NhJAicEpb1UX
	H50aT9TNL/APTPnstumRierdt6Ev2zPesr06dawZAneJOp2JONb3m++g9XndN6b9lK421XXY+nj
	Hq5VB50dTvxu5z3Z2+qEl8o5hHiV3/xKj8CJZ6Sr9tp3uYtEOvzHYoug0N98vZa1VnCAUtSA4RC
	JxX2g+FjT2pg4FANo0f0BLgIzTwBX6BKchuai9GhAGn1HljXm7w8unuYYzlZqkpk=
X-Received: by 2002:a05:620a:2b89:b0:93a:83d:1d0e with SMTP id af79cd13be357-93a4088b012mr16181885a.38.1789467887808;
        Tue, 15 Sep 2026 03:24:47 -0700 (PDT)
X-Received: by 2002:a05:620a:2b89:b0:93a:83d:1d0e with SMTP id af79cd13be357-93a4088b012mr16142485a.38.1789467882575;
        Tue, 15 Sep 2026 03:24:42 -0700 (PDT)
Received: from [192.168.10.107] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7ef2e117sm54501265e9.1.2026.09.15.03.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 03:24:41 -0700 (PDT)
Message-ID: <92fcf594-9b39-4af0-8bda-47abb0348bd6@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 12:24:40 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/9] arm64: dts: qcom: monaco: Enable CDSP cooling
To: Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
 <20260809-b4-qmi-tmd-v8-8-b15d47adc379@oss.qualcomm.com>
 <zacwmavu3huggr5tb3f4pqxw6ca7hsxuaye7okqgoh5fnnf6zf@73yke2jd5eia>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <zacwmavu3huggr5tb3f4pqxw6ca7hsxuaye7okqgoh5fnnf6zf@73yke2jd5eia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZY15MBvfIC1ZLKYDHdOMEAdH6I23igDg
X-Proofpoint-GUID: ZY15MBvfIC1ZLKYDHdOMEAdH6I23igDg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE1MCBTYWx0ZWRfX9yxBBjQX0pBz
 M1TDKYsDxNqZwq3sB1E49XepSIxKpfK9qV2rR89HHYOFlMCKnQWHfeYR/VZojzXaeR49MbWDEtf
 t3ZDdjiVxgLBQ1ZuNxWzAv99Vo6ZUnY=
X-Authority-Analysis: v=2.4 cv=As97T+9P c=1 sm=1 tr=0 ts=6aa91cf0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=mCxFjdEeA7KdPADpqcIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE1MCBTYWx0ZWRfX442LH8MATN/0
 tAB0PaPdLl16tlFD5p3QtbD/J4ecuybr+X264omxZjQRlxlj+UEVr7CCIor2GQS3yEP0n0JkBJa
 2SbTTEY4nw0f8yAGIbUUVIDM+VblTV+MHMCgHTYPbBsOoHXQb0UzgJI+DENm0sQcmJgfP4fhlyX
 d0gP+IRpyRoPNvP7fTfQjs8Cu9GFPRdduIIAZboAZWVIPL4RUwPdk22R1otgKmSAFgvE061LZTK
 cKwF8+bfmxnrTwqyHuJA+Y6BTZSSIue2M8BqDckJSm9O2zDO+Sh2pdMB1ln6rmEA7+huZ4oedH3
 fqcoMn57mamxZy1OmU2ighqz59ImD83LM2225ycfkfdvPdp8jqg4d0+jBSRLtLXd1Uw8oyC1J1h
 7pPSLExgzBlQYmFLivs18y5Bru59msZIf1IqIHW36POI5q0xD//zRA1Y3l/fSj9XZst4b2uUv1L
 aCLDqZBBkjmdWwR5f/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150150



Le 25/08/2026 à 09:34, Abel Vesa a écrit :
> On 26-08-09 17:59:04, Gaurav Kohli wrote:
>> Unlike the CPU, the CDSP does not throttle its speed automatically
>> when it reaches high temperatures in monaco.
>>
>> Set up CDSP cooling by throttling the cdsp, when it reaches 115°C.
>>
>> Add polling-delay-passive so the governor periodically evaluates
>> the zone during passive cooling and steps up cooling levels when
>> temperature stabilizes below the next trip.
>>
>> Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> 
> With Konrad's comment addressed, looks OK to me, so:

It is unclear how to should be addressed.

 From my POV, it would make more sense to send a separate change for 
LeMans with the explanation regarding 200ms vs 10ms

Otherwise it is a new v9 already reviewed which will trigger sashiko 
again, forcing to look at sashiko comments again and reply to the false 
positives again. Just for a sentence in the changelog
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

