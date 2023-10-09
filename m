Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3321A3B7A6
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hz72/ybI"
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2714CE3
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 12:53:00 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c7373cff01so43344255ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 09 Oct 2023 12:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696881179; x=1697485979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=csxmouwm4ofhF5cKOMzE27Rri8PFeo+HUVsFVEvzccY=;
        b=Hz72/ybIP9jC9mxMUf4UTw0Bz5TIm09QLh8Oderyl/tI5IWU7LmDFO23VtiM40zZ3a
         6x0xU4XZzONefqEbO4hFd2eXBLLN41vgGbTWirfGxbTZ9YaiH9PSihBY0con9XQsHMPa
         UbKwdi+elRJS4YyddjSuj+pNpyfB+JruVO8x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696881179; x=1697485979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csxmouwm4ofhF5cKOMzE27Rri8PFeo+HUVsFVEvzccY=;
        b=XKByfn1P1kt3d+KPxf75iVsQf0pmD1CFwNmc5waNQ1J0ccd2yp9D165iRICRThLBwE
         lM3SwbkAO3E6kqqYR84PJHG64xVXnfNL23dL+37k78aAZdVUFx2zNUfi1vcQh22nvkc+
         09ScRoO4o6n1ZdpbztKt6vDpJ1/8nTWYF4m82uX8FGW6lpsU2dWbU/Mid02G5++rTDkF
         x1Ba19AZndj7gO8xhjgGAr/jjT1onw3bNwlZC9Njk9WjGMX3O2ts/HFtEekdbUEvhlJN
         KjQFgibFMk4SOiWua/Swr+FJgAS/m23nWfzKmA+EqF10MxU60IlNwAUvVyChLLsqQGuP
         /vsQ==
X-Gm-Message-State: AOJu0Yx9G8rQ+N1R1Rusrm4tkitNHtifIDI3zEuSWqiUguVEB/l0BpWC
	VNoJIpytOvu1LfKiY0H/+KTvVA==
X-Google-Smtp-Source: AGHT+IH8+Ntc+mkBfEJvhkMQnUhAYyhOXnvDI9W+fGYDOJ7tdwlzxtrOGtqb7aH6TTdMvZXTN2zj5Q==
X-Received: by 2002:a17:902:c404:b0:1c9:9fa6:ce5b with SMTP id k4-20020a170902c40400b001c99fa6ce5bmr4306363plk.16.1696881179581;
        Mon, 09 Oct 2023 12:52:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b001c3f7fd1ef7sm10043902plg.12.2023.10.09.12.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 12:52:58 -0700 (PDT)
Date: Mon, 9 Oct 2023 12:52:57 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] media: venus: hfi_cmds: Replace one-element array
 with flex-array member and use __counted_by
Message-ID: <202310091252.660CFA9@keescook>
References: <ZSRJfRdUXQOzagKr@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSRJfRdUXQOzagKr@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 12:42:05PM -0600, Gustavo A. R. Silva wrote:
> Array `data` in `struct hfi_sfr` is being used as a fake flexible array
> at run-time:
> 
> drivers/media/platform/qcom/venus/hfi_venus.c:
> 1033         p = memchr(sfr->data, '\0', sfr->buf_size);
> 1034         /*
> 1035          * SFR isn't guaranteed to be NULL terminated since SYS_ERROR indicates
> 1036          * that Venus is in the process of crashing.
> 1037          */
> 1038         if (!p)
> 1039                 sfr->data[sfr->buf_size - 1] = '\0';
> 1040
> 1041         dev_err_ratelimited(dev, "SFR message from FW: %s\n", sfr->data);
> 
> Fake flexible arrays are deprecated, and should be replaced by
> flexible-array members. So, replace one-element array with a
> flexible-array member in `struct hfi_sfr`.
> 
> While there, also annotate array `data` with __counted_by() to prepare
> for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> This results in no differences in binary output.

Thanks for checking!

> 
> This issue was found with the help of Coccinelle, and audited and fixed
> manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
