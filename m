Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD89E238D3A
	for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 21:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750455882; cv=none; b=pBeBLtgg2K4IQIkJDyJ5wrDzF/g9t93Yftk96Qda2BFJBnI6kuFQtfhJ836JPAJAdrskKq4QjGfcwhKRYPiUa0eXClws/Ms2VOahse/SX+5GVeGZ7jY3PBAl3MEXti4+Hco4bWNCZULMfS8JZx9t7E6ifd9rHyDt0gT81f1W2XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750455882; c=relaxed/simple;
	bh=YzcmdcxDrTekUG/seNJPMliDEDlcxMooWnagOOkCocw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKyDk/V9WfqgoqWSx4azsYCiNbF7TQK8dSpPO5bkvP/tiCp94kPcUiu5ztyzhXyI54JbQYNhx7vSjJQTdW7ONumld0wUf8Zu2mQFjAFRj6E1yvWmjcsehunVb3/pSFM/cSaOrVj3RPxPZa9ZS1KhWh2sLGDxoDT+iMUKj9+kDpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Oj/OnBdd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oj/OnBdd"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KHc7Wt025154
	for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 21:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ctwi2DOqfjI225KB6TOH6mB5
	C8TUDi02E4qF9W2x+qs=; b=Oj/OnBddlpiCI0Z5jn8m/1LaNtcIfXnwUDKZVarA
	8fhvrVFSdvAFaiBYnsfpznrEZZNwD69Gy9fEP5ssJSYSRNzgwNcZKD2Gzae37R/e
	WyKbY1QrBWF/QT+jOwEaUvnOOsWAM9OEMCFXNbGXLOyKCecPrT73RONWFtQrB5Li
	HF1YbVyEc1zwwKhzsbUGqGj0n6fl8QyjGOlSXIxslW3swm17MoV/sn2PjKS1RCVX
	PyFWWqDhpcmu7taBPB9NZLg5QUMH52GvcTasH7sHgFOIpch4Wvi+ecwU52MlqPhS
	AF3hBkoA6Ol08L+ySrLGnBMH6cK66CpAt2K1aNPvl4eCSA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47dc72re2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 21:44:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d399065d55so274225885a.1
        for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 14:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750455879; x=1751060679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ctwi2DOqfjI225KB6TOH6mB5C8TUDi02E4qF9W2x+qs=;
        b=Gexm1IM3UgwZVL05MNOaYIdorjzEu5rFph0oofc/L3t7K6/Y9NAuF+IlzNXV1TLY7M
         1mXg5SptwusrS7MvNc83NLSN/UBREksC4S/oC+R72Uds4kwW/FX0zyuuDRVJgt7gAmJw
         XiUyvL0b2KpyJe/2FtSt2WqKjA2cqY/L7XFAUR60xIzrAwF23bhQ/8zNsU+iy8g/Mztc
         Zbv2H8O9EO+a0/X90DtuTZMuajmiHaTXX/jlnpl4mn4pG0KlEJK11mV2ZKllu1QOJ9td
         vpNvVBX+56Vm1jZDf4fp53f0PAmFhVk3CFhXJTfyxjqB6PYfGoOpJG0xN29/keVDlhh5
         xo+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXdvoEujBZDo0PpDgRb4xuVynI76t5yj9/Yoey3qHptDGlmpnU/XV5n6pyImS3Tms9ogolRFnWraYvW7x+Ki0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaIsL2iu7htP/dewI4Uwbd3y+uA3BCcUjBr5RizeFCnHDijjmC
	ooLRW0UjqpGGv/26b3QOCGk7iqAxL5cklZN1mL3rDFhz1Z2FVUkIpyZMOl8M5iNHDns7q6oOmNI
	qbeNrv6ijL3Obt//LlkCuXj1CMQXimUCH7hPEooncavnVodfcLy1cfUxKmu2yNw+FDrBdm8M=
