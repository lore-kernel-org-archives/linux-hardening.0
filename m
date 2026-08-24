Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E507F42902E
	for <linux-hardening@vger.kernel.org>; Mon, 24 Aug 2026 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581071; cv=none; b=O1t6BM7R+OvUnCbfbOpEEzNqKTjvthsXbuP9rPWPkjXQceyjy4gxYqBIULf3jqq/mFjpB9UHODfo7cwTr9NswXLuLYanxR6xd8lafIGsVmcD+BJr2pvmd/fK1noTgPk1+RgEXsD7FyOJSLqcPzs4yKjDgi48bpRdKrpN9Hi+9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581071; c=relaxed/simple;
	bh=TvryIBgvCG+IvPSiuyEqxDbZRXao9oq5INN8DtPiqn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnNXf8dkQ/uECj9LjOrqWDACewGPGvOnjRFT5JxiFApCV9GNKfnNG8c4ZYigHSIhILdkl51tkEQYnUl75KF2Bgjnl9wPdCwC2G22gVNKcjuULKtozvxLWPex77fFwGgZLocIHA6+nwn0YT/md9C4zWTBzPV7MUcCe/53sSZyFIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V3GEejuG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DJHjevcW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V3GEejuG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DJHjevcW"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OCvBeC2950727
	for <linux-hardening@vger.kernel.org>; Mon, 24 Aug 2026 14:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nay4ph6sJ6t9Vrb27RfArGCx2cz1q5GIFB5U1F0+RMo=; b=V3GEejuGocWXPJoy
	sGgGnF0VyB78kCLJ4VxL9tLOdkRyGFUSQfF+kPpPU57toCLoobkpE7pxvUIzOkNY
	lj6JT2yxWOEVIK+4Efza6iyzHR16ZN9e1b3ZvKS/ogJ3/IvmUMvj7bneP7hA18o9
	POg2Y57s5lPS0MuY1oBLsgf+LzSfLdYAiKTfNz2OqT8m/5kpJA7mfKfnvVDU/5kV
	1vZSy6x3UMpXO244R5qV/yZmGl0EdKf23+qUseVkBwvLMeakXxpz/ZfY/ZLqDJHT
	cnAVxDKKzTj5jRlkh0RdbKrJYMBvG7Q5OvFUTmGJJ/k7Yr3qp+uAzXnShUCQ60S7
	xjmzLw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8j7r1gyp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 24 Aug 2026 14:17:48 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-977c5e92ec6so44847241.3
        for <linux-hardening@vger.kernel.org>; Mon, 24 Aug 2026 07:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787581068; x=1788185868; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nay4ph6sJ6t9Vrb27RfArGCx2cz1q5GIFB5U1F0+RMo=;
        b=DJHjevcW62oow1w3kWq6Dvil6k/O+xu9yTD+0h6CHkN1qeBKBZSqcnKYkCRsR7yu18
         PHyQgOBX7b3sMEjNf7+FQ7NDoF2MGNmge4fnrySO4e6wcAvkL+fPXg5gHZot+CtPXjmY
         J2UKcKUsYU4zM3gwQ5YzjZgy7VoVQz9uD12swBTnbbsF8qL5stG1Qe6/Qk4VrVLyJ/lf
         OyFB5FyVZaZjiV7/+LnNc0es67r6uPdDsMV+sMY6yQ/HyWRRl75fU0fZpgs23StTic9D
         mrXKIxa3+OX2Ovr+NePLlioNf6Uw4fNIOGfKK2AB+nqOGgL9U9tu1bRJbwMF/N5DxGxb
         TrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787581068; x=1788185868;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nay4ph6sJ6t9Vrb27RfArGCx2cz1q5GIFB5U1F0+RMo=;
        b=SKT8vwII4hQpZvj8i9uIfXXXfrx5E2xG4jjN8ERZuwL+V9+XpDEy3Np6GUr8yFGnHW
         TYd9F8J1A8wVHYVt34jPSLPlvPpBv1NRRsMbq+3BIZ6MUDpLznzzL3iBYI+k73wyncye
         Kte07MWsLv43QSv6q8gjBSf7y9rI//oxtKk3ln7v0whXiDTbG7lKOO1ot6jcBH1Lqakd
         5hMWMzcEFGB/rQAqYsfShSaviKGDbgrGsPpv1y3dFhYYdy6eaiwFaev1bwzmUWhN0TVi
         oxed3Oc+YYAjeNIjKt87FsFSi5W6Jm2+CfGfmULThBMrpOB9uNxzDlHU7AhhNVmN/0Ku
         BQZg==
