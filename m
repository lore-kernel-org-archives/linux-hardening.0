Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E3B1F8672
	for <linux-hardening@vger.kernel.org>; Mon,  7 Apr 2025 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744037730; cv=none; b=sruUchFeNSE68QqRCFuUPrgcTZuiHrsTz+nvp6k4Pcgtd6+SW91b5xbCQ/t7uBSLJX02UB/fmDA/z3RCCj5fw3nN2IWCM8IE/BcNuFgTwhFkk+T2XPXF1FLdZhOSEEK6TEyJ51YRlVM/zxaEqmtCRPvUb8FrTJA6Wv8nX+DrgGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744037730; c=relaxed/simple;
	bh=E9qbrxGdm0fqahKIKbgt5AwMhqrhHXdpe/uu8rggp0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgr69kUar+Cr6p7nRz0IB8SETXPwnMMEJu+8pJJY86GL8niKLUhejiPsSTxFkCCfur+YAM5vPojvyMdfZa0dRiJm/v4lxTleBe6/Vh/iE6ynIwGXjsdr5rKIvNEXrpEQIfHF9sDoDSkxpsGsHm0GNbcGp/LLVkFPC314rzmdjoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J7i/Y59h; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J7i/Y59h"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2c7e5fb8c38so2793722fac.1
        for <linux-hardening@vger.kernel.org>; Mon, 07 Apr 2025 07:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744037726; x=1744642526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4xn9cimfDHTXs5TpUGv6N7Mowttz4ZTLbCFX2kVKqw=;
        b=J7i/Y59hjvNr4avwPD5Q8kF9RMsSvs30K5bkvTmuLguLYObIHDRS7DiAfDDsjdGKXQ
         wF2XYQN/464zI4EO/+gICsH9f+iu+PREB+9AjTJ4x8b/P+nkqQ3o8yS+DS1eDD0IpfZa
         OcvFBFhW88f8kgNn7YaX/aS0oFQFKth6fBTs/R6wbOAJfXIEEUiR4gWmoT3oTa0yzPRq
         mgaPtDqlzHYJgpIqVUSdOh+AiHny9wJVJZAx8gVXzT9oK0acG5tTojH5W0rpIcMU71v0
         qdp1hjcaWO5oqNGkQ/1nanc+1n/qvZEJtFgO2g0pkIVe3KV1HZ3T5fLJ97AEAefFUWLl
         O15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744037726; x=1744642526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4xn9cimfDHTXs5TpUGv6N7Mowttz4ZTLbCFX2kVKqw=;
        b=RRheLJ1Ra35dxN5FBbrf5bVg5vT6Qo78CSAKaxKuv2YQNiZ6dUbhvyvutT1P2Sv8ys
         ShVSW+ZH8/pgn1VZQ/55cWKjc8qIIMucIZKGDF99y6R4vzhD/LGb7rOnLGKqJZVVc5N8
         lQ1f30DDPjnRZdMOtP9jKC3bnQGZ3hQvkMS+rUcK8iNMV6vtSrPME/ibdSfA0Uyl9/LQ
         JhhZ6JCAPWMzs7O8xSBZigUbPPRCkx8vnUSMzC2VmsN23Cq5Ga9Ul2aNsQC85hcUuO06
         nekGNqp2l103zrWnf57E0k0nkPmTZLVeXMiHbT+S03l65RAO5pw9/8EFKQKV0aaFBv+4
         wssg==
X-Forwarded-Encrypted: i=1; AJvYcCXHJ7tYH7ksGR2EVDEkg0KyYawqU6Qw+skx+wWt38j60VaLLsUS5ypR+ntDBNSr5fBL/VCrJ0L66pK1jzVsbqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCIr1DbTEJFjmjihR8v9dHLPGTAKYZNeViSXUeUFEeikQf6XVN
	XJG41E6QiIl5XWE9MMdn/XIKQ+cN0gylaiwr/rBxRIMn7a4V61FrvowLxO6OGwB0nRBS/1xgKgv
	IQjpT+LXlUMi2Kf7kjqHcxicrZYgX8m7nKeEvaw==
X-Gm-Gg: ASbGnct6LZv35D3sN5/5VTE1lyEFyuZ9+NEk+FZnefV22SmR1Ru3D1lvh2aupznxQCJ
	Y5BU2Jz+8uCOqv+saBuRAvY9e/XN/E6yPP6lA4hNj/X/+oiITP6slFsUvN1jYadsaWTfsUPiWWS
	IQj/Ft1cSiStHAJB5YxgyA2pcSii8=
X-Google-Smtp-Source: AGHT+IE6txomzGGAbwFADFCUywgbtkEgGT6GCg3c/ibtTiN62bLYpeINpXvDIoclViQ8oopGWCfxq+knFtQaTlHdqqI=
X-Received: by 2002:a05:6870:de17:b0:2c2:5b08:8e42 with SMTP id
 586e51a60fabf-2cd3311870dmr5281511fac.27.1744037725617; Mon, 07 Apr 2025
 07:55:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-0-7f457073282d@oss.qualcomm.com>
 <20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-2-7f457073282d@oss.qualcomm.com>
