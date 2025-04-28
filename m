Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC82D73451
	for <linux-hardening@vger.kernel.org>; Mon, 28 Apr 2025 04:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745812911; cv=none; b=FkctqV8WZoRkWbGfMd4igw3yXszeUNhEZ05hXYobooWvVWISYEk7iHIaDfzHeOz4iedysz2ad5PocFSxVl4kXPF9RqM2dgqowYo4+hTD342LMLnzdTPLVxVfGq1nn1yuiQmBcW1PlMTX44GU/ADYsEU3gbV7YL/mSfooc0Z5A3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745812911; c=relaxed/simple;
	bh=h521du+oOsKqN8nVFL1leWAGOcYOY+aeH/BCDo07OZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAATiN4Wo2jRtYVPTlZlD1Vapk7ha00Wgzv0j+knPTycEKMZdjH8S1iE/RLxa2BJGr++1pQLX5GL10gMFucFzQqmlVTONwBIG18w9Ftp0G/hTXKFULk8jtwFYZyccg8TIRyXQo0z0TgopTzTJHjoYexQG1qA6bnKsOIJJYE7+QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nuO69sGG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nuO69sGG"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S3VfEm007553
	for <linux-hardening@vger.kernel.org>; Mon, 28 Apr 2025 04:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DejT4J16K0zWYoNdRL1oIKIin9yI3PBcLZCFQSodLbc=; b=nuO69sGGhZYiVjdI
	doK8P+aA+H1TrxSMTICganCHhiBlceiF8xafj9pxZ3nja24QXT6WawtDgGOGQ2er
	T3idaIPYrp371XpDn5LxlKWTuZWEd3DrO+Ppfne1H5V5Q6sNSm32tW8p9gcQalK5
	vZe4uqvX0Zsf/9Wiis0th9KPanfOxu1dwgfTqRuZThy2iw2o8v0GPz4LSD2xsuDI
	udrlhHIO5RSBqRpRSYhnqXHyB4f6PmW6oq+7hauKge/AUHiJR6rnL4GZuwWnR2BF
	tKy45wog+YbNoVbTG9lkOaFREdg0zTyMZjP2luAJQ3BgNDObyfeIB7li64I+4rCG
	JHiaSA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468rnmwnhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 28 Apr 2025 04:01:47 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2240a96112fso68383325ad.2
        for <linux-hardening@vger.kernel.org>; Sun, 27 Apr 2025 21:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745812907; x=1746417707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DejT4J16K0zWYoNdRL1oIKIin9yI3PBcLZCFQSodLbc=;
        b=NA2lloBd6Mzj3p/xcmrSiQ0915j76lZW256z6gnzl7cMhdcEv9cOIaYWnzoOnzGkr5
         q5pxbsHWgZ505Y1OLPop6WIvugltEkbGw79Iz2M8nivYMvNBTgMQQ0oN/wBXPMXEtTSq
         /qS7L7eCwcFra/ReFQbZRHShBZ6myK1vm3o584W+PBZWzuiKk39LufJZjg7knCveZxE9
         oKPb80GC1oHrM3wyy+658wFoFUbd0WZdhzbwPA0P4ca6OlHcLfccemlSz+rETc3TSutF
         X6XG8prAMc0h1AdvJOm0+dPZ0BWmDgc2+e6fJx+q5b117OmYHBpAOEuXfqo+ax3gv6KQ
         Gvkw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ/fmGjA8yMgI8pCAdOf6wQLTK7F8obeJMRIfggoGxuzT3ADEcMj+t2MxSusjupT477e4WjjMifKwnBVpZWzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9jB2LhwGHv+i1FYiK/1EutwosPGUxl4ma4krUGCJM7DemB7KU
	Ro/Y67D5P+u96eqJdnOMeF0DqRafJmqTvp9eqXY4IwzPXJ02AZP3KWKpSCkl9zD/nCWMehVztjy
	wIOZbjIvm7wAQdnn+FpR/w6Kspvt0yCYZlfDQ+2Z72ipr0PdXfGQVlqG8cD6LQMi2Xg==
X-Gm-Gg: ASbGncuKfJO3FHqhBYRdxkjgqZSUafAgfnUL2hawdCljgU87TP2wWT1TPS13/LKCgW6
	jvrjatFTWGb+FCr+M0RIujJwi0pa3ykwJJBUSxVBJCFPTlay1vm2nSk1ighDcqfwp2QWbPNU2/4
	xgI8kWlt6cOC/81vU3YSlN0fyV7Nx93vAv8n0eoZAw5q/SZ+lzaXkEw/rg8niyJXZHfOf6BUgEq
	CjUG6kq7lTvT8gJfyfBpKnHdDnVUEvjiFYYt0z3j9sXTyEg/z/GT1D7Qns8wpDs7YA6QrZDo3bk
	QAJTKI5U5wOhn7kn3CqkGBxCDOpaz8wwl7k14ftJq7xsaxEEILAv9sAewIsWBNpVRPKjxNwuRyl
	stisg3exoaA==
