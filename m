Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622201B6D08
	for <linux-hardening@vger.kernel.org>; Fri, 11 Jul 2025 05:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752210365; cv=none; b=F64I1f8zJNKXJ5wWtZ/KHMxrEkjUo2rRue7MPuaf1pr+4Cjrkj4L+1QW+BRHvhyUkvdtJfr4QlJeHH0eHIhj+aWT3UoL9Gc2epNykp5YgU9hLCQMRe3WASbV46q0lGKKx5PitEmYMY9iO34oZvP39PjymFq1lzibSokhfyaf59w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752210365; c=relaxed/simple;
	bh=ZiQ3Fv8gmz6RId3auba0EbdkWD4thp4jNvTHfKbkpmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pz5Dq5m+PruPJIa1W0YCwDpZwMAqfpAllh6s/CnN5M4RMjx+HlIVYpyvBgMzKBKePirB1mYkTVzzTM12Isl2K+pSyRoDKKNqGZatYMGKYmd0ykt5Rzpu0vB6L/SH1Bs8mDDWmx9oITIzn+pLV4FV2gVYUykomWSmKMicPovSJXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B9xo24QQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B9xo24QQ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1X7Ln021748
	for <linux-hardening@vger.kernel.org>; Fri, 11 Jul 2025 05:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ON4p5KKmBIR3FGHX5880lk4pL/vyxFoXHm7nsMOOrHc=; b=B9xo24QQrEIy7vY7
	2H/4mBPA3lz09M1dFW1fwOCkLhQfAW7ZCNoO5BPE83/2joulY+bKdcmmx1buzB4N
	DJ/k0jMO4qVOPlg9gxsmsShYUDwx4+Tkh5hVzS+GqIQA6tnG6jwrpqRQiwm6b9RS
	XPBK0WcYvjRKsCFErTQqZ8xDU9gfETVVz772t9enoch6qBI1PW/ivByxjkm8ZNhE
	V0l/K9PWd8NBcsTNpnzDVg2pVE4TydTdDmZEskeyhotPZmCkHAhrBUl8EulOipbr
	2hFqH7AF6YTK/z5hJYO5lxELm+g7qlasIirEqu+f1a1xEQdDlh6mI8QGPKeqqOBC
	j50esQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b18a27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 11 Jul 2025 05:05:57 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b3bc9d9590cso933054a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 10 Jul 2025 22:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752210356; x=1752815156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ON4p5KKmBIR3FGHX5880lk4pL/vyxFoXHm7nsMOOrHc=;
        b=vNhDPzsvaar4rjnycn/DPfBHmg8IilEBU+p3NBr12jgZgfvyBaGdqNnEVLCTh3olA+
         ETtnMp8j4wZ4YGnCd6SzQzyhfvVMFX0qwyWBFaOYm4FlaR+lCnBcC3ovctQG55DoPr19
         kTVElyQ6cbsDv9YOfyHCVDimOTmrBjCTT499T7Gen3sTbZJR9/dHHOF1NTdIkVaXM1Yu
         0fonngikcVLlk3jzUpGpTGCYbD+pHNJWpRuRxF2dDytZE4xVQXtCyjVltbfkU2YSh7ws
         Ia7PzxUDyLF6QMcUCWZNYUV3lTm/2l4XVdQzFil8tGBALCyb+j0maB/KoUOLhmAcMLjx
         ZneA==
X-Forwarded-Encrypted: i=1; AJvYcCVrkDqPBWIc1tfrHCs/lqhEB4DZTPMBJttKsnox3SL84uN9yjT72Skg/qXoejBuR2FBKdcCYm6ba8wFbOC35LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwpR53dTTWDCZRMEsf1vSxfuM/GVitR3jQ+vdtXsfpIgYE2qlW
	02oU95wyqREE7JrGzTIUwI10059M6A8fDK32sMM7Tqi7xoSknUKwVgDhnB8qq3B9S8SVZyJCQ0r
	mme9laZgLzFBRmn8SB3EXy5gzQgAoRJ21JKD/8ZA1gHa3lkF2LtiMnOuMyZWER/gXauziPA==
