Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813EA212554
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079255; cv=none; b=UMIJeeOnuYaxHdfs57+IzNXkrZBmZDpdNkSe7/+2q/n3oREhYMZDK/vvYcBEynlPgnjnBu62R5oKPgn/Wdyo57nMuecgN8vQHJmmoFchX7/+skShavEbBNRe98i1xr7UcUhmXyT8f0EdTraRd8Ia1KeiATQPoHqCHsWaU0hYqvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079255; c=relaxed/simple;
	bh=cBywqYQ571JjXH/CFVXtPZFVBnz+yE4lfUMvOMd0qMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHDPgTRtfsSSXrUEgilyVdLOWmkttfGl/glM+EytjE5PBvxslaRLzgL9/mGRfnpI/cLFYjh5Bi3VFHlNJFEk9H4hgsVOX7A5NftbbIGUgCB2kwB71r+HsZH6ftzO+ktrZUo9DM5usCuExyAYeXOzc2Ye0tBBz/HtAnbJC5++uBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N9CaoIbL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N9CaoIbL"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mJfO008724
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 10:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wiBWcdk24yow8RF3k9D1Z3F3r9BgHRGCWV7I+lbiN7E=; b=N9CaoIbLvjII5iGW
	91H0wJPvVuZVgOQHfDedopcJWkBiXmu0ICOQy8BWlNAMtuIFn76O9zsijrMcXWaR
	nGy1Lc3PT43fWeQIRxtPT/wUiLltdupUp3wNKpr4D6+EAXiXh4Y8inhd+D0CROS+
	QvyvLgiKqlvKBtRTXqbV1cO5t0dB9S9+v8yPwFXbTTPA6MgYB2fzMCuUCJvhmITS
	jVdz6J9Z8oSnKORIzJeeMhKraWxKcjqxlBdua9wfi2YinhduTNdaOnw1ZsZxFm7E
	EXQIckRprZ49SAJVNw7MUW0hmGfMqL2vtakcjWUxi7WJVzJI3YEFLDrBS1JssXgF
	zzOp1A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4favg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 10:00:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b08f6edcedso18596251cf.2
        for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 03:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755079251; x=1755684051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wiBWcdk24yow8RF3k9D1Z3F3r9BgHRGCWV7I+lbiN7E=;
        b=P+ddWAb20vO1/lP4jSCEvGf4ev8NodYefNJIFUmMMLfBH5p4pDfPmxiWU978C7jhTF
         t5cmZHrTJkccUFur60gIvOmf7tS7A6Q1RHYzDxdNPBLzZ3IsVkE8CLUkd6NA7NKM1coT
         jo5VZV5MVZpqH3oVJXXv7rAaswqmh8A8gKdTsS2e6oAFnACS/owL4rnkgXGObFSO0eJ9
         glmoYRx6U1O8cuDw9bbG9MIBQ7vD2ShgPtfvIF/+We6rBRIVFK9OCGvAlZGxQq9E5AKE
         Wj2qIvnD7+kdIFVcpY35uTH/hR8VKg9Ye2zo6EIWovQbGExZYfxhl4Jad2i1mDmqciDq
         NmPA==
X-Forwarded-Encrypted: i=1; AJvYcCUGyhjhA7codlC+7/et6/IVZKIPeIZ5Y8WYq/vmpJkGuxnz7zUxHQz4xP1OXK7NNxhk8eupZQmHDoyYtb622TY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAQ/wbWNNWgj6HRoSH8LTl/OwBgGfmMd3iLzKNCa5poQzGjq7W
	Abfe6i/4ujVy8yO1r4XZVeKcQtAvfuN9ZAlbFTgWlfwnGGRnu6FMCwuBV3j3/fb6r+0J0F222GV
	NLy6a+abmdChzWm5rMp4Bw0pq7IcZqA1uM6KUEKbj82fzfVrjSM78nxGZYZLYwMhnBNRpEbU=
