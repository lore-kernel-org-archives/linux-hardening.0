Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A2B3E92B9
	for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785499148; cv=none; b=hdoUyDuKDHY6M7RujZUr7aeW+xroIp4ZJYddDOHj8GzkuOpJ3zTNyprLVbDPKesJefiTUDFriybO2uME0eiML+HCHM/0rd2xcjC8TDWf8j8qVO/8ugZDeAJaE9pOUmnmY68yU63uD8O6PPFzG2DZ0nT02h5VsijTcBfwy7GdZac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785499148; c=relaxed/simple;
	bh=GELpTNNQJlbU2tl+wAZ0cQdnJgR+XPFVoYc2iOtYqcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcQ/5aTnm5x7hbtyoGBPR4JNObyYhjHPj9qseb/INJC050FbWkCb8u6OOHeDKNOkW0TFxbSWTRKSJz8XaANKXGpf3YGvytVegzTJ8AcIt6MIkM+E3w7V4EuS0iHUGivIIcPguswrFV7GhQqwG6pwFWgt3jjEf3mhmLCFr42hmp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gawz+7qI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KqmDNup3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gawz+7qI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KqmDNup3"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBgg283797931
	for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 11:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M0deU4TNX6fHxv9J0oFHoUXvgfYFVyrZJE+0KzVtFN4=; b=Gawz+7qItjp6JBG4
	wSZFtXV1r/8lDCem7/WneX55pR5DsP5IgR2DBJcb8TDx5PDGjU625+zPx6tKUInV
	bR72gzJbsg8LvXnGgUVwnTQBvA/usttj6SK3vC0RA2+UtSjwIQPiPgvX6h6CY/UH
	t8ScB06S8QsC+IKuD5CCTRPTt4ySIE4GXRGunyqpMK4ZlMcht+Txh72m0kMkDzMQ
	lXmlwk9gQGyNavFuxOIQH89B3h7AILhdJDwNSkx1g4Q/7doHozLD1/04c6ZdAFCJ
	3Kd804ctHFVuqUgMASBgyRYYGcCIw1xmTv/+y8hoEsmB2Sde+uhOt96fl2VBuwmm
	xiow5Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru2u01pn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 11:59:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1d137a68so15521871cf.3
        for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 04:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785499145; x=1786103945; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M0deU4TNX6fHxv9J0oFHoUXvgfYFVyrZJE+0KzVtFN4=;
        b=KqmDNup3IOlZq+NKpDSTR6kQRcHHpVyMqsKlrROjRvbzUo4hFXiOkpYlwQ+MMgWP3n
         +LtwTo/ZlS9/4xmFwR93Pm6y1fxm+v9DWIECsXtcKvkgqYfYf/x+gFJ70DaJrX1xblEc
         P/GuD+bVbn+SoyASahi4xU5+HuTbnJ2hZrRexAhBWbsXLYW2A6f6YX8zX4f3lwPs6i8v
         zWHbCEqzfsQV81Id2+1urG1QpZVPp9I4L21t3vDvU62tsV2/OoJYT2YE9rWUAGhryrz2
         qqQ/L821w+mJZ1CWDGrrafgJHkZT6zsRWzLSK5Gq7lTcrDKqVyVZBru9TJM8UROiEOiH
         L8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785499145; x=1786103945;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M0deU4TNX6fHxv9J0oFHoUXvgfYFVyrZJE+0KzVtFN4=;
        b=gqMxUPcW5doiZxF65MpqT3NXDJV2QHukgFfT7YeRqfH3c7vtT0vIil9PCFbQdDMA9+
         fFMUjgZp6NryW6NhWXyRLGKe2vFuOAaQHVtmAbP+9RGChFHSpr9XraZJBZZkqs8UPFXR
         QbbNWzbYFPdwUG1DMIWxsGAKlyG3ZqLMpwvodfAs2H7fId9bhTtxIVkI85RMs50tVliM
         u0NBGVi1YLxwWGTq3F5ErdnnpvbnW/r47fzJLlGi/wrhqpCX1zuIuAHg846aA+xHLdKy
         vgjzHpvA+d22px8uR1EdiMW1qKRtu1OwHStK8ts4qvbNRQR69XLaQcGXzx1vPKz0VY7x
         fgCw==
X-Forwarded-Encrypted: i=1; AHgh+RoLrx71WULlUqDSnS+Cr5GeiUeTd7YF3qAH8FubUG5hUbGDcl4BNqSb4Tr8QsjV6Vt1G7+FuJOKMaA2+SnyWGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu4bEDuhZrlTFBXk7OgWouddkn35MF1l+yuY9kYs34G2XNVYJ5
	wdtrwa6MFml2VB5Q0QN9NuZAqeVXOa7J4EV4HSShUq9zhsS86BHkPWSnvwd3ttBVyGzkbGK0sgM
	aFUzHfNWa9yVykBuj4j2y/voQlcKGaVVk+qEuGV/bb9UGImLXCwBrDisKHLcuy25UBwL5Oh8=
