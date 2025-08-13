Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A39C2D46C8
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078817; cv=none; b=owzr0nYp1oFIja7O+TcQgCZEB/QRlS8x2yTJqKMvHDHcAdceW2woSUmkMgZaZISZQ8v3RTKTfZq74Yp4MHurpfTNOpGT83za58uSWvY9NLpjmuj+2Xa661EEg+iqaXgsEDl0D18YZEN9XvSBUOING7G4V26Y5UDpk7LajPYLa8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078817; c=relaxed/simple;
	bh=ht1diEblsf5dN2e1cjhOK7qCFVmjDiqNwW826Qyw2Rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLT8XHNZp0itbff8gNz16RuvUYa/sJeVopw4F+Fpe+tc/9lBrbtyS2B/YKtC08OW7TJUDj2bJEA94fI/rXTBevf/7u1TMSbso5gIdgibOiiTWv4CqVzQoMPakeWjlyw9PRmfvyXj2lTAtmlu1fxW0p3iJcrZiprwABQbLA+G24Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jv1gb4ke; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jv1gb4ke"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mSrc015796
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 09:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0MpY81TRuNNBDJHPaklTYFI4wsF3yIvIsNOVJLMUbFI=; b=jv1gb4keblqk8Oe8
	0IfDMzKm25CeMTPUr3pF7EbmmsPsOLRWBpI00RvmXRswzIs7e8YQH+a0cRyDckIF
	LA4ZoN1AZjOx5pFVY3yJK4jw/QU8r2bxYcFvbcGdFiorQreKFUbhT07kl9Gi+G2N
	f55HidrgJkXBV5yJUT8BuXqNrt4c5PTtAZP+JnoYr5CYrsGIvfgmUEzGc4h7rmVc
	/DqajI7vnQRNFloz+QUnWILumdJbaJEZiGsizqio23jkwNZSN4z803BRoqhfjI79
	Wes3vpWBA5aKH4D6XyhjXc0Xhyb1iJFF9YTwD+0giYsH3PMGy5fLkWA1jfGrVSci
	OBrGMg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fjxbeh3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 09:53:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b07ae72350so16973341cf.0
        for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 02:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755078813; x=1755683613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0MpY81TRuNNBDJHPaklTYFI4wsF3yIvIsNOVJLMUbFI=;
        b=bqqrCEOL5K0qgAK2lHbrkzyl8yToUW6ZYrxcfxiYVtMSiE7eHo1rAm9Ae3CXpXpcpq
         kiNcgkwrwBP+2CjexhVJ4mrqRkl1Qe3Q91+L3aLenfHXe4SVqQzHzaU7+MkNoDeKgNXk
         DFq6Wd9fCU2qKBmx0oKKzF6Krnz4IRKrhW/aaHUHDew8RjFvyseX4drjEbFbORlo9AkH
         O109Yv27AWz2l/55ieMZSHiuAF565omiF89tsy+Hsj6yF9ryEN2d5NQpaZfKrZpBPBub
         Mo7PhRDkjJgq8G/qvz/se6zyQKBWawxFJyAKLYbB0zCi4dK06c253uRTzS4hO0hb64pE
         9LaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk0oRL6fo46t9HBR4D+Xq9Gui9hFvAvHnswYTH2w1+ejUqfCJlgZyX2HKPJKnnSHT53hdaWZouCILjpM3ERNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7uMZhiPLWhcwsbJyV2ZfnMlBx1eSRLpPiBwriY3Y/YkZJK+iq
	M8+tyP0owtTlOutcHXWUPdCFd2UCeJDjTuv/jid1W00oiZQuy+UiMb/BciSs4wj3BwuaIBeDnyB
	zFkksqj38FbCAcjHEkhLGjhBzm/8G8keMO0D/79kyXbXZMR7fVxPO4xoIHiQhIcUEOawIsGo=
X-Gm-Gg: ASbGncvYhNEB5mMRuve7hv0fZyd49t+KO00RFegpeS8FyyKT1pskJ3LPa0ToousCXM9
	VWsvns0JDpJYbA4z/7Thrh/bbS9Bir3IyFQpM+45gAXlzRxJsvU4wTckKNUyQKkmj8RJjIboXF8
	/SvpuEBmkGl3GkS15u2B0Gk7hNj5Q9+2IGMrvUnQOFSau0J9q4w+U1EP2cd1xVCM3bYoEJW3clk
	FqeKuSJq5B7Rug6qmoOTP4mJjkd3Jbul5LZ/9EqOz7uUymrJmZMhasp40ls7HIGjcc3f5BR7h4Q
	Enzy0sYvdD0P420/6qNEyNyE8HHbILLDYSFTKhxNYCNc2yXfTkU95MKL4gb+cR16Ea/FuTRY02f
	Hg83efNw4yU/wCjYFmg==
X-Received: by 2002:a05:622a:143:b0:4ab:63f8:ef30 with SMTP id d75a77b69052e-4b0fc6f5abamr14652431cf.3.1755078813047;
        Wed, 13 Aug 2025 02:53:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHL9p/V8kgz7pgbQLj/2LkDGUoYpwD7WnZTmIEKh4brnTqRmXHLFYJ1dJDBYqoeMLjGgWK2g==
X-Received: by 2002:a05:622a:143:b0:4ab:63f8:ef30 with SMTP id d75a77b69052e-4b0fc6f5abamr14652161cf.3.1755078812394;
        Wed, 13 Aug 2025 02:53:32 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af92a2ec9cbsm2254739566b.79.2025.08.13.02.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 02:53:31 -0700 (PDT)