X-Gm-Gg: ASbGncuG7uSLvjWjN7haKzPwSwlGa8Pum1/vFlBfkAq2atc5TVjtcpW6MPZcTgt/mgU
	BBy4R2younVzrOr1fiQiDRyqHHubXpCk+8yM0WqQL+8ZE59D+2c0getOJ+3LFoKjUJ1CrGL3IUn
	6WucT4EkvboPT6VCx/BDbK3rmRWj+lIi3OsjllvLvDZZPcym0qbeeFVEjWj4ndiqWHIiQacnw5m
	Xbt/T48zxbbHV5m1lr0epB8un8SUo/c/puFkeypkqZj2ZryRaOCTRStBi30g2Za5eGCdcZYqgiA
	2N/Yk3TRcxmh+Vmt1vp+cuApkO23+1uM+8LSfN2672hKa0G6ud13W6McAxoeotSdFolO0Is8uvc
	nmyP+SN4wYgx30EOp8g==
X-Received: by 2002:ac8:7f06:0:b0:472:2122:5a37 with SMTP id d75a77b69052e-4b0fc6c46d3mr13966881cf.4.1755079251122;
        Wed, 13 Aug 2025 03:00:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmTrD4ySjMqSbwhalzXJcsozDXyEzKvaYMIjrNiNP0RSpO0suJx9JL31ZtBXBXWoPTlWVUaw==
X-Received: by 2002:ac8:7f06:0:b0:472:2122:5a37 with SMTP id d75a77b69052e-4b0fc6c46d3mr13966501cf.4.1755079250541;
        Wed, 13 Aug 2025 03:00:50 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3375sm2366142566b.41.2025.08.13.03.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 03:00:50 -0700 (PDT)
Message-ID: <3ec0a8d0-7900-45bd-b0d3-90ee8ca7730c@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 12:00:46 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/11] qcomtee: enable TEE_IOC_SHM_ALLOC ioctl
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
 <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-10-ce7a1a774803@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-10-ce7a1a774803@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: h3Brrvv7a63McuLZ4bJ-uZqix_SJzs8u
X-Proofpoint-ORIG-GUID: h3Brrvv7a63McuLZ4bJ-uZqix_SJzs8u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfX1PYSP0bHZLi4
 2f//bFQR6qg9NEMgPCtLiIHB3G9zuY65oMij7/RyjStLBcH/YSIbLZmDZRfNC6eYl1VP4Z60XwY
 ZDUAGKoSDmt+WcbrLHhJHUtH0ChiQYA/lDOtipl26vvbQPf69g9g30CX147si7oNZGg51bS9IZF
 tlrGwWd5vISHi38u2natVVT5D8WEQFxBtIIWDeGSP1012fB4axdNHEXt03UOnLUAPcPJ6Sxg/QH
 oKtn6rA4ACfZyNueFIrbrFg0P393mJ/v9nrz4ZxA5zcZqZLWGTckOXxXp/sP1iBU0Gula2GitK5
 EUfIAYo+Ggcov7P7QAJYhFdIW9rEue8nZtCz8pTp4BeHHKqUqOsi4Rsw5BEww3zfq2ip6g/kRsC
 psqo5145
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689c6254 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=WNCivIMphfMWkbBb3CYA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
> Enable userspace to allocate shared memory with QTEE. Since
> QTEE handles shared memory as object, a wrapper is implemented
> to represent tee_shm as an object. The shared memory identifier,
> obtained through TEE_IOC_SHM_ALLOC, is transferred to the driver using
> TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT/OUTPUT.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---

[...]

> +/* Mapping information format as expected by QTEE. */
> +struct qcomtee_mapping_info {
> +	u64 paddr;
> +	u64 len;
> +	u32 perms;
> +} __packed;

Please use types with explicit endianness, e.g. __le32. I'm assuming
TZ will always be little-endian, regardless of the host OS

Konrad
