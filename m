Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924FA286419
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781006943; cv=none; b=m325m7l2RGffrzxpg+eiKDzd8Bz2IvKzVw/D043bCU0FeENXjO/uiEHfsKjHnAKX8uUhQC/UA2ELrVYR0L5mlgoPRIugXhxdc5u5WPML/GLdwZuJk1D2zF61H3WPd3wqMgxF2Rdg6H90BTxBWgFZa3QnrdcMAo2CTD37WFltgRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781006943; c=relaxed/simple;
	bh=1XiWFLWsxujiQANn+NvM3ghNX3eNtkTv+Cq/YH89VV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctNK+S4GtNcRDj63nmzN5pm4yg5FqwWH/neOvebUUadXaGjgbZW15LuIlo8UQYwaPV25pKGVeNO+rS353u12OeD9DOsHNg6xHiQLvO5gZQcsO5wRhnzN74VhCb40SbVcrqdnpGniVeepwxM20rWljdmmVMOYwjuCSWCrHbtBiw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vehoqstn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PvUGDRL7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vehoqstn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PvUGDRL7"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659BnACd518675
	for <linux-hardening@vger.kernel.org>; Tue, 9 Jun 2026 12:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dYYsHxVGk7Sj544332KQB8eb4Ow5NsC++ELEMmHpcPs=; b=VehoqstnJpt0qrV4
	8+bnw9wPALFYNur5hUGGFcu6Wtl8T1TkhSAXPivti7QD34bCHGvIPw+ocERkFD8K
	u/QQvImFA2xWxsd8v1e34L/fnpVGd5bwfiZ4ErZ4bBoXP8P3nCLNWQCbP4MeAH4n
	pEMSDeTM0zCi/IFgxCB2MVNtib7wLVKwt2kWMXJO6eupcJ3qtaFngGec09FUZC4n
	buR89V2t1zi4e5Awj+GWiRbXvKxl3+hvUmy7sedrkEveSfRprMaiwNk4fhmmeUXr
	53AMvzBUU3QX9x/752j8v6e9m5fcChrX0zmE7C6E6Xv9YMInxW6aPGUtFF/iAimO
	tBURmw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epf0sryyd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 12:09:01 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-963a02dca36so5400296241.1
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 05:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781006940; x=1781611740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dYYsHxVGk7Sj544332KQB8eb4Ow5NsC++ELEMmHpcPs=;
        b=PvUGDRL7Fbr4jMGS9Y2A6cbY1YYo6VB7fzDi5cv/uKGlDl0YW9vMs0ymf9cUoNS7BH
         0RzPi7dR3rtFqi+ib90FyGHg8ZCB9oa54tlBYmhZjLEgY7/Okj0OLmtErqOp10F483+4
         oedYI59Hp3pQPeA41Q140G9C0cZieAr/zFboxJ35Y5xfL4iIwhuRIn9a50Uhswb1gVO6
         LZ1K/hl1UxLNSAA1texWnaPs05yZnLpColr9KkZ+0IxVtL67Gh5nPXK4wlZlCtkjVqAX
         /OSeWhTxFXFAUcQXu/Jdy/J6OTT3hEFUMfTqZ2DlgTYpLOMOxFAGKhDPHCI6B+4poyEg
         zk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781006940; x=1781611740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dYYsHxVGk7Sj544332KQB8eb4Ow5NsC++ELEMmHpcPs=;
        b=rayNswiiTD2M6m409tEeZizR99U7nCggTl57dvFrDp4TrnuyqGhHL/g69psOOsCt9+
         dIlbY0M9/03lLdbXij4MzjmT6O3GcJY26O17IhRxWGMdMyAyaB2CdKKRu+6F/5zi9B5G
         7WKN7sxvDV2iWvdH9+HapcpRAmhkRUEpouAhzFaRmJ2TUGktgo02oLg/04M/FyArI4AX
         ISqD7DfZmSNncmbk/sFO6zH1zkfQJtO2LYSda0DQi/d1g37nE+J6bI4luEEZgbnIaHLM
         Oik/rt+FinfB18u8RgVGtEwELvDn3l+fxlSk4AkW5gPdD5EYQLXa5GFTnAl/yMAGwi3O
         UYIg==
X-Forwarded-Encrypted: i=1; AFNElJ+VnsWnswQonno26qVNFEgblO9Yx9eG16mkTUdecwpbF14z+4DIRHmu+aJy4+xQsILGy1isiJMykQ4bGU+DD4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YymEBkHi1BihkUONjzb/EfQubZp7Jfn0J0CHZRBYw6omm4qxoG7
	pXj/2YcXEK+lc7zJOlTBgHI/BXZYbyVbDIwTdi2AhWRC/yuqrWrrCMeH9GsReH2wK44h4HGPghw
	aKH2rdEhHfCiPsczBFWkjhDzywI/W6kk8W0+8OuOGXFuBI/YzZL4tFgQ0CBC6GFLsSmjlIBo=
