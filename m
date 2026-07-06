Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24122F1FD7
	for <linux-hardening@vger.kernel.org>; Mon,  6 Jul 2026 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357707; cv=none; b=dp1oT/x7TXgmj5gW0qAgX9j8hNljFdannnTtB/09RmkCS7Cui5DO2Si7SpOpW3PMlbH+AYQkM55+5TIhNOVBuD7vZ64AjQhIda+6kN4cS+L7GYIUb5O/YN7uv1/xDTMpugUMP31Zvz8f1h0tucjOta3tbrGs8pp4/72pbgPyDIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357707; c=relaxed/simple;
	bh=IZGbYaxH8ggjxoIMYNl+yupFd97qlolubyfSMaIcNTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQrb70MQRoNQPGzjrmjuiYIkNo+QGFPFaeXB10y/27avO+JuBQqZGSaOwNeFcnhf5QUj3w2LcgCwWBHfP0Fdn65P3skTXcIg7bq6kowHj0/y8s9+s6x+7daWwMuMxaXg5W0DEct2ipzBIK9/s8frF1bLvIwNJLu0xNthr//HlOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DFEjFBui; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X5rdUU4/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DFEjFBui";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X5rdUU4/"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF6wC832916
	for <linux-hardening@vger.kernel.org>; Mon, 6 Jul 2026 17:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7OEXeTG7Fk3+hIiVqx+oEcBHQzWnJhCqfnlrjuWJG/g=; b=DFEjFBuiaow3l3KQ
	48x9uLdVslT5J5BBQoMHLDn+doJBpQLrKQ3YPrHT99ZdJoiV0NbNKc0fO+cHToB7
	RZUYNlWA1W70yk5CxW0oye2NBslonJTYkTgxmfYsxONa1ro4847V0LDOETJABpZ0
	HrUNwjFAwFQh4VPntkV5ZLgsJMa9vc53RYoKfNsH+MTsUkLfLq61ylwmGM/7IXUB
	ZVUGRuu7A4VtbVn7D9na0NpNJaqvHlgsSV/tWXFhydCQedZ41IhXXVIQLEF5lzqD
	e+fSoZn5/Bx2af3pb/Kx3xpR8RdmagdBHoYhFjMoOwT8/c/X2AJZexg1Pih31lLR
	cdhQ9g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98hy0b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 06 Jul 2026 17:08:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e9a2b95b5so514508185a.2
        for <linux-hardening@vger.kernel.org>; Mon, 06 Jul 2026 10:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783357704; x=1783962504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7OEXeTG7Fk3+hIiVqx+oEcBHQzWnJhCqfnlrjuWJG/g=;
        b=X5rdUU4/6+r/FJA0srLv7JiUy8mgLyAFSXU2hqHQofLoii76glfFJQ0lXLRdFUb8QP
         4tFNu6iXTWV2M2oPP4kQplAv5+WCZs+dN1UGOGvhIfRdhh4bGXZCHr/mkWMvk5h/HCr3
         dzBrbJzwca+JQ6/rvZav5dFI6rwJwLRrsuiISgFs0bWhQe5iGmgphJHy6Bw9tSb2Tmt3
         gReuhCPEnIjKbqYe6kAqZxuXxjDJy9ub54iN1ETU0GzJSmi7Lj/P16GzCTstTpMEYQ9u
         9ewkFAbhr8W2GmRqzEoJs7YZtcQsyrPyhxDE1t8OKQhHVw1VmxJCMyAxSllt0P5Fqd2v
         c7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783357704; x=1783962504;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7OEXeTG7Fk3+hIiVqx+oEcBHQzWnJhCqfnlrjuWJG/g=;
        b=lBY09jTzCeeU3gX/x+WLa7xM4z3+EJdns6qPbe9oxAP5pA6ulRmqUa4A3vxeBGgXOJ
         4l1AqD/YQIze4TGra/eIntHBfHYMmYXsI7e/sOyAYwBOIRC6ql9zS85OSrrf8GkhrOkl
         xOzPHFqrtfTAU1C8skF7Rib+QHd0WL7mqe486oCiFAcjLAe1gm/uDbS/PQKuZMpB0Dqg
         BinwQb3mcjzXyX2XCFwlBiJpQ3CYEXxgZNAsrBckSYsi4UN9SI0NYUgWu0CzRf1JEirK
         6u3dG3emgtuEiS7IiPIxvxKQq7qhO218jOtsoNkxqO08sP+HGJ0dq4NwtQPK4CchhaVD
         BsPg==
X-Forwarded-Encrypted: i=1; AHgh+Rr33MZod9F6+nrLv4Droa0U9rR2FbL3dGn+vk9bPexPQ0aYRVOjT9kHo3aK0MAeVUuDJD0Wu+4U1vg0mp8Y35M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Chcn41S4PlMxtTYftMhINoxwtCCO4WG6b1UCSzSsaL2d4jXe
	1BE0jLvWsru8rMqXJ6RllBrNAE5XRFJn2FJxlsT3sIq4yPnUn87TEv76Rt8fpBjp5rDYWLH+DRu
	/+y8Y+tUDdT45mjSewChX8xsrYeLx9dK8UfExosgGczPaCsYbG9gbcRK7QHsnZDLjh3bsw1s=