X-Received: by 2002:a17:903:2ac6:b0:223:f408:c3e2 with SMTP id d9443c01a7336-22dc6a044bbmr124042805ad.14.1745812906948;
        Sun, 27 Apr 2025 21:01:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbbFIRcxoiiP4FReZ1WziDFdYEIAXqyusYcpdbf8RS10Jfxq3hdmSypRhLQqAI9N/SBp8YAA==
X-Received: by 2002:a17:903:2ac6:b0:223:f408:c3e2 with SMTP id d9443c01a7336-22dc6a044bbmr124042215ad.14.1745812906430;
        Sun, 27 Apr 2025 21:01:46 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22dd86032dcsm11868535ad.181.2025.04.27.21.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Apr 2025 21:01:45 -0700 (PDT)
Message-ID: <1bbdd255-ccd7-4b28-9d16-66c4e0c9fd34@oss.qualcomm.com>
Date: Mon, 28 Apr 2025 14:01:37 +1000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/11] tee: add close_context to TEE driver operation
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
        linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-doc@vger.kernel.org
References: <20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-0-7f457073282d@oss.qualcomm.com>
 <20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-2-7f457073282d@oss.qualcomm.com>
 <aAYhCg6XOeZm7jqq@sumit-X1>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <aAYhCg6XOeZm7jqq@sumit-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: BamxqxQ1N-i_HyliT0f6wK8BWmS8MMbb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDAzMiBTYWx0ZWRfX/fPKG5ELsTni nW9JFAkfpv6btrpQrR0y2AcZK1IQDOmIBUTdGER3sQeWO2IcjYTCAA72G70HRKvUDZj/2NvTsFV qpLl26x4WCQC4NbN6ZnCVsnS+KXjK7wulzwVyxK6FeBKC7ObDGxrAXGUEXwu7rA7hwhHx35sJA6
 twimSOhQQkvDTUSPN8m8jikLfN2dRsTV5Q40dBTL6R7dIV7FBmtjU9lR2YWuiMe1bfu0gMB351S pUDzhzWy2Ie+Rdu6QOJrYs8p60d62gpQJRiM7GIFVBu9FNcSL1A03z0jil1VW38VPAc55V+RYrp 5Lsh36yjCr3f6iR6M2vtvTsdF4bocoZ1q7TdJqecEPihKttdiZnpsMxtUm0fHI9GQT/EFjmJFLl
 i9tj5tjV80eHEgMOYlapVX66/ErvYJTOf9+PB8D3p+zBMTG4y6ap5bOD8bpywbUP0ldBbuzJ
X-Proofpoint-GUID: BamxqxQ1N-i_HyliT0f6wK8BWmS8MMbb
X-Authority-Analysis: v=2.4 cv=V9990fni c=1 sm=1 tr=0 ts=680efdac cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=hOmYuENgTawAdwdYsFYA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280032

Hi Sumit

On 4/21/2025 8:42 PM, Sumit Garg wrote:
> On Thu, Mar 27, 2025 at 07:47:24PM -0700, Amirreza Zarrabi wrote:
>> The tee_context can be used to manage TEE user resources, including
>> those allocated by the driver for the TEE on behalf of the user.
>> The release() callback is invoked only when all resources, such as
>> tee_shm, are released and there are no references to the tee_context.
>>
>> When a user closes the device file, the driver should notify the
>> TEE to release any resources it may hold and drop the context
>> references. To achieve this, a close_context() callback is
>> introduced to initiate resource release in the TEE driver when
>> the device file is closed.
> 
> Can you ellaborate more as to whether the TEE driver will release
> resources corresponding to a particular user or all the users?
>

Only users in the closing context are affected. So, if multiple
processes have opened the device file, only the resources belonging to
that process -- along with the resources in that context obtained by QTEE
-- are released.


>>
>> Relocate teedev_ctx_get, teedev_ctx_put, tee_device_get, and
>> tee_device_get functions to tee_drv.h to make them accessible
>> outside the TEE subsystem.
> 
> These should rather be relocated to tee_core.h as tee_drv.h is rather
> meant for kernel TEE client drivers.
> 

