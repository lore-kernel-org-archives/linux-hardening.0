Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26CB3C8C46
	for <linux-hardening@vger.kernel.org>; Fri,  3 Jul 2026 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783074683; cv=none; b=r6KpM532uMsLhGKsZSmRq/CF/iFUDuz5aTJERoMWo441BdVoAyoDGmZGvb7qpafmCPXf+iOoS/Ox72kt0l17CWIQsqU38HtbTF1QARDuM/1WkGIPz9FbWyO3+lSc+nt6xSR04ivxpWtODuvGA+Xq57v3sPAJnmPuQDkme0CP0F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783074683; c=relaxed/simple;
	bh=qiyzgDhFBvLQBInbQdAPGyL8srSytSEX42oOuQxiCH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ws+AjlsHQ81c+vHe1bCqpQPS+zhokQNB0vGrOp3A68eDJk/NlPx1YKlOh8c8J9WskLjmTss4dxvXTU6lhLBqzkpTs6jks0VcCgv+8l5vZCF7Z1blUzMJA7I2wjmMrwtC8xY8zSbLTGLuuANnQz9Xni3Bk79+SwUyjKsWwLRRSnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XF25VBTj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HkKlrQqr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XF25VBTj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HkKlrQqr"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rfSf3136145
	for <linux-hardening@vger.kernel.org>; Fri, 3 Jul 2026 10:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8sg/ld/I8qbw7uUnUsVl9AhVTb+2HSc9O79hpsKVLY8=; b=XF25VBTjXdW4rzLs
	Cv50XV/XSKIHVl2NDbWOZikEIzSts9CaNge1SdaskXgT77lLHZQRySRLceuSZw6w
	sjAzZuLbAQD7FDUUL/epyOXp7Ncz3eN8p3Olhq6f/Q/Dkm4dOdQZvpi7ALh3/drh
	hVifuvuDLxvcV2e3bfWznaqF1cFQ1GpktvjIn6Nspw5yZEpzzIPZ/lghhkTIjFrP
	rOxRC8MV55xl/RoDnQUUBN4BDqwTTU7jrwS88RV045BJEncNAdLoRDG9FG9A1gSE
	z8DXzKw5GEJ06tndCi1ST5hffPxVPH/zm3qfOUmd8rtPKoI6u4EgzzH7Fk633T2V
	wS+fdA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b59umj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 03 Jul 2026 10:31:21 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c8924f4d0a4so682251a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 03 Jul 2026 03:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783074681; x=1783679481; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8sg/ld/I8qbw7uUnUsVl9AhVTb+2HSc9O79hpsKVLY8=;
        b=HkKlrQqrBMdzBN6+NVhyBsbfGgnL6ph7UyOPJSl7ZXDHjrWVR7qq41L+SAHP7hQ478
         lvjIkJsbACA6u/oCwrBp0gYJJ8kuCRskgbMgRUgMuufnDhgDVxgILMLoh3Z19YApN8+Y
         6qTtCZImnkvGqXs7+ZR9MxMYIoP7XolbnYr7c9E8utarakkHyGJvgKSFMg5jCkCDfHTG
         pGzLZLsJb3JemIrDJ+c8/qQdZ7GKvFN+pi70bQ+dY0CDUsN2VToZ6qbdG5JjQG0hOFlF
         jbS3fgLnI/rZFp1+9Xnw3XkFubV0IVJcE+Do/lQY79NoXkCaiazklJLGrrbFKf+1ZeWt
         tkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783074681; x=1783679481;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8sg/ld/I8qbw7uUnUsVl9AhVTb+2HSc9O79hpsKVLY8=;
        b=E/BVE6KNkSOdXX/JiWm9pMvIbODMVy6+ASI77XRx6SWmY4HHPiiJ0jxLtPwMDij/Se
         qQ8MFobiQhlTXiJbzebbr9Nt+Y4R0gfjIOEBxbgNQ1jBvdCBmWgLylF3o+1qcT9i4Iht
         JhcaoU/tQyGDpn54IFkYe8vTY+AAQwSEvjhSKy1B//QDPer3Ft7TWjwM3JVGqphCamdO
         IpHUwzTxJri8TgaOwl6CIu05lVWV2TvkN+t58FGSHmXbE/MrlNgxZyGGbXNeOEDLVbiW
         ewij95u1fFGqUtEK08odUal4XS6C+MTu28AIKHpOkTnpmwYSveHHp6tbix6d9whGFtMK
         QucA==
X-Forwarded-Encrypted: i=1; AHgh+RrQ0viRKh5c1MtBu5Dv26zUlpAeCgB10LGpxcgOpUCfEj6t1sLRhA5QSKnRDibHEYdFmBF07bmlwh5QkNDcIf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzliFsW2XXQGlTxw3z+C2KtAeaavqeFp+p56Vg90tdANUGeGt2N
	6GJ23iXc4PoMD67gH8CtuZjSaQpoLt63SnkPeGnT2r/CMm+sclw7w71v7DVvEO7Xt5cl4SqwYm4
	R6ddto1LidjHfacJoiZrnj8q459MuBdOyBP77b9A5noGoQuZb3uuKf3Y/BT9Xc/7x0dBI5vg=
