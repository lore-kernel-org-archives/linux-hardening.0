Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15EC443A9F
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 23:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784675541; cv=none; b=Hu+VbL0+8V2PBElp36TR11kvqIOvvfYiXC4GHBFoqFkGsFb46+g+QwUVYre+QwEZN1H+QF0kEjzS9wgun0MWkcKb2MbIsGv4qCi9/ykJujuWr2++eSlnCnAk34T3Wq7nYP0f6H1fjpRR7yJlY5KtHhuVN8ndyYOoSNA5Wb0OpaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784675541; c=relaxed/simple;
	bh=Vl8rdLXA/zWODT5DG80RoiJoKnYzEvwuaitp4xFqIRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFWbAvrFdgUaewA2BuNbVGLQAeKvL7xiV5WAbKwZb3W5J9u77tg6p+XvQmAAI1LV16W5NhOTCcUAgRwsn+jFV6+xbTV7kz5sjzwAPV48aSeTpQTj8LbzaLO0qQa15mItSIjbB6z6OXcqiOmjP+X5/kvUmz9tgi75mUuPZAoD7RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gCfZDsuy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eZYGPZdT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gCfZDsuy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eZYGPZdT"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LMZoQu3171987
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 23:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DPFjYsfB74/nDvbDbVrJyGiokLJKFBi2imc3uqTjMCw=; b=gCfZDsuyx8wMiPx6
	EjB1L9/DUuBEJcexYw9PgKGiBCWx0LhrRNZDnTEtr4oZxr9P3ly25ZHfHVEKxSJY
	9kK1ufSBa7LZRQmbFZwOZxxyRQvZhnQc7Q5eu+4KB5syWvGe04yqCfHBI1ObuGLA
	e9xx0GnN0cFqNfj8dPDgD45Z/lINTd9Yow4xiY1mJqireeQIxlrPKa4Gmp5J2+A9
	u//EPfo6OEc8dpgB4cNiH4U0FYq41I8WqdOzJLrtTYx12R1SLGGzos9k/52QVrVX
	iixs/rsoNEs083G2eSwF0XCNiCZAxab6sYzdfhkmEETNKBIPu0yyZ/gRwIr1hc/q
	5Phr6w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9bsahgk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 23:12:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1eb52e1fso122217261cf.0
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 16:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784675538; x=1785280338; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DPFjYsfB74/nDvbDbVrJyGiokLJKFBi2imc3uqTjMCw=;
        b=eZYGPZdTZeUyLiFgHtkxVwwsHrQCJNQS0MfA8po9h9YZHmhI8dMwN8iWAH4nI1LCUf
         0crx3eAqsciFZtI28rdIlPCuwPQMeVI+6zbALE2QHZJySm2K4FV2TJezmKRYlrRARVwr
         1V+ZqnDllpCMKIEoJDF7EO5ZbBVKgqS9ucu9D5Puj8dM6LUraoYevqOaS2Plgji80HKc
         koCeIIAlJJIP7TVaLVEOPzofaMlWS2BOoQtRo+0s2fKCXYHZ6yYivn0i8Pz1PWk0U5Yd
         z9DNz97SN217iAI6dLD08FLbjALb2uuHKbPhWKLW8ErfaVuAgq7zULwlHzEmK5toQks+
         6MKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784675538; x=1785280338;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DPFjYsfB74/nDvbDbVrJyGiokLJKFBi2imc3uqTjMCw=;
        b=V/GAqcQw4IgVul3/dpjkh6E5YnjzbPIADz4aHTLjdcCmN9O5Gbo5AzE8MZ4JxkWQaE
         cIKmoVpICCLDNzgeMx8wnbEb2ir3Os1+ojnAk+ZBQp33r00YNDYpo4pbwYeOq/YNXglK
         XQ00ONiFqTb9xwlW4i5AVLC6+k+mvnmekiakb8XSksoQavYenvsrVKFkhHGb0Q7oecJY
         +iK9hhjG4exYfhsdQfKwRmlwohDsB2BNxfK+kJ5+ypawCMB7Tek7NfZnCK9XUZx7uWvA
         YhvQtt5cytGoZI0JZPaHx90fopcwgoJPsu9AZU/CBAMbolZnz4TV5wEnsl6d+ODMSExQ
         iy8A==
X-Forwarded-Encrypted: i=1; AHgh+RqdvzEihJRdmQoSa3jvGSlx70LJlCKpO2Cufq8rZZzk7s+ZhrxysGjBNz6ZZWh4e4GkEiG8ttlQe5PZHbaLf8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6iwhgBWO7zBbQZiOM/5oNT7GJxMsQ8QLYQ6B9iVoifrADb7Y8
	vibcfSjgsjB23w/2v4BgNcRn4AFYpwvwnCXCQzESUHInJAtDsuzgsusFyevqAK2ykUjxntUlgwC
	p6luVwlkIFP0tFKFT+YASTCQcB/FegOYgDCSQsb2DOJaFXtJ7EIGUtH1dEHllHoWZHTJR7oY=