Ack.

>>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>> ---
>>  drivers/tee/tee_core.c    | 39 +++++++++++++++++++++++++++++++++++++++
>>  drivers/tee/tee_private.h |  6 ------
>>  include/linux/tee_core.h  | 11 +++++++++--
>>  include/linux/tee_drv.h   | 40 ++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 88 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
>> index 24edce4cdbaa..22cc7d624b0c 100644
>> --- a/drivers/tee/tee_core.c
>> +++ b/drivers/tee/tee_core.c
>> @@ -72,6 +72,20 @@ struct tee_context *teedev_open(struct tee_device *teedev)
>>  }
>>  EXPORT_SYMBOL_GPL(teedev_open);
>>  
>> +/**
>> + * teedev_ctx_get() - Increment the reference count of a context
>> + *
>> + * This function increases the refcount of the context, which is tied to
>> + * resources shared by the same tee_device. During the unregistration process,
>> + * the context may remain valid even after tee_device_unregister() has returned.
>> + *
>> + * Users should ensure that the context's refcount is properly decreased before
>> + * calling tee_device_put(), typically within the context's release() function.
>> + * Alternatively, users can call tee_device_get() and teedev_ctx_get() together
>> + * and release them simultaneously (see shm_alloc_helper()).
>> + *
>> + * @ctx: Pointer to the context
>> + */
> 
> Let's not duplicate the documentation here when it has already been
> documented in the header file.
> 
> Same for other places below.
> 
> -Sumit
>

I was trying to follow how the TEE subsystem has already documented
other functions. I believe the documentation in the C file is the standard
practice. But I'll remove these.

