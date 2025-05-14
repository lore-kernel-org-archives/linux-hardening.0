Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D241B424F
	for <linux-hardening@vger.kernel.org>; Wed, 14 May 2025 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747236480; cv=none; b=epsmS498eNRivyis/i84e9MmJbS0nQHwT2Pnx1FDbf+AWMXS7e/PBwUgYTNSNP2weokUMZAcKeWLlMEuO+/S4/VCvckZ/L3LRfCs+bBq4i0XqVTsL+bPgDInEuWAM/oizSzOemKdddaXc1Xf96t3psNL1ifaixh8W3639EfhaHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747236480; c=relaxed/simple;
	bh=SGKjeHVkf6yzlsanhJUth/0wT7fmx6nVcIxyoA2ge08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDV3zh4atW+O5LwXRD/sqV9pMciP6SNQieDSFclVogjrNTB4IKEV3q5e+pcEH707aJmqfLIWn9eOE0XLEVEbDVWpnIevwzZtwJ/eHsDmGgEoM6YljFN8zuwRGW3i9tL+fs9Oht4n0jS15Y013ZQoZu4jDmQNcS6eMrOvI4AfG+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=grnyxb9+; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="grnyxb9+"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad2490d7838so107458366b.0
        for <linux-hardening@vger.kernel.org>; Wed, 14 May 2025 08:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747236477; x=1747841277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SGKjeHVkf6yzlsanhJUth/0wT7fmx6nVcIxyoA2ge08=;
        b=grnyxb9+BJjxqXifb26sykPJ3CcuBcpwvMtlEXyZVzEeelNLmTsZqCtlXlQigL1xxr
         XuaKeEELmraKZKYJqXg3oBsnByBVl/wTzfQkjiBGeQnvBZqxxUYubSZBlZb9Il7yTc1a
         MBBC7WeNG+7Mm2XeiwHqqRYksEb9fD5kb7ClAB0RmeC1plp+ZJqh1oYYd58euHg4dbl0
         OVb9U8eETKStDE3Mj17vLu0z39eDd2vZ+x+9efdl9PWcScmNzRVVoffipDhas1DQ0veA
         v9FJCpSdjIPVUtlSBEvZ2AHhOgpl90T/4XtEVTxNjKSBW0x+4o8oPme/n1wK4QSDBCHQ
         H1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747236477; x=1747841277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGKjeHVkf6yzlsanhJUth/0wT7fmx6nVcIxyoA2ge08=;
        b=Y/jZ/MvYpzh3KXI+PlEIcN3bKIw0Yt5RaC7XcbhxGfvLR6dDT9ZQDKg0Wkl9a9QOpl
         oyVNgREoJ2xOqhPZ4EbKvDbWQclG30sI8G2t2BAwoVUm49VnhJVCTTt4XR0p1XYqhbu/
         Yf5VZIMYupjjUAf3e0MGGvniRsknh6vsifoXsOZy/dAdZ2OV6ozf2u3RCrE6A8ssI3ma
         yWiPjMweTscI3w0jxyufkk9hzpFjWH51L1L1zK+gR2clb+AdCTCVK7Og7jVqhwxZiusT
         UekeQPDpkNqPIoseKMyv1PH65Mr97FY5J+XmJmbFrTOIvNDzjP7v5SbdkW30jdyqJfjD
         Xu1A==
X-Forwarded-Encrypted: i=1; AJvYcCX/7KZnjUnkCrve3Bz7aiwKWUk27IuaV8XSURFqrkP/RMUULed2eVD57uU11aFXFSEzaYIrKJPGd86RSF5YSKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOChm1as2JHSEzyAW6Kl0MEN42eVFsKsIElFVOtaE6Medzfegr
	/frzHSp13Ask7uA36eNP3VAL5OZfvKYcs2dT5pHWrWVqkmDj3qBoaGIUgaS/dWRv72Akr0f4IYn
	EzbTFWxezs9k+Du4be2u1xAc8lZL56aVLApVbcA==
X-Gm-Gg: ASbGncucWho9+t9zl8VCZPLQs1U6LWUpZ3qU+BsxG5XE4FnDqK5JJ+52fqZTda5zarw
	yRLEP8iL89dunk6W9VfNTEdVO7M+uV6ImEUCpLWJBDZcxf0TssiWmu0pWpcJR/rsG3P+hIwm6iM
	l794b6h3OUb3gl//ntI9zuXB5tpecB0nU=
X-Google-Smtp-Source: AGHT+IFI6WGyYTssVEodUuBbRbHdt/cK0IPusMpr/1+pqSkJpRWIkQArQUnuyloTmvBZCSiRQ0Ya6krvZBl9FePgExs=
X-Received: by 2002:a17:906:4f86:b0:ad5:935:81db with SMTP id
 a640c23a62f3a-ad5093584e3mr109467866b.10.1747236476735; Wed, 14 May 2025
 08:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-0-6a143640a6cb@oss.qualcomm.com>
 <20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-5-6a143640a6cb@oss.qualcomm.com>
 <aCRkRTMFi65zBODh@sumit-X1>
In-Reply-To: <aCRkRTMFi65zBODh@sumit-X1>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 14 May 2025 17:27:44 +0200
X-Gm-Features: AX0GCFubE386IXxNi4n8B2NKhYEqMdnxy1eH-BueT9owSlm2f-luFbE7L4_yv50
Message-ID: <CACMJSev2qqnxLN6OiSEKhUqxeewY09to0Jd2oPNoE39YFS6i3A@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] firmware: qcom: scm: add support for object invocation
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, 
	Jens Wiklander <jens.wiklander@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Apurupa Pattapu <quic_apurupa@quicinc.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 May 2025 at 11:37, Sumit Garg <sumit.garg@kernel.org> wrote:
>
> Hi Amir,
>
> I am still unable to get the QCOMTEE driver to work on db845c. As I can
> see machine: "qcom,sdm845" is not supported for tzmem based on SHM
> brigde here: drivers/firmware/qcom/qcom_tzmem.c +81. I am still seeing
> following logs from userspace:
>
> # /mnt/unittest -d
> [test_print_diagnostics_info][31] test_get_client_env_object.
> [test_supplicant_release][65] test_supplicant_worker killed.
>
> I think you should first check here for SHM bridge support. If available
> then only add a QTEE platform device.
>

On platforms not supporting SHM Bridge, the module should fall back to
non-SHM mode. Isn't it the case?

Bart
