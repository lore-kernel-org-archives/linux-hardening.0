Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28CB22578A
	for <linux-hardening@vger.kernel.org>; Thu, 11 Sep 2025 03:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757560752; cv=none; b=rlrjUUuocTijeRgWUMEzAAzGfc85Yo/kKJUX+rRYtKZu8eGrHGgFAPOQD7GUDHNa3zWqXxss0qOlwEVuJV1IIwsnvrSmRhn+71cFkjS2dFpPWdRpCuTjwewWYpnVDI8Ogghc77oNAU0N+rbDO7bvkSSAbfykhETQzQSuB7gUlqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757560752; c=relaxed/simple;
	bh=9HSJ4M3l8wxlkJRoKo/XxAvhBmmLkYJR9qfWXwkpZmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBVFmHcFO+6ohAKgaT7Rcq0Jjx8EAnbgEaq5+ov5rUeMsnQkiBmCiBD8GxQZC92UPk0/xSaH1mQ5P5pGwa9LgSC+FI2cnse+fkIz7THCiZ+pZOG3mHTErRjZ/jTliCgV8W8YY+M5eWvNBl7j8tjDA9WzE9Zxmh47ZLStrpsawPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L6vYqPhb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L6vYqPhb"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2IXxL006035
	for <linux-hardening@vger.kernel.org>; Thu, 11 Sep 2025 03:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LMMz/beZCdvqVQXt7ljdBTCVb0kcIqN10eziEUpqZKc=; b=L6vYqPhbj1DwYMfV
	oxvIRvTXnjvcVhM+OR3ScjO+gqbGmYKp37bx+jwl0L1wf90FIsL5r3yn7CRv3DBZ
	WUv1zHvhwjrGSXULwESjDewtySwTSlO/p0Bk8gc8fbZu4BjlarHLZOWl/DC77iky
	ghvAK/sLwmgWVhvybsJNH7PLh3bNDQOOBPi3XjuWja1umJpa4Od4EZUqEZ/Uqfqk
	5c/FB6xR0PtQRrXeSL+wM7ZgkmAD8oR/9wYXmjrQdRITlmuUKt+hfL09bYQluZi3
	AZrScIN1MnpCvY4CcpgaG6JisrrG1awIMB4ZvaXuajwfrruoXA9Wix6T4EaHSPDj
	tNGGRQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8ae1kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 11 Sep 2025 03:19:08 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24b4aa90c20so2678455ad.2
        for <linux-hardening@vger.kernel.org>; Wed, 10 Sep 2025 20:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757560748; x=1758165548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LMMz/beZCdvqVQXt7ljdBTCVb0kcIqN10eziEUpqZKc=;
        b=v6iUI8Ing9MJuj6BGvUi8woT83iAvFszpC3gaCk2urXV3VATcmlG8JMNvvedumPLJl
         gBB+EEhwrEyX0CSQNEAIvbG7Lqe3Vveom2g6ZYhmj6VywjaDsXr51GbFfdUKuPLUoXKr
         RDYHiqdcGflA4o/StkRd10sSPYpZCqLpnFrtgpKjLCggbHzIgTL4k1JWlGdIRuHuRk46
         1li2LFS4imqwj4RpOzvLWwRF8C1Udr03geXb6L3mq9AbAwBWQsSr3NyGNnpBAZSAPjMk
         4rtp2opSPg8CeXMKXsvS60RaOoF3t2mzlusYFxveigIa+AR65Wx8W4LZ1x3VB1clcatI
         s5cg==
X-Forwarded-Encrypted: i=1; AJvYcCUKhgAXfeTZ+HmPBbpO6Ipyxdb7ZshtaDWLAhWDbR40uHUix8XF9h9kmq0rPnfmxMEGxn3/a9huFeDIvNLzSaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzls9IjTmS/kbRMdr5NsI567NR2frPAHm+wL96+x1fnMhC+wAwR
	yiWjusQUA569imikMfTzPAVTjf/hZSuAyZb+uWxIVcBYRo3vC4pjUFEcE1Tmm3sDd76QaZ23wyD
	QcHLkOdBJb2B2GHRT/5cG75r0D4Tsih5tl9oHTnXwqJexA58sD7Jldw09aduPMX3g5KVAPw==