Best regards,
Amir

 
>>  void teedev_ctx_get(struct tee_context *ctx)
>>  {
>>  	if (ctx->releasing)
>> @@ -79,6 +93,7 @@ void teedev_ctx_get(struct tee_context *ctx)
>>  
>>  	kref_get(&ctx->refcount);
>>  }
>> +EXPORT_SYMBOL_GPL(teedev_ctx_get);
>>  
>>  static void teedev_ctx_release(struct kref *ref)
>>  {
>> @@ -89,6 +104,10 @@ static void teedev_ctx_release(struct kref *ref)
>>  	kfree(ctx);
>>  }
>>  
>> +/**
>> + * teedev_ctx_put() - Decrease reference count on a context
>> + * @ctx: pointer to the context
>> + */
>>  void teedev_ctx_put(struct tee_context *ctx)
>>  {
>>  	if (ctx->releasing)
>> @@ -96,11 +115,15 @@ void teedev_ctx_put(struct tee_context *ctx)
>>  
>>  	kref_put(&ctx->refcount, teedev_ctx_release);
>>  }
>> +EXPORT_SYMBOL_GPL(teedev_ctx_put);
>>  
>>  void teedev_close_context(struct tee_context *ctx)
>>  {
>>  	struct tee_device *teedev = ctx->teedev;
>>  
>> +	if (teedev->desc->ops->close_context)
>> +		teedev->desc->ops->close_context(ctx);
>> +
>>  	teedev_ctx_put(ctx);
>>  	tee_device_put(teedev);
>>  }
>> @@ -1024,6 +1047,10 @@ int tee_device_register(struct tee_device *teedev)
>>  }
>>  EXPORT_SYMBOL_GPL(tee_device_register);
>>  
>> +/**
>> + * tee_device_put() - Decrease the user count for a tee_device
>> + * @teedev: pointer to the tee_device
>> + */
>>  void tee_device_put(struct tee_device *teedev)
>>  {
>>  	mutex_lock(&teedev->mutex);
>> @@ -1037,7 +1064,18 @@ void tee_device_put(struct tee_device *teedev)
>>  	}
>>  	mutex_unlock(&teedev->mutex);
>>  }
>> +EXPORT_SYMBOL_GPL(tee_device_put);
>>  
>> +/**
>> + * tee_device_get() - Increment the user count for a tee_device
>> + * @teedev: Pointer to the tee_device
>> + *
>> + * If tee_device_unregister() has been called and the final user of @teedev
>> + * has already released the device, this function will fail to prevent new users
>> + * from accessing the device during the unregistration process.
>> + *
>> + * Returns: true if @teedev remains valid, otherwise false
>> + */
>>  bool tee_device_get(struct tee_device *teedev)
>>  {
>>  	mutex_lock(&teedev->mutex);
>> @@ -1049,6 +1087,7 @@ bool tee_device_get(struct tee_device *teedev)
>>  	mutex_unlock(&teedev->mutex);
>>  	return true;
>>  }
>> +EXPORT_SYMBOL_GPL(tee_device_get);
>>  
>>  /**
>>   * tee_device_unregister() - Removes a TEE device
>> diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
>> index 9bc50605227c..d3f40a03de36 100644
>> --- a/drivers/tee/tee_private.h
>> +++ b/drivers/tee/tee_private.h
>> @@ -14,12 +14,6 @@
>>  
>>  int tee_shm_get_fd(struct tee_shm *shm);
>>  
>> -bool tee_device_get(struct tee_device *teedev);
>> -void tee_device_put(struct tee_device *teedev);
>> -
>> -void teedev_ctx_get(struct tee_context *ctx);
>> -void teedev_ctx_put(struct tee_context *ctx);
>> -
>>  struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size);
>>  struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
>>  					  unsigned long addr, size_t length);
>> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
>> index a38494d6b5f4..8a4c9e30b652 100644
>> --- a/include/linux/tee_core.h
>> +++ b/include/linux/tee_core.h
>> @@ -65,8 +65,9 @@ struct tee_device {
>>  /**
>>   * struct tee_driver_ops - driver operations vtable
>>   * @get_version:	returns version of driver
>> - * @open:		called when the device file is opened
>> - * @release:		release this open file
>> + * @open:		called for a context when the device file is opened
>> + * @close_context:	called when the device file is closed
>> + * @release:		called to release the context
>>   * @open_session:	open a new session
>>   * @close_session:	close a session
>>   * @system_session:	declare session as a system session
>> @@ -76,11 +77,17 @@ struct tee_device {
>>   * @supp_send:		called for supplicant to send a response
>>   * @shm_register:	register shared memory buffer in TEE
>>   * @shm_unregister:	unregister shared memory buffer in TEE
>> + *
>> + * The context given to @open might last longer than the device file if it is
>> + * tied to other resources in the TEE driver. @close_context is called when the
>> + * client closes the device file, even if there are existing references to the
>> + * context. The TEE driver can use @close_context to start cleaning up.
>>   */
>>  struct tee_driver_ops {
>>  	void (*get_version)(struct tee_device *teedev,
>>  			    struct tee_ioctl_version_data *vers);
>>  	int (*open)(struct tee_context *ctx);
>> +	void (*close_context)(struct tee_context *ctx);
>>  	void (*release)(struct tee_context *ctx);
>>  	int (*open_session)(struct tee_context *ctx,
>>  			    struct tee_ioctl_open_session_arg *arg,
>> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
>> index a54c203000ed..ce23fd42c5d4 100644
>> --- a/include/linux/tee_drv.h
>> +++ b/include/linux/tee_drv.h
>> @@ -96,6 +96,46 @@ struct tee_param {
>>  	} u;
>>  };
>>  
>> +/**
>> + * tee_device_get() - Increment the user count for a tee_device
>> + * @teedev: Pointer to the tee_device
>> + *
>> + * If tee_device_unregister() has been called and the final user of @teedev
>> + * has already released the device, this function will fail to prevent new users
>> + * from accessing the device during the unregistration process.
>> + *
>> + * Returns: true if @teedev remains valid, otherwise false
>> + */
>> +bool tee_device_get(struct tee_device *teedev);
>> +
>> +/**
>> + * tee_device_put() - Decrease the user count for a tee_device
>> + * @teedev: pointer to the tee_device
>> + */
>> +void tee_device_put(struct tee_device *teedev);
>> +
>> +/**
>> + * teedev_ctx_get() - Increment the reference count of a context
>> + *
>> + * This function increases the refcount of the context, which is tied to
>> + * resources shared by the same tee_device. During the unregistration process,
>> + * the context may remain valid even after tee_device_unregister() has returned.
>> + *
>> + * Users should ensure that the context's refcount is properly decreased before
>> + * calling tee_device_put(), typically within the context's release() function.
>> + * Alternatively, users can call tee_device_get() and teedev_ctx_get() together
>> + * and release them simultaneously (see shm_alloc_helper()).
>> + *
>> + * @ctx: Pointer to the context
>> + */
>> +void teedev_ctx_get(struct tee_context *ctx);
>> +
>> +/**
>> + * teedev_ctx_put() - Decrease reference count on a context
>> + * @ctx: pointer to the context
>> + */
>> +void teedev_ctx_put(struct tee_context *ctx);
>> +
>>  /**
>>   * tee_shm_alloc_kernel_buf() - Allocate kernel shared memory for a
>>   *                              particular TEE client driver
>>
>> -- 
>> 2.34.1
>>
>>