In-Reply-To: <20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-2-7f457073282d@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 7 Apr 2025 16:55:13 +0200
X-Gm-Features: ATxdqUFUAjG5BhSKb_2PfAi1V3_18wUctOFmQdGMnywulnQl545FYuZXFXM_jpk
Message-ID: <CAHUa44G+Z9LjxqqqvKRRHrfN_6QPweF_5df2uOqtRuBfa5j3pw@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] tee: add close_context to TEE driver operation
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Apurupa Pattapu <quic_apurupa@quicinc.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amir,

On Fri, Mar 28, 2025 at 3:48=E2=80=AFAM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
> The tee_context can be used to manage TEE user resources, including
> those allocated by the driver for the TEE on behalf of the user.
> The release() callback is invoked only when all resources, such as
> tee_shm, are released and there are no references to the tee_context.
>
> When a user closes the device file, the driver should notify the
> TEE to release any resources it may hold and drop the context
> references. To achieve this, a close_context() callback is
> introduced to initiate resource release in the TEE driver when
> the device file is closed.
>
> Relocate teedev_ctx_get, teedev_ctx_put, tee_device_get, and
> tee_device_get functions to tee_drv.h to make them accessible
> outside the TEE subsystem.
>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---
>  drivers/tee/tee_core.c    | 39 +++++++++++++++++++++++++++++++++++++++
>  drivers/tee/tee_private.h |  6 ------
>  include/linux/tee_core.h  | 11 +++++++++--
>  include/linux/tee_drv.h   | 40 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 88 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 24edce4cdbaa..22cc7d624b0c 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -72,6 +72,20 @@ struct tee_context *teedev_open(struct tee_device *tee=
dev)
>  }
>  EXPORT_SYMBOL_GPL(teedev_open);
>
> +/**
> + * teedev_ctx_get() - Increment the reference count of a context
> + *
> + * This function increases the refcount of the context, which is tied to
> + * resources shared by the same tee_device. During the unregistration pr=
ocess,
> + * the context may remain valid even after tee_device_unregister() has r=
eturned.
> + *
> + * Users should ensure that the context's refcount is properly decreased=
 before
> + * calling tee_device_put(), typically within the context's release() fu=
nction.
> + * Alternatively, users can call tee_device_get() and teedev_ctx_get() t=
ogether
> + * and release them simultaneously (see shm_alloc_helper()).
> + *
> + * @ctx: Pointer to the context

Please move this @ctx line to before the verbose description of the functio=
n.

Cheers,
Jens

> + */
>  void teedev_ctx_get(struct tee_context *ctx)
>  {
>         if (ctx->releasing)
> @@ -79,6 +93,7 @@ void teedev_ctx_get(struct tee_context *ctx)
>
>         kref_get(&ctx->refcount);
>  }
> +EXPORT_SYMBOL_GPL(teedev_ctx_get);
>
>  static void teedev_ctx_release(struct kref *ref)
>  {
> @@ -89,6 +104,10 @@ static void teedev_ctx_release(struct kref *ref)
>         kfree(ctx);
>  }
>
> +/**
> + * teedev_ctx_put() - Decrease reference count on a context
> + * @ctx: pointer to the context
> + */
>  void teedev_ctx_put(struct tee_context *ctx)
>  {
>         if (ctx->releasing)
> @@ -96,11 +115,15 @@ void teedev_ctx_put(struct tee_context *ctx)
>
>         kref_put(&ctx->refcount, teedev_ctx_release);
>  }
> +EXPORT_SYMBOL_GPL(teedev_ctx_put);
>
>  void teedev_close_context(struct tee_context *ctx)
>  {
>         struct tee_device *teedev =3D ctx->teedev;
>
> +       if (teedev->desc->ops->close_context)
> +               teedev->desc->ops->close_context(ctx);
> +
>         teedev_ctx_put(ctx);
>         tee_device_put(teedev);
>  }
> @@ -1024,6 +1047,10 @@ int tee_device_register(struct tee_device *teedev)
>  }
>  EXPORT_SYMBOL_GPL(tee_device_register);
>
> +/**
> + * tee_device_put() - Decrease the user count for a tee_device
> + * @teedev: pointer to the tee_device
> + */
>  void tee_device_put(struct tee_device *teedev)
>  {
>         mutex_lock(&teedev->mutex);
> @@ -1037,7 +1064,18 @@ void tee_device_put(struct tee_device *teedev)
>         }
>         mutex_unlock(&teedev->mutex);
>  }
> +EXPORT_SYMBOL_GPL(tee_device_put);
>
> +/**
> + * tee_device_get() - Increment the user count for a tee_device
> + * @teedev: Pointer to the tee_device
> + *
> + * If tee_device_unregister() has been called and the final user of @tee=
dev
> + * has already released the device, this function will fail to prevent n=
ew users
> + * from accessing the device during the unregistration process.
> + *
> + * Returns: true if @teedev remains valid, otherwise false
> + */
>  bool tee_device_get(struct tee_device *teedev)
>  {
>         mutex_lock(&teedev->mutex);
> @@ -1049,6 +1087,7 @@ bool tee_device_get(struct tee_device *teedev)
>         mutex_unlock(&teedev->mutex);
>         return true;
>  }
> +EXPORT_SYMBOL_GPL(tee_device_get);
>
>  /**
>   * tee_device_unregister() - Removes a TEE device
> diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
> index 9bc50605227c..d3f40a03de36 100644
> --- a/drivers/tee/tee_private.h
> +++ b/drivers/tee/tee_private.h
> @@ -14,12 +14,6 @@
>
>  int tee_shm_get_fd(struct tee_shm *shm);
>
> -bool tee_device_get(struct tee_device *teedev);
> -void tee_device_put(struct tee_device *teedev);
> -
> -void teedev_ctx_get(struct tee_context *ctx);
> -void teedev_ctx_put(struct tee_context *ctx);
> -
>  struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t s=
ize);
>  struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
>                                           unsigned long addr, size_t leng=
th);
> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
> index a38494d6b5f4..8a4c9e30b652 100644
> --- a/include/linux/tee_core.h
> +++ b/include/linux/tee_core.h
> @@ -65,8 +65,9 @@ struct tee_device {
>  /**
>   * struct tee_driver_ops - driver operations vtable
>   * @get_version:       returns version of driver
> - * @open:              called when the device file is opened
> - * @release:           release this open file
> + * @open:              called for a context when the device file is open=
ed
> + * @close_context:     called when the device file is closed
> + * @release:           called to release the context
>   * @open_session:      open a new session
>   * @close_session:     close a session
>   * @system_session:    declare session as a system session
> @@ -76,11 +77,17 @@ struct tee_device {
>   * @supp_send:         called for supplicant to send a response
>   * @shm_register:      register shared memory buffer in TEE
>   * @shm_unregister:    unregister shared memory buffer in TEE
> + *
> + * The context given to @open might last longer than the device file if =
it is
> + * tied to other resources in the TEE driver. @close_context is called w=
hen the
> + * client closes the device file, even if there are existing references =
to the
> + * context. The TEE driver can use @close_context to start cleaning up.
>   */
>  struct tee_driver_ops {
>         void (*get_version)(struct tee_device *teedev,
>                             struct tee_ioctl_version_data *vers);
>         int (*open)(struct tee_context *ctx);
> +       void (*close_context)(struct tee_context *ctx);
>         void (*release)(struct tee_context *ctx);
>         int (*open_session)(struct tee_context *ctx,
>                             struct tee_ioctl_open_session_arg *arg,
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index a54c203000ed..ce23fd42c5d4 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -96,6 +96,46 @@ struct tee_param {
>         } u;
>  };
>
> +/**
> + * tee_device_get() - Increment the user count for a tee_device
> + * @teedev: Pointer to the tee_device
> + *
> + * If tee_device_unregister() has been called and the final user of @tee=
dev
> + * has already released the device, this function will fail to prevent n=
ew users
> + * from accessing the device during the unregistration process.
> + *
> + * Returns: true if @teedev remains valid, otherwise false
> + */
> +bool tee_device_get(struct tee_device *teedev);
> +
> +/**
> + * tee_device_put() - Decrease the user count for a tee_device
> + * @teedev: pointer to the tee_device
> + */
> +void tee_device_put(struct tee_device *teedev);
> +
> +/**
> + * teedev_ctx_get() - Increment the reference count of a context
> + *
> + * This function increases the refcount of the context, which is tied to
> + * resources shared by the same tee_device. During the unregistration pr=
ocess,
> + * the context may remain valid even after tee_device_unregister() has r=
eturned.
> + *
> + * Users should ensure that the context's refcount is properly decreased=
 before
> + * calling tee_device_put(), typically within the context's release() fu=
nction.
> + * Alternatively, users can call tee_device_get() and teedev_ctx_get() t=
ogether
> + * and release them simultaneously (see shm_alloc_helper()).
> + *
> + * @ctx: Pointer to the context
> + */
> +void teedev_ctx_get(struct tee_context *ctx);
> +
> +/**
> + * teedev_ctx_put() - Decrease reference count on a context
> + * @ctx: pointer to the context
> + */
> +void teedev_ctx_put(struct tee_context *ctx);
> +
>  /**
>   * tee_shm_alloc_kernel_buf() - Allocate kernel shared memory for a
>   *                              particular TEE client driver
>
> --
> 2.34.1
>