X-Gm-Gg: ASbGncuxx/8czjkiXdAFlWrl3X0x1V+7Sv2+CkujMdKeui8qwuv301FU0nporFv4h9s
	oxaOr17AeugWsQ5Fd14kcX6aLEdKHqOd3lzxOwFWW+5pK5W4Qjzyu5OZNCo2YfpER8oI6slE84+
	9ldokEI+8APtYFd5Ndw9WrR+wyD+Gn4Qb5IDlL+X6U2+iNsAlm+Z6/MwgTLPC3Izb8hboWmbKgg
	RYmmWIL2l9KYMhCrqprvdNWssN/VvWiMB+bRFLbIkgY3SG4sx/zdoHXL89T9BljPO/fMxywh67z
	9sZ55QcQB205uzK4M/oQcU5njQoUre48UWM6zpkusY9pzubKh5FUhu1u8q4QOWUMzxDNLmSO0mf
	rRUkkxJF47iMPhD178WaHVQf1mO2jG+Mas3C6nw==
X-Received: by 2002:a17:902:ce06:b0:24e:e5c9:ed07 with SMTP id d9443c01a7336-2517311894dmr260007645ad.36.1757560747523;
        Wed, 10 Sep 2025 20:19:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ6oFZGsoKEF6YNPd0EkmIus1YyTMDPHQIG1x59bSwD39p0/YQfyp9Xmnvg21I1G/sYxEahA==
X-Received: by 2002:a17:902:ce06:b0:24e:e5c9:ed07 with SMTP id d9443c01a7336-2517311894dmr260006635ad.36.1757560746789;
        Wed, 10 Sep 2025 20:19:06 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b304ce8sm2660265ad.128.2025.09.10.20.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 20:19:06 -0700 (PDT)
Message-ID: <23fe069e-727f-4bc3-a526-9320090991ed@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 13:18:58 +1000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/11] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuldeep Singh <quic_kuldsing@quicinc.com>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-0-20b17855ef31@oss.qualcomm.com>
 <aMEINycp24DG6KXO@sumit-X1>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <aMEINycp24DG6KXO@sumit-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68c23fac cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=PQODIOjcjKhI4WzMhAgA:9
 a=D8jLBtTEXUNSpw3P:21 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: njfYgjfuwC8M003LafsjBRsNuCr2xPJk
X-Proofpoint-ORIG-GUID: njfYgjfuwC8M003LafsjBRsNuCr2xPJk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfX04GPSVCl1vJq
 6pM/zUTlqjFN2g9XAZpVO4PBS2uXIhwokDbsjho0A0LK+kN5NcLGk0+M+oaBizjnSAsfx7uXAOe
 aIvaMOIaBtSJiDr7EsD4yfdTK5ePONPd6EIkyasFldN54duL+A14zeIju7d0f3frbAc8wDDLOGf
 7VtsFmuir+K4pNrb9NJ1dUigndPGz/H1IpQTOJcseUCq/ikFvUKkmprFnjRe+H28J1aBUMkMzwS
 Oe4tLe0OF1z3mQJysumJY3NkreU8bkQN/1z4Tb8HbOhi4QjPb9TvvrLO6OgEh9MjlLMZqFX9SK0
 zOw37BkTNT/JS6QYtxn40GsZxCy8g49n9yU5+mlsEnHDtjAsEBFBSQE4AVd+l9vaMKKPkqYAXza
 /Gg7hg+i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

Hi Sumit,

