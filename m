Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED161C860A
	for <linux-hardening@vger.kernel.org>; Wed, 27 Aug 2025 06:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756274789; cv=none; b=hA4NuJgTLnJ8NIJTR2S/oZoy4cRuejmHRyJoa8RHLcbvHn+sfcZINqAo9CpolzwISIzZ38vSU9ocborXk0IQButz4dpIi+sFPPEGO5UFkU4f5CfLeDoGrE0yqAIl21M16layYn9ZTG+nLNFMpuXmp4anyprxAgYRY5cOyYrEtbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756274789; c=relaxed/simple;
	bh=wMGz6LtFcqKacfGBJToPMAl+pHQslhvTR58QLzr0q7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+/1LHTLxfx5QvRn7Dt3cZgMt7yndlkvxzuBO56iIDBJB2OaNsnZRAPHiqQ6FZWqSFBSuGioIgE77Ad8YAoWv0ZwyQBoKdJd8C61UY9KJWIpWBxAkuTIvT667uY+auZzs6/qVDw5Me2DXDctUqcU5N+FjY1/kHbeaTUHkUChwVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n06+6yXW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n06+6yXW"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R5Yuha023173
	for <linux-hardening@vger.kernel.org>; Wed, 27 Aug 2025 06:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IvtoMULgukZ1V1cgtQetdWBAfSoYzONqp4myym0U6ZU=; b=n06+6yXW0wU0IpKz
	/+cogiaPfyl+lmuJ7TkprUJ72V/3CKRv7h/oJxp36crzCJpUNmcMeyRp09RunAMn
	C21412ZnXj3muBeVY7sPWwXYZ+vkj9n3ZZEehipGEvQAXd7J0BY3VBxwbvuOX4qi
	6KmthjfMvu8hO4TkUwZQzP1C8fyypOa/EylDhNmDMHedafqFBS7SQj706WS/YC39
	SLkxUBa39PGF7SHrIoO/Bg9etaQjwvWUl0LcaiJM4b/BduiSIBozd/bJ3EmK61+Y
	h4FQlyPWG4avYytuEIDHAXJq33C7x91FRUn6hYgjQLMUC2475PDhbS/nq3ou/dWt
	SE9oQw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xpussx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 27 Aug 2025 06:06:26 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-770562b1ed3so5759286b3a.2
        for <linux-hardening@vger.kernel.org>; Tue, 26 Aug 2025 23:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756274786; x=1756879586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvtoMULgukZ1V1cgtQetdWBAfSoYzONqp4myym0U6ZU=;
        b=gTEBge+mTbzKU8e20ejLrS7uzBFfVSHAgj4ky8/zXobuOGqEZwpDGQZ+yumecqGM/D
         gKexFjXZHwJchIm9ucPMbemr+kZtA3bd5rW397Ou3Rfxa/hMmPTbQyAH8l8xfU2mKgzy
         yhcjh0vFxD9nN/j3nQTWB2N1SX0kkvYs7kdGfjKyj6e5gH69X+RI/57GyHJ6bDdcxjKD
         yhpH7Y0tS9hRcqgsOqJECoadzvm1RBhWAIXXqqzE1W09WJuqBRxBQ4EBKS2lT8rgPC40
         TneDGWVp9WF2RM6eWo2YKVPOKDcR/CBOqKeXA5c0iFV2IETRewv//cK9Ljyxy2U4VqAm
         1A5A==
X-Forwarded-Encrypted: i=1; AJvYcCUYJFaQ7k/tJlAw3qb2QJO8q8EXv6F47XK7CrLNnXDbrdqYFHhVgDbYdbzpSQKYFTh62U0MDZsFvXC/qLgYhNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyywrDPQ9wYCFRmpV9UmHnvDBp7iwEXQR/M+zubTlHoeUM8ziLz
	6UlwW25F5x+dnqVkvgvvj7I0n3BuHBvAK0P9OFCZp8m20DK6xeGhIuL3/5VL2/ArAVvrM/8tSNx
	kq+sew58ygtZ4kWkjbU5tt+wUuDnncu2hsYur6yU2Dh7GbkapYKD4wMmPzoXO4HJgfQh0JA==
