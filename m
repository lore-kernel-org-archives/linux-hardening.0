Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E38199B2
	for <linux-hardening@vger.kernel.org>; Mon,  2 Oct 2023 17:41:54 +0000 (UTC)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA21AAC
	for <linux-hardening@vger.kernel.org>; Mon,  2 Oct 2023 10:41:52 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-277504a23a1so2368972a91.0
        for <linux-hardening@vger.kernel.org>; Mon, 02 Oct 2023 10:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696268512; x=1696873312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4PQ5k5L1vf7U2VTih6tAHOOIpHZFCPz9bxhvZ9xLpPg=;
        b=QnHgHkI54rM2dgH4r1tXPy6tXPBMD5ry1/ifdplX/l0guWws/HGKmd+izNN2lYbyQ8
         ASsK6Oo5Z7sy1Q/Z0kBNIYuCbzpRqXuKX6VuKTPVDI4BqtUsZz1HroIhIotGjXD5xnh5
         nFJxMKr5N8enwmuj+YAiIfixs5OqbH54QmgQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696268512; x=1696873312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PQ5k5L1vf7U2VTih6tAHOOIpHZFCPz9bxhvZ9xLpPg=;
        b=u+JIjF0i6vNAdW2m5LPU+t1lxo75wyeeT0Jf8X3K+9Gt9RVDgHyhXb0YxdkWEW15Rx
         xYzGJHihuAd7oOtlzoKoobH8ZIz+8CbreiIVMWLwzew2zEUVd2fUkIvfLjWfstz5pcnC
         vDnkt8z+BlU3z99b3eUTPbrk4iHDjnPI1PT29KXLr7Ug3J7GpebZ9z3xtOaKD2JL9lPp
         0VlAIoSmBcC4Z8bxSp+ZeF1tYmgIdqCvz/EptUa1tDHZXhhXziih/mot8oTc1JtskX/C
         e2XMRmE6Mr1DsWDSEiMxxH9vj5PXD05yrt8rSTfnN9BM3ACbffi9TWtK3EiZ+NaSWfLP
         lMgA==
X-Gm-Message-State: AOJu0YyMjBtPk3uxHWO298BeNbJqcti7TCRxpBNgTFkCawQWX5BhiKem
	BzO1oLbGTyjlb1FSWQ17ZXEK7Q==
X-Google-Smtp-Source: AGHT+IEKwoN8US8SbhoaEXG8I/zbZA98vFUpxqN5OwarkAVod2EsBwbtDvEJWjc/sy7+JQaEzvI/Jw==
X-Received: by 2002:a17:90b:128f:b0:279:c1e:a146 with SMTP id fw15-20020a17090b128f00b002790c1ea146mr341768pjb.23.1696268512222;
        Mon, 02 Oct 2023 10:41:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d24-20020a17090ac25800b00276cb03a0e9sm6392591pjx.46.2023.10.02.10.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:41:51 -0700 (PDT)
Date: Mon, 2 Oct 2023 10:41:48 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: message: fusion: replace deprecated strncpy with
 strscpy_pad
Message-ID: <202310021041.FA60C9812@keescook>
References: <20230927-strncpy-drivers-message-fusion-mptctl-c-v1-1-bb2eddc1743c@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927-strncpy-drivers-message-fusion-mptctl-c-v1-1-bb2eddc1743c@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 04:06:09AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Since all these structs are copied out to userspace let's keep them
> NUL-padded by using `strscpy_pad` which guarantees NUL-termination of
> the destination buffer while also providing the NUL-padding behavior
> that strncpy has.
> 
> Let's also opt to use the more idiomatic strscpy usage of:
> `dest, src, sizeof(dest)` in cases where the compiler can determine the
> size of the destination buffer. Do this for all cases of strscpy...() in
> this file.
> 
> To be abundantly sure we don't leak stack data out to user space let's
> also change a strscpy to strscpy_pad. This strscpy was introduced in
> Commit dbe37c71d1246ec2 ("scsi: message: fusion: Replace all
> non-returning strlcpy() with strscpy()")
> 
> Note that since we are creating these structs with a copy_from_user()
> and modifying fields and then copying back out to the user it is
> probably OK not to explicitly NUL-pad everything as any data leak is
> probably just data from the user themselves. If this is too eager, let's
> opt for `strscpy` which is still in the spirit of removing deprecated
> strncpy usage treewide.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Agreed -- this looks more robust and readable. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