X-Gm-Gg: ASbGncvziAfs8oQNFxiLd9jl6FAKlLpwvTEh1D3/5nBpoHo74s3rQ0DdqBlN4Bh+HY7
	0QhNmcnIlWbgcvFhD4MvW/vgjBHS8M43fwNC6P/W+auLwgrAwrY/CY/pxSVGGIcEWNtgzsVo3jz
	kl9g6I/PnkbfPieLMBJ6/rO7AfqsXUkmP5kV1SMMKbGJaTOnxcRv2SKGuKNLYzUGOhSH/f8uhwv
	CAmWaPJ22ifjmZd/OuY7aJI1F0UYVIKgbZvpbAvhY7DIEiwnUNo6+t7O5BfmI+GI4QAoILaXugx
	LBG4jk0HK577CiULT+wsHpJbccqDpd3E8cmDOYDfGz3Fdt9SGvTsA+XMInUAYFbGKL2Wh93fkwo
	5kESxRoJEfOPfTD4acoM3zrmTIeMXmkeXq8Y=
X-Received: by 2002:a05:620a:25d4:b0:7d2:11a:5d07 with SMTP id af79cd13be357-7d3f994c66fmr697119585a.51.1750455878665;
        Fri, 20 Jun 2025 14:44:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZvdnmqP63O5PRRl19Y/9Q76MA6K05Mv4i76MtyquHA2RkydgG8Ih53vLnCssRj5N3PUcNOQ==
X-Received: by 2002:a05:620a:25d4:b0:7d2:11a:5d07 with SMTP id af79cd13be357-7d3f994c66fmr697116285a.51.1750455878264;
        Fri, 20 Jun 2025 14:44:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a3631sm4223561fa.67.2025.06.20.14.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 14:44:37 -0700 (PDT)
Date: Sat, 21 Jun 2025 00:44:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 03/11] power: supply: qcom_pmi8998_charger: fix wakeirq
Message-ID: <e523itylvfmikypnic7exgrnrtr6ocjmlvtozmgbhqos4lpcdm@rfsqiezqb5p3>
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
 <20250619-smb2-smb5-support-v1-3-ac5dec51b6e1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619-smb2-smb5-support-v1-3-ac5dec51b6e1@linaro.org>
X-Authority-Analysis: v=2.4 cv=GNgIEvNK c=1 sm=1 tr=0 ts=6855d647 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=QHKHbuR_x138-IVXrqQA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MU-_Mwk3UKI2NDPnSiB4HV_W8DiPjU2a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDE0OSBTYWx0ZWRfX/AYHHWlJAxOg
 wWHxJw0c2VmsVR/ty9QkAoM3svrkPkqKXsj8VVhPss/o5MSJTPGa+phk36adJ38BFa/4LMqSLpu
 z9TAjH7o/+ptZCv0J7eskOWciplsUuY0vNOUfGrZWkIrur1gzQMvc2RZtaWrmwkGJqiCSKnjelv
 bgPdzvvak0YRJIbcKn34aaY70J4OaeBh6jvY7CuoT+IXP1oO9So9xG1WyvYqxRBzQ0hEbjwhLhj
 T+Ht3yzoN0mwc5RKBPN5s2ceL1YLsH63OlTOGxeKt6dixxdDBc5tNHFuzz4gG7SY1e8bP8NorKi
 Rb1BCYlekaEtWvIqFOqc60tQTUNWvto8FaRS1+IOtFwanf9FrsVEEBbZ5eUSnkbC0asJHORNjL1
 0s1Gk4pbx/1qzXKDqtZv5X39YFZxlBGmQYBmvMcgDMsxuMgxmNNbQcCiEY/Iqvnz//25k8Mb
X-Proofpoint-GUID: MU-_Mwk3UKI2NDPnSiB4HV_W8DiPjU2a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_08,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=836 clxscore=1011 malwarescore=0 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506200149

On Thu, Jun 19, 2025 at 04:55:11PM +0200, Casey Connolly wrote:
> Unloading and reloading the driver (e.g. when built as a module)
> currently leads to errors trying to enable wake IRQ since it's already
> enabled.
> 
> Use devm to manage this for us so it correctly gets disabled when
> removing the driver.
> 
> Additionally, call device_init_wakeup() so that charger attach/remove
> will trigger a wakeup by default.
> 
> Fixes: 8648aeb5d7b7 ("power: supply: add Qualcomm PMI8998 SMB2 Charger driver")
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  drivers/power/supply/qcom_pmi8998_charger.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