X-Gm-Gg: ASbGncssVk3RIzeNMqomTjClBZNslz75lLD2LbipHXM8gddl++rpp3lM0fR5WEROFIk
	feioEN5p8rKv2W+oP55+cVEy1rSA06BUJFUEGSJ3Oo6IS6sy9zcD+gqHiZyiIE7RMFheAZT9hTa
	LlBmJ0BqHr5neQLkh0z3hE2cgoFt5jSQGxvlURywFKDeFsimgpmeKcYwVo80A1k0Kt42+Quadqp
	w3Udi1oWLygRVq3Gm+k81gYtR88WTcZVATrcJuKuXvLPfk0eH/gJJIPBptLxwCZo2JM/ipMeoDy
	cSjcCAO+mFZbNz2tVauFHUGVVTTciWoXygmu7AQQVzpuXaH2FvpYXAaQGJr4UsouD1BctmiqNiM
	LyBDWR3l8B21qsAveO0m+Pim0+Z1xKIvdIMEoNQ==
X-Received: by 2002:a05:6a00:340e:b0:771:ea51:690e with SMTP id d2e1a72fcca58-771ea5170d6mr9587238b3a.20.1756274785572;
        Tue, 26 Aug 2025 23:06:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjXY9tZYbdaHdBkaKUQPtpmPxg/EWHTA5baJ83nFS3+u9isarHBBJ/FYnGHhPcbEv04uBR8Q==
X-Received: by 2002:a05:6a00:340e:b0:771:ea51:690e with SMTP id d2e1a72fcca58-771ea5170d6mr9587212b3a.20.1756274785081;
        Tue, 26 Aug 2025 23:06:25 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771ecc4454esm6208226b3a.0.2025.08.26.23.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 23:06:24 -0700 (PDT)
Message-ID: <265e23fb-8865-4dee-99ed-f08450975ba8@oss.qualcomm.com>
Date: Wed, 27 Aug 2025 16:06:16 +1000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/11] firmware: qcom: scm: add support for object
 invocation
To: Bjorn Andersson <andersson@kernel.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com>
 <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-6-7066680f138a@oss.qualcomm.com>
 <itpdolgmxp4ofdv3vf2ghulo7slj5wjby2tvawehihwvenbep2@ub5sdgf6gxeh>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <itpdolgmxp4ofdv3vf2ghulo7slj5wjby2tvawehihwvenbep2@ub5sdgf6gxeh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KOlaDEFo c=1 sm=1 tr=0 ts=68aea062 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=3sczFqAQEyrjP0LPqEUA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: 5iiN61vAXJIHDRch2xKdOpkxDYyIz12h
X-Proofpoint-ORIG-GUID: 5iiN61vAXJIHDRch2xKdOpkxDYyIz12h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX4rZDNe2xLUdp
 W4TzYsDELpVjdbUc+V7nPkxP1pq6f4qr1nPK6GVX0ReWH1KURu22/c3nLs6NOxi/c+6hc8YNaRu
 C9g1jvXFTjBbWSPjoYMx+2B4S8ZW4wvTDteoq0PX1tnRl4cBDCssZ7wJlfB6o86QWmh+T13v30s
 Cz+JB5hjYiBQsxHsJ4Kcm+gKdOn+QCEt1JWkZ8U2l+zs88k1vM9mlQr0qkJjhCcU8ADufPDZS12
 6WdQSZeW+ZGNxVX447hbA9WPSGxsP9rhfQiJaePSyoKKTSBxSusjLJUQLH5DwyalKAbRRGCZbYv
 b6y7aLHrOYB8dSNKG52kkA/WuV+sam0Hb+UewKJ657m9Zt8Yf5MarqO9kUxwY/nGxN6oIrnL2sR
 6c0/7rt8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