X-Gm-Gg: AR+sD11ug5xmmHjRMpa/I4c444lIHWUOqn6CTRkcEihIbwdM+IoGT5S4CgSPVoLIGfk
	ZcVAv+mDwziBAX58yGVhqKG4HTMQ+5hiAAu1a2iUqUDyPYR5mZCZ5BU1SfdYeVIAbduN+Pj8p9v
	DYcqBtKAS4wZhkUFB3DtS7DrBJaTVYpDXPOkEua+0BStwAS6vnoMoxGe5X5wgdp4BHMae3kFQJt
	J3RGArxzIF5xYWp2XtvIRnRLU/si7IsCTJmx09NksMUEyEq3d4REsdwROjxe00l9yclGvXP8OdX
	UQ/KNBd4FKxXv6GoImeJM+bIyPfvAA0m/jYZxdHT/96PlAwAXdC+6moQrdQHF9LQ1SEDqmxnxB1
	dejKB4v3Wug/OCXo=
X-Received: by 2002:a05:622a:5593:b0:517:5bc1:e1f0 with SMTP id d75a77b69052e-52b4aa0c880mr23329421cf.0.1785499144744;
        Fri, 31 Jul 2026 04:59:04 -0700 (PDT)
X-Received: by 2002:a05:622a:5593:b0:517:5bc1:e1f0 with SMTP id d75a77b69052e-52b4aa0c880mr23328911cf.0.1785499144278;
        Fri, 31 Jul 2026 04:59:04 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.163.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd4068fb7sm4618924f8f.0.2026.07.31.04.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:59:03 -0700 (PDT)
Date: Fri, 31 Jul 2026 14:59:00 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
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
        linux-hardening@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com,
        Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v7 9/9] arm64: dts: qcom: hamoa: Enable CDSP cooling
Message-ID: <aljdjmmenszu2gtdeqy47sblo7cfz2hg2rxvaedie2s27e7gcv@jdzrzzdxrwbg>
References: <20260731-b4-qmi-tmd-v7-0-3befd44403d5@oss.qualcomm.com>
 <20260731-b4-qmi-tmd-v7-9-3befd44403d5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731-b4-qmi-tmd-v7-9-3befd44403d5@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: pkgCA_gatR2A4jMRPjl4Gc68KYWEBFDj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5MSBTYWx0ZWRfX6kW/ZV1FOuSj
 NUTK49zDh3heu5u5lBkdHPlgkTpCmT0Fvrvqmu32RKAik2Deun9RKo0scitagQIJxuCQ2E+eSbl
 e4qTQpzfgTfXoq+eu0m+yV2guZLo3yQxP1h3b/ExPDLUj32dEu8/XlOLfSx3Af6nJqMpyn0HE0o
 K6l2ik5sIs1CPQbPalpb009ZAzMA/L1mNpiwnopN6ca7o1y+cRwGMZxAeIJNc1yey1dT2U503Q+
 MY3Y6yMOeEbsFGO09C3WOTbYGscsYzF4OSJHlkE+em6AEpihRQLjAy+e7UeSqGYswmm659TpHTD
 UVU0Cz2UJgs65k9Ji/0Rmz73HnoBeVWIZ/m+sn4VJkI47TRamML0I77Xae8S0JX7ofyM/dkscco
 MEDGinn1TQ8cdxSjJvTvAJZVDeWrlR04vg97ueLcucPB8D+2Id5yL1GIpqk8QuWlUsrv0nIzrxT
 YKcy+GRmrBjDiWHIxsw==
X-Proofpoint-GUID: pkgCA_gatR2A4jMRPjl4Gc68KYWEBFDj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5MSBTYWx0ZWRfX38ke0ZbkjVU5
 xdLMJHAyl30uY/4Vv9e6+S7lkS0t2UIQa3dgQI0Yl8brcCQWx6ao8hRyYPaV2fQ758u5fQ+07Yc
 2fWfbHMGri4fnfnKE1uL4jE3as+mta4=
X-Authority-Analysis: v=2.4 cv=b+uCJNGx c=1 sm=1 tr=0 ts=6a6c8e09 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=6dw9+iwJWV8PcCi9M4lOBg==:17
 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=_nN_CDt7C_a4776dohAA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310091

On 26-07-31 16:03:49, Gaurav Kohli wrote:
> From: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
> 
> Unlike the CPU, the CDSP does not throttle its speed automatically
> when it reaches high temperatures in hamoa.
> 
> Set up CDSP cooling by throttling the cdsp, when it reaches 95°C.
> 
> Add polling-delay-passive so the governor periodically evaluates
> the zone during passive cooling and steps up cooling levels when
> temperature stabilizes below the next trip.
> 
> Signed-off-by: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

With comments from Stephan addressed, patch looks good to me:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