X-Gm-Gg: AfdE7cmjHD0YLNUa5oDsWGj/vSHlresiMr40f2l7+Hyg/EscYAcl137SiF5YSfdv9lb
	Tztcr5nKsUvWwmSCmzRQQ3DziqRDuzX29Sk4NpYBB3+OLypBD6y99lF76OOa5Ghp89Cirj0sMRj
	+m1lIUHSLhBdJzexoF8wXAKgEnKJ9LgE8k5NKtLfSBQRu12Rp1HYq5yqxvPy1TRXxu4dzxmptpU
	Jyt0VxzF8RvJbPflzoDsoa/S/p4s4/0vHvDdd/azBqzkHn3YHTq+Y9M5jX3qbJBn0ZmqrQ9u/v/
	KQbDfunQXwAGHJ7mPww0FRkdbYAu92oMyDyu61W3xN/8cjGlqAeTY69U0eKdXcfaJhts1jS3idf
	nETkKYqH3oL5Nty39GQiA4MKoodzj4PnjhCWHRL4Nk5gG7QD02E9am2ockm0iAXT46aQlnlFUQw
	==
X-Received: by 2002:a05:620a:2991:b0:912:1206:ddd1 with SMTP id af79cd13be357-92ebb52fb00mr210915385a.1.1783357703718;
        Mon, 06 Jul 2026 10:08:23 -0700 (PDT)
X-Received: by 2002:a05:620a:2991:b0:912:1206:ddd1 with SMTP id af79cd13be357-92ebb52fb00mr210907885a.1.1783357703111;
        Mon, 06 Jul 2026 10:08:23 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637bc21sm686999515e9.7.2026.07.06.10.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 10:08:21 -0700 (PDT)
Message-ID: <d9c6ec58-930f-4834-ad3b-d9beb4e21f6a@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 19:08:20 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] remoteproc: qcom_q6v5_pas: enable QMI TMD
 cooling support
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
 <20260703-qmi-tmd-v4-5-3882189c1f83@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260703-qmi-tmd-v4-5-3882189c1f83@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4be109 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=gAhwoHsd_6a96UM4EnwA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE3MyBTYWx0ZWRfX5HokmO24gqMn
 UlPm9maNyiOf1nZISqsVXCJNfT8rJXYq60AcvcL9W8ZzUKGH9LoVu+sX2YO9wZjZjckYivWAOTA
 sLevdqJOgBKp4ROBWXXFRXOpjn798gg3cSduDz5I6Bv8aLKaidOS97JYinReh/UCIOBeard2Wjx
 VwdV7EcIbzlRRkGofWGijUke5tKxTW7iN3vegLywTgERgz5PU4d0mAG80tpPm1qnzuYvR/4pF+Y
 3bemMzYB4QhXt1pjsnuj0ufR/ySKOGiHHPstpctRTcosoa+LuylC7Nr4Gu9lJ3xzRpaEN+hLkEu
 hb/nXqlnQAebFl8rx7PYS428XKR38JW75LPauVgGk5CF2RMfjNPMcDaAJucc/IpUqIoE5N/qKLK
 /YRe68bnRaQ2d2WnITCoyHuI//G6kBEhcaT7y8Uc0fGcXH4kU5XyKT+czaG1+B5230/TWeEfecW
 swIFbfoKyYTJiCxXMnA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE3MyBTYWx0ZWRfX20LgU7HZCbIk
 bPYtsq8CgfyhWYu7ur4NXePXoGrXTz4HyhY8+mGeqvrqSGslxSfrMEiEnGFXjepVim1+aztV3/d
 rQmd74E9j5mbgvBm0xgvv5Zp8SeUWtE=
X-Proofpoint-GUID: jNHPgzqTERUys2J9IjNj4livyx6tmTxu
X-Proofpoint-ORIG-GUID: jNHPgzqTERUys2J9IjNj4livyx6tmTxu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060173

On 7/3/26 07:03, Gaurav Kohli wrote:
> Enable Thermal Mitigation Device (TMD) support for PAS-managed CDSP and
> modem remote processors on platforms that expose the QMI TMD service.
> 
> This adds per-platform TMD configuration in qcom_q6v5_pas for:
> - Hamoa (X1E80100) CDSP
> - Kodiak CDSP and modem
> - Lemans (SA8775P) CDSP
> - Talos CDSP
> - Monaco CDSP
> 
> For each remoteproc, the configured TMD QMI instance ID is used to bind to
> the TMD service running on that subsystem (e.g. CDSP: 0x43, modem: 0x0).
> The driver then uses the corresponding TMD endpoint names ("cdsp_sw",
> "pa", "modem") for cooling-device registration.
> 
> QMI TMD identifies mitigation endpoints by name, while DT thermal bindings
> reference cooling devices by id. This change provides the mapping
> between DT cooling indices and QMI TMD names, allowing remoteproc nodes
> with #cooling-cells to act as cooling devices in the thermal framework.
> 
> With this in place, thermal policies can request mitigation from CDSP and
> modem subsystems via QMI under thermal pressure.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

