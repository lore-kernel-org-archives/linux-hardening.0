Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B48519B
	for <linux-hardening@vger.kernel.org>; Sun, 24 Sep 2023 03:04:42 +0000 (UTC)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D757136
	for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 20:04:41 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-57b5f0d658dso2256129eaf.0
        for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 20:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695524680; x=1696129480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3sQ7m4xt0fK6eu4MW7lFXq5f5EhNnp1BBnPa+JfP91w=;
        b=Iu1Dkt85dqEYsbP3Bv+7mtNRP+/1lI+PBrMKtfjmUOwWfuacR0f2JZuyhWv6PY+cbD
         7xyG7YLAY95X0efx/m2bKMfl+k5pTGfmtbU+slNhguQkb0eYY/wZ/4uWG9fRYxem3od0
         4n7ZGvFuIxuJow+/eQPEJgrO2S4OMgjlb6Nto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695524680; x=1696129480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sQ7m4xt0fK6eu4MW7lFXq5f5EhNnp1BBnPa+JfP91w=;
        b=NUBBG62g9DPet2OIoU0YyPKGkRs5VsPX/85nlXFjBmSZdQLTVCKfe6tSvU9dXGS39U
         ew9w97X5LE5YnjQ5uoWdXxD8DSUxYCB3iv4s5nBOcH/H/tO8YAt7LKKXa3XuCa3uHxwo
         T8AihbOunGs7PSbkzwBsIU8rsuA+lf5Rq0Zoe04k1Cfy3t4pyodv8SRp2qJLpVmr7Xfy
         hlUz7oSfw9udbNhBcmLGKQvYfmvtWQazLTXSoYINdAkkYFWUksDI7HuVy/5LkXIof/KX
         McRcotZshtieeI1uPFpLoUwphEtSyM/p7HDojPDmULDqk6jiSTo4Jno3s9e5OpJfewOi
         1BYw==
X-Gm-Message-State: AOJu0Yxb1LMkpZJYvSbORq84hN9j0KdIzUuH0tq8X88Botk6pjlQuYkq
	abTa1ITpqcfSeZEE1EHxeBUm6w==
X-Google-Smtp-Source: AGHT+IEyctQpGdRHVqfskRrctSvr+c0AutzD5V01OHg/wphX4795l8UXDPxsR/JiCrGwUFsS6seQ2g==
X-Received: by 2002:a05:6358:991e:b0:141:d2d:6da7 with SMTP id w30-20020a056358991e00b001410d2d6da7mr4584544rwa.17.1695524680210;
        Sat, 23 Sep 2023 20:04:40 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id rm10-20020a17090b3eca00b0027480345180sm7265781pjb.2.2023.09.23.20.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 20:04:39 -0700 (PDT)
Date: Sat, 23 Sep 2023 20:04:38 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] i3c: replace deprecated strncpy
Message-ID: <202309232003.05306BB415@keescook>
References: <20230921-strncpy-drivers-i3c-master-c-v1-1-9fdb8d8169e1@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921-strncpy-drivers-i3c-master-c-v1-1-9fdb8d8169e1@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 03:51:04AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> We expect adap->name to be NUL-terminated based on i2c_adapter name use:
> | dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
> 
> NUL-padding does not seem to be required as `master` is zero-allocated
> and `i3c_master_to_i2c_adapter` simply returns a field from within
> `master`:
> |       master = devm_kzalloc(dev, sizeof(*master), GFP_KERNEL);
> ...
> |      	struct i2c_adapter *adap = i3c_master_to_i2c_adapter(master);
> ...
> |       static struct i2c_adapter *
> |       i3c_master_to_i2c_adapter(struct i3c_master_controller *master)
> |       {
> |       	return &master->i2c;
> |       }
> 
> This means that `adap->name` should already be filled with NUL-bytes.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks right to me; straight replacement.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