X-Forwarded-Encrypted: i=1; AHgh+Rosqr0G9PQHedjbcyddFXw7MXOVoYKqrapuSSgRNb9YIDdxSUVUFibNUpXYbEHcJ7/mHrJhsww5w2UXQQPm73I=@vger.kernel.org
X-Gm-Message-State: AFuF++mbYXvAk3DMtCLvUUaUZz1jzHlya/XnQP4sd4yuwOAq7CSDz6dH
	PNUkbL45IlIvheLnoDzdgUtjJW7bSsgc557jimTX0B3wIMmuoNpP/ydwmlUT6za7GNa/36QkHLM
	Ag30m20NVm/NtVoezyqnls1G7dI8M6jNAj6Wn1r8LeLK4zKu211RY1FRkD3qrpBn9jk1cgG0=
X-Gm-Gg: AR+sD13SANRb5Ig6nX82Z5lUb0uue3r1eWlmkig5uC04asMmozqa7TnD4cXTNPFwH9H
	u9IjqCKqozola068JWG44KMCAi9lIVnRRDas7WavdUqzVONN4HKdWRvUGJpO0LezBLJFVkP8pY7
	UXf6iK3BawWVdLybJYdGSXb7aMa5neWvbzs0WxNSCMls3R0U27bSSXIrhxMSjoIVnbApR2y00C4
	UaV7b3myZhpmpUNQry84XnQxh8DcW2GfTiGnHVUfaWgqLBZcG1qQ+bZ19knaZ+TSIjK8hgrttnw
	cXFiZxP21lam4aMiCN0SPnUZQriOTkKVNQIFnxnzlh2IrOxpozwzQrxg21l6g+57gOD4/jnUSIo
	6FXEhqKgeCmahgXE4hyHjFdfr
X-Received: by 2002:a05:6102:f90:b0:779:7d3b:1398 with SMTP id ada2fe7eead31-77a5edee8a5mr4020956137.0.1787581068107;
        Mon, 24 Aug 2026 07:17:48 -0700 (PDT)
X-Received: by 2002:a05:6102:f90:b0:779:7d3b:1398 with SMTP id ada2fe7eead31-77a5edee8a5mr4020939137.0.1787581067732;
        Mon, 24 Aug 2026 07:17:47 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e001305sm9565004a12.4.2026.08.24.07.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 07:17:46 -0700 (PDT)
Message-ID: <b471a134-397a-4f0a-9d79-1777ed067c54@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 16:17:43 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/9] arm64: dts: qcom: talos: Enable CDSP cooling
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
 <20260809-b4-qmi-tmd-v8-7-b15d47adc379@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260809-b4-qmi-tmd-v8-7-b15d47adc379@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMCBTYWx0ZWRfX+BUvfw1jMqoJ
 iNaprxWJv68k+15xnnnQ4VMoQdnLzod6zOO3erm4+7rrId7s+Z63jAwp9CBquWmEEgM/tWWRBT5
 5abaJ5TQ9ENZ9152xpyHAiB4zN6BQh3RZYievT+F4Z5urGUJPPGwGeXujBs+av+wd77Sa9RHOCp
 zaqWFR3zj9rtlyV9hourDWxn5O2GNM87b7joyqKMKO6QNAyYFweJPBNrP9M24e+vyPBzxg1+pzM
 SetSFXWD/rB7k4AcjM7rtfohf4xStvLib79oKrsFXr/3d3/ik+bVStRTUn2yC9tJMZ/t/X9SIeC
 OHK19TGHoQDKMmhPsFK+33UYL8I6i8BsNtoRXVrkneote1vlOn8AzWB4ba8duEnkVFRBztiCKfB
 UQl1G3BIjCW0GqMcf5tYIuXp4TGBn9QdPM4W2qccZuPTVcVirO33j2RuLJk2Qt6Y5O1P5I7ZPSp
 8xIIf7L1D2b71vHTesQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMCBTYWx0ZWRfX4NIvrSOQNnkl
 62O3+xLRFJBkQpiEkgzoD3u4mFAV6BFVWV+J43o1WfMuwo7Kc/l1MOW57sS/DWUyhLHoEYjprHj
 5yHQggQcyBkfxHrALJdnJiryVoYXqzc=
X-Proofpoint-GUID: uSxsAbalrwYe4sUYmLd__SvIf74OV3UA
X-Authority-Analysis: v=2.4 cv=IL8yzAvG c=1 sm=1 tr=0 ts=6a8c528c cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=mNkqgjryeaPBWjMOkUYA:9 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: uSxsAbalrwYe4sUYmLd__SvIf74OV3UA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240120

On 8/9/26 2:29 PM, Gaurav Kohli wrote:
> Unlike the CPU, the CDSP does not throttle its speed automatically
> when it reaches high temperatures in talos.

[...]

> +			cooling-maps {
> +				map0 {
> +					trip = <&q6_hvx_alert0>;
> +					cooling-device = <&remoteproc_cdsp QCOM_TMD_CDSP_SW
> +							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		mdm-core-thermal {

Should this sensor also be bound to the rproc?

Konrad