Hi Bjorn,

On 8/27/2025 1:52 AM, Bjorn Andersson wrote:
> On Wed, Aug 20, 2025 at 04:38:53PM -0700, Amirreza Zarrabi wrote:
>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> [..]
>> +static void qcom_scm_qtee_free(void *data)
>> +{
>> +	struct platform_device *qtee_dev = data;
>> +
>> +	platform_device_unregister(qtee_dev);
>> +}
>> +
>> +static int qcom_scm_qtee_init(struct qcom_scm *scm)
>> +{
>> +	struct platform_device *qtee_dev;
>> +	u64 result, response_type;
>> +	int ret;
>> +
>> +	/*
>> +	 * Check if QTEE supports smcinvoke:
>> +	 * This will fail due to invalid buffers, but first, it checks whether
>> +	 * the call is supported in QTEE syscall handler.
>> +	 * If not supported, -EIO is returned.
>> +	 */
>> +	ret = qcom_scm_qtee_invoke_smc(0, 0, 0, 0, &result, &response_type);
>> +	if (ret == -EIO)
>> +		return -EIO;
>> +
>> +	/* Setup QTEE interface device. */
>> +	qtee_dev = platform_device_alloc("qcomtee", -1);
>> +	if (!qtee_dev)
>> +		return -ENOMEM;
>> +
>> +	qtee_dev->dev.parent = scm->dev;
>> +
>> +	ret = platform_device_add(qtee_dev);
>> +	if (ret) {
>> +		platform_device_put(qtee_dev);
>> +		return ret;
>> +	}
> 
> Wouldn't this work instead of the alloc + parent + add?
> 
> 	qtee_dev = platform_device_alloc_data(scm->dev, "qcomtee", -1, NULL, 0);
> 	if (IS_ERR(qtee_dev))
> 		return PTR_ERR(qtee_dev);
>

You are right, I'll replace it with platform_device_register_data().

>> +
>> +	return devm_add_action_or_reset(scm->dev, qcom_scm_qtee_free, qtee_dev);
>> +}
>> +
>>  /**
>>   * qcom_scm_is_available() - Checks if SCM is available
>>   */
>> @@ -2326,6 +2450,16 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>  	ret = qcom_scm_qseecom_init(scm);
>>  	WARN(ret < 0, "failed to initialize qseecom: %d\n", ret);
>>  
>> +	/*
>> +	 * Initialize the QTEE object interface.
>> +	 *
>> +	 * This only represents the availability for QTEE object invocation
>> +	 * and callback support. On failure, ignore the result. Any subsystem
>> +	 * depending on it may fail if it tries to access this interface.
>> +	 */
>> +	ret = qcom_scm_qtee_init(scm);
>> +	dev_warn_probe(scm->dev, ret, "Failed to initialize qcomtee\n");
> 
> A successful boot of db410c (APQ8016) now has the following in the log:
> 
> [    0.161437] qcom_scm firmware:scm: error -EIO: Failed to initialize qcomtee
> 
> If the target doesn't implement qtee, I'd expect that you tell me that -
> or preferably stay silent.
> 
> Looking at the other error conditions, we find -ENOMEM, for which you
> should also avoid printing. In fact, I believe all other error paths of
> qcom_scm_qtee_init() will have printed an error already (if not, please
> move the error print to the place(s) where it's needed).
> 
> As you're ignoring the return value, please then also change the return
> type of the function to void.
> 
> Regards,
> Bjorn
> 

Sure, a successful QTEE boot already logs its version from TEE SS,
along with any internal error messages. Based on those logs,
it's quite clear whether this function failed or succeeded at the
beginning. I'll remove the print statements.

Regards,
Amir

>> +
>>  	return 0;
>>  }