On 9/10/2025 3:10 PM, Sumit Garg wrote:
> Hi Amir,
> 
> On Tue, Sep 09, 2025 at 05:11:02PM -0700, Amirreza Zarrabi wrote:
>> This patch series introduces a Trusted Execution Environment (TEE)
>> driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TAs)
>> and services to run securely. It uses an object-based interface, where
>> each service is an object with sets of operations. Clients can invoke
>> these operations on objects, which can generate results, including other
>> objects. For example, an object can load a TA and return another object
>> that represents the loaded TA, allowing access to its services.
>>
>> Kernel and userspace services are also available to QTEE through a
>> similar approach. QTEE makes callback requests that are converted into
>> object invocations. These objects can represent services within the
>> kernel or userspace process.
>>
>> Note: This patch series focuses on QTEE objects and userspace services.
>>
>> Linux already provides a TEE subsystem, which is described in [1]. The
>> tee subsystem provides a generic ioctl interface, TEE_IOC_INVOKE, which
>> can be used by userspace to talk to a TEE backend driver. We extend the
>> Linux TEE subsystem to understand object parameters and an ioctl call so
>> client can invoke objects in QTEE:
>>
>>   - TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_*
>>   - TEE_IOC_OBJECT_INVOKE
>>
>> The existing ioctl calls TEE_IOC_SUPPL_RECV and TEE_IOC_SUPPL_SEND are
>> used for invoking services in the userspace process by QTEE.
>>
>> The TEE backend driver uses the QTEE Transport Message to communicate
>> with QTEE. Interactions through the object INVOKE interface are
>> translated into QTEE messages. Likewise, object invocations from QTEE
>> for userspace objects are converted into SEND/RECV ioctl calls to
>> supplicants.
>>
>> The details of QTEE Transport Message to communicate with QTEE is
>> available in [PATCH 12/12] Documentation: tee: Add Qualcomm TEE driver.
>>
>> You can run basic tests with following steps:
>> git clone https://github.com/quic/quic-teec.git
>> cd quic-teec
>> mkdir build
>> cmake .. -DCMAKE_TOOLCHAIN_FILE=CMakeToolchain.txt -DBUILD_UNITTEST=ON
>>
>> https://github.com/quic/quic-teec/blob/main/README.md lists dependencies
>> needed to build the above.
>>
>> More comprehensive tests are availabe at
>> https://github.com/qualcomm/minkipc.
>>
>> root@qcom-armv8a:~# qtee_supplicant &
>> root@qcom-armv8a:~# qtee_supplicant: process entry PPID = 378
>> Total listener services to start = 4
>> Opening CRequestTABuffer_open
>> Path /data/
>> register_service ::Opening CRegisterTABufCBO_UID
>> Calling TAbufCBO Register
>> QTEE_SUPPLICANT RUNNING
>>  
>> root@qcom-armv8a:~# smcinvoke_client -c /data 1
>> Run callback obj test...
>> Load /data/tzecotestapp.mbn, size 52192, buf 0x1e44ba0.
>> System Time: 2024-02-27 17:26:31
>> PASSED - Callback tests with Buffer inputs.
>> PASSED - Callback tests with Remote and Callback object inputs.
>> PASSED - Callback tests with Memory Object inputs.
>> TEST PASSED!
>> root@qcom-armv8a:~#
>> root@qcom-armv8a:~# smcinvoke_client -m /data 1
>> Run memory obj test...
>> Load /data/tzecotestapp.mbn, size 52192, buf 0x26cafba0.
>> System Time: 2024-02-27 17:26:39
>> PASSED - Single Memory Object access Test.
>> PASSED - Two Memory Object access Test.
>> TEST PASSED!
>>
>> This series has been tested for QTEE object invocations, including
>> loading a TA, requesting services from the TA, memory sharing, and
>> handling callback requests to a supplicant.
>>
>> Tested platforms: sm8650-mtp, sm8550-qrd, sm8650-qrd, sm8650-hdk
>>
>> [1] https://www.kernel.org/doc/Documentation/tee.txt
>>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>
>> Changes in v10:
>> - Remove all loggings in qcom_scm_qtee_init().
>> - Reorder patches.
>> - Link to v9:
>>   https://lore.kernel.org/r/20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com
> 
> It's still not rebased on top of linux-next and have merge conflicts,
> see my comments here [1].
> 
> [1] https://lore.kernel.org/all/aL_MCagNVIDXW0wp@sumit-X1/
> 
> -Sumit