X-Gm-Gg: ASbGncsUrR9gE5iZb1A7t44NBkhqd9aYV+7BfRO8vtOMfkIEvACSvtDcjUHq/D7rkFv
	Ujy9lRcbqtcDV4N/ZF1O/x/sGGGzmveOk/2cxCjNqHgV29ZQ6QPKh9Gt1fLkfrA1RAxkmSxqWFl
	iKYvlRmbvYFWB2aNO1298PY1mxds0+kIx+PRZjn73m11L35HJ7GvoCK+Sf1pHTbSIjilJNkjJBj
	3JdcOaWgceE1CGYlfvwWmsgc4CilxqX5dD7s7SWr74sCBWrC5n1GtghefvOPGxEy853lrGSsKg4
	HBqaZ0DjytGQMO9hwJQWMScOwuasbKuXChAK18o/x6tvmFek35cV5Bcq6IyRVj7xvAJSOhfafm1
	exAZzCTnjEGQDUli07394JnU1N9VZ/COlCGD6EA==
X-Received: by 2002:a17:902:e54a:b0:234:8a16:d62b with SMTP id d9443c01a7336-23dede38615mr28066675ad.12.1752210356354;
        Thu, 10 Jul 2025 22:05:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc9IdZCzOQJSKnApzYY4Ey9QwM3RLDd7RZBRwcYVcIK2ljlo/TA59XUzUEdTJNZzy9kf6SxQ==
X-Received: by 2002:a17:902:e54a:b0:234:8a16:d62b with SMTP id d9443c01a7336-23dede38615mr28066255ad.12.1752210355851;
        Thu, 10 Jul 2025 22:05:55 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de432289bsm37082315ad.118.2025.07.10.22.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 22:05:55 -0700 (PDT)
Message-ID: <ad88258e-dc44-4b82-b49c-e327609ab774@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 15:05:46 +1000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] Documentation: tee: Add Qualcomm TEE driver
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
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org
References: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-0-024e3221b0b9@oss.qualcomm.com>
 <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-12-024e3221b0b9@oss.qualcomm.com>
 <aGu7boxOTB3TFRNU@sumit-X1>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <aGu7boxOTB3TFRNU@sumit-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=68709bb5 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8
 a=VwQbUJbxAAAA:8 a=XIjxTgID6P44-LRwrwcA:9 a=QEXdDO2ut3YA:10 a=M0EVDjxxv-UA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDAzMyBTYWx0ZWRfX7Q9eM9ybZHt2
 xRlu98b8TKhxUlZclOS4HlgXoE+Gz+tvH2ci7Tps+UDqjVw0Tpil5d9ZV2OAO2BzHUyn2j4j3Gp
 FhcSUwcG7+z5KGjEbOSVM/S3Pi58+LuCQHk3zq8k0TsP8YmdANRoFlkmtptVW2btf0QW33FlfUD
 sDdG536+bpOprHPRHdoWX/qgiaAc2pLima7qa1vNFdAL/myz0R57ZP91HyuwGhvjmP6qUkUuGr7
 aD5R/cesNkRzWZHDlhkEWcJFxWzkAlZQNAD8hWlWQT0jvmxqMjw44YP8Zbn+/IbIo2MUVOd7IO2
 f0JHF7oukqXoRgo6bBjL6Id0BWFkAsj9rb9C1P4rLtbjic1vuO64t2M/0wy7S5ts7yv17SMHVr6
 XIF4fHX6Z8CJOY5atYWujtzmOpwDeUjpfbEDnelCqQpgh3CDNg/ARJgBnzYNKFVTAErJ37/n
X-Proofpoint-GUID: 5cSxBCLoXW6SvkWfmpDqwIbEzpalgWjC
X-Proofpoint-ORIG-GUID: 5cSxBCLoXW6SvkWfmpDqwIbEzpalgWjC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110033

Hi Sumit,