X-Gm-Gg: Acq92OExvk6fYzLCFCfrSvqCS45YNWggllxiR9GOLpavX0folkvL2lpK3QvXPOZm/Y2
	BUXQMHozw1ssHbJ7fRLjcVdZ95x0tFMjSj/U+7fpkv522ij9PsrH+UXB0XQC/uU/RO/PJhHKucT
	iZndNrsMbc0t8bZ7tU9y+Zc8b8b1rG7nz9E+P96CPF19U03+TAdtAGt/lWmtyr4vgEhu13EEl+I
	8xkQL5ZFyiAsbEGOigAVZz5oiBfp9hh+T1NiwCngdTi5THone3qoOlEkrfa81AFs0mfT9bF7Mrd
	rKIjrlCebrbT/VR26wj2kpqVCr3ReJamzFGi0e2/OIw9fdhgaEnuuVZnMOu2dH4+2TE5mUXQhKc
	vTncSsOyH4zFtQW4p7ntQC7ypl9zj6b3JwxqDAvN3OcTUDmsx7YGRAGRfvYyQIBiysEYw4yz8Wg
	6kSf9Q/XeOHUYPa5BYWr0=
X-Received: by 2002:a05:6102:41ab:b0:631:4e25:5e40 with SMTP id ada2fe7eead31-6fefc8b764amr10390559137.25.1781006940549;
        Tue, 09 Jun 2026 05:09:00 -0700 (PDT)
X-Received: by 2002:a05:6102:41ab:b0:631:4e25:5e40 with SMTP id ada2fe7eead31-6fefc8b764amr10390530137.25.1781006940179;
        Tue, 09 Jun 2026 05:09:00 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:78ff:9b6f:a837:626f? ([2a05:6e02:1041:c10:78ff:9b6f:a837:626f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc412sm64030956f8f.4.2026.06.09.05.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 05:08:58 -0700 (PDT)
Message-ID: <33fe758a-a733-4f27-8824-3dff398e1cd3@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 14:08:57 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] soc: qcom: Add support for QMI TMD cooling devices
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Casey Connolly <casey.connolly@linaro.org>
References: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
 <20260609-qmi-tmd-v3-2-291a2ff4c634@oss.qualcomm.com>
 <pyt62qpa75nzdatp5xl7vcqrdzmrzsf5ethw6wq62bzg6b7qtv@ts2v53im4bos>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <pyt62qpa75nzdatp5xl7vcqrdzmrzsf5ethw6wq62bzg6b7qtv@ts2v53im4bos>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDExNSBTYWx0ZWRfX9IiW0Ode9JY8
 E7m6a+pJN8HYq2IS5bstgIpZxpyCTNg6+rWEt642Crqynsly/X3jgxpPHBAUzsCHqoQGmfqWZXI
 E5ArPaxlPilKrcRxipS9BI620mUR9B6w2erYUcoghEPGPOvRtSLBtANkZVGEOeEsCzgYMnp5hrW
 pokLCB3vBJ8SMVcedes2bu/PzhTLZTraM5iUAvYqZIwcNRqVVX1irZ8pFZqUhLXyex0aVX4DflN
 KTT6xx9GMQLl126U/m03bZ68qkJo4BpG0uAAHdqTWZeqTyFeGGKWvE/WK2c4fAYniZaHRfkmtYs
 ESUVzrlGClgTWoLKQEtzwde0w5idImva/xtpWcGaqLtsRATjZBUhC1Ovkrg6fE9uuBq828c6dBt
 Cx2ModvKRrTuoNicUB86OGt4v156khiO8DTR/TOO6DR8IzHMclUNzE0bdzjUue5S6PHpWjBQDMD
 WrmaYI8WgtOMPVice+g==
X-Proofpoint-ORIG-GUID: qWP1Zb12ULJvyAMHZAg_DvIAo2U7irkg
X-Proofpoint-GUID: qWP1Zb12ULJvyAMHZAg_DvIAo2U7irkg
X-Authority-Analysis: v=2.4 cv=GeonWwXL c=1 sm=1 tr=0 ts=6a28025d cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=JfLJAETMnmGwVqR1u6MA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090115

On 6/9/26 13:30, Dmitry Baryshkov wrote:
> On Tue, Jun 09, 2026 at 03:52:57PM +0530, Gaurav Kohli wrote:
>> From: Casey Connolly <casey.connolly@linaro.org>
>>
>> Add a Qualcomm QMI Thermal Mitigation Device (TMD) to support thermal
>> cooling devices backed by remote subsystems.
>>
>> On several Qualcomm platforms, remote processors (for example modem and
>> CDSP) expose thermal mitigation controls through the TMD QMI service.
>> Client drivers need a way to discover that service, map DT thermal
>> mitigation endpoints to cooling devices, and forward cooling state
>> updates to the remote subsystem.
>>
>> Co-developed-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> 
> Wrong SoB chain.

I think Gaurav wanted to reflect the changes did a back and forth 
between us, so I ended up in the delivery path somehow. I guess adding 
Co-developped-by should fix the SoB but won't reflect Gaurav and Casey 
did actually most of the work. So I'm fine if we remove my SoB to fix 
the chain
