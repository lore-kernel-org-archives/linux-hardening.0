Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E52FB98A
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 22:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755125758; cv=none; b=LMmau9v+kqKhCmjAWYD9ES629r1036q0FZwsHmAvwxo3tzGt1z1aHmQ8KcbUElsKRv+ThYSadud8VXtxWvovGtOmoKUFHKy8DwyfXqWatUQ5oi+wYn5s6JRHDtsRIDTKMBOEK83Q79wPaIY7BrGKOIQkNnaqUt9LVXDj4HRcYsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755125758; c=relaxed/simple;
	bh=jAnNKoc8OIVx+dw7TrFVfvfY8lmRFsZzlTTw/qR/0dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwncZIDnsQ4YJxncwDvtpFNZaQdLALjyULkeKXJxYXCnYNkLQDGamd9GzseWRBKuM9//gpDCrTNQkzgKzBRJyiHwU25GHFHRYeXJn0ZqKLef7sFCgMLnplGOfHi63n8PbOvgwVnBIDSkhDbGxh7SIIVslTMoVvtBHmGfJmPjyQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kvOe4hR3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kvOe4hR3"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DMFVar027001
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 22:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8e0ZVNprxYNA0/9coeslBrJajBup8IpRB7mgWlinU3I=; b=kvOe4hR389WJMGpr
	pSwX613gEZv7psgmjtiDKWNew9mN/oaXMWt7VZsUGZ0BYhGuur1Tz3LOgjc4ZcK8
	/ynBUUlLlkC9ecKh/1uPZUlS49gpcuwVRp1AIl8jtwpxIE2wI758QNLtqcuIMjqI
	u5Iu1TIo6URF61zeq0ZC83H3d+6cTgEDcqZXQq6s97Yqr1aWTmz2quWNfvCk2QFF
	euT8hKEvGddJZWYZKTRwNVXCQURNZieBYj52C5lJvsE4tofLzHsd4HIGpe++dhTC
	2hnP3czq2OO5mp5AJoSFJhPJvDbMPVyR6GLoI3PXpoxprIRy8abBaUsC7jdJ9wdQ
	0fkCvg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjsb1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 22:55:55 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b471737e673so385019a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 15:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755125754; x=1755730554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8e0ZVNprxYNA0/9coeslBrJajBup8IpRB7mgWlinU3I=;
        b=iknuSh9G61aGB1mqcSoxU3zgTRjDeyCbkCayH4OaOPZdsq4078MsGenHWqmLmNI9ew
         JvgCOTihSQmbEecuSq6QCMBkdvOZubdybBHJ07uTxWjRV3GHe1kFLyoNC6UY0l4IU+n0
         Tx9Eb9MqYqJN9sT/Zh5NRGuiyfDqzNTY5qgjHWxfYvGTYg/HGGjhMioMmhPJ5BQA2MKj
         lRrRcpB7g0eChuw8xKh/DXy32OBNgAs2nHoyevbBxtDt4ky8dST75KC+X1RjsOGE4XIQ
         ckBdfQ99+z7ZIKj904sRfNOFwnA7v/MjSwxoFzvtItqOInP6kiisTa048QMFqsyYAbPn
         3G8g==
X-Forwarded-Encrypted: i=1; AJvYcCUjl6uRoVgx4skQxtRGsyQX8L8324rfYKsXeVSWcRuaOp5R6lc97QA83ynAjASLZUjf6mBGLcE3IFOAL/5sCnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/8bvBCCfcw/YUYo3aeM/Vqw5viaju9hepOLkXoQR8W+7fN1p/
	PdVDsOA/Pn2/QU4RHz6YenjHlpDoeP3JTvWQelprqj+hQH2NXh7uF8DiLa5TVGeFqcN3ZiG46RU
	Y4DFWAFh2hJzcCRU4WVcw5oCtskhok/uqwoRPjZ3ogAtsDgOuMSpE0a8UJQ01GLCVUjoBEQ==
X-Gm-Gg: ASbGnctOAXbnPtQ+UYE2mIqo3euPY4MMH2Io66douGsFqRDWAK0/nIe7ogokpSIR/k6
	tk7Bsb43JCXegSlyyKfwvKVSvDpjnOwAAc0yEaaWZDNCMVwIYERvZmpPeupvgfS2/QrX8FIG6UP
	DZRajj8Dg3FhhGd6V22+4oJofRo5c+U9gmnx8qBsNZrCjc5pelGOFgm2bXnrDHNOEpsLbYf+sv9
	t37AcwtbLeC7YgGM8DPaMAesdmDqSV+plbY33HU3Wc4mjJx1fkhsZCxN+HdjbN4AFeqK/KCMKvt
	xsOBwWinv3wt159oIb+zWKaqjCO6ffzXZ7O+oGsvk4B7rv1pX4XVxK5YixAkdKAii65FYJN2zGV
	13l6N/QyCZ7NcDA3uQ6rSGw4p6hDlMooWPDbyAQ==