Thanks, I'll rebase.

As per Bjorn's request, I removed the logging messages entirely,
as they seemed redundant. ;).

Regards,
Amir

> 
>>
>> Changes in v9:
>> - Remove unnecessary logging in qcom_scm_probe().
>> - Replace the platform_device_alloc()/add() sequence with
>>   platform_device_register_data().
>> - Fixed sparse warning.
>> - Fixed documentation typo.
>> - Link to v8:
>>   https://lore.kernel.org/r/20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com
>>
>> Changes in v8:
>> - Check if arguments to qcom_scm_qtee_invoke_smc() and
>>   qcom_scm_qtee_callback_response() are NULL.
>> - Add CPU_BIG_ENDIAN as a dependency to Kconfig.
>> - Fixed kernel bot errors.
>> - Link to v7:
>>   https://lore.kernel.org/r/20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com
>>
>> Changes in v7:
>> - Updated copyrights.
>> - Updated Acked-by: tags.
>> - Fixed kernel bot errors.
>> - Link to v6:
>>   https://lore.kernel.org/r/20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com
>>
>> Changes in v6:
>> - Relocate QTEE version into the driver's main service structure.
>> - Simplfies qcomtee_objref_to_arg() and qcomtee_objref_from_arg().
>> - Enhanced the return logic of qcomtee_object_do_invoke_internal().
>> - Improve comments and remove redundant checks.
>> - Improve helpers in qcomtee_msh.h to use GENMASK() and FIELD_GET().
>> - updated Tested-by:, Acked-by:, and Reviewed-by: tags
>> - Link to v5:
>>   https://lore.kernel.org/r/20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-0-024e3221b0b9@oss.qualcomm.com
>>
>> Changes in v5:
>> - Remove references to kernel services and public APIs.
>> - Support auto detection for failing devices (e.g., RB1, RB4).
>> - Add helpers for obtaining client environment and service objects.
>> - Query the QTEE version and print it.
>> - Move remaining static variables, including the object table, to struct
>>   qcomtee.
>> - Update TEE_MAX_ARG_SIZE to 4096.
>> - Add a dependancy to QCOM_TZMEM_MODE_SHMBRIDGE in Kconfig
>> - Reorganize code by removing release.c and qcom_scm.c.
>> - Add more error messages and improve comments.
>> - updated Tested-by:, Acked-by:, and Reviewed-by: tags
>> - Link to v4: https://lore.kernel.org/r/20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-0-6a143640a6cb@oss.qualcomm.com
>>
>> Changes in v4:
>> - Move teedev_ctx_get/put and tee_device_get/put to tee_core.h.
>> - Rename object to id in struct tee_ioctl_object_invoke_arg.
>> - Replace spinlock with mutex for qtee_objects_idr.
>> - Move qcomtee_object_get to qcomtee_user/memobj_param_to_object.
>> - More code cleanup following the comments.
>> - Cleanup documentations.
>> - Update MAINTAINERS file.
>> - Link to v3: https://lore.kernel.org/r/20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-0-7f457073282d@oss.qualcomm.com
>>
>> Changes in v3:
>> - Export shm_bridge create/delete APIs.
>> - Enable support for QTEE memory objects.
>> - Update the memory management code to use the TEE subsystem for all
>>   allocations using the pool.
>> - Move all driver states into the driver's main service struct.
>> - Add more documentations.
>> - Link to v2: https://lore.kernel.org/r/20250202-qcom-tee-using-tee-ss-without-mem-obj-v2-0-297eacd0d34f@quicinc.com
>>
>> Changes in v2:
>> - Clean up commit messages and comments.
>> - Use better names such as ubuf instead of membuf or QCOMTEE prefix
>>   instead of QCOM_TEE, or names that are more consistent with other
>>   TEE-backend drivers such as qcomtee_context_data instead of
>>   qcom_tee_context.
>> - Drop the DTS patch and instantiate the device from the scm driver.
>> - Use a single structure for all driver's internal states.
>> - Drop srcu primitives and use the existing mutex for synchronization
>>   between the supplicant and QTEE.
>> - Directly use tee_context to track the lifetime of qcomtee_context_data.
>> - Add close_context() to be called when the user closes the tee_context.
>> - Link to v1: https://lore.kernel.org/r/20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-0-f502ef01e016@quicinc.com
>>
>> Changes in v1:
>> - It is a complete rewrite to utilize the TEE subsystem.
>> - Link to RFC: https://lore.kernel.org/all/20240702-qcom-tee-object-and-ioctls-v1-0-633c3ddf57ee@quicinc.com
>>
>> ---
>> Amirreza Zarrabi (11):
>>       firmware: qcom: tzmem: export shm_bridge create/delete
>>       firmware: qcom: scm: add support for object invocation
>>       tee: allow a driver to allocate a tee_device without a pool
>>       tee: add close_context to TEE driver operation
>>       tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
>>       tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF
>>       tee: increase TEE_MAX_ARG_SIZE to 4096
>>       tee: add Qualcomm TEE driver
>>       tee: qcom: add primordial object
>>       tee: qcom: enable TEE_IOC_SHM_ALLOC ioctl
>>       Documentation: tee: Add Qualcomm TEE driver
>>
>>  Documentation/tee/index.rst              |   1 +
>>  Documentation/tee/qtee.rst               |  96 ++++
>>  MAINTAINERS                              |   7 +
>>  drivers/firmware/qcom/qcom_scm.c         | 119 ++++
>>  drivers/firmware/qcom/qcom_scm.h         |   7 +
>>  drivers/firmware/qcom/qcom_tzmem.c       |  63 ++-
>>  drivers/tee/Kconfig                      |   1 +
>>  drivers/tee/Makefile                     |   1 +
>>  drivers/tee/qcomtee/Kconfig              |  12 +
>>  drivers/tee/qcomtee/Makefile             |   9 +
>>  drivers/tee/qcomtee/async.c              | 182 ++++++
>>  drivers/tee/qcomtee/call.c               | 820 +++++++++++++++++++++++++++
>>  drivers/tee/qcomtee/core.c               | 915 +++++++++++++++++++++++++++++++
>>  drivers/tee/qcomtee/mem_obj.c            | 169 ++++++
>>  drivers/tee/qcomtee/primordial_obj.c     | 113 ++++
>>  drivers/tee/qcomtee/qcomtee.h            | 185 +++++++
>>  drivers/tee/qcomtee/qcomtee_msg.h        | 304 ++++++++++
>>  drivers/tee/qcomtee/qcomtee_object.h     | 316 +++++++++++
>>  drivers/tee/qcomtee/shm.c                | 150 +++++
>>  drivers/tee/qcomtee/user_obj.c           | 692 +++++++++++++++++++++++
>>  drivers/tee/tee_core.c                   | 127 ++++-
>>  drivers/tee/tee_private.h                |   6 -
>>  include/linux/firmware/qcom/qcom_scm.h   |   6 +
>>  include/linux/firmware/qcom/qcom_tzmem.h |  15 +
>>  include/linux/tee_core.h                 |  54 +-
>>  include/linux/tee_drv.h                  |  12 +
>>  include/uapi/linux/tee.h                 |  56 +-
>>  27 files changed, 4410 insertions(+), 28 deletions(-)
>> ---
>> base-commit: 33bcf93b9a6b028758105680f8b538a31bc563cf
>> change-id: 20241202-qcom-tee-using-tee-ss-without-mem-obj-362c66340527
>>
>> Best regards,
>> -- 
>> Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>