On 7/7/2025 10:19 PM, Sumit Garg wrote:
> On Mon, May 26, 2025 at 11:56:57PM -0700, Amirreza Zarrabi wrote:
>> Add documentation for the Qualcomm TEE driver.
>>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>> ---
>>  Documentation/tee/index.rst |   1 +
>>  Documentation/tee/qtee.rst  | 150 ++++++++++++++++++++++++++++++++++++++++++++
>>  MAINTAINERS                 |   1 +
>>  3 files changed, 152 insertions(+)
>>
>> diff --git a/Documentation/tee/index.rst b/Documentation/tee/index.rst
>> index 4be6e69d7837..62afb7ee9b52 100644
>> --- a/Documentation/tee/index.rst
>> +++ b/Documentation/tee/index.rst
>> @@ -11,6 +11,7 @@ TEE Subsystem
>>     op-tee
>>     amd-tee
>>     ts-tee
>> +   qtee
>>  
>>  .. only::  subproject and html
>>  
>> diff --git a/Documentation/tee/qtee.rst b/Documentation/tee/qtee.rst
>> new file mode 100644
>> index 000000000000..8ae4da17c3a7
>> --- /dev/null
>> +++ b/Documentation/tee/qtee.rst
>> @@ -0,0 +1,150 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=============================================
>> +QTEE (Qualcomm Trusted Execution Environment)
>> +=============================================
>> +
>> +The QTEE driver handles communication with Qualcomm TEE [1].
>> +
>> +The lowest level of communication with QTEE builds on the ARM SMC Calling
>> +Convention (SMCCC) [2], which is the foundation for QTEE's Secure Channel
>> +Manager (SCM) [3] used internally by the driver [4].
>> +
>> +In a QTEE-based system, services are represented as objects with a series of
>> +operations that can be called to produce results, including other objects.
>> +
>> +When an object is hosted within QTEE, executing its operations is referred
>> +to as direct invocation. QTEE can invoke objects hosted in the kernel or
>> +userspace using a method known as callback requests.
>> +
>> +The SCM provides two functions for direct invocation and callback request:
>> +
>> +- QCOM_SCM_SMCINVOKE_INVOKE for direct invocation. It can return either
>> +  a result or a callback request.
>> +- QCOM_SCM_SMCINVOKE_CB_RSP submits a response for a previous callback request.
>> +
>> +The QTEE Transport Message [5] is stacked on top of the SCM driver functions.
>> +
>> +A message consists of two buffers shared with QTEE: inbound and outbound
>> +buffers. The inbound buffer is used for direct invocation, and the outbound
>> +buffer is used to make callback requests. This picture shows the contents of
>> +a QTEE transport message::
>> +
>> +                                      +---------------------+
>> +                                      |                     v
>> +    +-----------------+-------+-------+------+--------------------------+
>> +    | qcomtee_msg_    |object | buffer       |                          |
>> +    |  object_invoke  |  id   | offset, size |                          | (inbound buffer)
>> +    +-----------------+-------+--------------+--------------------------+
>> +    <---- header -----><---- arguments ------><- in/out buffer payload ->
>> +
>> +                                      +-----------+
>> +                                      |           v
>> +    +-----------------+-------+-------+------+----------------------+
>> +    | qcomtee_msg_    |object | buffer       |                      |
>> +    |  callback       |  id   | offset, size |                      | (outbound buffer)
>> +    +-----------------+-------+--------------+----------------------+
>> +
>> +Each buffer is started with a header and array of arguments.
>> +
>> +QTEE Transport Message supports four types of arguments:
>> +
>> +- Input Object (IO) is an object parameter to the current invocation
>> +  or callback request.
>> +- Output Object (OO) is an object parameter from the current invocation
>> +  or callback request.
>> +- Input Buffer (IB) is (offset, size) pair to the inbound or outbound region
>> +  to store parameter to the current invocation or callback request.
>> +- Output Buffer (OB) is (offset, size) pair to the inbound or outbound region
>> +  to store parameter from the current invocation or callback request.
>> +
>> +The QTEE driver provides the qcomtee_object, which represents an object within
>> +both QTEE and the kernel. To access any service in QTEE, a client needs to
>> +invoke an instance of this object. Any structure intended to represent a service
>> +for export to QTEE should include an instance of qcomtee_object::
>> +
>> +	struct driver_service {
>> +		struct qcomtee_object object;
>> +		...
>> +	};
>> +
>> +	#define to_driver_service_object(o) container_of((o), struct driver_service, object)
>> +
>> +	static int driver_service_dispatch(struct qcomtee_object *object, u32 op,
>> +					   struct qcomtee_arg *args)
>> +	{
>> +		struct driver_service *so = to_driver_service_object(object);
>> +
>> +		switch(op) {
>> +		case OBJECT_OP1:
>> +			...
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	static void driver_service_object_release(struct si_object *object)
>> +	{
>> +		struct driver_service *so = to_driver_service_object(object);
>> +		kfree(so);
>> +	}
>> +
>> +	struct si_object_operations driver_service_ops = {
>> +		.release = driver_service_object_release;
>> +		.dispatch = driver_service_dispatch;
>> +	};
>> +
>> +	void service_init(void)
>> +	{
>> +		struct driver_service *so = kzalloc(sizeof(*so), GFP_KERNEL);
>> +
>> +		/* Initialize so->object as a callback object. */
>> +		qcomtee_object_user_init(&so->object, QCOMTEE_OBJECT_TYPE_CB_OBJECT,
>> +					 &driver_service_ops, "driver_service_object");
>> +
>> +		/* Invoke a QTEE object and pass/register 'so->object' with QTEE. */
>> +		...
>> +	}
>> +	module_init(service_init);
> 
> Lets drop any reference for kernel client/services since they aren't
> supported by this patch-set yet.

Will do.

Regards,
Amir

> 
> -Sumit
> 
>> +
>> +The QTEE driver utilizes qcomtee_object to encapsulate userspace objects. When
>> +a callback request is made, it translates into calling the dispatch operation.
>> +For userspace objects, this is converted into requests accessible to callback
>> +servers and available through generic TEE API IOCTLs.
>> +
>> +Picture of the relationship between the different components in the QTEE
>> +architecture::
>> +
>> +         User space               Kernel                     Secure world
>> +         ~~~~~~~~~~               ~~~~~~                     ~~~~~~~~~~~~
>> +   +--------+   +----------+                                +--------------+
>> +   | Client |   |callback  |                                | Trusted      |
>> +   +--------+   |server    |                                | Application  |
>> +      /\        +----------+                                +--------------+
>> +      ||  +----------+ /\                                          /\
>> +      ||  |callback  | ||                                          ||
>> +      ||  |server    | ||                                          \/
>> +      ||  +----------+ ||                                   +--------------+
>> +      \/       /\      ||                                   | TEE Internal |
>> +   +-------+   ||      ||                                   | API          |
>> +   | TEE   |   ||      ||   +--------+--------+             +--------------+
>> +   | Client|   ||      ||   | TEE    | QTEE   |             | QTEE         |
>> +   | API   |   \/      \/   | subsys | driver |             | Trusted OS   |
>> +   +-------+----------------+----+-------+----+-------------+--------------+
>> +   |      Generic TEE API        |       |   QTEE MSG                      |
>> +   |      IOCTL (TEE_IOC_*)      |       |   SMCCC (QCOM_SCM_SMCINVOKE_*)  |
>> +   +-----------------------------+       +---------------------------------+
>> +
>> +References
>> +==========
>> +
>> +[1] https://docs.qualcomm.com/bundle/publicresource/topics/80-70015-11/qualcomm-trusted-execution-environment.html
>> +
>> +[2] http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
>> +
>> +[3] drivers/firmware/qcom/qcom_scm.c
>> +
>> +[4] drivers/tee/qcomtee/qcom_scm.c
>> +
>> +[5] drivers/tee/qcomtee/qcomtee_msg.h
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 99fe1ae22ae0..42823d33cc03 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20515,6 +20515,7 @@ QUALCOMM TEE (QCOMTEE) DRIVER
>>  M:	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>  L:	linux-arm-msm@vger.kernel.org
>>  S:	Maintained
>> +F:	Documentation/tee/qtee.rst
>>  F:	drivers/tee/qcomtee/
>>  F:	include/linux/firmware/qcom/qcom_tee.h
>>  
>>
>> -- 
>> 2.34.1
>>