Message-ID: <f015c644-1176-47b3-8ce2-2567e529081e@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 11:53:28 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/11] firmware: qcom: scm: add support for object
 invocation
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
 <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-6-ce7a1a774803@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-6-ce7a1a774803@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G6EcE8k5 c=1 sm=1 tr=0 ts=689c609e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=ZC-EX8TnQz-G3DLW9GIA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfX6FZiU+TlaA0h
 AxPHR3YTVRtAV7GiyrSv/LOo3P8BS9eBTggDLzM8ML1W/ES9l9u34kt7MGs2mar2XRtVpC/KfBo
 pM4NwAngZx59JAAejAYimYJQVrecFZKcOFBpRfN1/GJa+71VsxzyDG7IT8S0KqVy+0TApUoMDDw
 YRy/r7ehzqGj0akivH9Ndx37rVlw2cC7rkWu1rjQvqCqXB2pKAL+5f4PSaKX7GlPOtHAIqQzBVb
 1W2WRTqGhFOU3BOz0j3V0UQQS2wo90pq8KbrKwufpgO/Xm/0KZwWChjj9/7852pp6MUZqY7hFgA
 IC9dhIN2F4izJr13IyswNyyA43zK27ju3+008NiJN8ZgN97KY4k9sDa0GWqUfFMy9B5IZROyXw2
 4Tw0xDAt
X-Proofpoint-ORIG-GUID: d7RdF5uRTfxi6-3eqtVsh7IH9mkz-DAj
X-Proofpoint-GUID: d7RdF5uRTfxi6-3eqtVsh7IH9mkz-DAj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110097

On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
> Qualcomm TEE (QTEE) hosts Trusted Applications (TAs) and services in
> the secure world, accessed via objects. A QTEE client can invoke these
> objects to request services. Similarly, QTEE can request services from
> the nonsecure world using objects exported to the secure world.
> 
> Add low-level primitives to facilitate the invocation of objects hosted
> in QTEE, as well as those hosted in the nonsecure world.
> 
> If support for object invocation is available, the qcom_scm allocates
> a dedicated child platform device. The driver for this device communicates
> with QTEE using low-level primitives.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---

[...]

> +int qcom_scm_qtee_invoke_smc(phys_addr_t inbuf, size_t inbuf_size,
> +			     phys_addr_t outbuf, size_t outbuf_size,
> +			     u64 *result, u64 *response_type)
> +{
> +	struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_SMCINVOKE,
> +		.cmd = QCOM_SCM_SMCINVOKE_INVOKE,
> +		.owner = ARM_SMCCC_OWNER_TRUSTED_OS,
> +		.args[0] = inbuf,
> +		.args[1] = inbuf_size,
> +		.args[2] = outbuf,
> +		.args[3] = outbuf_size,
> +		.arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_RW, QCOM_SCM_VAL,
> +					 QCOM_SCM_RW, QCOM_SCM_VAL),
> +	};
> +	struct qcom_scm_res res;
> +	int ret;
> +
> +	ret = qcom_scm_call(__scm->dev, &desc, &res);
> +	if (ret)
> +		return ret;
> +
> +	*response_type = res.result[0];
> +	*result = res.result[1];

These are dereferenced without checking, which will surely upset static
checkers (and users)

I see that res.result[2] should also return some (aptly named) "data"
which you handled in v1, but dropped in v2 (without a comment AFAICT)

Looking at it, we could probably wrap it in qcom_scm_qseecom_call()
which this seems to be fit for

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(qcom_scm_qtee_invoke_smc);
> +
> +/**
> + * qcom_scm_qtee_callback_response() - Submit response for callback request.
> + * @buf: start address of memory area used for outbound buffer.
> + * @buf_size: size of the memory area used for outbound buffer.
> + * @result: Result of QTEE object invocation.
> + * @response_type: Response type returned by QTEE.
> + *
> + * @response_type determines how the contents of @buf should be processed.
> + *
> + * Return: On success, return 0 or <0 on failure.
> + */
> +int qcom_scm_qtee_callback_response(phys_addr_t buf, size_t buf_size,
> +				    u64 *result, u64 *response_type)

These should be aligned

> +{
> +	struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_SMCINVOKE,
> +		.cmd = QCOM_SCM_SMCINVOKE_CB_RSP,
> +		.owner = ARM_SMCCC_OWNER_TRUSTED_OS,
> +		.args[0] = buf,
> +		.args[1] = buf_size,
> +		.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_RW, QCOM_SCM_VAL),
> +	};
> +	struct qcom_scm_res res;
> +	int ret;
> +
> +	ret = qcom_scm_call(__scm->dev, &desc, &res);
> +	if (ret)
> +		return ret;
> +
> +	*response_type = res.result[0];
> +	*result = res.result[1];

this also seems like a good candidate for qcom_scm_qseecom_call()

[...]

>  /**
>   * qcom_scm_is_available() - Checks if SCM is available
>   */
> @@ -2326,6 +2444,16 @@ static int qcom_scm_probe(struct platform_device *pdev)
>  	ret = qcom_scm_qseecom_init(scm);
>  	WARN(ret < 0, "failed to initialize qseecom: %d\n", ret);
>  
> +	/*
> +	 * Initialize the QTEE object interface.
> +	 *
> +	 * This only represents the availability for QTEE object invocation
> +	 * and callback support. On failure, ignore the result. Any subsystem
> +	 * depending on it may fail if it tries to access this interface.
> +	 */
> +	ret = qcom_scm_qtee_init(scm);
> +	WARN(ret < 0, "failed to initialize qcomtee: %d\n", ret);

This will throw a WARN on *a lot* of platforms, ranging from
Chromebooks running TF-A (with a reduced SMC handler), through
platforms requiring QCOM_SCM_SMCINVOKE_INVOKE_LEGACY (0x00) cmd

Konrad