X-Gm-Gg: AfdE7clP6qaXZ/0K6Lwyp8mGLcH3r0PBqze6AsxVr3NDO062jniFwEEfiJgkTc0Q9bG
	l2xd2PGP6Pw3P0MTBojbYHxa4D2CQxKPuHdjBg4KzOC9DtBC97E+EkGvDgphWltIily/l6Srvvr
	s28oP5niD8UwjTkWwNMXqEQ8J0JF+46pmT6X8CuMJJw4dpQ6LDjmfkQKNUxq/5SbW52EGtplOf2
	MSlgSPHSi9bDNocJ/N/uIDCnSIdu7KT3mMcR9fXlXlS2OYtZjYyarfT0nsOaRuZDAvgh4MDFTpF
	TBd8jeqQ6UN1GOE5MSewD1MaazjvwIwPTzH5FbQToGesuUXx2Dm/HhHYwCmsOs5HLPMx6WcsqUm
	yn5VXOUgpVdKHUF3wz/6sFdJOFqkR1/DI+xU25CpCvA==
X-Received: by 2002:a17:902:da89:b0:2c9:e6d7:fbb4 with SMTP id d9443c01a7336-2ca7e85a856mr102663205ad.31.1783074680700;
        Fri, 03 Jul 2026 03:31:20 -0700 (PDT)
X-Received: by 2002:a17:902:da89:b0:2c9:e6d7:fbb4 with SMTP id d9443c01a7336-2ca7e85a856mr102662705ad.31.1783074680012;
        Fri, 03 Jul 2026 03:31:20 -0700 (PDT)
Received: from [10.217.199.117] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad71328d8sm7377295ad.29.2026.07.03.03.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 03:31:19 -0700 (PDT)
Message-ID: <faa65875-0aee-4a12-a751-084459edd4a7@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 16:01:13 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] dt-bindings: firmware: qcom: tmd: add TMD device
 type constants
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
 <20260703-qmi-tmd-v4-1-3882189c1f83@oss.qualcomm.com>
 <20260703-bizarre-abiding-spoonbill-dcc142@quoll>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <20260703-bizarre-abiding-spoonbill-dcc142@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEwMSBTYWx0ZWRfXzzBzqKrq4+I1
 iheFin9akoBhHAqGa1KKkmeDzkaw1atgPIWkVW4bV+7pvTJi0Iw1KFccyCQCBiwu+8wmt9uZZ7b
 iNPqVG2cqt8fLbPXh3dQafRskJrlnN8=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a478f79 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Ac_jkr_iY3tVM05H0rEA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: IQplWIac4tQYprdhCIZfuRp3-HibSZKY
X-Proofpoint-GUID: IQplWIac4tQYprdhCIZfuRp3-HibSZKY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEwMSBTYWx0ZWRfX2hqcGE/1C/cH
 gLgIDf3p7GHUSz93xhGr+Lce+qSN2hPN/bGHKnhe5HChcBjEOstUBBBnV/9LuNKqsplTl1D5k0U
 CQAxNb0X4kLGJfwts8gxRPmIFRnMnwhMtmeb4W55BQRt5kk+J2GhFwpNgZjrRJRbiNzSNibjpiI
 XvTf4BvO50ZVKKGHojJR9OfCGTWFmmxRo8jXi1rP1BkLy3BtrIi2tG0BnLkVFpiGKY6JTLlfDfG
 wltHOCtV2xBgANWZGzI0dtscG5ZpvTeDaLVATBjUHPIlOCpfyjhX82zp+p76lMRfXfuhF9ouc8Z
 5qgnuYztkJrQF1HBjl+OIsAFE54GzoNqvBri+U82BS5arKDrsxQhG+GJqBo5fIak2FEGnxKn+6B
 4XL4kcs6YEfInWo4+4QE6GxnSSaQQ3Ab94t0lBwJ6rlrgaHBhj3Yb2Bw7jrHYpEIp5gn1I4xNBb
 1fZcM1wnqEx7NcuginA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030101



On 7/3/2026 1:22 PM, Krzysztof Kozlowski wrote:
> On Fri, Jul 03, 2026 at 10:33:04AM +0530, Gaurav Kohli wrote:
>> Add Device Tree binding constants for Qualcomm Thermal Mitigation
>> Device (TMD) types used by remoteproc-backed thermal cooling devices.
>>
>> Qualcomm remote processors expose thermal mitigation endpoints
>> through QMI. These endpoints can be registered with the thermal
>> framework via the `#cooling-cells` property on the remoteproc node.
>>
>> The QMI TMD protocol identifies devices using string names (for example,
>> "pa", "modem", and "cdsp_sw"), while the DT cooling-device binding with
>> `#cooling-cells = <3>` requires numeric device id in the form:
>>
>>    <&phandle device_id min_state max_state>
>>
>> Define common TMD device index constants shared across currently
>> supported platforms. If a future target requires a different mapping,
>> additional target-specific constants can be introduced while preserving
>> existing DT ABI.
>>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---
>>   MAINTAINERS                                 |  1 +
>>   include/dt-bindings/firmware/qcom,qmi-tmd.h | 20 ++++++++++++++++++++
> 
> Why is it put into firmware? What part of firmware are you describing?
> To me it looks like thermal thing and even you wrote: Thermal Mitigation Device

Ack, it looks better under thermal. Will move to
include/dt-bindings/thermal/qcom,qmi-tmd.h in the next version.
> 
> Best regards,
> Krzysztof
> 

