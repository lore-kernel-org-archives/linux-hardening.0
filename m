Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188012F2908
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079626; cv=none; b=D25WyHeTqwNndTr4di0ALdo9tvINn3j+enF5onfEVj4yJYkye3Sp/8bYKRUH2lZ27qmYvBksxy+uvJMluaJ3z4EP2M9cCFTexyO8I8WA3BoyeZGucmM25bkzL1R9IRcOpA3uS13U+y8WK3yhgs+gNgCUEkZ0u+9qgyMexX7LgC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079626; c=relaxed/simple;
	bh=CRPKsVAhqXLyl5B9IWZbInaWZbGzzt5vGVn6BvQJQis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCDa4DsrRTsMZW1szPBG4qa3wFD86685pBYjn1YWXD+6x3SlHzUDHlJFeX/5/wY9D6flvjopBm5BFr9j6ASeo3VOutud/YoAQtdwN1srE/VvgHlOzFihwNDBL3+yQxNo4xUGZD6HvXtXCRQxU+UoQjVCDTWg2CNeEUV/JBLnHIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TPoeXl4I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TPoeXl4I"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mIhm020458
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 10:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lo/uyCg8eI45CIAczel8wExuTSXtA1VT9FQTS1gDCiI=; b=TPoeXl4IjXVD2YQV
	7PgGj9r/3vk0QoRPKTnaIosHjf093O/ALUsVq61RqOpmDap4f+w999tmLJ9urEst
	Nl7bDUeKgmBth6OefCysUvALMPvErT66ikBQ3GRPjzM0c21pZfj6H7pUbnLkUlp2
	gzHM4yEy5pzomSygB2CLW5ggaKuY8TiOJmkAMhHp+jfz5z0el9m1cbsm+IaaDiWa
	Y1R8WWMZwz84bWml2GpnvdbBo3sb48jZU8MDTVBYu6AKnzDOtm5C48/hM/iXu/Oo
	sxNah/WcqjrvA5pbCeYWSOeMIYin4eFMs4IcVl3hkQQnrhkTGpE1/sHlh5WWjSMJ
	wFZHoQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhx9h1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 10:07:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b0c502e87bso4998931cf.2
        for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 03:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755079623; x=1755684423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lo/uyCg8eI45CIAczel8wExuTSXtA1VT9FQTS1gDCiI=;
        b=UqrQnWJwtwQQF4Pz+YJaCy7GZ7u5wcsIi3wRafNs7rRhQ7jd6YoPmeqMtqwuaWOzxh
         zCzto8tcgMx9rJOhiCifay30zy71ndZKCi7+1gsi+OZRkuoLr0PVM+zSVY3Ark4h0Ei2
         AMUhJ+zoshymhNmO+EV3nWdIJnVGrENQNY6s6GMRPAU/Y3TmCOhkimkPx9f+rXQSW949
         vurrFwDVLiyzQPGkVDSVQz88YjdB04ke/z7UZIZXhBQMeDUYcVYWpxzJt68ZkDu+np8k
         kMXJsQEndQx5o8X5OnGCeR20UlDU+HB6gNFKmXoJcb8v9eksalk9zRsh/qTu/gSueRv1
         ZSIg==
X-Forwarded-Encrypted: i=1; AJvYcCXEx3gafNo9L7NWoWLzdQOK8apNHKK1E6Huq6w7hHj1gvz/tK/8Q1aCoOlrjKOITBxOR0AJnuSSDAjWJYYa9M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvNHpdP5vkPw1RUsxDl+CdocBVxHPJYWjJCR2+Yox4qd1Q/s1I
	2tl+EFfwXRifAS+pZGV6FhM9Q6s8J3KIH24SwOXzas+PEo+PmQ4DqU4SBrws7G6chH1mTw7qaj/
	HQye5P387HJOORezc5ooEpV8LvI5RhK3cZtQfwQTFp1X1DnTquFfUnsBnwmZliFdUL+imzUQ=
X-Gm-Gg: ASbGncuPNrJWKzg+wAsNCh3C0yjNrOI10X94TU7ucHc3181KiBTDPZZDNckpMNvOfwl
	9h1FYt5Os5H+3wZcPW++AuS6D5IsPhqtpQoc+PVsgkfRPsMbbuYuMp1ceTPdcei/cxKGsl5oPEM
	ZikHqBgrqyOdofPEubjn8T+xDK3TTux3HR2DEQlt4yIlZyp8vGPSxWI7dZt92Fp3vE4Ixi3ZSiz
	6pR6pdgVEevvq6IyQrRENTU8W2JJbriybzfIwm77AdBHcX14POfYY55ps+FSadZr6FN5nWJnhOa
	ZcveNVLE+4zNLuwq7iQ39aqtd+2jGbfURr6R6TpIpartScTnVIv7UaWb2odHnQH7j1533H1cS8g
	m6GOGcrbY+7SYhGVlYA==
X-Received: by 2002:ac8:5dce:0:b0:4ab:609f:d7d1 with SMTP id d75a77b69052e-4b0fc6cbd31mr13706871cf.4.1755079622786;
        Wed, 13 Aug 2025 03:07:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbEx/52bIrz3cKGljrcyVxad9pOt/IN1rRcYfZiJuhcUb6gPtWuoMusDjEvu/er5MYTpmlKg==
X-Received: by 2002:ac8:5dce:0:b0:4ab:609f:d7d1 with SMTP id d75a77b69052e-4b0fc6cbd31mr13706491cf.4.1755079622218;
        Wed, 13 Aug 2025 03:07:02 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3b6csm2371260366b.48.2025.08.13.03.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 03:07:01 -0700 (PDT)
Message-ID: <f10f1602-972a-491f-9c11-95e5e7bd80f8@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 12:06:58 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/11] firmware: qcom: tzmem: export shm_bridge
 create/delete
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
 <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-7-ce7a1a774803@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-7-ce7a1a774803@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfX7MrGYjs9UKZ/
 M8HBNiZsCS8D4ToSpkXswBD9onlI24v+JOGFQDVJQC+69ZDuy+Zw9ZlrB1Jj4cw7d3cirHmFV+f
 zsdpFDXnOT0mWx5DNC8MDAOu6AIhUYkkp4hJPmz4Dsaw1hAbLTjXlKW1WJbG+Ga//gBHwfgXkix
 0oFlU6CbVnaAU742pXXNCk+EtWDiPpGpiJAQlX5vK6uiG3gnpuGJ0ZLcDppMc6yGRS6uw0yjYCn
 GJ85s9lNE4dKm9Au/5WTSYdwQ1ro4Ps2CzKMMYAvLPeOjPl+g21rmHMyMEZqjgLbiMbOPvMhTVf
 wDG2S3j52laVNnV7mDqJqWrHZFdVLb5QfrUh8qbD6sEMfMs15OBDun5TojeW6nqwZ5tZKk1+X+2
 jGwG12c4
X-Proofpoint-GUID: csT5r3jpchAEnWQYwldp4lbMjoI0vLzl
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689c63c7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=sWKEhP36mHoA:10 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=clTIM29CJtwRRT_IFxsA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: csT5r3jpchAEnWQYwldp4lbMjoI0vLzl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057

On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
> Anyone with access to contiguous physical memory should be able to
> share memory with QTEE using shm_bridge.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---

Hm, I thought the idea for the tzmem allocator was to abstract
these operations to prevent users from shooting themselves in
the foot, and this seems to be circumventing that..

Konrad