X-Received: by 2002:a17:902:ef48:b0:243:38d:b3c5 with SMTP id d9443c01a7336-244586d6812mr11283095ad.47.1755125754325;
        Wed, 13 Aug 2025 15:55:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwyZkPhdjRr1DNqf2XUlzMie+QCuji1zBonY4NxpkKvkrR7x/LGRt8rtlqOJlwD4OUaeYUew==
X-Received: by 2002:a17:902:ef48:b0:243:38d:b3c5 with SMTP id d9443c01a7336-244586d6812mr11282655ad.47.1755125753877;
        Wed, 13 Aug 2025 15:55:53 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2429b4ca995sm202959025ad.177.2025.08.13.15.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 15:55:53 -0700 (PDT)
Message-ID: <1874e02d-993f-483b-bcb7-dba7c0611376@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 08:55:45 +1000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/11] firmware: qcom: scm: add support for object
 invocation
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
 <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-6-ce7a1a774803@oss.qualcomm.com>
 <f015c644-1176-47b3-8ce2-2567e529081e@oss.qualcomm.com>
 <a93b9788-92ef-4b5a-89ca-7e7733697eed@oss.qualcomm.com>
 <176361cd-a095-4b81-9e36-f933d159d249@oss.qualcomm.com>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <176361cd-a095-4b81-9e36-f933d159d249@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfXxOgXWIEI09NF
 QGnLKV/Kjj4+UoWV7399GjlbooQ+etaaOtkZFEBa0lyPah9Zhx5o33wStJFZe9HKBim9qDK8nkr
 JaXeOUDMG9A09MApsjBPtkGBjT5lBeWX+U8IeyqbrZzVPznndj2Q5SsLiKXLSp6oSfdJE24ac/k
 0A9tJDP367x8sPQTsiFkpizfrn/j0ztxeAC6W2jwuSu7HZCDpMbuQ43+A3BaiKsKhWDW+ULu2yV
 wwBiAakL42c3wqKmu/xFhdgZwHF1R2K5wzgoFg5FJzwSnEYYgWtGAjx8FKQSaJAdtjoWFVUZoPo
 6K/Ch954yyEv2oSZFFxZLzsryjbweBuxb/uslKPUfYwskIZcx1nJt0N9aBu/MR1ni2v1+MGr7cl
 xFuLL9zw
X-Proofpoint-GUID: zsFk86tEKwM5mKb2OdfzP10nkLNFa6Ze
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689d17fb cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=T0n-DW2OHO-Z3PBZrcMA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: zsFk86tEKwM5mKb2OdfzP10nkLNFa6Ze
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074



On 8/14/2025 8:52 AM, Konrad Dybcio wrote:
> On 8/13/25 11:37 PM, Amirreza Zarrabi wrote:
>>
>>
>> On 8/13/2025 7:53 PM, Konrad Dybcio wrote:
>>> On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
>>>> Qualcomm TEE (QTEE) hosts Trusted Applications (TAs) and services in
>>>> the secure world, accessed via objects. A QTEE client can invoke these
>>>> objects to request services. Similarly, QTEE can request services from
>>>> the nonsecure world using objects exported to the secure world.
>>>>
>>>> Add low-level primitives to facilitate the invocation of objects hosted
>>>> in QTEE, as well as those hosted in the nonsecure world.
>>>>
>>>> If support for object invocation is available, the qcom_scm allocates
>>>> a dedicated child platform device. The driver for this device communicates
>>>> with QTEE using low-level primitives.
>>>>
>>>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
>>>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>>> ---
> 
> [...]
> 
>>>>  /**
>>>>   * qcom_scm_is_available() - Checks if SCM is available
>>>>   */
>>>> @@ -2326,6 +2444,16 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>>>  	ret = qcom_scm_qseecom_init(scm);
>>>>  	WARN(ret < 0, "failed to initialize qseecom: %d\n", ret);
>>>>  
>>>> +	/*
>>>> +	 * Initialize the QTEE object interface.
>>>> +	 *
>>>> +	 * This only represents the availability for QTEE object invocation
>>>> +	 * and callback support. On failure, ignore the result. Any subsystem
>>>> +	 * depending on it may fail if it tries to access this interface.
>>>> +	 */
>>>> +	ret = qcom_scm_qtee_init(scm);
>>>> +	WARN(ret < 0, "failed to initialize qcomtee: %d\n", ret);
>>>
>>> This will throw a WARN on *a lot* of platforms, ranging from
>>> Chromebooks running TF-A (with a reduced SMC handler), through
>>> platforms requiring QCOM_SCM_SMCINVOKE_INVOKE_LEGACY (0x00) cmd
>>>
>>
>> Are you suggesting I remove the WARN? If so, how should the user be notified?
>> Should the error simply be ignored?
> 
> I suggest using dev_info/dev_notice, WARN prints multiple dozen lines
> and taints the kernel
> 
> Konrad

Ack.

Amir