X-Gm-Gg: AfdE7cnXbgbrkWaBbI/Q+Zm2c/XG4n0zHe29+fHDhF+BaZiQEs5z0Up6dM9kWAXFx77
	kOz2prhMwEbTV9/Q6GlwZN28gmaThy9vd3HsCSQLvdAhjkR9kZuOoeRE/zPa0kKC1ZFMvQ5YmIF
	zV7b/qBDBNksWe6XYzOqGws5GiojBbUVoLqukElqyWEeWBjXheiQLFfyqhS+iin895PSvv7qE+K
	wSfNLCizu+iE1VTNM7Dr6ueZtO1/6UIo0icpfgmksWFGDUVu9KokhGAGsey1Y4jty1UeeXrFZHV
	VjwKWSvNUcY8/msJz+tZBOLH2NmDdC8mpQj2g78ZAdoHY+r/ORjRRJ+g3i7N/2AMaNIAHwLbsvL
	wGAeNCqZRUhmw+bAbqLUf/MuO7RIG0CpfgQt4vvPgOjsoeA84jtkfJZSzeIUeFpE3jp3Y6U4JWn
	I671UGS5pHMe6D8A==
X-Received: by 2002:ac8:7dd4:0:b0:519:f884:b587 with SMTP id d75a77b69052e-5213ab6d3a9mr195185201cf.27.1784675537743;
        Tue, 21 Jul 2026 16:12:17 -0700 (PDT)
X-Received: by 2002:ac8:7dd4:0:b0:519:f884:b587 with SMTP id d75a77b69052e-5213ab6d3a9mr195184921cf.27.1784675537347;
        Tue, 21 Jul 2026 16:12:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39ef68b7425sm1387111fa.11.2026.07.21.16.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 16:12:15 -0700 (PDT)
Date: Wed, 22 Jul 2026 02:12:12 +0300
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
Subject: Re: [PATCH v5 6/9] arm64: dts: qcom: lemans: Enable CDSP cooling
Message-ID: <mi4irfwanrjjv56p62nn352yinzzxuig56amv3xkpkscwlrywl@pst3udv3kpth>
References: <20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com>
 <20260721-b4-qmi-tmd-v5-6-99620e07f505@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260721-b4-qmi-tmd-v5-6-99620e07f505@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 1RKzMcJ6toymZFVeRjfEpxlAWAih_vRM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIzOSBTYWx0ZWRfX4qOZlVloqztc
 lRjtcZWNnkHG3eP9D4kVyejbAQqGMA54ZN7UyEV65UtHYWiSNdc3nkE3NJdRIaLbfyTOdJ72Yf6
 QnLR2u99SyM5XPsD5TbSh0XLTd1uFxJOvYFr6jkFPzYMBmw1Rr5wzlw0yGS3IviwxE4SNiRbb0/
 i0/W9rOGw3CGK2L9zjc0ySiq3zCHNhlfvePQQtZaKf05/l0sAHSlHcO6BiU/oL/VJKTzYzMPbtp
 +DHGqqbnokZ2fuqvD0taM4IP4kU5lzOhnq/xdxthC8lrbHsEvbwiFilo1lJkbtQ+N55/O06F8P2
 52+rHzuGpOhYQU348Vw/ydPKRb/JdmPUFBjZSnQrpCQG+SBecYK7JUIQJOffwRHrAnZef5tp8Bz
 jQOdZEp7IP93/CbPmbdCXr3yMTtpCJDPaiJfbAiJK9oe9e9mydrlgSQbjbdjPDb5RvMkbtewXLq
 /oQD6obwvBHbwEcncfA==
X-Proofpoint-GUID: 1RKzMcJ6toymZFVeRjfEpxlAWAih_vRM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIzOSBTYWx0ZWRfX5/3jo008ZNe5
 8AG1YKuU8mBxQYZBXlQ13oXNAW1efquEAtor6PlwuGd/YOp7fUcifc9ul3PLjf09wf5XixdluDe
 DIQ2qRZqfc38e0ly95XmR2RXItf5iAU=
X-Authority-Analysis: v=2.4 cv=QK1YgALL c=1 sm=1 tr=0 ts=6a5ffcd2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=ysZNT-AePBnC6ZdsTwIA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_04,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210239

On Tue, Jul 21, 2026 at 11:59:03AM +0530, Gaurav Kohli wrote:
> Unlike the CPU, the CDSP does not throttle its speed automatically
> when it reaches high temperatures in lemans.
> 
> Set up CDSP cooling for both instances by throttling the cdsp, when
> it reaches 105°C.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans.dtsi | 125 +++++++++++++++++++++++++++++++----
>  1 file changed, 113 insertions(+), 12 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
